// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   FinanceBean.java
package finance;

import bean.*;
import comptabilite.ComptabiliteEjbClient;
import facture.*;
import historique.HistoriqueEtat;
import historique.MapHistorique;
import java.io.PrintStream;
import java.sql.*;
import javax.ejb.*;

import lc.*;
import utilitaire.Constante;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;
import facturefournisseur.FactureFournisseur;
import ded.*;
import facturefournisseur.FactureFournisseurUtil;
import historique.MapUtilisateur;
import java.rmi.RemoteException;
import utilitaire.UtilitaireMetier;
import java.util.Vector;

// Referenced classes of package finance:
//            Caisse, CaisseUtil, Sortie, SortieUtil,
//            Entree, EntreeUtil, ChangeUtil, Change2,
//            EtatCaisseUtil, AdminEntree, EtatCaisse
@Stateful
@AccessTimeout(0)
public class FinanceBean
        implements FinanceEjb, FinanceEjbRemote, SessionBean {

    public FinanceBean() {
    }

    public void ejbCreate() throws CreateException {
    }

    public void ejbRemove() {
    }

    public void ejbActivate() {
    }

    public void ejbPassivate() {
    }

    public void setSessionContext(SessionContext sessionContext) {
        this.sessionContext = sessionContext;
    }

    public String createCaisse(String descCaisse, String respCaisse, String etatCaisse, String refUser) throws Exception {
        try {
            Caisse c = new Caisse(descCaisse, respCaisse, etatCaisse);
            MapHistorique h = new MapHistorique("Caisse", "insert", refUser, c.getTuppleID());
            c.insertToTable(h);
            String s = c.getTuppleID();
            return s;
        } catch (ErreurDAO ex) {
            throw new ErreurDAO(ex.getMessage());
        }
    }

    public String createCaisseComptable(String descCaisse, String respCaisse, String etatCaisse, String comptable, String refUser) throws Exception {
        Connection con = null;
        try {
            con = (new UtilDB()).GetConn();
            con.setAutoCommit(false);
            Caisse c = new Caisse(descCaisse, respCaisse, etatCaisse);
            MapHistorique h = new MapHistorique("Caisse", "insert", refUser, c.getTuppleID());
            c.insertToTable(con);
            h.insertToTable(con);
            FactureEJBClient.getInterface().createCompteConnection(comptable, c.getTuppleID(), Utilitaire.dateDuJour(), refUser, con);
            con.commit();
            String s = c.getTuppleID();
            return s;
        } catch (Exception ex) {
            con.rollback();
            throw new Exception(ex.getMessage());
        } finally {
            con.close();
        }
    }

    public String updateCaisse(String idCaisse, String descCaisse, String respCaisse, String etatCaisse, String refUser) throws ErreurDAO {
        try {
            Caisse c = new Caisse(idCaisse, descCaisse, respCaisse, etatCaisse);
            MapHistorique h = new MapHistorique("Caisse", "update", refUser, c.getTuppleID());
            c.updateToTableWithHisto(h);
            String s = c.getTuppleID();
            return s;
        } catch (ErreurDAO ex) {
            throw new ErreurDAO(ex.getMessage());
        }
    }

    public int deleteCaisse(String idCaisse, String refUser) throws ErreurDAO {
        try {
            Caisse c = new Caisse(idCaisse, "-", "-", "-");
            MapHistorique h = new MapHistorique("Caisse", "delete", refUser, c.getTuppleID());
            c.deleteToTable(h);
            int i = 1;
            return i;
        } catch (ErreurDAO ex) {
            throw new ErreurDAO(ex.getMessage());
        }
    }

    public Caisse[] findCaisse(String idCaisse, String descCaisse, String respCaisse, String etatCaisse) throws ErreurDAO {
        try {
            int[] a = {1, 2, 3, 4};
            String[] val = {idCaisse, descCaisse, respCaisse, etatCaisse};
            CaisseUtil cu = new CaisseUtil();
            Caisse acaisse[] = (Caisse[]) cu.rechercher(a, val, " order by desccaisse asc");
            return acaisse;
        } catch (Exception ex) {
            throw new ErreurDAO(ex.getMessage());
        }
    }

    public String mapperMouvementDepenseFacture(String numMvt, String numFact, String montant, Connection c, String refUser) throws Exception {
        String retour = utilitaire.UtilitaireMetier.mapperMereToFille(Constante.getTableDepenseLC(), "getSortieFactureSeq", "SFF", numMvt, numFact, "-", montant, refUser, c);
        return retour;
    }

    public String mapperMouvementRecetteFacture(String numMvt, String numFact, String montant, Connection c, String refUser) throws Exception {
        String retour = utilitaire.UtilitaireMetier.mapperMereToFille(Constante.getTableRecetteLC(), "getEntreeFactureSeq", "RFF", numMvt, numFact, "-", montant, refUser, c);
        return retour;
    }

    public String createSortie(String daty, String designation, String montant, String idDevise, String idMode, String idCaisse, String remarque, String agence, String projet, String numpiece, String idFacture, String idLigne, String refUser) throws Exception {
        Connection c = null;
        try {
            c = new utilitaire.UtilDB().GetConn();
            c.setAutoCommit(false);
            LCEjb lci = LCEjbClient.getInterface();
            Sortie s = new Sortie();
            s.setDaty(Utilitaire.string_date(daty, "dd/mm/yyyy"));
            s.setDesignation(designation);
            s.setMontant(Utilitaire.stringToDouble(montant));
            s.setIdDevise(idDevise);
            s.setIdModePaiement(idMode);
            s.setIdCaisse(idCaisse);
            s.setRemarque(remarque);
            s.setAgence(agence);
            s.setIdProjet(projet);
            s.setNUMPIECE(numpiece);
            s.setNomTable("sortie");
            s.setIndicePk("DEP");
            s.setNomProcedureSequence("getSeqSortie");
            s.setIdSortie(s.makePK());
            if (idFacture == null || (idFacture.compareToIgnoreCase("") == 0)) //s il n y a pas de facture, on cree auto facture
            {
                facturefournisseur.FactureFournisseur ff = new facturefournisseur.FactureFournisseur("FACTUREFOURNISSEUR", "numAuto", "creation auto", daty, daty, Constante.getIdFournAuto(), "0", montant, "-", idDevise);
                s.insertToTableWithHisto(refUser, c);
                ff.insertToTableWithHisto(refUser, c);
                String mapSortie = utilitaire.UtilitaireMetier.mapperMereToFille(Constante.getTableDepenseLC(), "getSortieFactureSeq", "SFF", s.getTuppleID(), ff.getTuppleID(), "-", montant, refUser, c);
                String mapFact = lci.mapperFactureFournisseurLC(ff.getTuppleID(), idLigne, "-", montant, refUser);
                lci.validerMappageLC(Constante.getTableFactureFLC(), mapFact, c, refUser);
                this.validerMappage(Constante.getTableDepenseLC(), mapSortie, c, refUser);
            } else {
                FactureFournisseur ff = null;
                facturefournisseur.FactureFournisseurUtil ffu = new facturefournisseur.FactureFournisseurUtil();
                ffu.setNomTable("factureFournisseur");
                facturefournisseur.FactureFournisseur[] ffListe = (facturefournisseur.FactureFournisseur[]) ffu.rechercher(1, idFacture);
                if (ffListe.length == 0) {
                    throw new Exception("La facture n'existe pas");
                }
                ff = ffListe[0];
                String mapFact = null;
                s.insertToTableWithHisto(refUser, c);
                String mapSortie = utilitaire.UtilitaireMetier.mapperMereToFille("sortieFF", "getSortieFactureSeq", "SFF", s.getTuppleID(), ff.getTuppleID(), "-", montant, refUser, c);
                UnionIntraTableUtil uit = new UnionIntraTableUtil();
                UnionIntraTable[] unionFFLC = uit.findUnionIntraTable(Constante.getTableFactureFLC(), "%", ff.getTuppleID(), idLigne, "%", "", "", "%", "");
                if (unionFFLC.length == 0) //raha mbola tsy mapp�
                {
                    mapFact = lci.mapperFactureFournisseurLC(ff.getTuppleID(), idLigne, "-", montant, refUser);
                    lci.validerMappageLC(Constante.getTableFactureFLC(), mapFact, c, refUser);
                } else if (unionFFLC[0].getEtat() == 0) //mapp� fa mbola tsy valid�
                {
                    mapFact = unionFFLC[0].getTuppleID();
                    lci.validerMappageLC(Constante.getTableFactureFLC(), mapFact, c, refUser);
                }
                this.validerMappage(Constante.getTableDepenseLC(), mapSortie, c, refUser);
            }
            c.commit();
        } catch (Exception ex) {
            c.rollback();
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        } finally {
            try {
                c.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
                throw new Exception(ex.getMessage());
            }
        }
        c.close();
        return null;
    }

    public void validerMappageMouvement(String nomTable, String idMvt, Connection c, String refUser) throws Exception {
        UnionIntraTableUtil utu = new UnionIntraTableUtil();
        UnionIntraTable[] uit = utu.findUnionIntraTable(nomTable, "%", idMvt, "%", "%", "", "", "0", "");
        for (int i = 0; i < uit.length; i++) {
            validerMappage(nomTable, uit[i].getId(), c, refUser);
        }
    }

    public void validerMappage(String nomTable, String idMappage, Connection c, String refUser) throws Exception {
        try {
            UnionIntraTableUtil utu = new UnionIntraTableUtil();
            UnionIntraTable[] ut = utu.findUnionIntraTable(nomTable, idMappage, "%", "%", "%", "", "", "%", "");
            LigneCredit lc[] = null;
            LigneCreditUtil lu = new LigneCreditUtil();
            String refFact = ut[0].getId2();
            if (ut.length == 0) {
                throw new Exception("Le donn�es n existe pas");
            } else {
                ut[0].setNomTable(nomTable);
                if (nomTable.compareToIgnoreCase(utilitaire.Constante.getTableDepenseLC()) == 0)// si c'est une d�pense
                {
                    UnionIntraTable[] uit = utu.findUnionIntraTable(Constante.getTableFactureFLC(), "%", refFact, "%", "%", "", "", "1", "");
                    if (uit.length == 0) {
                        throw new Exception("La facture n appartient pas a une ligne cr�dit");
                    }
                    lu.setNomTable("LigneCredit");
                    for (int i = 0; i < uit.length; i++) {
                        String refLC = uit[i].getId2();
                        lc = (LigneCredit[]) lu.rechercher(1, refLC);
                        ut[0].setEtat(1);
                        lc[0].setMontantEng(lc[0].getMontantEng() + uit[i].getMontantMere());
                    }
                }
                if (nomTable.compareToIgnoreCase(utilitaire.Constante.getTableRecetteLC()) == 0)// si c'est une recette
                {
                    lu.setNomTable("LigneCreditRecette");
                    UnionIntraTable[] uit = utu.findUnionIntraTable(Constante.getTableFactureLC(), "%", refFact, "%", "%", "", "", "1", "");
                    if (uit.length == 0) {
                        throw new Exception("La facture n appartient pas a une ligne cr�dit");
                    }
                    for (int i = 0; i < uit.length; i++) {
                        String refLC = uit[i].getId2();
                        lc = (LigneCredit[]) lu.rechercher(1, refLC);
                        ut[0].setEtat(1);
                        lc[0].setMontantEng(lc[0].getMontantEng() + uit[i].getMontantMere());
                    }
                }
                ut[0].updateToTableWithHisto(refUser, c);
                lc[0].updateToTableWithHisto(refUser, c);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        }
    }

    public String createSortieSimple(String daty, String designation, String montant, String idDevise, String idMode, String idCaisse, String remarque, String agence, String projet, String numpiece, String refUser) throws Exception {
        Sortie s = new Sortie(daty, designation, montant, idDevise, idMode, idCaisse, remarque, agence, projet, numpiece);
        s.insertToTableWithHisto(refUser);
        return s.getTuppleID();
    }

    public String createSortie(String datee, String desi, String mont, String ben, String typ, String dev, String mode, String cais, String rem, String refUser, String parution, String agence, String prj, String part, String fact, String idLigne, Connection con) throws Exception {
        try {
            if (verifEtatCaisse(cais).compareTo("etaCs1") == 0) {
                Sortie s = new Sortie(datee, desi, mont, ben, typ, dev, mode, cais, "eta2", rem, parution, agence, prj, part, fact, idLigne);
                try {
                    int[] a = {1};
                    String[] vall = {idLigne};
                    LigneCreditUtil lu = new LigneCreditUtil();
                    lu.setNomTable("LigneCredit");
                    LigneCredit lc = (LigneCredit) lu.rechercher(a, vall, "", con)[0];
                    if (lc == null) {
                        System.out.println("IdLigne non identifier!!");
                    } else { //Mbola miaraka mitombo aloha ny r�alisation mandra-pisin'ny engagement sy ny visa
                        if ((lc.getMontantEng() + s.getMontant()) > lc.getCreditModifier()) {
                            throw new Exception("Votre credit disponible est insufisant pour cette op�ration!");
                        }
                        lc.setMontantEng(lc.getMontantEng() + s.getMontant());
                        lc.setMontantVis(lc.getMontantVis() + s.getMontant());
                        lc.setMontantFac(lc.getMontantFac() + s.getMontant());
                        lc.updateToTable(con);
                        if (lc.getIdLigne().compareToIgnoreCase("init") != 0) {
                            s.setBeneficiaire(lc.getIdEntite());
                            s.setIdTypeSortie(lc.getIdTypeLigne());
                        }
                    }

                    MapHistorique h = new MapHistorique("Sortie", "insert", refUser, s.getTuppleID());
                    s.insertToTable(con);
                    h.insertToTable(con);
                    System.out.println("vita fact");
                    Compte compteCaisse = FactureEJBClient.getInterface().findCompte("%", "%", cais, Utilitaire.dateDuJour())[0];
                    System.out.println("vita compteCaisse");
                    Compte compteVirement = FactureEJBClient.getInterface().findCompte("%", "%", "Compte de virement", Utilitaire.dateDuJour())[0];
                    System.out.println("avant insert ecritu");
                    FactureEJBClient.getInterface().createEcritureConnection(Utilitaire.dateDuJour(), compteCaisse.getId(), "D�pense ".concat(String.valueOf(String.valueOf(desi))), "0", String.valueOf(mont), s.getTuppleID(), refUser, con);
                    FactureEJBClient.getInterface().createEcritureConnection(Utilitaire.dateDuJour(), compteVirement.getId(), "D�pense ".concat(String.valueOf(String.valueOf(desi))), String.valueOf(mont), "0", s.getTuppleID(), refUser, con);
                    System.out.println("apres insert ecritu");

                    String s1 = s.getTuppleID();
                    return s1;
                } catch (Exception ex) {
                    ex.printStackTrace();
                    throw new Exception(ex.getMessage());
                }
            } else {
                throw new Exception("La caisse est ferm�e!");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        }
    }

    public String createSortie(String datee, String desi, String mont, String ben, String typ, String dev, String mode, String cais, String rem, String refUser, String parution, String agence, String prj, String part, String fact, String idLigne) throws Exception {
        Connection con = null;
        try {
            con = (new UtilDB()).GetConn();
            con.setAutoCommit(false);
            String res = createSortie(datee, desi, mont, ben, typ, dev, mode, cais, rem, refUser, parution, agence, prj, part, fact, idLigne, con);
            con.commit();
            String s = res;
            return s;
        } catch (Exception ex) {
            con.rollback();
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        } finally {
            con.close();
        }
    }

    public String updateSortie(String idSortie, String datee, String desi, String mont, String ben, String typ, String dev, String mode, String cais, String rem, String eta, String refUser, String prj, String part, String fact) throws ErreurDAO {
        try {
            String s = null;
            return s;
        } catch (Exception ex) {
            throw new ErreurDAO(ex.getMessage());
        }
    }

    public int deleteSortie(String idSortie, String refUser, String prj, String part, String fact) throws ErreurDAO {
        try {
            Sortie s = new Sortie(idSortie);
            MapHistorique h = new MapHistorique("Sortie", "delete", refUser, s.getTuppleID());
            s.deleteToTable(h);
            int i = 1;
            return i;
        } catch (ErreurDAO ex) {
            throw new ErreurDAO(ex.getMessage());
        }
    }

    public Sortie[] findSortie(String idSortie, String daty1, String daty2, String beneficiaire, String typeSortie, String designation, String idModePaiement, String idDevise, String idCaisse, String idEtat) throws ErreurDAO {
        try {
            int a[] = {
                1, 3, 5, 6, 7, 8, 10, 9
            };
            String val[] = new String[a.length];
            val[0] = idSortie;
            val[1] = designation;
            val[2] = beneficiaire;
            val[3] = typeSortie;
            val[4] = idDevise;
            val[5] = idModePaiement;
            val[6] = idEtat;
            val[7] = idCaisse;
            SortieUtil su = new SortieUtil();
            if ((daty1.compareTo("") == 0) & (daty2.compareTo("") == 0)) {
                Sortie asortie[] = (Sortie[]) su.rechercher(a, val, " order by idSortie desc");
                return asortie;
            }
            if ((daty1.compareTo("") > 0) & (daty2.compareTo("") == 0)) {
                Sortie asortie1[] = (Sortie[]) su.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and daty>='")).append(daty1).append("' order by idSortie desc"))));
                return asortie1;
            }
            if ((daty1.compareTo("") == 0) & (daty2.compareTo("") > 0)) {
                Sortie asortie2[] = (Sortie[]) su.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and daty<='")).append(daty2).append("' order by idSortie desc"))));
                return asortie2;
            }
            if ((daty1.compareTo("") != 0) & (daty2.compareTo("") != 0)) {
                Sortie asortie3[] = (Sortie[]) su.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and daty>='")).append(daty1).append("' and daty<='").append(daty2).append("' order by idSortie desc"))));
                return asortie3;
            } else {
                Sortie asortie4[] = null;
                return asortie4;
            }
        } catch (Exception ex) {
            throw new ErreurDAO(ex.getMessage());
        }
    }

    public Sortie[] findSortieSourceCaissse(String idSortie, String daty1, String daty2, String beneficiaire, String typeSortie, String designation, String idModePaiement, String idDevise, String idCaisse, String idEtat, String sourceC) throws ErreurDAO {
        try {
            int a[] = {
                1, 3, 5, 6, 7, 8, 10, 9, 18
            };
            String val[] = new String[a.length];
            val[0] = idSortie;
            val[1] = designation;
            val[2] = beneficiaire;
            val[3] = typeSortie;
            val[4] = idDevise;
            val[5] = idModePaiement;
            val[6] = idEtat;
            val[7] = idCaisse;
            val[8] = sourceC;
            SortieUtil su = new SortieUtil();
            su.setNomTable("sortiecompletvalide");
            if ((daty1.compareTo("") == 0) & (daty2.compareTo("") == 0)) {
                Sortie asortie[] = (Sortie[]) su.rechercher(a, val, " order by idSortie desc");
                return asortie;
            }
            if ((daty1.compareTo("") > 0) & (daty2.compareTo("") == 0)) {
                Sortie asortie1[] = (Sortie[]) su.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and daty>='")).append(daty1).append("' order by idSortie desc"))));
                return asortie1;
            }
            if ((daty1.compareTo("") == 0) & (daty2.compareTo("") > 0)) {
                Sortie asortie2[] = (Sortie[]) su.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and daty<='")).append(daty2).append("' order by idSortie desc"))));
                return asortie2;
            }
            if ((daty1.compareTo("") != 0) & (daty2.compareTo("") != 0)) {
                Sortie asortie3[] = (Sortie[]) su.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and daty>='")).append(daty1).append("' and daty<='").append(daty2).append("' order by idSortie desc"))));
                return asortie3;
            } else {
                Sortie asortie4[] = null;
                return asortie4;
            }
        } catch (Exception ex) {
            throw new ErreurDAO(ex.getMessage());
        }
    }

    public Sortie[] findSortieLettre(String idSortie, String daty1, String daty2, String beneficiaire, String typeSortie, String designation, String idModePaiement, String idDevise, String idCaisse, String idEtat, String parution, String agence, String colonne, String ordre, String prj, String part, String fact, String apresW) throws ErreurDAO {
        try {
            int a[] = {
                1, 3, 5, 6, 7, 8, 10, 9, 12, 13, 14, 15, 16
            };
            String val[] = new String[a.length];
            val[0] = idSortie;
            val[1] = designation;
            val[2] = beneficiaire;
            val[3] = typeSortie;
            val[4] = idDevise;
            val[5] = idModePaiement;
            val[6] = idEtat;
            val[7] = idCaisse;
            val[8] = parution;
            val[9] = agence;
            val[10] = prj;
            val[11] = part;
            val[12] = fact;
            SortieUtil su = new SortieUtil();
            su.setNomTable("SortieLettre");
            String apresWhere = null;
            if (apresW.compareTo("") > 0) {
                apresW = " and " + apresW + " ";
            }
            if ((daty1.compareTo("") == 0) & (daty2.compareTo("") == 0)) {
                Sortie asortie[] = (Sortie[]) su.rechercher(a, val, apresW + String.valueOf(String.valueOf((new StringBuffer(" order by ")).append(colonne).append(" ").append(ordre))));
                return asortie;
            }
            if ((daty1.compareTo("") > 0) & (daty2.compareTo("") == 0)) {
                Sortie asortie1[] = (Sortie[]) su.rechercher(a, val, apresW + String.valueOf(String.valueOf((new StringBuffer(" and daty>='")).append(daty1).append("' order by ").append(colonne).append(" ").append(ordre))));
                return asortie1;
            }
            if ((daty1.compareTo("") == 0) & (daty2.compareTo("") > 0)) {
                Sortie asortie2[] = (Sortie[]) su.rechercher(a, val, apresW + String.valueOf(String.valueOf((new StringBuffer(" and daty<='")).append(daty2).append("' order by ").append(colonne).append(" ").append(ordre))));
                return asortie2;
            }
            if ((daty1.compareTo("") != 0) & (daty2.compareTo("") != 0)) {
                Sortie asortie3[] = (Sortie[]) su.rechercher(a, val, apresW + String.valueOf(String.valueOf((new StringBuffer(" and daty>='")).append(daty1).append("' and daty<='").append(daty2).append("' order by ").append(colonne).append(" ").append(ordre))));
                return asortie3;
            } else {
                Sortie asortie4[] = null;
                return asortie4;
            }
        } catch (Exception ex) {
            throw new ErreurDAO(ex.getMessage());
        }
    }

    /*Critere projet nosoloiko ben Caisse*/
    public Sortie[] findSortieAgence(String idSortie, String daty1, String daty2, String beneficiaire, String typeSortie, String designation, String idModePaiement, String idDevise, String idCaisse, String idEtat, String parution, String agence, String colonne, String ordre, String prj, String part, String fact, String idLigne) throws ErreurDAO {
        try {

            int a[] = {
                1, 3, 5, 6, 7, 8, 10, 9, 12, 13, 14, 15, 16, 17
            };
            String val[] = new String[a.length];

            val[0] = idSortie;
            val[1] = designation;
            val[2] = beneficiaire;
            val[3] = typeSortie;
            val[4] = idDevise;
            val[5] = idModePaiement;
            val[6] = idEtat;
            val[7] = idCaisse;
            val[8] = parution;
            val[9] = agence;
            val[10] = prj;
            val[11] = part;
            val[12] = fact;
            val[13] = idLigne;

            SortieUtil su = new SortieUtil();
            su.setNomTable("sortiesansreport");
            int numInt[] = {2};
            String valInte[] = {daty1, daty2};
            su.utiliserChampClasse();
            return (Sortie[]) su.rechercher(a, val, " order by " + colonne + " " + ordre, numInt, valInte);
        } catch (Exception ex) {
            throw new ErreurDAO(ex.getMessage());
        }
    }

    public SyntheseCompte[] findSyntheseCompteSortie(String daty1, String daty2, String idCaiss, String benC, String compte, String descComp) throws Exception {
        int a[] = {3, 4, 5, 6};
        String val[] = {idCaiss, benC, compte, descComp};
        SyntheseCompteUtil s = new SyntheseCompteUtil();
        s.setNomTable("SortieCompValCatgroup");
        int numInt[] = {1};
        String valInte[] = {daty1, daty2};
        return (SyntheseCompte[]) s.rechercher(a, val, " order by daty desc ", numInt, valInte);
    }

    public SyntheseCompte[] findSyntheseCompteEntree(String daty1, String daty2, String idCaiss, String benC, String compte, String descComp) throws Exception {
        int a[] = {3, 4, 5, 6};
        String val[] = {idCaiss, benC, compte, descComp};
        SyntheseCompteUtil s = new SyntheseCompteUtil();
        s.setNomTable("EntreeCompValCatgroup");
        int numInt[] = {1};
        String valInte[] = {daty1, daty2};
        return (SyntheseCompte[]) s.rechercher(a, val, " order by daty desc ", numInt, valInte);
    }

    public SyntheseCompte[] findSyntheseCompteSortieType(String daty1, String daty2, String idCaiss, String benC, String compte, String descComp, String idT, String v) throws Exception {
        int a[] = {3, 4, 5, 6, 7, 8};
        String val[] = {idCaiss, benC, compte, descComp, idT, v};
        SyntheseCompteTypeUtil s = new SyntheseCompteTypeUtil();
        s.setNomTable("sortiecompvalcattype");
        int numInt[] = {1};
        String valInte[] = {daty1, daty2};
        return (SyntheseCompte[]) s.rechercher(a, val, " order by daty desc ", numInt, valInte);
    }

    public SyntheseCompte[] findSyntheseCompteEntreeType(String daty1, String daty2, String idCaiss, String benC, String compte, String descComp, String idT, String v) throws Exception {
        int a[] = {3, 4, 5, 6, 7, 8};
        String val[] = {idCaiss, benC, compte, descComp, idT, v};
        SyntheseCompteTypeUtil s = new SyntheseCompteTypeUtil();
        s.setNomTable("entreecompvalcattype");
        int numInt[] = {1};
        String valInte[] = {daty1, daty2};
        return (SyntheseCompte[]) s.rechercher(a, val, " order by daty desc ", numInt, valInte);
    }

    public String createEntree(String datee, String desi, String mont, String sour, String typ, String n_pie, String dev, String mode, String cais, String rem, String refUser, String paru, String agence, String source, String prj, String part, String idLigne) throws Exception {
        try {
            if (typ.compareTo("tEnt1") == 0) {
                String s = createEntreeFacture(datee, desi, mont, sour, typ, n_pie, dev, mode, cais, rem, refUser, paru, agence, source, prj, part, idLigne);
                return s;
            } else {
                String s1 = createEntreeNonFact(datee, desi, mont, sour, typ, n_pie, dev, mode, cais, rem, refUser, paru, agence, source, prj, part, idLigne);
                return s1;
            }
        } catch (ErreurDAO ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        }
    }

    public String createEntree(String datee, String desi, String mont, String sour, String typ, String n_pie, String dev, String mode, String cais, String rem, String refUser, String paru, String agence, String prj, String prt, String idLigne, Connection con) throws Exception {
        try {
            if (verifEtatCaisse(cais).compareTo("etaCs1") > 0) {
                throw new ErreurDAO("La caisse est ferm�e!");
            } else {
                Entree c = new Entree(datee, desi, mont, sour, typ, n_pie, dev, mode, cais, "eta2", rem, paru, agence, "BE011", prj, prt, idLigne);
                //MapHistorique h = new MapHistorique("Entree", "insert", refUser, c.getTuppleID());
                c.insertToTable(con);
                //h.insertToTable(con);
                Compte compteCaisse = FactureEJBClient.getInterface().findCompte("%", "%", cais, Utilitaire.dateDuJour())[0];
                Compte compteVirement = FactureEJBClient.getInterface().findCompte("%", "%", "Compte de virement", Utilitaire.dateDuJour())[0];
                FactureEJBClient.getInterface().createEcritureConnection(Utilitaire.dateDuJour(), compteCaisse.getId(), "Recette ".concat(String.valueOf(String.valueOf(desi))), String.valueOf(mont), "0", c.getTuppleID(), refUser, con);
                FactureEJBClient.getInterface().createEcritureConnection(Utilitaire.dateDuJour(), compteVirement.getId(), "Recette ".concat(String.valueOf(String.valueOf(desi))), "0", String.valueOf(mont), c.getTuppleID(), refUser, con);
                String s = c.getTuppleID();
                return s + " d";
            }
        } catch (ErreurDAO ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        }
    }

    public String updateEntree(String idEntree, String datee, String desi, String mont, String sour, String typ, String n_pie, String dev, String mode, String cais, String eta, String rem, String refUser, String prj, String part, String idLigne) throws ErreurDAO, Exception {
        try {
            if (verifEtatCaisse(cais).compareTo("etaCs1") == 0) {
                LCEjb lce = LCEjbClient.getInterface();
                System.out.println("Apres verif caisse :".concat(String.valueOf(String.valueOf(verifEtatCaisse(cais)))));
                Entree e = new Entree(idEntree, Utilitaire.string_date("dd/MM/yyyy", datee), desi, Utilitaire.stringToDouble(mont), sour, typ, n_pie, dev, mode, cais, eta, rem, prj, part, idLigne);
                MapHistorique h = new MapHistorique("Entree", "update", refUser, e.getTuppleID());
                Entree u = findEntree(idEntree, "", "", "", "", "", "", "", "", "", "")[0];

                LigneCredit lc = lce.findLC(u.getIdLigne(), "", "", "", "", "", "", "LIGNECREDITRECETTE")[0];

                if (lc == null) {
                    System.out.println("IdLigne non ins�rer!!");
                } else { //Mbola miaraka mihena aloha ny r�alisation mandra-pisin'ny engagement sy ny visa
                    double diffMontant = u.getMontant() - Utilitaire.stringToDouble(mont);
                    if (diffMontant < 0) {
                        lc.setMontantEng(lc.getMontantEng() + diffMontant);
                        lc.setMontantVis(lc.getMontantVis() + diffMontant);
                        lc.setMontantFac(lc.getMontantFac() + diffMontant);

                    } else {
                        lc.setMontantEng(lc.getMontantEng() - diffMontant);
                        lc.setMontantVis(lc.getMontantVis() - diffMontant);
                        lc.setMontantFac(lc.getMontantFac() - diffMontant);
                    }
                    lc.upDateToTable();
                }
                if (u.getMontant() < Utilitaire.stringToDouble(mont)) {
                    e.updateToTableWithHisto(h);
                }
                String s = e.getTuppleID();
                return s;
            } else {
                throw new ErreurDAO("La caisse est ferm�e!");
            }
        } catch (ErreurDAO ex) {
            throw new ErreurDAO(ex.getMessage());
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public int deleteEntree(String idEntree, String refUser) throws ErreurDAO {
        /*try
        {
            Entree e = new Entree(idEntree, null, "-", 0.0D, "-", "-", "-", "-", "-", "-", "-", "-");
            MapHistorique h = new MapHistorique("Entree", "delete", refUser, e.getTuppleID());
            e.deleteToTable(h);
            int i = 1;
            return i;
        }
        catch(ErreurDAO ex)
        {
            throw new ErreurDAO(ex.getMessage());
        }*/
        return 1;
    }

    public Entree[] findEntree(String idEntree, String daty1, String daty2, String client, String typeEntree, String designation, String idModePaiement, String idDevise, String idEtat) throws ErreurDAO {
        try {
            Entree aentree[] = findEntree(idEntree, daty1, daty2, client, typeEntree, designation, idModePaiement, "%", idDevise, "%", idEtat);
            return aentree;
        } catch (Exception ex) {
            throw new ErreurDAO(ex.getMessage());
        }
    }

    public Entree[] findEntreeBenCaisse(String idEntree, String daty1, String daty2, String client, String typeEntree, String designation, String idModePaiement, String numPiece, String idDevise, String idCaisse, String idEtat, String benCaisse) throws ErreurDAO {
        try {
            int a[] = {
                1, 3, 5, 6, 7, 8, 9, 11, 10, 17
            };
            String val[] = new String[a.length];
            val[0] = idEntree;
            val[1] = designation;
            val[2] = client;
            val[3] = typeEntree;
            val[4] = numPiece;
            val[5] = idDevise;
            val[6] = idModePaiement;
            val[7] = idEtat;
            val[8] = idCaisse;
            val[9] = benCaisse;
            EntreeUtil eu = new EntreeUtil();
            eu.setNomTable("entreecompletvalide");
            if ((daty1.compareTo("") == 0) & (daty2.compareTo("") == 0)) {
                Entree aentree[] = (Entree[]) eu.rechercher(a, val, " order by idEntree desc");
                return aentree;
            }
            if ((daty1.compareTo("") > 0) & (daty2.compareTo("") == 0)) {
                Entree aentree1[] = (Entree[]) eu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and daty>='")).append(daty1).append("' order by idEntree desc"))));
                return aentree1;
            }
            if ((daty1.compareTo("") == 0) & (daty2.compareTo("") > 0)) {
                Entree aentree2[] = (Entree[]) eu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and daty<='")).append(daty2).append("' order by idEntree desc"))));
                return aentree2;
            }
            if ((daty1.compareTo("") != 0) & (daty2.compareTo("") != 0)) {
                Entree aentree3[] = (Entree[]) eu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and daty>='")).append(daty1).append("' and daty<='").append(daty2).append("' order by idEntree desc"))));
                return aentree3;
            } else {
                throw new ErreurDAO("Probl�me dans la recherche");
            }
        } catch (Exception ex) {
            throw new ErreurDAO(ex.getMessage());
        }
    }

    public Entree[] findEntree(String idEntree, String daty1, String daty2, String client, String typeEntree, String designation, String idModePaiement, String numPiece, String idDevise, String idCaisse, String idEtat) throws ErreurDAO {
        try {
            int a[] = {
                1, 3, 5, 6, 7, 8, 9, 11, 10
            };
            String val[] = new String[a.length];
            val[0] = idEntree;
            val[1] = designation;
            val[2] = client;
            val[3] = typeEntree;
            val[4] = numPiece;
            val[5] = idDevise;
            val[6] = idModePaiement;
            val[7] = idEtat;
            val[8] = idCaisse;
            EntreeUtil eu = new EntreeUtil();
            if ((daty1.compareTo("") == 0) & (daty2.compareTo("") == 0)) {
                Entree aentree[] = (Entree[]) eu.rechercher(a, val, " order by idEntree desc");
                return aentree;
            }
            if ((daty1.compareTo("") > 0) & (daty2.compareTo("") == 0)) {
                Entree aentree1[] = (Entree[]) eu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and daty>='")).append(daty1).append("' order by idEntree desc"))));
                return aentree1;
            }
            if ((daty1.compareTo("") == 0) & (daty2.compareTo("") > 0)) {
                Entree aentree2[] = (Entree[]) eu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and daty<='")).append(daty2).append("' order by idEntree desc"))));
                return aentree2;
            }
            if ((daty1.compareTo("") != 0) & (daty2.compareTo("") != 0)) {
                Entree aentree3[] = (Entree[]) eu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and daty>='")).append(daty1).append("' and daty<='").append(daty2).append("' order by idEntree desc"))));
                return aentree3;
            } else {
                throw new ErreurDAO("Probl�me dans la recherche");
            }
        } catch (Exception ex) {
            throw new ErreurDAO(ex.getMessage());
        }
    }

    public Entree[] findEntreeAgence(String idEntree, String daty1, String daty2, String client, String typeEntree, String designation, String idModePaiement, String numPiece, String idDevise, String idCaisse, String idEtat, String agenc, String paru, String colonne, String ordre) throws ErreurDAO {
        try {
            int a[] = {
                1, 3, 5, 6, 7, 8, 15, 11, 10, 14,
                13
            };
            String val[] = new String[a.length];
            val[0] = idEntree;
            val[1] = designation;
            val[2] = client;
            val[3] = typeEntree;
            val[4] = numPiece;
            val[5] = idDevise;
            val[6] = idModePaiement;
            val[7] = idEtat;
            val[8] = idCaisse;
            val[9] = agenc;
            val[10] = paru;
            EntreeUtil eu = new EntreeUtil();
            if ((daty1.compareTo("") == 0) & (daty2.compareTo("") == 0)) {
                Entree aentree[] = (Entree[]) eu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" order by ")).append(colonne).append(" ").append(ordre))));
                return aentree;
            }
            if ((daty1.compareTo("") > 0) & (daty2.compareTo("") == 0)) {
                Entree aentree1[] = (Entree[]) eu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and daty>='")).append(daty1).append("' order by ").append(colonne).append(" ").append(ordre))));
                return aentree1;
            }
            if ((daty1.compareTo("") == 0) & (daty2.compareTo("") > 0)) {
                Entree aentree2[] = (Entree[]) eu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and daty<='")).append(daty2).append("' order by ").append(colonne).append(" ").append(ordre))));
                return aentree2;
            }
            if ((daty1.compareTo("") != 0) & (daty2.compareTo("") != 0)) {
                Entree aentree3[] = (Entree[]) eu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and daty>='")).append(daty1).append("' and daty<='").append(daty2).append("' order by ").append(colonne).append(" ").append(ordre))));
                return aentree3;
            } else {
                throw new ErreurDAO("Probl�me dans la recherche");
            }
        } catch (Exception ex) {
            throw new ErreurDAO(ex.getMessage());
        }
    }

    public Entree[] findEntreePenalite(String idEntree, String daty1, String daty2, String client, String typeEntree, String designation, String idModePaiement, String numPiece, String idDevise, String idCaisse, String idEtat) throws ErreurDAO {
        try {
            int a[] = {
                1, 3, 5, 6, 7, 8, 9, 11, 10
            };
            String val[] = new String[a.length];
            val[0] = idEntree;
            val[1] = designation;
            val[2] = client;
            val[3] = typeEntree;
            val[4] = numPiece;
            val[5] = idDevise;
            val[6] = idModePaiement;
            val[7] = idEtat;
            val[8] = idCaisse;
            EntreeUtil eu = new EntreeUtil();
            eu.setNomTable("EntreeJour");
            if ((daty1.compareTo("") == 0) & (daty2.compareTo("") == 0)) {
                Entree aentree[] = (Entree[]) eu.rechercher(a, val, " order by daty asc, idEntree asc");
                return aentree;
            }
            if ((daty1.compareTo("") > 0) & (daty2.compareTo("") == 0)) {
                Entree aentree1[] = (Entree[]) eu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and daty>='")).append(daty1).append("' order by daty asc, idEntree asc"))));
                return aentree1;
            }
            if ((daty1.compareTo("") == 0) & (daty2.compareTo("") > 0)) {
                Entree aentree2[] = (Entree[]) eu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and daty<='")).append(daty2).append("' order by daty asc, idEntree asc"))));
                return aentree2;
            }
            if ((daty1.compareTo("") != 0) & (daty2.compareTo("") != 0)) {
                Entree aentree3[] = (Entree[]) eu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and daty>='")).append(daty1).append("' and daty<='").append(daty2).append("' order by daty asc, idEntree asc"))));
                return aentree3;
            } else {
                throw new ErreurDAO("Probl�me dans la recherche");
            }
        } catch (Exception ex) {
            throw new ErreurDAO(ex.getMessage());
        }
    }

    public String verifEtatCaisse(String cais) throws ErreurDAO {
        try {
            Caisse ca = null;
            ca = findCaisse(cais, "%", "%", "%")[0];
            String s = ca.getIdEtatCaisse();
            return s;
        } catch (ErreurDAO ex) {
            throw new ErreurDAO(ex.getMessage());
        }
    }

    public int annulerEntree(String idEntree, String refuser) throws ErreurDAO {
        Connection c = null;
        Entree en1 = null;
        Entree en2[] = null;
        MapHistorique h3 = null;
        facture.AutorisationAnnulation aut[] = null;
        FactureEjb fl = null;
        LCEjb lce = null;
        LigneCredit lc = null;
        try {
            c = (new UtilDB()).GetConn();
            c.setAutoCommit(false);
            fl = FactureEJBClient.getInterface();

            aut = fl.findAutorisationAnnulation("%", idEntree, "%", "", "", "%", "typOb2");
            if (aut.length < 1) {
                throw new Exception("V�rifiez l'autorisation d'annulation");
            }
            en2 = findEntree(idEntree, "", "", "%", "%", "%", "%", "%", "%", "%", "%");
            if (en2[0].getIdEtat().compareTo("eta1") == 0) {
                throw new Exception("L'entr�e a d�j� �t� annul�e!");
            }
            en1 = en2[0];
            en1.setIdEtat("eta1");
            en1.updateToTable(c);

            int[] a = {1};
            String[] vall = {en1.getIdLigne()};
            lc = (LigneCredit) new LigneCreditUtil().rechercher(a,
                    vall, "", c)[0];

            if (lc == null) {
                System.out.println("IdLigne non ins�rer!!");
            } else { //Mbola miaraka mihena aloha ny r�alisation mandra-pisin'ny engagement sy ny visa
                lc.setMontantEng(lc.getMontantEng() - en1.getMontant());
                lc.setMontantVis(lc.getMontantVis() - en1.getMontant());
                lc.setMontantFac(lc.getMontantFac() - en1.getMontant());
                lc.updateToTable(c);
            }
            HistoriqueEtat he = new HistoriqueEtat(idEntree, refuser, "eta1", Utilitaire.dateDuJourSql());
            MapHistorique mh = new MapHistorique("Entree", "Annulation", refuser, en1.getTuppleID());
            mh.insertToTable(c);
            he.insertToTable(c);
            Compte compteCaisse = FactureEJBClient.getInterface().findCompte("%", "%", en1.getIdCaisse(), Utilitaire.dateDuJour())[0];
            Compte compteClient = FactureEJBClient.getInterface().findCompte("%", "%", "Compte de virement", Utilitaire.dateDuJour())[0];
            FactureEJBClient.getInterface().createEcritureConnection(Utilitaire.dateDuJour(), compteCaisse.getId(), "Annulation ".concat(String.valueOf(String.valueOf(en1.getNumpiece()))), "0", String.valueOf(en1.getMontant()), en1.getTuppleID(), refuser, c);
            FactureEJBClient.getInterface().createEcritureConnection(Utilitaire.dateDuJour(), compteClient.getId(), "Annulation ".concat(String.valueOf(String.valueOf(en1.getNumpiece()))), String.valueOf(en1.getMontant()), "0", en1.getTuppleID(), refuser, c);
            c.commit();
            int i = 1;
            return i;
        } catch (Exception ex) {
            try {
                ex.printStackTrace();
                c.rollback();
            } catch (SQLException exsq) {
                throw new ErreurDAO(exsq.getMessage());
            }
            throw new ErreurDAO(ex.getMessage());
        } finally {
            try {
                c.close();
            } catch (SQLException exsq) {
                throw new ErreurDAO(exsq.getMessage());
            }
        }
    }

    public int annulerSortie(String idSortie, String refuser) throws ErreurDAO {
        Connection c = null;
        Sortie so1 = null;
        Sortie so2[] = null;
        MapHistorique h3 = null;
        facture.AutorisationAnnulation aut[] = null;
        FactureEjb fl = null;
        try {
            c = (new UtilDB()).GetConn();
            c.setAutoCommit(false);
            fl = FactureEJBClient.getInterface();
            aut = fl.findAutorisationAnnulation("%", idSortie, "%", "", "", "%", "typOb3");
            if (aut.length < 1) {
                throw new ErreurDAO("V�rifiez l'autorisation d'annulation");
            }
            so2 = findSortie(idSortie, "", "", "%", "%", "%", "%", "%", "%", "%");
            if (so2[0].getIdEtat().compareTo("eta1") == 0) {
                throw new ErreurDAO("La sortie a d�j� �t� annul�e!");
            }
            so1 = so2[0];
            so1.setIdEtat("eta1");
            int[] a = {1};
            String[] vall = {so1.getIdLigne()};
            LigneCredit lc = (LigneCredit) new LigneCreditUtil().rechercher(a,
                    vall, "", c)[0];

            if (lc == null) {
                System.out.println("IdLigne non ins�rer!!");
            } else { //Mbola miaraka mihena aloha ny r�alisation mandra-pisin'ny engagement sy ny visa
                lc.setMontantEng(lc.getMontantEng() - so1.getMontant());
                lc.setMontantVis(lc.getMontantVis() - so1.getMontant());
                lc.setMontantFac(lc.getMontantFac() - so1.getMontant());
                lc.updateToTable(c);
            }
            so1.updateToTable(c);
            HistoriqueEtat he = new HistoriqueEtat(idSortie, refuser, "eta1", Utilitaire.dateDuJourSql());
            MapHistorique mh = new MapHistorique("Sortie", "Annulation", refuser, so1.getTuppleID());
            mh.insertToTable(c);
            he.insertToTable(c);
            Compte compteCaisse = FactureEJBClient.getInterface().findCompte("%", "%", so1.getIdCaisse(), Utilitaire.dateDuJour())[0];
            Compte compteClient = FactureEJBClient.getInterface().findCompte("%", "%", "Compte de virement", Utilitaire.dateDuJour())[0];
            FactureEJBClient.getInterface().createEcritureConnection(Utilitaire.dateDuJour(), compteCaisse.getId(), "Annulation ".concat(String.valueOf(String.valueOf(so1.getTuppleID()))), String.valueOf(so1.getMontant()), "0", so1.getTuppleID(), refuser, c);
            FactureEJBClient.getInterface().createEcritureConnection(Utilitaire.dateDuJour(), compteClient.getId(), "Annulation ".concat(String.valueOf(String.valueOf(so1.getTuppleID()))), "0", String.valueOf(so1.getMontant()), so1.getTuppleID(), refuser, c);
            c.commit();
            int i = 1;
            return i;
        } catch (Exception ex) {
            try {
                c.rollback();
                throw new ErreurDAO(ex.getMessage());
            } catch (Exception ef) {
                throw new ErreurDAO(ef.getMessage());
            }
        } finally {
            try {
                c.close();
            } catch (SQLException exsq) {
                throw new ErreurDAO(exsq.getMessage());
            }
        }
    }

    public int verifExistFacture(String idObj, String typ) throws ErreurDAO {
        FactureEjb fl = null;
        FactMere fm6[] = null;
        try {
            if (typ.compareTo("tEnt1") == 0 || typ.compareTo("typOb1") == 0 || typ.compareTo("facture") == 0) {
                fl = FactureEJBClient.getInterface();
                fm6 = fl.findFactureMere("", "", idObj, "%", "", "%", "%", "%");
            }
            int i = 0;
            return i;
        } catch (Exception ex) {
            throw new ErreurDAO(ex.getMessage());
        }
    }

    public String createEntreeFacture(String datee, String desi, String mont, String sour, String typ, String n_pie, String dev, String mode, String cais, String rem, String refUser, String parution, String agence, String source, String prj, String part, String idLigne) throws Exception {
        FactureEjb fl = null;
        FactMere fm1[] = null;
        Entree entree_talou[] = null;
        facture.Avoir av[] = null;
        try {
            entree_talou = findEntree("%", "", "", "%", "tEnt1", "%", "%", n_pie, "%", "%", "eta2");
            double montant_talou = AdminEntree.getSommeEntree(entree_talou);
            double montant_vaovao = Utilitaire.stringToDouble(mont);
            double sommeAvoir = 0.0D;
            double mmmmmm = montant_talou + montant_vaovao;
            fl = FactureEJBClient.getInterface();
            if (verifEtatCaisse(cais).compareTo("etaCs1") > 0) {
                throw new ErreurDAO("La caisse est ferm�e!");
            }
            fm1 = fl.findFactureMere("", "", n_pie, "%", "", "%", "%", "%");
            if (fm1.length < 1) {
                throw new ErreurDAO("V�rifiez le num�ro de pi�ce");
            }
            av = fl.findAvoir("%", fm1[0].getTuppleID(), "%", "", "", "%", "%");
            sommeAvoir = AdminAvoir.getSommeMontantAvoir(av);
            if (fm1[0].getIdEtat().compareTo("eta4") > 0) {
                throw new ErreurDAO("V�rifiez l'�tat de la facture");
            }
            if (montant_talou + montant_vaovao + sommeAvoir > fm1[0].getMontantAPayer()) {
                throw new ErreurDAO("La somme d�passe le montant total!");
            }
            if (montant_talou + montant_vaovao + sommeAvoir == fm1[0].getMontantTtc()) {
                fm1[0].setIdEtat("eta3");
                MapHistorique h = new MapHistorique("Facture", "update", refUser, fm1[0].getTuppleID());
                fm1[0].upDateToTable();
                h.insertToTable();
            }
            String s = createEntreeNonFact(datee, desi, mont, sour, typ, n_pie, dev, mode, cais, rem, refUser, parution, agence, source, prj, part, idLigne);
            return s;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        }
    }

    public String createEntreeNonFact(String datee, String desi, String mont, String sour, String typ, String n_pie, String dev, String mode, String cais, String rem, String refUser, String parution, String agence, String source, String prj, String part, String idLigne) throws Exception {
        Connection con = null;
        try {
            con = (new UtilDB()).GetConn();
            con.setAutoCommit(false);
            if (verifEtatCaisse(cais).compareTo("etaCs1") > 0) {
                throw new ErreurDAO("La caisse est ferm�e!");
            }
            Entree c = new Entree(datee, desi, mont, sour, typ, n_pie, dev, mode, cais, "eta2", rem, parution, agence, source, prj, part, idLigne);
            MapHistorique h = new MapHistorique("Entree", "insert", refUser, c.getTuppleID());

            int[] a = {1};
            String[] vall = {idLigne};
            LigneCreditUtil lu = new LigneCreditUtil();
            lu.setNomTable("LigneCreditRecette");
            LigneCredit lc = (LigneCredit) lu.rechercher(a, vall, "", con)[0];

            if (lc == null) {
                System.out.println("IdLigne non identifier!!");
            } else { //Mbola miaraka mitombo aloha ny r�alisation mandra-pisin'ny engagement sy ny visa
                lc.setMontantEng(lc.getMontantEng() + c.getMontant());
                lc.setMontantVis(lc.getMontantVis() + c.getMontant());
                lc.setMontantFac(lc.getMontantFac() + c.getMontant());
                lc.updateToTable(con);
                if (lc.getIdLigne().compareToIgnoreCase("init") != 0) {
                    c.setSource(lc.getIdEntite());
                    c.setIdTypeEntree(lc.getIdTypeLigne());
                }
            }

            c.insertToTable(con);
            h.insertToTable(con);
            con.commit();
            String s = c.getTuppleID();
            return s;
        } catch (Exception ex) {
            try {
                con.rollback();
                ex.printStackTrace();
                throw new Exception(ex.getMessage());
            } catch (Exception exe) {
                throw new Exception(exe.getMessage());
            }
        } finally {
            try {
                con.close();
            } catch (SQLException exsq) {
                throw new ErreurDAO(exsq.getMessage());
            }
        }

    }

    public ResultatEtSomme findVirement(String nomtable, String dev, String caisse1, String caisse2, String mode, String daty1, String daty2, String apreW, int numPage) throws Exception {
        SaisieVirementUtil svu = new SaisieVirementUtil();
        svu.setNomTable(nomtable);
        int numcol[] = {3, 4, 5, 6};
        String val[] = {dev, caisse1, caisse2, mode};
        int numColInt[] = {8};
        String valColInt[] = {daty1, daty2};
        String[] nomColSomme = {"montant"};
        return svu.rechercherPage(numcol, val, apreW, numColInt, valColInt, numPage, nomColSomme);
    }

    public SaisieVirement[] findVirementNormale(String nomtable, String id, String dev, String caisse1, String caisse2, String mode, String daty1, String daty2, String apreW) throws Exception {
        SaisieVirementUtil svu = new SaisieVirementUtil();
        svu.setNomTable(nomtable);
        int numcol[] = {1, 3, 4, 5, 6};
        String val[] = {id, dev, caisse1, caisse2, mode};
        int numColInt[] = {8};
        String valColInt[] = {daty1, daty2};
        String[] nomColSomme = {"montant"};
        return (SaisieVirement[]) svu.rechercher(numcol, val, apreW, numColInt, valColInt);
    }

    public SaisieVirement virer(String montant, String devise, String caisse1, String caisse2, String mode, String remarque, String daty, String refUser) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            SaisieVirement sv = new SaisieVirement(utilitaire.Utilitaire.stringToDouble(montant), devise, caisse1, caisse2, mode, remarque, daty);
            sv.insertToTableWithHisto(refUser);
            return sv;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void virerVirementMiltiple(String[] numCheque, String[] montant, String devise, String caisse1, String caisse2, String mode, String remarque, String daty, String refUser) throws Exception {
        Connection con = null;
        double somme = 0;
        try {
            con = (new UtilDB()).GetConn();
            con.setAutoCommit(false);
            String[] idVir = new String[numCheque.length];
            String idVirString = "";
            for (int i = 0; i < numCheque.length; i++) {
                double mt = utilitaire.Utilitaire.stringToDouble(montant[i]);
                SaisieVirement sv = new SaisieVirement(mt, devise, caisse1, caisse2, mode, remarque, daty);
                sv.setNumcheque(numCheque[i]);
                sv.insertToTableWithHisto(refUser);
                ded.Visa v = new ded.Visa("visaVirement", "getseqVisaVirement", "VSV", daty, remarque, sv.getId());
                v.insertToTableWithHisto(refUser, con);

                idVir[i] = sv.getId();
                idVirString += sv.getId() + "-";
                somme += mt;
            }
            SaisieVirement[] sv = (SaisieVirement[]) new SaisieVirementUtil().rechercher(1, idVir[0], con);
            String mvmax = Utilitaire.getMaxId("mvtcaisse");
            String[] g = Utilitaire.split(mvmax, "MVT");
            String idmvtor = "SMOR" + g[0] + 1;
            String idmvtorrec = "SMOR" + g[0] + 1 + "VIR";
            MvtCaisse dep = new MvtCaisse("", daty, daty, remarque + " : virement moins num " + idVirString, String.valueOf(somme), "0", sv[0].getDevise(), sv[0].getModePay(), sv[0].getCaisseDep(), "virement", "-", "-", sv[0].getTuppleID(), "4", "VRMT", idmvtor);
            MvtCaisse rec = new MvtCaisse("", daty, daty, remarque + " : virement plus num " + idVirString, "0", String.valueOf(somme), sv[0].getDevise(), sv[0].getModePay(), sv[0].getCaisseArr(), "virement", "-", "-", sv[0].getTuppleID(), "4", "VRMT", idmvtorrec);
            dep.insertToTableWithHisto(refUser, con);
            rec.insertToTableWithHisto(refUser, con);

            for (int k = 0; k < idVir.length; k++) {
                VirMvt vm = new VirMvt(idVir[k], dep.getTuppleID(), rec.getTuppleID(), remarque);
                vm.insertToTableWithHisto(refUser, con);
            }

            MvtOr crt = new MvtOr(idmvtorrec, rec.getTuppleID(), rec.getIdOrdre());
            MvtOr crt2 = new MvtOr(idmvtor, dep.getTuppleID(), dep.getIdOrdre());

            crt.insertToTableWithHisto(refUser, con);
            crt2.insertToTableWithHisto(refUser, con);

            con.commit();
        } catch (Exception ex) {
            con.rollback();
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        } finally {
            if (con != null) {
                con.close();
            }
        }
    }

    public Visa viserVirement(String idVir, String daty, String rem, String refUser) throws Exception {
        Connection con = null;
        // String numpiece=rem;
        try {
            con = (new UtilDB()).GetConn();
            con.setAutoCommit(false);
            SaisieVirement[] sv = (SaisieVirement[]) new SaisieVirementUtil().rechercher(1, idVir, con);
            if (sv.length == 0) {
                throw new Exception("Virement non saisie");
            }
            if (sv[0].getVisa(con) != null) {
                throw new Exception("deja vise");
            }

            ded.Visa v = new ded.Visa("visaVirement", "getseqVisaVirement", "VSV", daty, rem, idVir);
            String mvmax = Utilitaire.getMaxId("mvtcaisse");
            String[] g = Utilitaire.split(mvmax, "MVT");
            String idmvtor = "SMOR" + g[0] + 1;
            String idmvtorrec = "SMOR" + g[0] + 1 + "VIR";

            //ilay designation eto zany ovaina : sv[0].getRemarque()
            MvtCaisse dep = new MvtCaisse("", daty, daty, sv[0].getRemarque() + " : virement moins num " + idVir, String.valueOf(sv[0].getMontant()), "0", sv[0].getDevise(), sv[0].getModePay(), sv[0].getCaisseDep(), "virement moins", "-", "-", sv[0].getTuppleID(), "4", "VRMT", idmvtor);
            MvtCaisse rec = new MvtCaisse("", daty, daty, sv[0].getRemarque() + " : virement plus num " + idVir, "0", String.valueOf(sv[0].getMontant()), sv[0].getDevise(), sv[0].getModePay(), sv[0].getCaisseArr(), "virement plus", "-", "-", sv[0].getTuppleID(), "4", "VRMT", idmvtorrec);
            VirMvt vm = new VirMvt(idVir, dep.getTuppleID(), rec.getTuppleID(), rem);
            MvtOr crt = new MvtOr(idmvtorrec, rec.getTuppleID(), rec.getIdOrdre());
            MvtOr crt2 = new MvtOr(idmvtor, dep.getTuppleID(), dep.getIdOrdre());

            v.insertToTableWithHisto(refUser, con);
            dep.insertToTableWithHisto(refUser, con);
            rec.insertToTableWithHisto(refUser, con);
            crt.insertToTableWithHisto(refUser, con);
            crt2.insertToTableWithHisto(refUser, con);
            vm.insertToTableWithHisto(refUser, con);

            con.commit();
            return v;
        } catch (Exception ex) {
            con.rollback();
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        } finally {
            if (con != null) {
                con.close();
            }
        }
    }

    public boolean virer(String daty, String caisse1, String caisse2, String montant, String remarque, String devise, String mode, String refUser, String typeE, String typeS, String prj, String part, String fact, String idLigne) throws Exception {
        Connection con = null;
        try {
            con = (new UtilDB()).GetConn();
            con.setAutoCommit(false);
            String caisse11 = findCaisse(caisse1, "%", "%", "%")[0].getDescCaisse();
            String caisse12 = findCaisse(caisse2, "%", "%", "%")[0].getDescCaisse();
            createEntree(daty, String.valueOf(String.valueOf((new StringBuffer("virement du ")).append(caisse11).append(" vers ").append(caisse12))), montant, "clt1", typeE, "-", devise, mode, caisse2, "virement", refUser, "0", "ag005", prj, part, idLigne, con);
            createSortie(daty, String.valueOf(String.valueOf((new StringBuffer("virement du ")).append(caisse11).append(" vers ").append(caisse12))), montant, "BE011", typeS, devise, mode, caisse1, "virement", refUser, "0", "ag005", prj, part, fact, idLigne, con);
            con.commit();
            boolean flag = true;
            return flag;
        } catch (Exception ex) {
            try {
                con.rollback();
                ex.printStackTrace();
                throw new Exception(ex.getMessage());
            } catch (Exception exe) {
                throw new Exception(exe.getMessage());
            }
        } finally {
            try {
                con.close();
            } catch (SQLException exsq) {
                throw new ErreurDAO(exsq.getMessage());
            }
        }
    }

    public boolean reporter(String daty, String datyFin, String montant, String caisse, String devise, String refUser, String prj, String part, String fact, String idLigne) throws Exception {
        Connection con = null;
        try {
            con = (new UtilDB()).GetConn();
            con.setAutoCommit(false);
            createEntree(datyFin, "report du " + caisse, montant, "clt1", "TENT015", "-", devise, "pay1", caisse, "virement", refUser, "0", "ag005", prj, part, idLigne, con);
            createSortie(daty, "report du " + caisse, montant, "BE011", "TS020", devise, "pay1", caisse, "virement", refUser, "0", "ag005", prj, part, fact, idLigne, con);
            con.commit();
            boolean flag = true;
            return flag;
        } catch (Exception ex) {
            try {
                con.rollback();
                ex.printStackTrace();
                throw new Exception(ex.getMessage());
            } catch (Exception exe) {
                throw new Exception(exe.getMessage());
            }
        } finally {
            try {
                con.close();
            } catch (SQLException exsq) {
                throw new ErreurDAO(exsq.getMessage());
            }
        }
    }

    public Report[] findReport(String daty1, String daty2, String caisse, String devise) throws Exception {
        int numCol[] = {4, 5};
        String[] val = {devise, caisse};
        int numColInt[] = {2};
        String valColInt[] = {daty1, daty2};
        return (Report[]) new ReportUtil().rechercher(numCol, val, numColInt, valColInt);
    }

    /*public EtatCaisseReste[] findEtatCaisseResteMvt(String daty1, String daty2, String caisse, String entite) throws Exception {
    Connection c=null;
    try {
      String req1="select c.IDCAISSE, c.DESCCAISSE,b.val as entite ,nvl((select sum(mv.debit) from mvtCaisse mv ";
      String req2="where mv.IDCAISSE=c.IDCAISSE and mv.daty>='"+daty1+"' and mv.daty<='"+daty2+"' and mv.idCaisse like '"+caisse+"'),0) as debit ";
      String req3=",nvl((select sum(mv.credit) from mvtCaisse mv where mv.IDCAISSE=c.IDCAISSE and mv.daty>='"+daty1+"' and mv.daty<='"+daty2+"' and mv.idCaisse like '"+caisse+"'),0) as credit,nvl((select r.montant from report r where r.CAISSE=c.IDCAISSE ";
      String req4="and r.DATY='"+daty1+"'),0) as report from caisse c,beneficiaire b where c.RESPCAISSE=b.ID and b.val like '"+entite+"'";
      String req=req1+req2+req3+req4; System.out.println(req);
      c=new UtilDB().GetConn();
      Statement st=c.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
      ResultSet rs=st.executeQuery(req);
      EtatCaisseReste temp = null;
      Vector vect = new Vector();
      int i=0;
      while(rs.next())
      {
        //public EtatCaisseReste(java.sql.Date dt,String idCaisse,String descC,String entite,double credit,double deb,double res,double repE, double repD)
          temp = new EtatCaisseReste (utilitaire.Utilitaire.dateDuJourSql() ,rs.getString(1),rs.getString(2),rs.getString(3),rs.getDouble(5),rs.getDouble(4),rs.getDouble(6)+rs.getDouble(5)-rs.getDouble(4),rs.getDouble(6),0);
              vect.add(i,temp);
              i++;
      }
      EtatCaisseReste []retour = new EtatCaisseReste[i];
      vect.copyInto(retour);
      return retour;
    }
    catch (SQLException ex) {
      ex.printStackTrace();
      return null;
    }
    finally{
      if(c!=null)c.close();
    }
  }*/
    public EtatCaisseReste[] findEtatCaisseResteMvt(String daty1, String daty2, String caisse, String entite) throws Exception {
        Connection c = null;
        try {
            String req1 = "select c.IDCAISSE, c.DESCCAISSE,b.val as entite ,nvl((select sum(mv.debit) from mvtCaisse mv ";
            String req2 = String.valueOf(String.valueOf(new StringBuffer("where mv.IDCAISSE=c.IDCAISSE and mv.daty>='").append(daty1).append("' and mv.daty<='").append(daty2).append("' and mv.idCaisse like '").append(caisse).append("'),0) as debit ")));
            String req3 = String.valueOf(String.valueOf(new StringBuffer(",nvl((select sum(mv.credit) from mvtCaisse mv where mv.IDCAISSE=c.IDCAISSE and mv.daty>='").append(daty1).append("' and mv.daty<='").append(daty2).append("' and mv.idCaisse like '").append(caisse).append("'),0) as credit,nvl((select r.montant from report r where r.CAISSE=c.IDCAISSE ")));
            String req4 = String.valueOf(String.valueOf(new StringBuffer("and r.DATY='").append(daty1).append("'),0) as report from caisse c,typecaisse b where c.RESPCAISSE=b.ID and b.val like '").append(entite).append("'")));
            String req = String.valueOf(String.valueOf(new StringBuffer(String.valueOf(String.valueOf(req1))).append(req2).append(req3).append(req4)));
            System.out.println(req);

            c = new UtilDB().GetConn();
            Statement st = c.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = st.executeQuery(req);
            EtatCaisseReste temp = null;
            Vector vect = new Vector();
            int i = 0;

            while (rs.next()) {
                temp = new EtatCaisseReste(Utilitaire.dateDuJourSql(), rs.getString(1), rs.getString(2), rs.getString(3), rs.getDouble(5), rs.getDouble(4), rs.getDouble(6) + rs.getDouble(5) - rs.getDouble(4), rs.getDouble(6), 0.0D);
                vect.add(i, temp);
                i++;
            }
            EtatCaisseReste[] retour = new EtatCaisseReste[i];
            vect.copyInto(retour);
            return retour;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public ResultatEtSomme findReportPage(String daty1, String daty2, String caisse, String devise, int numP) throws Exception {
        int numCol[] = {4, 5};
        String[] val = {devise, caisse};
        int numColInt[] = {2};
        String valColInt[] = {daty1, daty2};
        String[] nomColSomme = {"montant"};
        return new ReportUtil().rechercherPage(numCol, val, "", numColInt, valColInt, numP, nomColSomme);
    }

    public Report reporter(String daty, String montant, String caisse, String devise, String refUser) throws Exception {
        Connection con = null;
        try {
            con = new UtilDB().GetConn();
            con.setAutoCommit(false);
            int[] champ = {2, 5};
            String[] val = {daty, caisse};
            Report[] taloha = (Report[]) new ReportUtil().rechercher(champ, val, "", con, null, null);
            if (taloha.length > 0) {
                throw new Exception("Caisse deja reporte");
            }
            Report r = new Report(daty, montant, devise, caisse);
            r.insertToTableWithHisto(refUser, con);
            return r;
        } catch (Exception ex) {
            try {
                con.rollback();
                ex.printStackTrace();
                throw new Exception(ex.getMessage());
            } catch (Exception exe) {
                throw new Exception(exe.getMessage());
            }
        } finally {
            try {
                con.close();
            } catch (SQLException exsq) {
                throw new ErreurDAO(exsq.getMessage());
            }
        }
    }

    public Change2 loadChangeValide(String devise, String datyInf) throws Exception {
        try {
            int a[] = {
                2
            };
            ChangeUtil chu = new ChangeUtil();
            String val[] = new String[a.length];
            val[0] = devise;
            Change2 change2 = (Change2) chu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and datyDebutValid<='")).append(datyInf).append("' order by datyDebutValid desc,idChange desc"))))[0];
            return change2;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public double[] calculResteCaisse(String idCaisse, String daty1, String daty2) {
        bean.TypeObjet dev[] = null;
        double ad[];
        try {
            TypeObjetUtil to = new TypeObjetUtil();
            dev = to.findTypeObjet("Devise", "%", "%");
            double retour[] = new double[dev.length];
            double ad1[] = null;
            return ad1;
        } catch (Exception ex) {
            ad = null;
        }
        return ad;
    }

    /*
  *Projet ea ete change en ben Caisse
  *******************************
  *Part a ete chang� en idLigne  */
    public Entree[] findEntreeLettre(String idEntree, String daty1, String daty2, String client, String typeEntree, String designation, String idModePaiement, String numPiece, String idDevise, String idCaisse, String idEtat, String agenc, String paru, String colonne, String ordre, String prj, String part, String apresW) throws Exception {
        try {
            int a[] = {
                1, 3, 5, 6, 7, 8, 15, 11, 10, 14, 13, 17, 18
            };
            String val[] = new String[a.length];
            val[0] = idEntree;
            val[1] = designation;
            val[2] = client;
            val[3] = typeEntree;
            val[4] = numPiece;
            val[5] = idDevise;
            val[6] = idModePaiement;
            val[7] = idEtat;
            val[8] = idCaisse;
            val[9] = agenc;
            val[10] = paru;
            val[11] = prj;
            val[12] = part;

            EntreeUtil eu = new EntreeUtil();
            eu.setNomTable("EntreeLettre");
            String apresWhere = null;
            if (apresW.compareTo("") > 0) {
                apresW = " and " + apresW + " ";
            }
            if ((daty1.compareTo("") == 0) & (daty2.compareTo("") == 0)) {
                apresWhere = apresW + String.valueOf(String.valueOf((new StringBuffer(" order by ")).append(colonne).append(" ").append(ordre)));
            }
            if ((daty1.compareTo("") > 0) & (daty2.compareTo("") == 0)) {
                apresWhere = apresW + String.valueOf(String.valueOf((new StringBuffer(" and daty>='")).append(daty1).append("' order by ").append(colonne).append(" ").append(ordre)));
            }
            if ((daty1.compareTo("") == 0) & (daty2.compareTo("") > 0)) {
                apresWhere = apresW + String.valueOf(String.valueOf((new StringBuffer(" and daty<='")).append(daty2).append("' order by ").append(colonne).append(" ").append(ordre)));
            }
            if ((daty1.compareTo("") != 0) & (daty2.compareTo("") != 0)) {
                apresWhere = apresW + String.valueOf(String.valueOf((new StringBuffer(" and daty>='")).append(daty1).append("' and daty<='").append(daty2).append("' order by ").append(colonne).append(" ").append(ordre)));
            }
            eu.utiliserChampClasse();
            return (Entree[]) (eu.rechercher(a, val, apresWhere));
        } catch (Exception ex) {
            throw new ErreurDAO(ex.getMessage());
        }
    }

    public Entree[] findEntreeLettrePage(String idEntree, String daty1, String daty2, String client, String typeEntree, String designation, String idModePaiement, String numPiece, String idDevise, String idCaisse, String idEtat, String agenc, String paru, String colonne, String ordre, String prj, String part, String apresW, int numPa) throws Exception {
        try {
            int a[] = {
                1, 3, 5, 6, 7, 8, 15, 11, 10, 14, 13, 16, 17
            };
            String val[] = new String[a.length];
            val[0] = idEntree;
            val[1] = designation;
            val[2] = client;
            val[3] = typeEntree;
            val[4] = numPiece;
            val[5] = idDevise;
            val[6] = idModePaiement;
            val[7] = idEtat;
            val[8] = idCaisse;
            val[9] = agenc;
            val[10] = paru;
            val[11] = prj;
            val[12] = part;
            EntreeUtil eu = new EntreeUtil();
            eu.setNomTable("EntreeLettre");
            String apresWhere = null;
            if (apresW.compareTo("") > 0) {
                apresW = " and " + apresW + " ";
            }
            if ((daty1.compareTo("") == 0) & (daty2.compareTo("") == 0)) {
                apresWhere = apresW + String.valueOf(String.valueOf((new StringBuffer(" order by ")).append(colonne).append(" ").append(ordre)));
            }
            if ((daty1.compareTo("") > 0) & (daty2.compareTo("") == 0)) {
                apresWhere = apresW + String.valueOf(String.valueOf((new StringBuffer(" and daty>='")).append(daty1).append("' order by ").append(colonne).append(" ").append(ordre)));
            }
            if ((daty1.compareTo("") == 0) & (daty2.compareTo("") > 0)) {
                apresWhere = apresW + String.valueOf(String.valueOf((new StringBuffer(" and daty<='")).append(daty2).append("' order by ").append(colonne).append(" ").append(ordre)));
            }
            if ((daty1.compareTo("") != 0) & (daty2.compareTo("") != 0)) {
                apresWhere = apresW + String.valueOf(String.valueOf((new StringBuffer(" and daty>='")).append(daty1).append("' and daty<='").append(daty2).append("' order by ").append(colonne).append(" ").append(ordre)));
            }
            return (Entree[]) (eu.rechercher(a, val, apresWhere, numPa));
        } catch (Exception ex) {
            throw new ErreurDAO(ex.getMessage());
        }
    }

    public EtatCaisse[] findEtatCaisseDepense(String daty1, String daty2, String caisse, String benCaisse) throws Exception {
        UtilDB util = null;
        PreparedStatement st = null;
        ResultSet rs = null;
        Connection c = null;
        try {
            util = new UtilDB();
            c = util.GetConn();
            String param = null;
            if ((benCaisse.compareTo("") == 0 || (benCaisse == null))) {
                benCaisse = "%";
            }
            if (caisse.compareToIgnoreCase("%") != 0) {
                param = "select val,sum(montant),idDevise,idCaisse from sortieCompletValide where montant>0 and idCaisse like '" + caisse + "' and sourceCaisse like '" + benCaisse + "'";
            } else {
                param = "select val,sum(montant),idDevise,'-' from sortieCompletValide where montant>0 and sourceCaisse like '" + benCaisse + "'";
            }
            if ((daty1.compareTo("") > 0) & (daty2.compareTo("") == 0)) {
                if ((daty1.compareTo("") > 0) & (daty2.compareTo("") == 0)) {
                    param = String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(param)))).append(" and daty>='").append(daty1).append("'")));
                }
            }
            if ((daty1.compareTo("") == 0) & (daty2.compareTo("") > 0)) {
                param = String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(param)))).append(" and daty<='").append(daty2).append("'")));
            }
            if ((daty1.compareTo("") != 0) & (daty2.compareTo("") != 0)) {
                param = String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(param)))).append(" and daty>='").append(daty1).append("' and daty<='").append(daty2).append("'")));
            }
            if (caisse.compareToIgnoreCase("%") != 0) {
                param = String.valueOf(String.valueOf(param)).concat(" group by val,idDevise,idCaisse order by val asc ");
            } else {
                param = String.valueOf(String.valueOf(param)).concat(" group by val,idDevise order by val asc ");
            }
            st = c.prepareStatement(param, 1004, 1008);
            rs = st.executeQuery();
            EtatCaisse aetatcaisse[] = EtatCaisseUtil.result(rs);
            return aetatcaisse;
        } catch (Exception ex) {
            try {
                ex.printStackTrace();
                c.rollback();
            } catch (SQLException exsq) {
                throw new ErreurDAO(exsq.getMessage());
            }
            throw new ErreurDAO(ex.getMessage());
        } finally {
            try {
                c.close();
                st.close();
                rs.close();
            } catch (SQLException exsq) {
                throw new ErreurDAO(exsq.getMessage());
            }
        }
    }

    public EtatCaisse[] findEtatCaisseEntree(String daty1, String daty2, String caisse, String benCaisse) throws Exception {
        UtilDB util = null;
        PreparedStatement st = null;
        ResultSet rs = null;
        Connection c = null;
        try {
            util = new UtilDB();
            c = util.GetConn();
            String param = null;
            if (caisse.compareToIgnoreCase("%") != 0) {
                param = "select val,sum(montant),idDevise,idCaisse from entreeCompletValide where montant>0 and idCaisse like '" + caisse + "' and benCaisse like '" + benCaisse + "'";
            } else {
                param = "select val,sum(montant),idDevise,'-' from entreeCompletValide where montant>0 and benCaisse like '" + benCaisse + "'";
            }
            if ((daty1.compareTo("") > 0) & (daty2.compareTo("") == 0)) {
                param = String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(param)))).append(" and daty>='").append(daty1).append("'")));
            }
            if ((daty1.compareTo("") == 0) & (daty2.compareTo("") > 0)) {
                param = String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(param)))).append(" and daty<='").append(daty2).append("'")));
            }
            if ((daty1.compareTo("") != 0) & (daty2.compareTo("") != 0)) {
                param = String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(param)))).append(" and daty>='").append(daty1).append("' and daty<='").append(daty2).append("'")));
            }
            if (caisse.compareToIgnoreCase("%") != 0) {
                param = String.valueOf(String.valueOf(param)).concat(" group by val,idDevise,idCaisse order by val asc ");
            } else {
                param = String.valueOf(String.valueOf(param)).concat(" group by val,idDevise order by val asc ");
            }
            st = c.prepareStatement(param, 1004, 1008);
            rs = st.executeQuery();
            EtatCaisse aetatcaisse[] = EtatCaisseUtil.result(rs);
            return aetatcaisse;
        } catch (Exception ex) {
            try {
                ex.printStackTrace();
                c.rollback();
            } catch (SQLException exsq) {
                throw new ErreurDAO(exsq.getMessage());
            }
            throw new ErreurDAO(ex.getMessage());
        } finally {
            try {
                c.close();
                st.close();
                rs.close();
            } catch (SQLException exsq) {
                throw new ErreurDAO(exsq.getMessage());
            }
        }
    }

    public EtatCaisseReste[] findEtatCaisseReste(String dateDebut, String dateFin, String caisse, String entite) throws Exception {
        EtatCaisseResteUtil ec = new EtatCaisseResteUtil();
        int[] a = {2, 4};
        String[] val = {caisse, entite};
        String apresWhere = null;
        if ((dateDebut.compareTo("") == 0) & (dateFin.compareTo("") == 0)) {
            throw new Exception("Il faut au moins une date");
        }
        if ((dateDebut.compareTo("") > 0) & (dateFin.compareTo("") == 0)) {
            dateFin = utilitaire.Utilitaire.formatterDaty(Utilitaire.ajoutJourDate(dateDebut, 7));
        }
        if ((dateDebut.compareTo("") == 0) & (dateFin.compareTo("") > 0)) {
            dateDebut = utilitaire.Utilitaire.formatterDaty(Utilitaire.ajoutJourDate(dateFin, -7));
        }
        apresWhere = " and daty>='" + dateDebut + "' and daty<='" + dateFin + "'";
        return (EtatCaisseReste[]) (ec.rechercher(a, val, apresWhere));
    }

    public String ventilerMvtCaisseDebit(String idMvt, String[] idLcDet, String[] montant, String[] remarque, String[] eta, String nature, String refU) throws Exception {
        Connection c = null;
        try {
            int nbAventiler = idLcDet.length;
            MvtCaisse[] de = this.findMvtCaisse(idMvt, "", "", "", "", "%", "%", "%", "%", "%", "%", "%", "%", "%");
            if (de.length == 0) {
                throw new Exception("L op n existe pas");
            }
            double sommeListe = Utilitaire.calculSomme(montant);
            if (de[0].getDebit() != sommeListe) {
                throw new Exception("La somme nest pas balancee");
            }
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            UnionIntraTable[] liste = new UnionIntraTable[nbAventiler];
            for (int i = 0; i < nbAventiler; i++) {
                liste[i] = new UnionIntraTable(ConstantesDed.getTableMvtLcDet(), ConstantesDed.getFonctMvtLcDet(), ConstantesDed.getSuffMvtLcDet(), idMvt, idLcDet[i], remarque[i], montant[i], eta[i]);
                liste[i].insertToTableWithHisto(refU, c);
                LcDetail[] lcd = (LcDetail[]) new LcDetailUtil().rechercher(1, idLcDet[i]);
                if (lcd.length == 0) {
                    throw new Exception("id lc non existant");
                }
                lcd[i].setMontantEng(lcd[i].getMontantEng() + Utilitaire.stringToDouble(montant[i]));
                lcd[i].updateToTableWithHisto(refU, c);
            }
            c.commit();
            return null;
        } catch (Exception ex) {
            c.rollback();
            ex.printStackTrace();
            return null;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public MvtCaisse[] findMvtCaisse(String id, String daty1, String daty2, String datyVal1, String datyVal2, String designation, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM) throws Exception {
        /**
         * Rehefa page=0 dia affichena daholo
         */
        try {
            int a[] = {1, 3, 6, 7, 8, 9, 10, 11, 12, 13};
            String aval[] = {id, designation, devise, mode, caisse, remarque, agence, tier, numP, typeM};
            int b[] = {2, 14};
            String bval[] = {daty1, daty2, datyVal1, datyVal2};
            MvtCaisseUtil m = new MvtCaisseUtil();
            return (MvtCaisse[]) (m.rechercher(a, aval, b, bval));
        } catch (Exception Ex) {
            throw new Exception(Ex.getMessage());
        }
    }

    public MvtCaisseLc[] findMvtCaisseLc(String id, String daty1, String daty2, String datyVal1, String datyVal2, String designation, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM, String idLigne, String typeLc, String compte, String ent, String dir, String mois1, String mois2) throws Exception {
        /**
         * Rehefa page=0 dia affichena daholo
         */
        try {
            int a[] = {1, 3, 6, 7, 8, 9, 10, 11, 12, 13, 16, 23, 24, 25, 26};
            String aval[] = {id, designation, devise, mode, caisse, remarque, agence, tier, numP, typeM, idLigne, typeLc, compte, ent, dir};
            int b[] = {2, 14, 29};
            String bval[] = {daty1, daty2, datyVal1, datyVal2, mois1, mois2};
            MvtCaisseUtil m = new MvtCaisseUtil();
            return (MvtCaisseLc[]) (m.rechercher(a, aval, b, bval));
        } catch (Exception Ex) {
            throw new Exception(Ex.getMessage());
        }
    }

    public ResultatEtSomme findMvtCaisse(String id, String daty1, String daty2, String datyVal1, String datyVal2, String designation, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM, int numPage) throws Exception {
        /**
         * Rehefa page=0 dia affichena daholo
         */
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            int a[] = {1, 3, 6, 7, 8, 9, 10, 11, 15, 13};
            String aval[] = {id, designation, devise, mode, caisse, remarque, agence, tier, numP, typeM};
            int b[] = {2, 14};
            String bval[] = {daty1, daty2, datyVal1, datyVal2};
            MvtCaisseUtil m = new MvtCaisseUtil();
            m.setNomTable("MvtCaisseLc");
            //System.out.println("AVANT Taille aty anaty fonction ");
            MvtCaisse[] ret = (MvtCaisse[]) (m.rechercher(a, aval, "", c, b, bval, numPage));
            //System.out.println("Taille aty anaty fonction "+ret.length);
            String nomColSom[] = {"debit", "credit"};
            double[] sommeNombre = m.calculSommeNombre(a, aval, "", c, b, bval, nomColSom);
            //System.out.println("Taille aty anaty fonction somme nombre "+sommeNombre.length);
            return new ResultatEtSomme(ret, sommeNombre);
        } catch (Exception Ex) {
            Ex.printStackTrace();
            throw new Exception(Ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public ResultatEtSomme findMvtCaisseLcPage(String id, String daty1, String daty2, String datyVal1, String datyVal2, String designation, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM, String idLigne, String typeLc, String compte, String ent, String dir, String mois1, String mois2, int numPage) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            int a[] = {1, 3, 6, 7, 8, 9, 10, 11, 12, 13, 16, 23, 24, 25, 26};
            String aval[] = {id, designation, devise, mode, caisse, remarque, agence, tier, numP, typeM, idLigne, typeLc, compte, ent, dir};
            int b[] = {2, 14, 29};
            String bval[] = {daty1, daty2, datyVal1, datyVal2, mois1, mois2};
            MvtCaisseUtil m = new MvtCaisseUtil();
            m.setNomTable("MvtCaisseLc");
            MvtCaisseLc[] ret = (MvtCaisseLc[]) (m.rechercher(a, aval, "", c, b, bval, numPage));
            String nomColSom[] = {"debit", "credit", "montantEng", "montantVis", "montantFac"};
            double[] sommeNombre = m.calculSommeNombre(a, aval, "", c, b, bval, nomColSom);
            return new ResultatEtSomme(ret, sommeNombre);
        } catch (Exception Ex) {
            throw new Exception(Ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public Cheque createCheque(String mvt, String datyS, String datyV, String ord, String rem, String numC, String ca, String mont, String refU) throws Exception {
        Cheque cq = new Cheque(mvt, datyS, datyV, ord, rem, numC, ca, mont);
        cq.insertToTableWithHisto(refU);
        return cq;
    }

    public Cheque[] findCheque(String id, String mvt, String datyS1, String datyS2, String datyV1, String datyV2, String ord, String rem, String numC, String ca) throws Exception {
        int[] numCol = {1, 2, 5, 6, 7, 8};
        String[] col = {id, mvt, ord, rem, numC, ca};
        int[] numColInt = {3, 4};
        String[] colInt = {datyS1, datyS2, datyV1, datyV2};
        ChequeUtil cu = new ChequeUtil();
        return (Cheque[]) cu.rechercher(numCol, col, "", numColInt, colInt);
    }

    public String CaisseDepenseRetour(String daty, String datyValeur, String designation, String debit, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM, String idOrdre, String idMvt, String refU) throws Exception {
        Connection c = null;
        try {
            if ((tier == null) || (tier.compareTo("") == 0)) {
                tier = "-";
            }
            finance.MvtCaisse m = new finance.MvtCaisse(daty, datyValeur, designation, debit, "0", devise, mode, caisse, remarque, agence, tier, numP, typeM, idOrdre);
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            MvtCaisse[] mancien = (MvtCaisse[]) new MvtCaisseUtil().rechercher(1, idMvt, c);
            if (mancien.length == 0) {
                throw new Exception("Pas de mouvement correspondant");
            }
            UnionIntraTableUtil util = new UnionIntraTableUtil();
            util.setNomTable("RETOURMONNAIEMVTCAISSE");
            UnionIntraTable[] ancienAnn = (UnionIntraTable[]) util.rechercher(3, idMvt);
            double montantAncien = AdminGen.calculSommeDouble(ancienAnn, 4);
            if (Math.abs(mancien[0].getDebit()) < Math.abs(montantAncien + m.getDebit())) {
                throw new Exception("Montant superieur au montant initial");
            }
            DedEjb d = DedEjbClient.getInterface();
            OrdonnerPayement[] op = (OrdonnerPayement[]) new OpUtil().rechercher(1, idOrdre, c);
            if (op.length == 0) {
                throw new Exception("Op no existante");
            }
            if (op[0].getVisa(c) == null) {
                throw new Exception("Op non vise");
            }
            if (op[0].getPayement(c) != null) {
                throw new Exception("Op deja paye");
            }
            int ret = m.insertToTableWithHisto(refU, c);
            //public UnionIntraTable(String nomTable,String nomProcedure,String suff,String id1e,String id2e,String remarqueE, double montantE,int eta)
            UnionIntraTable uit = new UnionIntraTable("RETOURMONNAIEMVTCAISSE", "getseqRetourMvtCaisse", "RMT", m.getTuppleID(), idMvt, "auto", m.getDebit(), 1);
            uit.insertToTableWithHisto(refU, c);
            //comptabilite
            ComptabiliteEjbClient.getInterface().ecrireMvt(m.getTuppleID(), "F", c, refU);

            c.commit();
            return m.getId();
        } catch (Exception ex) {
            if (c != null) {
                c.rollback();
            }
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public String createMvtCaisseDepense(String daty, String datyValeur, String designation, String debit, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM, String idOrdre, String refU) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            Cloture cl = new Cloture();
            cl.setObjet(caisse);
            cl.setTypeObjet(utilitaire.Constante.typeCloture[0]);
            String colInt[] = {"daty"};
            String valInt[] = {daty, daty};
            Cloture[] lc = (Cloture[]) CGenUtil.rechercher(cl, colInt, valInt, c, "");
            if (lc.length > 0) {
                throw new Exception("Caisse deja clotur�e pour cette date");
            }

            if ((tier == null) || (tier.compareTo("") == 0)) {
                tier = "-";
            }
            finance.MvtCaisse m = new finance.MvtCaisse(daty, datyValeur, designation, debit, "0", devise, mode, caisse, remarque, agence, tier, numP, typeM, idOrdre);

            c.setAutoCommit(false);
            DedEjb d = DedEjbClient.getInterface();
            OpUtil ou = new OpUtil();
            ou.setNomTable("OpApayer");
            OrdonnerPayement[] op = (OrdonnerPayement[]) ou.rechercher(1, idOrdre, c);
            if (op.length == 0) {
                throw new Exception("Op non payable, verifier son visa ou s il a ete deja paye");
            }
            if (op[0].getVisa(c) == null) {
                throw new Exception("Op non vise");
            }
            if (op[0].getPayement(c) != null) {
                throw new Exception("Op deja paye");
            }
            int ret = m.insertToTableWithHisto(refU, c);

            //comptabilite
            ComptabiliteEjbClient.getInterface().ecrireMvt(m.getTuppleID(), "F", c, refU);

            c.commit();
            return m.getId();
        } catch (Exception Ex) {
            if (c != null) {
                c.rollback();
            }
            Ex.printStackTrace();
            throw Ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public String ventilerMvtCaisseLcDetailDepenseGroupe(String idDetLc, String idMvt, String rem, String montant, String refU) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            MvtCaisse[] m = this.findMvtCaisse(idMvt, "", "", "", "", "%", "%", "%", "%", "%", "%", "%", "%", "%");
            if (m.length == 0) {
                throw new Exception("Le mvt n existe pas");
            }
            String montantTot = String.valueOf(m[0].getDebit());
            if (Utilitaire.stringToDouble(montant) > Utilitaire.stringToDouble(montantTot)) {
                throw new Exception("Le montant est sup au montant tot");
            }
            UnionIntraTable uitMvtLcDetail = new UnionIntraTable(Constante.getObjetLcDetMvt(), idDetLc, idMvt, rem, montant);
            uitMvtLcDetail.insertToTableWithHisto(refU, c);
            bean.UnionIntraTable[] ui = new UnionIntraTableUtil().findUnionIntraTable(Constante.getObjetLcDetOp(), "%", "%", m[0].getIdOrdre(), "%", "", "", "%", "");
            if (ui.length == 0) {
                UnionIntraTable uitOpLcDet = new UnionIntraTable(Constante.getObjetLcDetOp(), idDetLc, m[0].getIdOrdre(), rem, montant);
                uitOpLcDet.insertToTableWithHisto(refU, c);
            } else if (AdminGen.calculSommeDouble(ui, 4) < m[0].getDebit()) {
                UnionIntraTable uitOpLcDet = new UnionIntraTable(Constante.getObjetLcDetOp(), idDetLc, m[0].getIdOrdre(), rem, String.valueOf(m[0].getDebit() - AdminGen.calculSommeDouble(ui, 4)));
                uitOpLcDet.insertToTableWithHisto(refU, c);
            }
            OrdonnerPayement[] op = DedEjbClient.getInterface().findOp(m[0].getIdOrdre(), "%", "%", "", "", "", "", "%");
            if (op.length == 0) {
                throw new Exception("Op non existante");
            }
            bean.UnionIntraTable[] uiDlc = new UnionIntraTableUtil().findUnionIntraTable(Constante.getObjetLcDetDed(), "%", "%", op[0].getDed_Id(), "%", "", "", "%", "");
            if (uiDlc.length == 0) {
                UnionIntraTable uitDedLcDet = new UnionIntraTable(Constante.getObjetLcDetDed(), idDetLc, op[0].getDed_Id(), rem, montant);
                uitDedLcDet.insertToTableWithHisto(refU, c);
            } else if (AdminGen.calculSommeDouble(uiDlc, 4) < m[0].getDebit()) {
                UnionIntraTable uitDedLcDet = new UnionIntraTable(Constante.getObjetLcDetDed(), idDetLc, op[0].getDed_Id(), rem, String.valueOf(m[0].getDebit() - AdminGen.calculSommeDouble(uiDlc, 4)));
                uitDedLcDet.insertToTableWithHisto(refU, c);
            }
            c.commit();
            return uitMvtLcDetail.getId();
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public String ventilerOpLcDetailDepenseGroupe(String idDetLc, String idOp, String rem, String montant, String refU) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            UnionIntraTable uitOpLcDet = null;
            OrdonnerPayement[] op = DedEjbClient.getInterface().findOp(idOp, "%", "%", "", "", "", "", "%");
            if (op.length == 0) {
                throw new Exception("Op non existante");
            }
            String montantTot = String.valueOf(op[0].getMontant());
            if (Utilitaire.stringToDouble(montant) > Utilitaire.stringToDouble(montantTot)) {
                throw new Exception("Le montant est sup au montant tot");
            }
            bean.UnionIntraTable[] ui = new UnionIntraTableUtil().findUnionIntraTable(Constante.getObjetLcDetOp(), "%", "%", idOp, "%", "", "", "%", "");
            if (ui.length == 0) {
                uitOpLcDet = new UnionIntraTable(Constante.getObjetLcDetOp(), idDetLc, idOp, rem, montant);
                uitOpLcDet.insertToTableWithHisto(refU, c);
            } else if (AdminGen.calculSommeDouble(ui, 4) < op[0].getMontant()) {
                uitOpLcDet = new UnionIntraTable(Constante.getObjetLcDetOp(), idDetLc, idOp, rem, String.valueOf(op[0].getMontant() - AdminGen.calculSommeDouble(ui, 4)));
                uitOpLcDet.insertToTableWithHisto(refU, c);
            }
            bean.UnionIntraTable[] uiDlc = new UnionIntraTableUtil().findUnionIntraTable(Constante.getObjetLcDetDed(), "%", "%", op[0].getDed_Id(), "%", "", "", "%", "");
            if (uiDlc.length == 0) {
                UnionIntraTable uitDedLcDet = new UnionIntraTable(Constante.getObjetLcDetDed(), idDetLc, op[0].getDed_Id(), rem, montant);
                uitDedLcDet.insertToTableWithHisto(refU, c);
            } else if (AdminGen.calculSommeDouble(uiDlc, 4) < op[0].getMontant()) {
                UnionIntraTable uitDedLcDet = new UnionIntraTable(Constante.getObjetLcDetDed(), idDetLc, op[0].getDed_Id(), rem, String.valueOf(op[0].getMontant() - AdminGen.calculSommeDouble(uiDlc, 4)));
                uitDedLcDet.insertToTableWithHisto(refU, c);
            }
            c.commit();
            return uitOpLcDet.getId();
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public String validerMvtCaisseLcDetailDepenseGroupe(String numMvtCaisse, String refU) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            MvtCaisse[] m = this.findMvtCaisse(numMvtCaisse, "", "", "", "", "%", "%", "%", "%", "%", "%", "%", "%", "%");
            if (m.length == 0) {
                throw new Exception("Le mvt n existe pas");
            }
            String montantTot = String.valueOf(m[0].getDebit());
            LCEjbClient.getInterface().validerMappageAvecControle(Constante.getObjetLcDetMvt(), numMvtCaisse, montantTot, refU, c);
            LCEjbClient.getInterface().validerMappageAvecControle(Constante.getObjetLcDetOp(), m[0].getIdOrdre(), montantTot, refU, c);
            OrdonnerPayement[] op = DedEjbClient.getInterface().findOp(m[0].getIdOrdre(), "%", "%", "", "", "", "", "%");
            if (op.length == 0) {
                throw new Exception("Op non existante");
            }
            LCEjbClient.getInterface().validerMappageAvecControle(Constante.getObjetLcDetDed(), op[0].getDed_Id(), montantTot, refU, c);
            //LcDetail[] ld = LCEjbClient.getInterface().findDetailLc(op[0].getIdLigne(),"%","%","%");
            bean.UnionIntraTableUtil uti = new UnionIntraTableUtil();
            bean.UnionIntraTable[] ui = uti.findUnionIntraTable(Constante.getObjetLcDetMvt(), "%", "%", numMvtCaisse, "%", "", "", "%", "");

            for (int k = 0; k < ui.length; k++) {
                LcDetail[] ld = LCEjbClient.getInterface().findDetailLc(ui[k].getId1(), "%", "%", "%");
                if (ld.length > 0) {
                    ld[0].setNomTable(Constante.getObjetLcDetail());
                    ld[0].setMontantFact(ld[0].getMontantFact() + ui[k].getMontantMere());
                    ld[0].setMontantVis(ld[0].getMontantVis() + ui[k].getMontantMere());
                    ld[0].setMontantEng(ld[0].getMontantEng() + ui[k].getMontantMere());
                    ld[0].updateToTableWithHisto(refU, c);
                }
            }
            c.commit();
            return "ok";
        } catch (Exception ex) {
            c.rollback();
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public String retourVola(String idMvt, String idLcDet, String montant, String refU) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            LigneCredit[] lc = (LigneCredit[]) new LigneCreditUtil().rechercher(1, idLcDet, c);
            MvtCaisse mv[] = (MvtCaisse[]) new MvtCaisseUtil().rechercher(1, idMvt, c);
            if ((lc.length == 0) || (mv.length == 0)) {
                throw new Exception("Le mouvement n existe pas");
            }
            OrdonnerPayement[] op = (OrdonnerPayement[]) new OpUtil().rechercher(1, mv[0].getIdOrdre(), c);
            FactureFournisseur[] ffo = (FactureFournisseur[]) new FactureFournisseurUtil().rechercher(1, op[0].getDed_Id(), c);
            //String id=this.createMvtCaisseDirecteDepense(Utilitaire.dateDuJour(),"retour sur "+idMvt,lc[0].getIdLc(), "","-"+montant, "0", mv[0].getIdDevise(), mv[0].getIdMode(),mv[0].getIdCaisse(), "-",mv[0].getAgence(), mv[0].getTiers(),mv[0].getRemarque(),"2", refU);
            //String idv=this.ventilerMvtCaisseLcDetailDepenseGroupe(idLcDet,id,"retour vola","-"+montant,refU);
            /*
      Cr�ation facture avec ventilation + visa
      Cr�ation op avec ventilation + visa auto
      Cr�ation Mvt caisse
      Cr�ation ligne anaty table RETOURMONNAIEMVTCAISSE
             */
            FactureFournisseur ff = new FactureFournisseur(Constante.getObjetFactureF(), "auto annul", "annulation auto", Utilitaire.dateDuJour(), Utilitaire.dateDuJour(), ffo[0].getIdFournisseur(), "0", montant, "retour vola", mv[0].getIdDevise());
            ff.insertToTableWithHisto(refU, c);
            String mapFlc = UtilitaireMetier.mapperMereToFille("FACTUREFOURNISSEURLC", "getSeqFactLigneF", "SFF", ff.getTuppleID(), idLcDet, "mappage auto", montant, refU, "1", c);
            Visa vt = new Visa("VISAFACTUREF", Utilitaire.dateDuJour(), "visa auto retour monnaie", ff.getTuppleID());
            vt.insertToTableWithHisto(refU, c);

            OrdonnerPayement opv = new OrdonnerPayement(ff.getTuppleID(), idLcDet, Utilitaire.dateDuJour(), montant, "creation auto", "1");// op deja vise
            opv.insertToTableWithHisto(refU, c);
            UtilitaireMetier.mapperMereToFille(Constante.tableOpFfLc, "getseqOpffLc", "OFL", opv.getTuppleID(), mapFlc, "auto", montant, refU, c);
            Visa vop = new Visa(Constante.getVisaOp(), Utilitaire.dateDuJour(), "visa auto retour", opv.getId());
            vop.insertToTableWithHisto(refU, c);
            //finance.MvtCaisse m=new finance.MvtCaisse(Utilitaire.dateDuJour(),Utilitaire.dateDuJour(),"retour monnaie",montant,"0",mv[0].getIdDevise(),mode,caisse,"retour monnaie",mv[0].getAgence(),mv[0].getTiers(),numP,"2",opv.getTuppleID());
            /*l[0].setMontantFac(l[0].getMontantFac()+d.getMttc());

      this.validerMvtCaisseLcDetailDepenseGroupe(id,refU);*/
            //m.insertToTableWithHisto(refU,c);
            c.commit();
            return "";
        } catch (Exception ex) {
            c.rollback();
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public String annulerMvtDepense(String idMvt, String refU) throws Exception {
        MvtCaisse mv[] = this.findMvtCaisse(idMvt, "", "", "", "", "%", "%", "%", "%", "%", "%", "%", "%", "%");
        if (mv.length == 0) {
            throw new Exception("Mvt non existante");
        }
        if (mv[0].getIdOrdre().compareToIgnoreCase("VRMT") == 0) {
            throw new Exception("Mvt de caisse relatif � un virement, veuillez annuler le virement");
            /*VirMvt crt=new VirMvt();
      if(mv[0].getDebit()>0)
        crt.setIdMvtDep(mv[0].getId());
      else
        crt.setIdMvtRec(mv[0].getId());
      crt=(VirMvt)CGenUtil.rechercher(crt,null,null,"")[0];
      crt.deleteToTableWithHisto(refU);*/
        }
        mv[0].deleteToTableWithHisto(refU);
        /*String montant=String.valueOf(mv[0].getDebit());
    OrdonnerPayement[] op=DedEjbClient.getInterface().findOp(mv[0].getIdOrdre(),"%","%","","","","","%");
    if(op.length==0) throw new Exception("Pas de op");
    String id=this.createMvtCaisseDirecteDepense(Utilitaire.dateDuJour(),"annulation sur "+idMvt,op[0].getIdLigne(), "","-"+montant, "0", mv[0].getIdDevise(), mv[0].getIdMode(),mv[0].getIdCaisse(), "-",mv[0].getAgence(), mv[0].getTiers(),mv[0].getRemarque(),"3", refU);
    bean.UnionIntraTable[] ui=new UnionIntraTableUtil().findUnionIntraTable(Constante.getObjetLcDetMvt() ,"%","%",idMvt,"%","","","1","");
    for(int h=0;h<ui.length;h++)
    {
      LcDetail[]lc=LCEjbClient.getInterface().findDetailLc(ui[h].getId1() ,"%","%","%");
      if((lc.length==0)||(mv.length==0)) throw new Exception("Le mouvement n existe pas");
      String idv=this.ventilerMvtCaisseLcDetailDepenseGroupe(ui[h].getId1(),id,"annulation","-"+ui[h].getMontantMere(),refU);
    }
    this.validerMvtCaisseLcDetailDepenseGroupe(id,refU);*/
        return mv[0].getTuppleID();
    }

    public String createMvtCaisseDirecteDepense(String daty, String designation, String idLigne, String idFacture, String debit, String credit, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM, String refU) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            LCEjb lci = LCEjbClient.getInterface();
            LigneCredit[] l = lci.findLC(idLigne, "%", "%", "%", "%", "%", "%", Constante.getObjetLigneCredit());
            if (l.length == 0) {
                throw new Exception("Ligne de credit non existante");
            }
            if (Utilitaire.stringToDouble(debit) + l[0].getMontantVis() > l[0].getCreditModifier()) {
                throw new Exception("Le montant excede la ligne de credit");
            }
            ded.Ded d = new Ded(designation, daty, debit, "0", "creation auto", "30", tier, idLigne);// La demande a d�ja �t� op
            Visa v = new Visa("VisaDed", daty, "visa auto", d.getId());
            l[0].setMontantVis(l[0].getMontantVis() + d.getMttc());
            OrdonnerPayement op = new OrdonnerPayement(d.getId(), idLigne, daty, debit, "creation auto", "1");// op deja vise
            Visa vop = new Visa(Constante.getVisaOp(), daty, remarque, op.getId());
            l[0].setMontantFac(l[0].getMontantFac() + d.getMttc());
            if ((tier == null) || (tier.compareTo("") == 0)) {
                tier = "-";
            }
            finance.MvtCaisse m = new finance.MvtCaisse(daty, daty, designation, debit, "0", devise, mode, caisse, remarque, agence, tier, numP, typeM, op.getTuppleID());
            l[0].setMontantEng(l[0].getMontantEng() + d.getMttc());
            d.insertToTableWithHisto(refU, c);
            v.insertToTableWithHisto(refU, c);
            l[0].updateToTableWithHisto(refU, c);
            op.insertToTableWithHisto(refU, c);
            vop.insertToTableWithHisto(refU, c);
            m.insertToTableWithHisto(refU, c);
            if ((idFacture != null) && (idFacture.compareToIgnoreCase("") != 0)) {
                UnionIntraTable uit = new UnionIntraTable(Constante.getOpFactureFournisseur(), op.getId(), idFacture, "Mappage auto", debit);
                uit.setEtat(1);
                uit.insertToTableWithHisto(refU, c);
            }
            //comptabilite
            ComptabiliteEjbClient.getInterface().ecrireMvt(m.getTuppleID(), "F", c, refU);
            c.commit();
            return m.getId();
        } catch (Exception ex) {
            c.rollback();
            ex.printStackTrace();
            return null;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public String createMvtCaisseDirecteRecette(String daty, String designation, String idLigne, String idFacture, String debit, String credit, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM, String refU) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            LCEjb lci = LCEjbClient.getInterface();
            LigneCredit[] l = lci.findLC(idLigne, "%", "%", "%", "%", "%", "%", Constante.getObjetLigneCreditRecette());
            if (l.length == 0) {
                throw new Exception("Ligne de credit non existante");
            }
            OrdonnerPayement op = new OrdonnerPayement();// op deja vise
            op.OrdonnerRecette(idLigne, daty, credit, "creation auto", "1");// op deja vise
            Visa vop = new Visa(Constante.getVisaOr(), daty, remarque, op.getId());
            l[0].setMontantFac(l[0].getMontantFac() + op.getMontant());
            if ((tier == null) || (tier.compareTo("") == 0)) {
                tier = "-";
            }
            finance.MvtCaisse m = new finance.MvtCaisse(daty, daty, designation, "0", credit, devise, mode, caisse, remarque, agence, tier, numP, typeM, op.getTuppleID());
            l[0].setMontantEng(l[0].getMontantEng() + op.getMontant());
            l[0].updateToTableWithHisto(refU, c);
            op.insertToTableWithHisto(refU, c);
            vop.insertToTableWithHisto(refU, c);

            m.insertToTableWithHisto(refU, c);

            if ((idFacture != null) && (idFacture.compareToIgnoreCase("") != 0)) {
                UnionIntraTable uit = new UnionIntraTable(Constante.getOpFactureFournisseur(), op.getId(), idFacture, "Mappage auto", debit);
                uit.setEtat(1);
                uit.insertToTableWithHisto(refU, c);
            }
            //comptabilite
            ComptabiliteEjbClient.getInterface().ecrireMvt(m.getTuppleID(), "C", c, refU);
            c.commit();
            return null;
        } catch (Exception ex) {
            ex.printStackTrace();
            c.rollback();
            return null;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public String createMvtCaisse(String daty, String datyValeur, String designation, String debit, String credit, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM, String refU) throws Exception {
        return null;
    }

    public String createDetailMvtCaisse(String deb, String crd, String tiers, String rem, String idMere, String paru, String numP, String refU) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            String montant = deb;
            MvtCaisse[] mcs = (MvtCaisse[]) new MvtCaisseUtil().rechercher(1, idMere);
            if (mcs.length == 0) {
                throw new Exception("Le mvt " + idMere + " n exsite pas");
            }
            if (mcs[0].getNatureMvt().compareTo("credit") == 0) {
                crd = deb;
                deb = "0";
            }
            DetailMvtCaisse[] mc = (DetailMvtCaisse[]) new DetailMvtCaisseUtil().rechercher(6, idMere, c);
            double dejaDebit = AdminGen.calculSommeDouble(mc, 1);
            double dejaCredit = AdminGen.calculSommeDouble(mc, 2);
            if (mcs[0].getCredit() == 0) {
                boolean estDebitKo = Utilitaire.stringToDouble(deb) + dejaDebit > mcs[0].getDebit();
                if (estDebitKo == true) {
                    throw new Exception("Montant detail depassant le montant Mere");
                }
            } else {
                boolean estCreditKo = Utilitaire.stringToDouble(deb) + dejaCredit > mcs[0].getCredit();
                if (estCreditKo == true) {
                    throw new Exception("Montant detail depassant le montant Mere");
                }
            }

            DetailMvtCaisse dm = new DetailMvtCaisse(deb, crd, tiers, rem, idMere, paru, numP);
            int ret = dm.insertToTableWithHisto(refU);
            return dm.getId();
        } catch (Exception ex) {
            ex.printStackTrace();
            c.rollback();
            return null;
        } finally {
            if (c != null) {
                c.close();
            }
        }

    }

    public DetailMvtCaisse[] findDetMvtCaisseParu(String id, String tiers, String rem, String idMere, String paruInf, String paruSup) throws Exception {
        int a[] = {1, 4, 5, 6};
        String aval[] = {tiers, rem, idMere};
        int[] numColInt = {7};
        String[] valColInt = {paruInf, paruSup};
        DetailMvtCaisseUtil m = new DetailMvtCaisseUtil();
        return (DetailMvtCaisse[]) (m.rechercher(a, aval, numColInt, valColInt));
    }

    public ResultatEtSomme findDetMvtCaisseParu(String tiers, String rem, String idMere, String paruInf, String paruSup, int numPage) throws Exception {
        Connection c = null;
        try {
            int a[] = {4, 5, 6};
            String aval[] = {tiers, rem, idMere};
            DetailMvtCaisseUtil m = new DetailMvtCaisseUtil();
            int[] numColInt = {7};
            String[] valColInt = {paruInf, paruSup};
            DetailMvtCaisse[] ret = (DetailMvtCaisse[]) (m.rechercher(a, aval, "", c, numColInt, valColInt, numPage));
            String nomColSom[] = {"debit", "credit"};
            double[] sommeNombre = m.calculSommeNombre(a, aval, "", c, null, null, nomColSom);
            return new ResultatEtSomme(ret, sommeNombre);
        } catch (Exception ex) {
            return null;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public DetailMvtCaisse[] findDetMvtCaisse(String tiers, String rem, String idMere) throws Exception {
        int a[] = {4, 5, 6};
        String aval[] = {tiers, rem, idMere};
        DetailMvtCaisseUtil m = new DetailMvtCaisseUtil();
        return (DetailMvtCaisse[]) (m.rechercher(a, aval));
    }

    public ResultatEtSomme findDetMvtCaisse(String tiers, String rem, String idMere, int numPage) throws Exception {
        Connection c = null;
        try {
            int a[] = {4, 5, 6};
            String aval[] = {tiers, rem, idMere};
            DetailMvtCaisseUtil m = new DetailMvtCaisseUtil();
            DetailMvtCaisse[] ret = (DetailMvtCaisse[]) (m.rechercher(a, aval, "", c, null, null, numPage));
            String nomColSom[] = {"debit", "credit"};
            double[] sommeNombre = m.calculSommeNombre(a, aval, "", c, null, null, nomColSom);
            return new ResultatEtSomme(ret, sommeNombre);
        } catch (Exception ex) {
            return null;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public String createMvtCaisseRecette(String daty, String datyValeur, String designation, String credit, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM, String idOrdre, String refU) throws Exception {
        Connection c = null;
        try {
            Cloture cl = new Cloture();
            cl.setObjet(caisse);
            cl.setTypeObjet(utilitaire.Constante.typeCloture[0]);
            String colInt[] = {"daty"};
            String valInt[] = {daty, daty};
            Cloture[] lc = (Cloture[]) CGenUtil.rechercher(cl, colInt, valInt, "");
            if (lc.length > 0) {
                throw new Exception("Caisse deja clotur�e pour cette date");
            }
            if ((tier == null) || (tier.compareTo("") == 0)) {
                tier = "-";
            }
            finance.MvtCaisse m = new finance.MvtCaisse(daty, datyValeur, designation, "0", credit, devise, mode, caisse, remarque, agence, tier, numP, typeM, idOrdre);
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            DedEjb d = DedEjbClient.getInterface();
            OpUtil o = new OpUtil();
            o.setNomTable("orapayer");
            OrdonnerPayement[] op = (OrdonnerPayement[]) o.rechercher(1, idOrdre, c);
            if (op.length == 0) {
                throw new Exception("Or non recevable, verifier si cest deja paye ou non vise");
            }
            int ret = m.insertToTableWithHisto(refU, c);
            //comptabilite
            ComptabiliteEjbClient.getInterface().ecrireMvt(m.getTuppleID(), "C", c, refU);
            c.commit();
            return m.getId();
        } catch (Exception Ex) {
            if (c != null) {
                c.rollback();
            }
            throw new Exception(Ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public EtatCaisseReste[] findEtatCaisseReportMvt(String daty1, String daty2, String caisse, String entite) throws Exception {
        Connection c = null;
        try {
            String req1 = "select c.IDCAISSE, c.DESCCAISSE,b.val as entite ,nvl((select sum(mv.debit) from mvtCaisse mv ";
            String req2 = "where mv.IDCAISSE=c.IDCAISSE and mv.daty='" + daty1 + "' and mv.idCaisse like '" + caisse + "'),0) as debit ";
            String req3 = ",nvl((select sum(mv.credit) from mvtCaisse mv where mv.IDCAISSE=c.IDCAISSE and mv.daty='" + daty1 + "'and mv.idCaisse like '" + caisse + "'),0) as credit,nvl((select r.montant from report r where r.CAISSE=c.IDCAISSE ";
            String req4 = "and r.DATY='" + daty2 + "'),0) as report from caisse c,beneficiaire b where c.RESPCAISSE=b.ID and b.val like '" + entite + "'";
            String req = req1 + req2 + req3 + req4;
            System.out.println(req);
            c = new UtilDB().GetConn();
            Statement st = c.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = st.executeQuery(req);
            EtatCaisseReste temp = null;
            Vector vect = new Vector();
            int i = 0;
            while (rs.next()) {
                //public EtatCaisseReste(java.sql.Date dt,String idCaisse,String descC,String entite,double credit,double deb,double res,double repE, double repD)
                //on met report th�orique dans repD ( derni�re variable)
                temp = new EtatCaisseReste(utilitaire.Utilitaire.dateDuJourSql(), rs.getString(1), rs.getString(2), rs.getString(3), 14, rs.getDouble(5), rs.getDouble(4), rs.getDouble(6) + rs.getDouble(5) - rs.getDouble(4), rs.getDouble(6));
                vect.add(i, temp);
                i++;
            }
            EtatCaisseReste[] retour = new EtatCaisseReste[i];
            vect.copyInto(retour);
            return retour;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public static void main(String[] arg) {

        /**
         * @todo Complete this method
         */
    }

    public String createMvtCaisseRecette(String daty, String datyValeur, String designation, String credit, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM, String idOrdre, String numCheque, String etablissement, String idmvtor, String refU) throws Exception {
        Connection c = null;
        try {
            Cloture cl = new Cloture();
            
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            String retour = createMvtCaisseRecette( daty, datyValeur, designation, credit, devise, mode, caisse, remarque, agence, tier, numP, typeM, idOrdre, numCheque, etablissement, idmvtor, refU, c);
            c.commit();
            return retour;
        } catch (Exception Ex) {
            if (c != null) {
                c.rollback();
            }
            throw new Exception(Ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }
    
    public String createMvtCaisseRecette(String daty, String datyValeur, String designation, String credit, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM, String idOrdre, String numCheque, String etablissement, String idmvtor, String refU, Connection c) throws Exception {

            Cloture cl = new Cloture();
            cl.setObjet(caisse);
            cl.setTypeObjet(utilitaire.Constante.typeCloture[0]);
            String colInt[] = {"daty"};
            String valInt[] = {daty, daty};
            Cloture[] lc = (Cloture[]) CGenUtil.rechercher(cl, colInt, valInt, "");
            if (lc.length > 0) {
                throw new Exception("Caisse deja clotur�e pour cette date");
            }
            if ((tier == null) || (tier.compareTo("") == 0)) {
                tier = "-";
            }
            finance.MvtCaisse m = null;
            DedEjb d = DedEjbClient.getInterface();
            OpUtil o = new OpUtil();
            o.setNomTable("orapayer");
            OrdonnerPayement[] op = (OrdonnerPayement[]) o.rechercher(1, idOrdre, c);
            if (op.length == 0) {
                throw new Exception("Or non recevable, verifier si cest deja paye ou non vise");
            }
            m = new finance.MvtCaisse(daty, datyValeur, designation, "0", credit, devise, mode, caisse, remarque, agence, tier, numP, typeM, idOrdre);
            if (mode.compareToIgnoreCase("pay2") == 0) {
                //System.out.println(" MIDITRA "+numCheque);
                if (numCheque.compareTo("-") == 0 || numCheque == null || Utilitaire.stringToInt(numCheque) == 0) {
                    throw new Exception("num cheque invalide");
                }
            }
            m.setNumcheque(numCheque);
            m.setEtablissement(etablissement);
            m.setIdmvtor(idmvtor);
            int ret = m.insertToTableWithHisto(refU, c);
            //comptabilite
            ComptabiliteEjbClient.getInterface().ecrireMvt(m.getTuppleID(), "C", c, refU);
            return m.getId();

    }

    public MvtCaisseTous[] findMvtCaissetous(String id, String daty1, String daty2, String datyVal1, String datyVal2, String designation, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM) throws Exception {
        /**
         * Rehefa page=0 dia affichena daholo
         */
        try {
            int a[] = {1, 3, 6, 7, 8, 9, 10, 11, 12, 13};
            String aval[] = {id, designation, devise, mode, caisse, remarque, agence, tier, numP, typeM};
            int b[] = {2, 14};
            String bval[] = {daty1, daty2, datyVal1, datyVal2};
            MvtCaisseUtil m = new MvtCaisseUtil();
            //System.out.print("tonga eto");
            m.setNomTable("mvtcaissetous");
            return (MvtCaisseTous[]) (m.rechercher(a, aval, b, bval));
        } catch (Exception Ex) {
            throw new Exception(Ex.getMessage());
        }
    }

    public String createMvtCaisseDepense(String daty, String datyValeur, String designation, String debit, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM, String idOrdre, String idmvtor, String refU) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            Cloture cl = new Cloture();
            cl.setObjet(caisse);
            cl.setTypeObjet(utilitaire.Constante.typeCloture[0]);
            String colInt[] = {"daty"};
            String valInt[] = {daty, daty};
            Cloture[] lc = (Cloture[]) CGenUtil.rechercher(cl, colInt, valInt, c, "");
            if (lc.length > 0) {
                throw new Exception("Caisse deja clotur�e pour cette date");
            }

            if ((tier == null) || (tier.compareTo("") == 0)) {
                tier = "-";
            }
            finance.MvtCaisse m = new finance.MvtCaisse(daty, datyValeur, designation, debit, "0", devise, mode, caisse, remarque, agence, tier, numP, typeM, idOrdre);

            c.setAutoCommit(false);
            DedEjb d = DedEjbClient.getInterface();
            OpUtil ou = new OpUtil();
            ou.setNomTable("OpApayer");
            OrdonnerPayement[] op = (OrdonnerPayement[]) ou.rechercher(1, idOrdre, c);
            if (op.length == 0) {
                throw new Exception("Op non payable, verifier son visa ou s il a ete deja paye");
            }
            if (op[0].getVisa(c) == null) {
                throw new Exception("Op non vise");
            }
            if (op[0].getPayement(c) != null) {
                throw new Exception("Op deja paye");
            }
            m.setIdmvtor(idmvtor);
            int ret = m.insertToTableWithHisto(refU, c);
            //comptabilite
            ComptabiliteEjbClient.getInterface().ecrireMvt(m.getTuppleID(), "F", c, refU);
            c.commit();
            return m.getId();
        } catch (Exception Ex) {
            if (c != null) {
                c.rollback();
            }
            Ex.printStackTrace();
            throw Ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public Cheque[] findChequeEtat(String id, String mvt, String datyS1, String datyS2, String datyV1, String datyV2, String ord, String rem, String numC, String ca, String etat) throws Exception {
        int[] numCol = {1, 2, 5, 6, 7, 8, 10};
        String[] col = {id, mvt, ord, rem, numC, ca, etat};
        int[] numColInt = {3, 4};
        String[] colInt = {datyS1, datyS2, datyV1, datyV2};
        ChequeUtil cu = null;
        if (etat == null || "tous".equalsIgnoreCase(etat) || "".equalsIgnoreCase(etat)) {
            cu = new ChequeUtil();
        } else if ("nonvire".equalsIgnoreCase(etat)) {
            cu = new ChequeUtil("CHEQUEDISPO");
        } else {
            cu = new ChequeUtil("CHEQUEVIRE");
        }
        return (Cheque[]) cu.rechercher(numCol, col, "", numColInt, colInt);
    }

    public SaisieVirement virer(String montant, String devise, String caisse1, String caisse2, String mode, String remarque, String daty, String refUser, String numCheque) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            CaisseUtil cu = new CaisseUtil();
            if (mode.compareTo("pay2") == 0) {
                if (numCheque.compareToIgnoreCase("-") == 0 || numCheque == null || Utilitaire.stringToInt(numCheque) == 0) {
                    throw new Exception("num cheque invalide");
                }
            }
            SaisieVirement sv = new SaisieVirement(utilitaire.Utilitaire.stringToDouble(montant), devise, caisse1, caisse2, mode, remarque, daty, numCheque);
            sv.insertToTableWithHisto(refUser);
            return sv;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public String createMvtCaisseDepenseRetour(String daty, String datyValeur, String designation, String debit, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM, String idOrdre, String idMvt, String refU) throws Exception {
        Connection c = null;
        try {
            if ((tier == null) || (tier.compareTo("") == 0)) {
                tier = "-";
            }
            finance.MvtCaisse m = new finance.MvtCaisse(daty, datyValeur, designation, debit, "0", devise, mode, caisse, remarque, agence, tier, numP, typeM, idOrdre);
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            MvtCaisse[] mancien = (MvtCaisse[]) new MvtCaisseUtil().rechercher(1, idMvt, c);
            if (mancien.length == 0) {
                throw new Exception("Pas de mouvement correspondant");
            }
            UnionIntraTableUtil util = new UnionIntraTableUtil();
            util.setNomTable("RETOURMONNAIEMVTCAISSE");
            UnionIntraTable[] ancienAnn = (UnionIntraTable[]) util.rechercher(3, idMvt);
            double montantAncien = AdminGen.calculSommeDouble(ancienAnn, 4);
            if (Math.abs(mancien[0].getDebit()) < Math.abs(montantAncien + m.getDebit())) {
                throw new Exception("Montant superieur au montant initial");
            }
            DedEjb d = DedEjbClient.getInterface();
            OrdonnerPayement[] op = (OrdonnerPayement[]) new OpUtil().rechercher(1, idOrdre, c);
            if (op.length == 0) {
                throw new Exception("Op no existante");
            }
            if (op[0].getVisa(c) == null) {
                throw new Exception("Op non vise");
            }
            if (op[0].getPayement(c) != null) {
                throw new Exception("Op deja paye");
            }
            int ret = m.insertToTableWithHisto(refU, c);
            //public UnionIntraTable(String nomTable,String nomProcedure,String suff,String id1e,String id2e,String remarqueE, double montantE,int eta)
            UnionIntraTable uit = new UnionIntraTable("RETOURMONNAIEMVTCAISSE", "getseqRetourMvtCaisse", "RMT", m.getTuppleID(), idMvt, "auto", m.getDebit(), 1);
            uit.insertToTableWithHisto(refU, c);
            //comptabilite
            ComptabiliteEjbClient.getInterface().ecrireMvt(m.getTuppleID(), "F", c, refU);
            c.commit();
            return m.getId();
        } catch (Exception ex) {
            if (c != null) {
                c.rollback();
            }
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }
    SessionContext sessionContext;

    @Override
    public int create(ClassMAPTable value1, MapUtilisateur value2) throws Exception, RemoteException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public int update(ClassMAPTable value1, MapUtilisateur value2) throws Exception, RemoteException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public int delete(ClassMAPTable value1, MapUtilisateur value2) throws Exception, RemoteException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public EJBHome getEJBHome() throws RemoteException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Object getPrimaryKey() throws RemoteException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void remove() throws RemoteException, RemoveException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Handle getHandle() throws RemoteException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public boolean isIdentical(EJBObject obj) throws RemoteException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
}
