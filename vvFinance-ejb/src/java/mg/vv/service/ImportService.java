package mg.vv.service;

import bean.AdminGen;
import bean.CGenUtil;
import bean.ClassMAPTable;
import historique.MapUtilisateur;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Field;
import java.sql.Connection;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import pub.Parution;
import pub.Publication;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;
import utilitaire.XlsImport;
import ventegazety.Invendu;
import ventegazety.Journal;
import ventegazety.Prisejournal;
import ventegazety.Recette;
import ventegazety.Vendeur;

public class ImportService {

    private static int tailleExcel = 0;
    private static int tailleTrouve = 0;

    public static int getTailleExcel() {
        return tailleExcel;
    }

    public static void setTailleExcel(int tailleExcel) {
        ImportService.tailleExcel = tailleExcel;
    }

    public static int getTailleTrouve() {
        return tailleTrouve;
    }

    public static void setTailleTrouve(int tailleTrouve) {
        ImportService.tailleTrouve = tailleTrouve;
    }

    public static List<NouveauObjet> importExcelFile(HttpServletRequest request, MapUtilisateur mapUser) throws Exception {
        Connection connection = null;
        try {
            connection = new UtilDB().GetConn();
            connection.setAutoCommit(false);
            DiskFileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);
            List items = upload.parseRequest(request);
            Iterator i = items.iterator();
            FileItem fichierExcel = null;
            String inputName = "", date = "";
            while (i.hasNext()) {
                FileItem itemTemp = (FileItem) i.next();
                if (!itemTemp.isFormField()) {
                    fichierExcel = itemTemp;
                } else {
                    inputName = (String) itemTemp.getFieldName();
                    if (inputName.equalsIgnoreCase("dateImport")) {
                        date = (String) itemTemp.getString();
                    }
                }
            }

            JournalImport instanceExcel = new JournalImport();
            Object[] lignesFactureExcel = XlsImport.toObject(fichierExcel.getInputStream(), instanceExcel);
            List<NouveauObjet> nonTrouvees = translateJournalExcel(Utilitaire.stringDate(date), connection, mapUser, lignesFactureExcel);
            connection.commit();
            return nonTrouvees;
        } catch (Exception e) {
            if (connection != null) {
                connection.rollback();
            }
            e.printStackTrace();
            throw e;
        } finally {
            if (connection != null) {
                connection.close();
            }
        }
    }

    public static List<NouveauObjet> translateJournalExcel(Date date, Connection connection, MapUtilisateur mapUser, Object[] lignesFacturesExcel) throws Exception {
        List<NouveauObjet> nonTrouves = new ArrayList();
        setTailleTrouve(0);

        for (Object ligneFactureExcel : lignesFacturesExcel) {
            JournalImport journalExcel = (JournalImport) ligneFactureExcel;
            NouveauObjet nonTrouve = importJournal(journalExcel, date, connection, mapUser);
            if (nonTrouve != null) {
                nonTrouves.add(nonTrouve);
            }
        }
        return nonTrouves;
    }

    public static NouveauObjet importJournal(JournalImport journalImport, Date date, Connection connection, MapUtilisateur mapUser) throws Exception {
        // find vendeur => idvendeur
        Vendeur vendeur = new Vendeur();
        vendeur.setSurnom(journalImport.getIdvendeur());
        Vendeur[] vendeurs = (Vendeur[]) CGenUtil.rechercher(vendeur, null, null, connection, "");
        if (vendeurs.length == 0) {
            return new NouveauObjet(journalImport, "Vendeur introuvable!");
        } else {
            vendeur = vendeurs[0];
        }

        // find journal => idjournal
        Journal journal = new Journal();
        journal.setVal(journalImport.getJournal().trim());
        Journal[] journals = (Journal[]) CGenUtil.rechercher(journal, null, null, connection, "");
        if (journals.length == 0) {
            return new NouveauObjet(journalImport, "Journal introuvable!");
        } else {
            journal = journals[0];
        }

        // find parution where journal = idjournal and numparution = journalImport.numParution => idParution
        Parution parution = new Parution();
        parution.setJournal(journal.getId().trim());
        Parution[] parutions = null;
        if (journalImport.getParution() != null) {
            parutions = (Parution[]) CGenUtil.rechercher(parution, null, null, connection, " AND NUMPARUTION='" + journalImport.getParution().trim() + "'");
        }

        if (parutions.length == 0) {
            return new NouveauObjet(journalImport, "Parution introuvable!");
        } else {
            parution = parutions[0];
        }

        // find publication where numparution = idparution and journal = idjournal => idpublication
        Publication publication = new Publication();
        publication.setNumParution(parution.getId());
        publication.setJournal(journal.getId());
        Publication[] publications = (Publication[]) CGenUtil.rechercher(publication, null, null, connection, "");
        if (publications.length == 0) {
            return new NouveauObjet(journalImport, "Publication introuvable!");
        } else {
            publication = publications[0];
        }

        // find prise journal where publication = idpublication and vendeur = idvendeur => idprisejournal
        Prisejournal priseJournal = new Prisejournal();
        priseJournal.setPublicat(publication.getId());
        priseJournal.setVendeur(vendeur.getId());
        Prisejournal[] prisesJournal = (Prisejournal[]) CGenUtil.rechercher(priseJournal, null, null, connection, "");
        if (prisesJournal.length == 0) {
            return new NouveauObjet(journalImport, "Prise journal introuvable!");
        } else {
            priseJournal = prisesJournal[0];
        }

        // save recette
        Recette recette = new Recette();
        recette.setDaty(date);
        recette.setPrise(priseJournal.getId());
        Recette[] rec = (Recette[])CGenUtil.rechercher(recette, null, null, connection, "");
        if(rec.length == 0){
            return new NouveauObjet(journalImport, "Recette deja inseree pour ce date et prise!");
        }
        System.out.print("journalImport.getSomme().trim() ===> " + journalImport.getSomme().trim());
        if (journalImport.getSomme().trim() == null || journalImport.getSomme().trim().isEmpty()) {
            recette.setSomme(0);
        } else {
            recette.setSomme(Double.valueOf(journalImport.getSomme().trim()));
        }

        recette.construirePK(connection);
        recette.insertToTableWithHisto(mapUser.getTuppleID(), connection);
        tailleTrouve += 1;
        return null;
    }

    public static FileOutputStream exportNotFound(List<NouveauObjet> nouveauxObjets) throws Exception {
        HSSFWorkbook workBook = new HSSFWorkbook();
        HSSFSheet feuille = workBook.createSheet("NON-TROUVE");
        int size = nouveauxObjets.size();
        for (int i = 0; i < size; i++) {
            HSSFRow row = feuille.createRow(i);
            row.createCell(0).setCellValue(nouveauxObjets.get(i).getIdvendeur());
            row.createCell(1).setCellValue(nouveauxObjets.get(i).getJournal());
            row.createCell(2).setCellValue(nouveauxObjets.get(i).getParution());
            row.createCell(3).setCellValue(nouveauxObjets.get(i).getSomme());
            row.createCell(4).setCellValue(nouveauxObjets.get(i).getMotif());
        }
        FileOutputStream file = new FileOutputStream("export-non-trouve.xlsx");
        workBook.write(file);
        file.close();
        return file;
    }
    //INSERTION GENERIQUE
    public static List<MotifNonTrouve> genericImportExcel(HttpServletRequest request, MapUtilisateur mapUser, ClassMAPTable cmt) throws Exception {
        Connection connection = null;
        Object[] lister = null;
        try {
            connection = new UtilDB().GetConn();
            connection.setAutoCommit(false);
            DiskFileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);
            List items = upload.parseRequest(request);
            Iterator i = items.iterator();
            FileItem fichierExcel = null;
            String inputName = "", date = "", type= "";
            while (i.hasNext()) {
                FileItem itemTemp = (FileItem) i.next();
                if (!itemTemp.isFormField()) {
                    fichierExcel = itemTemp;
                }
                else {
                    inputName = (String) itemTemp.getFieldName();
                    if (inputName.equalsIgnoreCase("dateImport")) {
                        date = (String) itemTemp.getString();
                    }
                    if (inputName.equalsIgnoreCase("type")) {
                        type = (String) itemTemp.getString();
                    }
                }
            }
            System.out.println("date = " + date);
            lister = XlsImport.genToObject(fichierExcel.getInputStream(), cmt);
            List<MotifNonTrouve> nonTrouvees = castJournalExcel( Utilitaire.stringDate(date), connection, mapUser, lister, type);
            //tokony manana tableau vendeur non trouver, journaux, prises, vendu
            /*
               1. maka id ao anaty vendeur where nom = 
                2. manao verif ny journaux (nom), parution (mitovy ve ny nbr), prises, invendus , prix
            */
            return nonTrouvees;
        } catch (Exception e) {
            if (connection != null) {
                connection.rollback();
            }
            e.printStackTrace();
            throw e;
        } finally {
            if (connection != null) {
                connection.close();
            }
        }
        
    }
    
    public static List<MotifNonTrouve> castJournalExcel(Date date, Connection connection, MapUtilisateur mapUser, Object[] lignesFacturesExcel, String type) throws Exception {
        Connection c = null;
        try{
            c = new UtilDB().GetConn();
            List<MotifNonTrouve> nonTrouves = new ArrayList();
            setTailleTrouve(0);
            for (Object ligneFactureExcel : lignesFacturesExcel) {
                if(type.compareToIgnoreCase("prise")==0){
                    ImportJournalPrise journalExcel = (ImportJournalPrise) ligneFactureExcel;
                    MotifNonTrouve nonTrouve = genImportJournalPrise(journalExcel, date, connection, mapUser);
                    if (nonTrouve != null) {
                        nonTrouves.add(nonTrouve);
                    }
                }
                else{
                    ImportJournalInvendu journalExcel = (ImportJournalInvendu) ligneFactureExcel;
                    MotifNonTrouve nonTrouve = genImportJournalInvendu(journalExcel, date, connection, mapUser);
                    if (nonTrouve != null) {
                        nonTrouves.add(nonTrouve);
                    }
                }
                
            }
            return nonTrouves;
        }
        catch(Exception e){
            throw e;
        }
        finally{
            if(c!=null) c.close();
        }
    }
    
    public static MotifNonTrouve genImportJournalPrise(ImportJournalPrise journalImport, Date date, Connection connection, MapUtilisateur mapUser) throws Exception {
        // find vendeur => idvendeur
        Vendeur vendeur = new Vendeur();
        vendeur.setSurnom(journalImport.getNoms());
        Vendeur[] vendeurs = (Vendeur[]) CGenUtil.rechercher(vendeur, null, null, connection, "");
       // System.out.println("vendeurs.length = "+vendeurs.length);
        if (vendeurs.length == 0) {
            return new MotifNonTrouve(journalImport, "Vendeur introuvable!");
        } else {
            vendeur = vendeurs[0];
        }
        //vendeur.construirePK(connection);
        //vendeur.insertToTableWithHisto(mapUser.getTuppleID(), connection);
        // find journal => idjournal
        Journal journal = new Journal();
        journal.setVal(journalImport.getJournaux().trim());
        Journal[] journals = (Journal[]) CGenUtil.rechercher(journal, null, null, connection, "");
       // System.out.println("journals = " + journals.length);
        if (journals.length == 0) {
           // System.out.println("tsy hita ilay journal");
            return new MotifNonTrouve(journalImport, "Journal introuvable!");
        } else {
           // System.out.println("hita ilay journal ary ito no valeur ny "+journals[0].getVal());
            journal = journals[0];
        }
        //journal.construirePK(connection);
        //journal.insertToTableWithHisto(mapUser.getTuppleID(), connection);

        // find parution where journal = idjournal and numparution = journalImport.numParution => idParution
        Parution parution = new Parution();
        parution.setJournal(journal.getId().trim());
        Parution[] parutions = null;
        if (journalImport.getParution() != 0) {
            parutions = (Parution[]) CGenUtil.rechercher(parution, null, null, connection, " AND NUMPARUTION = "+journalImport.getParution()+"");
            //System.out.println("parutions = " + parutions.length);
        }
        if (parutions.length == 0) {
            //System.out.println("tsy hita ilay parution");
            return new MotifNonTrouve(journalImport, "Parution introuvable!");
        } else {
            //System.out.println("hita ilay parution ary ito no valeur "+parutions[0].getNumParution());
            parution = parutions[0];
        }
        //parution.construirePK(connection);
        //parution.insertToTableWithHisto(mapUser.getTuppleID(), connection);

        // find publication where numparution = idparution and journal = idjournal => idpublication
        Publication publication = new Publication();
        publication.setNumParution(parution.getId()); //eto no tokony verifier-na
        publication.setJournal(journal.getId());
        Publication[] publications = (Publication[]) CGenUtil.rechercher(publication, null, null, connection, "");
        //System.out.println("publications = " + publications.length);
        if (publications.length == 0) {
            //System.out.println("tsy hita ilay publication");
            return new MotifNonTrouve(journalImport, "Publication introuvable!");
        } else {
            //System.out.println("hita ilay publication ary ito ny valeur "+publications[0].getNumParution());
            publication = publications[0];
        }
        //publication.construirePK(connection);
        //publication.insertToTableWithHisto(mapUser.getTuppleID(), connection);

        // find prise journal where publication = idpublication and vendeur = idvendeur => idprisejournal
        Prisejournal priseJournal = new Prisejournal();
        priseJournal.setPublicat(publication.getId());
       // System.out.println("priseJournal = " + priseJournal.getPublicat());
        priseJournal.setVendeur(vendeur.getId());
       // System.out.println("priseJournal = " + priseJournal.getVendeur());
        priseJournal.setIdPrix(journalImport.getPrix());
       // System.out.println("priseJournal = " + priseJournal.getIdPrix());
        priseJournal.setDaty(date);
        priseJournal.setNbreprise(journalImport.getPrises());
        //System.out.println("priseJournal = " + priseJournal.getNbreprise());
        Prisejournal[] prisehita= (Prisejournal[])CGenUtil.rechercher(new Prisejournal(), null, null, connection, " AND PUBLICAT = '"+publication.getId()+"' AND VENDEUR = '"+vendeur.getId()+"' AND DATY = '"+Utilitaire.formatterDaty(date)+"'");
        if(prisehita.length>0){
            return new MotifNonTrouve(journalImport, "Prise deja inseree pour ce vendeur a cette date et num parution");
        }else{
            priseJournal.setPlace("-");
            priseJournal.construirePK(connection);
            priseJournal.insertToTableWithHisto(mapUser.getTuppleID(), connection);
        }
        tailleTrouve += 1;
        //System.out.println("tailleTrouve = " + tailleTrouve);
        return null;
    }
    
    public static MotifNonTrouve genImportJournalInvendu(ImportJournalInvendu journalImport, Date date, Connection connection, MapUtilisateur mapUser) throws Exception {
        // find vendeur => idvendeur
        Vendeur vendeur = new Vendeur();
        vendeur.setSurnom(journalImport.getNoms());
        Vendeur[] vendeurs = (Vendeur[]) CGenUtil.rechercher(vendeur, null, null, connection, "");
       // System.out.println("vendeurs.length = "+vendeurs.length);
        if (vendeurs.length == 0) {
            return new MotifNonTrouve(journalImport, "Vendeur introuvable!");
        } else {
            vendeur = vendeurs[0];
        }
        //vendeur.construirePK(connection);
        //vendeur.insertToTableWithHisto(mapUser.getTuppleID(), connection);
        // find journal => idjournal
        Journal journal = new Journal();
        journal.setVal(journalImport.getJournaux().trim());
        Journal[] journals = (Journal[]) CGenUtil.rechercher(journal, null, null, connection, "");
       // System.out.println("journals = " + journals.length);
        if (journals.length == 0) {
           // System.out.println("tsy hita ilay journal");
            return new MotifNonTrouve(journalImport, "Journal introuvable!");
        } else {
           // System.out.println("hita ilay journal ary ito no valeur ny "+journals[0].getVal());
            journal = journals[0];
        }
        //journal.construirePK(connection);
        //journal.insertToTableWithHisto(mapUser.getTuppleID(), connection);

        // find parution where journal = idjournal and numparution = journalImport.numParution => idParution
        Parution parution = new Parution();
        parution.setJournal(journal.getId().trim());
        Parution[] parutions = null;
        if (journalImport.getParution() != 0) {
            parutions = (Parution[]) CGenUtil.rechercher(parution, null, null, connection, " AND NUMPARUTION = "+journalImport.getParution()+"");
            //System.out.println("parutions = " + parutions.length);
        }
        if (parutions.length == 0) {
            //System.out.println("tsy hita ilay parution");
            return new MotifNonTrouve(journalImport, "Parution introuvable!");
        } else {
            //System.out.println("hita ilay parution ary ito no valeur "+parutions[0].getNumParution());
            parution = parutions[0];
        }
        //parution.construirePK(connection);
        //parution.insertToTableWithHisto(mapUser.getTuppleID(), connection);

        // find publication where numparution = idparution and journal = idjournal => idpublication
        Publication publication = new Publication();
        publication.setNumParution(parution.getId()); //eto no tokony verifier-na
        publication.setJournal(journal.getId());
        Publication[] publications = (Publication[]) CGenUtil.rechercher(publication, null, null, connection, "");
        //System.out.println("publications = " + publications.length);
        if (publications.length == 0) {
            //System.out.println("tsy hita ilay publication");
            return new MotifNonTrouve(journalImport, "Publication introuvable!");
        } else {
            //System.out.println("hita ilay publication ary ito ny valeur "+publications[0].getNumParution());
            publication = publications[0];
        }
        //publication.construirePK(connection);
        //publication.insertToTableWithHisto(mapUser.getTuppleID(), connection);

        // find prise journal where publication = idpublication and vendeur = idvendeur => idprisejournal
        Prisejournal pj = new Prisejournal();
        Prisejournal[] pri = (Prisejournal[]) CGenUtil.rechercher(new Prisejournal(), null, null, connection, " AND PUBLICAT = '"+publication.getId()+"'");
        if (pri.length == 0) {
            //System.out.println("tsy hita ilay publication");
            return new MotifNonTrouve(journalImport, "Prise journal introuvable!");
        } else {
            //System.out.println("hita ilay publication ary ito ny valeur "+publications[0].getNumParution());
            pj = pri[0];
        }
        
        Invendu inv = new Invendu();
        Invendu[] invenduhita= (Invendu[])CGenUtil.rechercher(new Invendu(), null, null, connection, " AND IDPRISE = '"+pj.getId()+"' AND DATY ='"+Utilitaire.formatterDaty(date)+"'");
        inv.setIdprise(pj.getId());
        //System.out.println("inv = " + inv.getIdprise());
        inv.setDaty(Utilitaire.dateDuJourSql());
        inv.setNombreinvendu(journalImport.getInvendus());
       // System.out.println("inv = " + inv.getNombreinvendu());
        if(invenduhita.length>0){
            return new MotifNonTrouve(journalImport, "Invendu deja inseree pour ce vendeur a cette date et num parution");
        }else{
            inv.construirePK(connection);
            inv.insertToTableWithHisto(mapUser.getTuppleID(), connection);
        }           
        tailleTrouve += 1;
        //System.out.println("tailleTrouve = " + tailleTrouve);
        return null;
    }
}


