package comptabilite;

import bean.*;
import historique.*;
import java.io.*;
import java.sql.*;
import javax.ejb.*;
import utilitaire.*;
import facturefournisseur.*;
import finance.*;
import facture.*;
import ded.*;
import java.rmi.RemoteException;
import lc.*;
import java.util.*;
//import employe.EmployeLibelleNoSal;

@Stateful
public class ComptabiliteEjbBean extends ClassEjb implements SessionBean, ComptabiliteEjb {

    SessionContext sessionContext;

    public ComptabiliteEjbBean() {
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

    public int getNumeroEcriture(Connection c) throws Exception {
        return Utilitaire.getMaxSeq("GETSEQNUMEROECRITURECOMPTA", c);
    }

    public int[] numTobase26(int num) throws Exception {

        int[] result = new int[3];

        // ??? plus plus
        if (num > 17576) {
            throw new Exception("Plus de lettres");
        }

        result[0] = (int) num / (26 ^ 2);
        int reste = num - result[0] * (26 ^ 2);
        result[1] = (int) (reste / 26);
        result[2] = reste - result[1];

        return result;
    }

    public String generateLettreByChiffre(int num) throws Exception {
        String liste = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        String result = "";
        int[] base = numTobase26(num);
        result += liste.charAt(base[0]);
        result += liste.charAt(base[1]);
        result += liste.charAt(base[2]);
        return result;
    }

    public String getLettre(Connection c) throws Exception {
        int num = Utilitaire.getMaxSeq("GETSEQLETTRELETTRAGECOMPTA", c);
        return generateLettreByChiffre(num);
    }

    public Societe[] findSociete(String idSociete, String nom, String regime, String tel, String fax,
            String email, String gerant, String nif, String numstat, String rc, String capital, String quittance) throws Exception {
        try {
            int a[] = {
                1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
                11, 12
            };
            String val[] = new String[a.length];
            val[0] = idSociete;
            val[1] = nom;
            val[2] = regime;
            val[3] = tel;
            val[4] = fax;
            val[5] = email;
            val[6] = gerant;
            val[7] = nif;
            val[8] = numstat;
            val[9] = rc;
            val[10] = capital;
            val[11] = quittance;

            SocieteUtil cu = new SocieteUtil();
            Societe aclient[] = (Societe[]) cu.rechercher(a, val, " order by nom asc");
            return aclient;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Exercice findExercice(String idSociete, java.sql.Date daty) throws Exception {
        try {
            Exercice cu = new Exercice();
            Exercice aclient[] = (Exercice[]) CGenUtil.rechercher(cu, null, null, " and idsociete = '" + idSociete + "' and datedebut <= '"
                    + Utilitaire.datetostring(daty) + "' and datefin >= '" + Utilitaire.datetostring(daty) + "'");
            if (aclient != null && aclient.length > 0) {
                return aclient[0];
            } else {
                return null;
            }
        } catch (Exception ex) {
            throw new Exception(ex.getMessage() + " : " + daty);
        }
    }

    public Exercice findExercice(String idSociete) throws Exception {
        try {
            Exercice cu = new Exercice();
            Exercice aclient[] = (Exercice[]) CGenUtil.rechercher(cu, null, null, " and idsociete = '" + idSociete + "' and etat = 0");
            if (aclient != null && aclient.length > 0) {
                return aclient[0];
            } else {
                return null;
            }
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public int insertMultipleEcriture(java.sql.Date[] daty, String[] societe, String[] journal, String[] numpiece, String[] compte, String[] tiers,
            java.sql.Date[] echeance, String[] libelle, double[] montantcredit, double[] montantdebit, String refUser) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            //getNumero pour l'ensemble de l'ecriture
            int num = getNumeroEcriture(c);
            int taille = daty.length;
            for (int index = 0; index < taille; index++) {
                insertEcriture(daty[index], societe[index], journal[index], numpiece[index],
                        compte[index], tiers[index], echeance[index], libelle[index], montantdebit[index], montantcredit[index], refUser, c, num);
            }
            c.commit();
            return num;
        } catch (Exception ex) {
            if (c != null) {
                c.rollback();
            }
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void insertEcriture(java.sql.Date daty, String societe, String journal, String numpiece, String compte, String tiers, java.sql.Date echeance,
            String libelle, double montantdebit, double montantcredit, String refUser, Connection c, int num) throws Exception {
        Ecriture ecriture = new Ecriture(daty, societe, journal, numpiece,
                compte, tiers, echeance, libelle, montantdebit, montantcredit);
        Exercice exercice = this.findExercice(societe, daty);
        if (exercice == null) {
            throw new Exception("Aucun exercice correspondant");
        } else {
            ecriture.setExercice(exercice.getId());
        }
        ecriture.setEtat(1);
        ecriture.setNumero(num);
        ecriture.construirePK(c);
        ecriture.insertToTableWithHisto(refUser, c);
    }

    public void viserMultipleEcriture(String[] temp, String refUser) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            for (int i = 0; i < temp.length; i++) {
                this.viserEcriture(temp[i], refUser, c);
            }
            c.commit();
        } catch (Exception ex) {
            if (c != null) {
                c.rollback();
            }
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void viserEcriture(String numero, String refUser, Connection c) throws Exception {
        Ecriture crt = new Ecriture();
        Ecriture[] ecritures = (Ecriture[]) CGenUtil.rechercher(crt, null, null, c, " and numero =" + numero);
        for (int a = 0; a < ecritures.length; a++) {
            ecritures[a].setEtat(0);
            ecritures[a].updateToTableWithHisto(refUser, c);
        }
    }

    public void viserEcriture(String temp, String refUser) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            this.viserEcriture(temp, refUser, c);
            c.commit();
        } catch (Exception ex) {
            if (c != null) {
                c.rollback();
            }
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void extournerEcriture(String num, String refUser) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);

            extournerEcriture(num, refUser, c);
            c.commit();
        } catch (Exception ex) {
            if (c != null) {
                c.rollback();
            }
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void extournerEcriture(String num, String refUser, Connection c) throws Exception {

        int numero = Utilitaire.getMaxSeq("GETSEQNUMEROECRITURECOMPTA", c);

        Ecriture crt = new Ecriture();
        Ecriture[] ecritures = (Ecriture[]) CGenUtil.rechercher(crt, null, null, c, " and numero =" + num);
        for (int index = 0; index < ecritures.length; index++) {
            insertEcriture(ecritures[index].getDaty(), ecritures[index].getSociete(), ecritures[index].getCodejournal(), ecritures[index].getNumpiece(),
                    ecritures[index].getCompte(), ecritures[index].getComptetiers(), ecritures[index].getEcheance(), "Extourne " + ecritures[index].getLibelle(),
                    ecritures[index].getMontantcredit(), ecritures[index].getMontantdebit(), refUser, c, numero);
        }
    }

    public void retournerMvtCaisse(String mvt, String refUser, Connection c) throws Exception {
        int numero = Utilitaire.getMaxSeq("GETSEQNUMEROECRITURECOMPTA", c);

        Ecriture crt = new Ecriture();
        Ecriture[] ecritures = (Ecriture[]) CGenUtil.rechercher(crt, null, null, c, " and idobjet =" + mvt);
        extournerEcriture(String.valueOf(ecritures[0].getNumero()), refUser, c);

    }

    public void updateEcriture(String id, java.sql.Date daty, String societe, String journal, String numpiece, String compte, String tiers, java.sql.Date echeance,
            String libelle, double montantdebit, double montantcredit, String refUser, Connection c, int num) throws Exception {
        Ecriture ecriture = new Ecriture(daty, societe, journal, numpiece,
                compte, tiers, echeance, libelle, montantdebit, montantcredit);
        ecriture.setId(id);
        ecriture.setNumero(num);
        Exercice exercice = this.findExercice(societe);
        if (exercice == null) {
            throw new Exception("Aucun exercice correspondant");
        } else {
            ecriture.setExercice(exercice.getId());
        }
        ecriture.setEtat(1);
        ecriture.updateToTableWithHisto(refUser, c);
    }

    public void updateMultipleEcriture(java.sql.Date[] daty, String[] societe, String[] journal, String[] numpiece, String[] compte, String[] tiers,
            java.sql.Date[] echeance, String[] libelle, double[] montantcredit, double[] montantdebit, String[] id, int numero, int tailleInit, String refUser) throws Exception {

        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            int indice = 0;
            for (indice = 0; indice < tailleInit; indice++) {
                //update
                updateEcriture(id[indice], daty[indice], societe[indice], journal[indice], numpiece[indice],
                        compte[indice], tiers[indice], echeance[indice], libelle[indice], montantdebit[indice], montantcredit[indice], refUser, c, numero);
            }
            for (indice = tailleInit; indice < daty.length; indice++) {
                //insert
                insertEcriture(daty[indice], societe[indice], journal[indice], numpiece[indice],
                        compte[indice], tiers[indice], echeance[indice], libelle[indice], montantdebit[indice], montantcredit[indice], refUser, c, numero);
            }

            c.commit();
        } catch (Exception ex) {
            if (c != null) {
                c.rollback();
            }
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    private FactureFournisseur getFacture(String idFact, String table, Connection c) throws Exception {
        FactureFournisseur fact = new FactureFournisseur();
        fact.setNomTable(table);
        fact.setIdFactureFournisseur(idFact);
        FactureFournisseur[] facts = (FactureFournisseur[]) CGenUtil.rechercher(fact, null, null, c, "");
        if (facts.length == 0) {
            throw new Exception("Facture n'existe pas");
        }
        return facts[0];
    }

    private LigneCredit getLigneCredit(String idFact, String table, String tableligne, Connection c) throws Exception {
        UnionIntraTable fflc = new UnionIntraTable();
        fflc.setNomTable(table);
        fflc.setId1(idFact);
        UnionIntraTable[] ff = (UnionIntraTable[]) CGenUtil.rechercher(fflc, null, null, c, "");
        if (ff.length == 0) {
            throw new Exception("Facture non rattaché à une ligne credit : " + idFact);
        }

        LigneCredit lc = new LigneCredit();
        lc.setNomTable(tableligne);
        lc.setIdLigne(ff[0].getId2());
        LigneCredit[] lignes = (LigneCredit[]) CGenUtil.rechercher(lc, null, null, c, "");
        if (lignes.length == 0) {
            throw new Exception("Ligne de credit n'existe pas : " + ff[0].getId2());
        }
        return lignes[0];
    }

    private SocieteEntite getSociete(String identite, Connection c) throws Exception {
        SocieteEntite soc = new SocieteEntite();
        soc.setIdentite(identite);
        SocieteEntite[] socs = (SocieteEntite[]) CGenUtil.rechercher(soc, null, null, c, "");
        if (socs.length == 0) {
            throw new Exception("Entite non rattache a une societe : " + identite);
        }
        return socs[0];
    }

    private TypeObjet getCompte(String id, String table, Connection c) throws Exception {
        TypeObjet cmpt = new TypeObjet();
        cmpt.setNomTable(table);
        cmpt.setId(id);
        TypeObjet[] cmpts = (TypeObjet[]) CGenUtil.rechercher(cmpt, null, null, c, "");
        if (cmpts.length == 0) {
            throw new Exception("Type ligne credit n'existe pas : " + id);
        }
        return cmpts[0];
    }

    private CompteTiers getTiers(String reftiers, String societe, String type, Connection c) throws Exception {
      //  System.out.println("reftiers = " + reftiers);
      //  System.out.println("societe = " + societe);
       // System.out.println("type = " + type);
       // System.out.println("c = " + c);
        CompteTiers tr = new CompteTiers();
        tr.setReftiers(reftiers);
        tr.setIdsociete(societe);
        tr.setTypetiers(type);
        CompteTiers[] trs = (CompteTiers[]) CGenUtil.rechercher(tr, null, null, c, "");
      //  System.out.println("trs = " + trs.length);
        if (trs.length == 0) {
            throw new Exception("Compte tiers n existe pas " + type + " - " + reftiers + " - " + societe);
        }
        return trs[0];
    }

    public void ecrireFactureF(String idFact, Connection c, String refU) throws Exception {
        Visa vs = new Visa();
        vs.setNomTable("VISAFACTUREF");
        vs.setIdObjet(idFact);
        Visa[] visas = (Visa[]) CGenUtil.rechercher(vs, null, null, c, "");
        if (visas.length == 0) {
            throw new Exception("Facture non vise");
        }

        FactureFournisseur fact = this.getFacture(idFact, "FACTUREFOURNISSEUR", c);
        LigneCredit ligne = this.getLigneCredit(idFact, "FACTUREFOURNISSEURLC", "LIGNECREDIT", c);
        SocieteEntite soc = this.getSociete(ligne.getIdEntite(), c);

        Exercice exercice = this.findExercice(soc.getIdsociete(), visas[0].getDaty());
        if (exercice == null) {
            throw new Exception("Aucun exercice correspondant");
        }

        TypeObjet cmpt = this.getCompte(ligne.getIdTypeLigne(), "TYPESORTIE", c);

        CompteTiers tr = this.getTiers(fact.getIdFournisseur(), soc.getIdsociete(), "F", c);

        if (cmpt.getDesce().startsWith("64")) {
            if (fact.getDesignation().indexOf("avance") > 0 && cmpt.getDesce().compareTo("641001") == 0) {
                tr.setCompte("425001");
            } else {
                tr.setCompte("421001");
            }
        } //achat
        else {
            tr = this.getTiers(fact.getIdFournisseur(), soc.getIdsociete(), "F", c);
        }

        System.out.println("FactureFournisseur : " + fact.getIdFournisseur() + " COMPTE  : " + cmpt.getDesce() + " TIERS " + tr.getCompte());

        String journal = findJournalCorrespondant(cmpt.getDesce(), tr.getCompte(), c);

        double montant = fact.getMontantTTC() - fact.getIdTVA();

        int num = getNumeroEcriture(c);

        System.out.println("DEBUT FactureFournisseur : " + fact.getIdFournisseur() + " Journal : " + journal);

        Ecriture debit = new Ecriture();
        debit.setDaty(visas[0].getDaty());
        debit.setSociete(soc.getIdsociete());
        debit.setCodejournal(journal);
        debit.setNumpiece(fact.getNumFact());
        debit.setCompte(cmpt.getDesce());
        debit.setEcheance(fact.getDatyecheance());
        debit.setLibelle("Ecriture auto : " + fact.getDesignation());
        debit.setMontantdebit(montant);
        debit.setMontantcredit(0);
        debit.setNumero(num);
        debit.setEtat(0);
        debit.setIdobjet(idFact);
        debit.setExercice(exercice.getId());
        debit.construirePK(c);
        debit.insertToTableWithHisto(refU, c);

        comptabilite.Ecriture credit = new comptabilite.Ecriture();
        credit.setDaty(visas[0].getDaty());
        credit.setSociete(soc.getIdsociete());
        credit.setCodejournal(journal);
        credit.setNumpiece(fact.getNumFact());
        credit.setCompte(tr.getCompte());
        credit.setComptetiers(tr.getId());
        credit.setEcheance(fact.getDatyecheance());
        credit.setLibelle("Ecriture auto : " + tr.getNom() + " " + fact.getDesignation());
        credit.setMontantdebit(0);
        credit.setMontantcredit(fact.getMontantTTC());
        credit.setNumero(num);
        credit.setEtat(0);
        credit.setIdobjet(idFact);
        credit.setExercice(exercice.getId());
        credit.construirePK(c);
        credit.insertToTableWithHisto(refU, c);

        if (fact.getIdTVA() > 0) {
            Ecriture tva = new Ecriture();
            tva.setDaty(visas[0].getDaty());
            tva.setSociete(soc.getIdsociete());
            tva.setCodejournal(journal);
            tva.setNumpiece(fact.getNumFact());
            String comptetva = this.getCompteTVA(debit.getCompte());
            tva.setCompte(comptetva);
            tva.setEcheance(fact.getDatyecheance());
            tva.setLibelle("Ecriture auto (TVA) : " + fact.getDesignation());
            tva.setMontantdebit(fact.getIdTVA());
            tva.setMontantcredit(0);
            tva.setNumero(num);
            tva.setEtat(0);
            tva.setIdobjet(idFact);
            tva.setExercice(exercice.getId());
            tva.construirePK(c);
            tva.insertToTableWithHisto(refU, c);
        }
        System.out.println("OK FactureFournisseur : " + fact.getIdFournisseur());
    }

    public void ecrireFactureC(String idFact, Connection c, String refU) throws Exception {
        Visa vs = new Visa();
        vs.setNomTable("VISAFACTURECLIENT");
        vs.setIdObjet(idFact);
        Visa[] visas = (Visa[]) CGenUtil.rechercher(vs, null, null, c, "");
        if (visas.length == 0) {
            throw new Exception("Facture non vise");
        }

        FactureFournisseur fact = this.getFacture(idFact, "FactureClient", c);
        LigneCredit ligne = this.getLigneCredit(idFact, "FACTURECLIENTLC", "LIGNECREDITRECETTE", c);
        SocieteEntite soc = this.getSociete(ligne.getIdEntite(), c);

        Exercice exercice = this.findExercice(soc.getIdsociete(), visas[0].getDaty());
        if (exercice == null) {
            throw new Exception("Aucun exercice correspondant");
        }

        TypeObjet cmpt = this.getCompte(ligne.getIdTypeLigne(), "TYPEENTREE", c);
        CompteTiers tr = this.getTiers(fact.getIdFournisseur(), soc.getIdsociete(), "C", c);

        System.out.println("Client : " + fact.getIdFournisseur() + " COMPTE  : " + cmpt.getDesce() + " TIERS " + tr.getCompte());

        String journal = findJournalCorrespondant(cmpt.getDesce(), tr.getCompte(), c);

        //Montant
        double montant = fact.getMontantTTC() - fact.getIdTVA();

        int num = getNumeroEcriture(c);

        Ecriture credit = new Ecriture();
        credit.setDaty(visas[0].getDaty());
        credit.setSociete(soc.getIdsociete());
        credit.setCodejournal(journal);
        credit.setNumpiece(fact.getNumFact());
        credit.setCompte(cmpt.getDesce());
        credit.setEcheance(fact.getDatyecheance());
        credit.setLibelle("Ecriture auto : " + fact.getDesignation());
        credit.setMontantdebit(0);
        credit.setMontantcredit(montant);
        credit.setNumero(num);
        credit.setEtat(0);
        credit.setIdobjet(idFact);
        credit.setExercice(exercice.getId());
        credit.construirePK(c);
        credit.insertToTableWithHisto(refU, c);

        comptabilite.Ecriture debit = new comptabilite.Ecriture();
        debit.setDaty(visas[0].getDaty());
        debit.setSociete(soc.getIdsociete());
        debit.setCodejournal(journal);
        debit.setNumpiece(fact.getNumFact());
        debit.setCompte(tr.getCompte());
        debit.setComptetiers(tr.getId());
        debit.setEcheance(fact.getDatyecheance());
        debit.setLibelle("Ecriture auto : " + tr.getNom() + " " + fact.getDesignation());
        debit.setMontantdebit(fact.getMontantTTC());
        debit.setMontantcredit(0);
        debit.setNumero(num);
        debit.setEtat(0);
        debit.setIdobjet(idFact);
        debit.setExercice(exercice.getId());
        debit.construirePK(c);
        debit.insertToTableWithHisto(refU, c);

        if (fact.getIdTVA() > 0) {
            Ecriture tva = new Ecriture();
            tva.setDaty(visas[0].getDaty());
            tva.setSociete(soc.getIdsociete());
            tva.setCodejournal(journal);
            tva.setNumpiece(fact.getNumFact());
            String comptetva = this.getCompteTVA(debit.getCompte());
            tva.setCompte(comptetva);
            tva.setEcheance(fact.getDatyecheance());
            tva.setLibelle("Ecriture auto (TVA) : " + fact.getDesignation());
            tva.setMontantdebit(0);
            tva.setMontantcredit(fact.getIdTVA());
            tva.setNumero(num);
            tva.setEtat(0);
            tva.setIdobjet(idFact);
            tva.setExercice(exercice.getId());
            tva.construirePK(c);
            tva.insertToTableWithHisto(refU, c);
        }
    }

    private String findJournalCorrespondant(String debit, String credit, Connection c) throws Exception {
        ComptejournalLibelle[] lignes = getJournaux(debit, credit, c);
        if (lignes.length == 0) {
            ComptejournalLibelle[] lgns = getJournaux(credit, debit, c);
            if (lgns.length == 0) {
                throw new Exception("Les comptes ne correspondent a aucun journal : " + debit + " / " + credit);
            }
            return lgns[0].getCodejournal();
        }
        return lignes[0].getCodejournal();
    }

    private ComptejournalLibelle[] getJournaux(String debit, String credit, Connection c) throws Exception {
        try{
            ComptejournalLibelle cpt = new ComptejournalLibelle();
            ComptejournalLibelle[] lignes = (ComptejournalLibelle[]) CGenUtil.rechercher(cpt, null, null, c,
                    " and  (debutdebit<" + debit + " and " + debit + "<findebit) and (debutcredit<" + credit + " and " + credit + "<fincredit)");

            return lignes;
        }
        catch(Exception e){
            c.rollback();
            e.printStackTrace();
            throw e;
        }
    }

    private String getCompteTVA(String compte) {
        int compteI = Integer.parseInt(compte);
        if (compteI > 599999 && compteI < 610000) {
            return "445601";
        } else if (compteI > 609999 && compteI < 630000) {
            return "445602";
        } else if (compteI > 699999 && compteI < 710000) {
            return "445701";
        } else if (compteI > 709999 && compteI < 730000) {
            return "445702";
        } else {
            return "445601";
        }
    }

    public void lettrerEcriture(Ecriture[] ecritures, String refUser, Connection c) throws Exception {
        String lettr = getLettre(c);
        for (int a = 0; a < ecritures.length; a++) {
            Lettrage lettre = new Lettrage();
            lettre.setSociete(ecritures[a].getSociete());
            lettre.setExercice(ecritures[a].getExercice());
            lettre.setIdecriture(ecritures[a].getId());
            lettre.setLettres(lettr);
            lettre.setDaty(Utilitaire.dateDuJourSql());
            lettre.setMontantdebit(ecritures[a].getMontantdebit());
            lettre.setMontantcredit(ecritures[a].getMontantcredit());
            lettre.setEtat(1);
            lettre.construirePK(c);
            lettre.insertToTableWithHisto(refUser, c);
        }
    }

    public void lettrerEcriture(String[] ecritures, String refUser) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);

            String ins = "";
            int a = 0;
            for (a = 0; a < ecritures.length - 1; a++) {
                ins += "'" + ecritures[a] + "', ";
            }
            ins += "'" + ecritures[a] + "'";

            Ecriture fact = new Ecriture();
            Ecriture[] ecrs = (Ecriture[]) CGenUtil.rechercher(fact, null, null, c, " and id in (" + ins + ")");

            double credits = 0;
            double debits = 0;
            for (a = 0; a < ecrs.length; a++) {
                credits += ecrs[a].getMontantcredit();
                debits += ecrs[a].getMontantdebit();
            }

            if (credits != debits) {
                throw new Exception("Les montants debit et credit doivent etre egaux");
            }

            //Test compte comptetiers
            String compte = ecrs[0].getCompte();
            String comptetiers = ecrs[0].getComptetiers();
            for (a = 0; a < ecrs.length; a++) {
                if (compte.compareTo(ecrs[a].getCompte()) != 0) {
                    throw new Exception("Les comptes doivent etre egaux");
                }
                if (comptetiers.compareTo(ecrs[a].getComptetiers()) != 0) {
                    throw new Exception("Les tiers doivent etre egaux");
                }
            }

            lettrerEcriture(ecrs, refUser, c);

            c.commit();
        } catch (Exception ex) {
            if (c != null) {
                c.rollback();
            }
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    private MvtCaisse getMvtCaisse(String idMvt, Connection c) throws Exception {
        MvtCaisse mvt = new MvtCaisse();
        mvt.setId(idMvt);
        MvtCaisse[] mvts = (MvtCaisse[]) CGenUtil.rechercher(mvt, null, null, c, "");
        if (mvts.length == 0) {
            throw new Exception("Mouvement de caisse n'existe pas");
        }
        return mvts[0];
    }

    private CaisseCompta getCompteCaisse(String idCaisse, Connection c) throws Exception {
        CaisseCompta mvt = new CaisseCompta();
        mvt.setIdcaisse(idCaisse);
        CaisseCompta[] mvts = (CaisseCompta[]) CGenUtil.rechercher(mvt, null, null, c, "");
        if (mvts.length == 0) {
            throw new Exception("Information compta sur caisse n'existe pas" + idCaisse);
        }
        return mvts[0];
    }

    public void ecrireMvt(String idMvt, String type, Connection c, String refU) throws Exception {
        //MvtCaisse
        MvtCaisse mvt = this.getMvtCaisse(idMvt, c);
        CaisseCompta caisse = this.getCompteCaisse(mvt.getIdCaisse(), c);
        System.out.println("MVT : " + idMvt);

        Exercice exercice = this.findExercice(caisse.getIdsociete(), mvt.getDaty());
        if (exercice == null) {
            throw new Exception("Aucun exercice correspondant : " + mvt.getDaty());
        }

        String piece = mvt.getNumPiece();
        if (mvt.getNumcheque() != null) {
            piece += mvt.getNumcheque();
        }

        int num = getNumeroEcriture(c);

        String journal = null;
        String compte = null;
        String comptetiers = null;

        if (mvt.getNumPiece().startsWith("VIR")) {
            //virement  : ligne 1 ihany no soratana
            journal = findJournalCorrespondant(caisse.getCompte(), caisse.getCompte(), c);
            comptabilite.Ecriture debit = new comptabilite.Ecriture();
            debit.setDaty(mvt.getDaty());
            debit.setSociete(caisse.getIdsociete());
            debit.setCodejournal(journal);
            debit.setNumpiece(piece);
            debit.setCompte(compte);
            debit.setComptetiers(comptetiers);
            debit.setEcheance(mvt.getDatyValeur());
            debit.setLibelle("Ecriture auto : " + mvt.getDesignation());
            debit.setMontantdebit(mvt.getDebit());
            debit.setMontantcredit(mvt.getCredit());
            debit.setNumero(num);
            debit.setEtat(0);
            debit.setExercice(exercice.getId());
            debit.setIdobjet(idMvt);
            debit.construirePK(c);
            debit.insertToTableWithHisto(refU, c);
            return;
        }

        if (mvt.getTiers().compareTo("-") != 0 && mvt.getTiers() != null && (mvt.getTiers().startsWith("clt") || mvt.getTiers().startsWith("CLT"))) {
            //achat tsotra
            if (mvt.getIdOrdre().startsWith("ORP")) {
                type = "F";
            } else if (mvt.getIdOrdre().startsWith("ORR")) {
                type = "C";
            }
            CompteTiers tr = this.getTiers(mvt.getTiers(), caisse.getIdsociete(), type, c);
            journal = findJournalCorrespondant(tr.getCompte(), caisse.getCompte(), c);
            compte = tr.getCompte();
            comptetiers = tr.getId();
        } else {
            //agence vers caisse : idordre : ORP ORR
            OrdonnerPayement orr = new OrdonnerPayement();
            FactureFournisseur fcc = new FactureFournisseur();
            if (mvt.getIdOrdre().startsWith("ORP")) {
                type = "F";
                orr.setNomTable("Ordonnerpayement");
                fcc.setNomTable("facturefournisseur");
            } else if (mvt.getIdOrdre().startsWith("ORR")) {
                type = "C";
                orr.setNomTable("Ordonnerrecette");
                fcc.setNomTable("factureclient");
            }
            orr.setId(mvt.getIdOrdre());
            OrdonnerPayement[] reponse = (OrdonnerPayement[]) CGenUtil.rechercher(orr, null, null, c, "");
            if (reponse != null && reponse.length > 0) {
                fcc.setIdFactureFournisseur(reponse[0].getDed_Id());
                FactureFournisseur[] listefcc = (FactureFournisseur[]) CGenUtil.rechercher(fcc, null, null, c, "");
                if (listefcc != null && listefcc.length > 0) {
                    CompteTiers tr = this.getTiers(listefcc[0].getIdFournisseur(), caisse.getIdsociete(), type, c);
                    journal = findJournalCorrespondant(tr.getCompte(), caisse.getCompte(), c);
                    compte = tr.getCompte();
                    comptetiers = tr.getId();
                }
            }
        }
        //avance
        if (mvt.getDesignation().indexOf("avance") > 0 || mvt.getDesignation().indexOf("avanve") > 0) {
            journal = "JOU000009";
            compte = "425001";
        }
        //salaire
        if (mvt.getDesignation().indexOf("salaire") > 0) {
            journal = "JOU000009";
            compte = "421001";
        }

        System.out.println("JOURNAL : " + journal);
        System.out.println("COMPTE : " + compte + " " + comptetiers);

        comptabilite.Ecriture debit = new comptabilite.Ecriture();
        debit.setDaty(mvt.getDaty());
        debit.setSociete(caisse.getIdsociete());
        debit.setCodejournal(journal);
        debit.setNumpiece(piece);
        debit.setCompte(compte);
        debit.setComptetiers(comptetiers);
        debit.setEcheance(mvt.getDatyValeur());
        debit.setLibelle("Ecriture auto : " + mvt.getDesignation());
        debit.setMontantdebit(mvt.getDebit());
        debit.setMontantcredit(mvt.getCredit());
        debit.setNumero(num);
        debit.setEtat(0);
        debit.setExercice(exercice.getId());
        debit.setIdobjet(idMvt);
        debit.construirePK(c);
        debit.insertToTableWithHisto(refU, c);

        Ecriture credit = new Ecriture();
        credit.setDaty(mvt.getDaty());
        credit.setSociete(caisse.getIdsociete());
        credit.setCodejournal(journal);
        credit.setNumpiece(piece);
        credit.setCompte(caisse.getCompte());
        credit.setEcheance(mvt.getDatyValeur());
        credit.setLibelle("Ecriture auto : " + mvt.getDesignation());
        credit.setMontantdebit(mvt.getCredit());
        credit.setMontantcredit(mvt.getDebit());
        credit.setNumero(num);
        credit.setEtat(0);
        credit.setExercice(exercice.getId());
        credit.setIdobjet(idMvt);
        credit.construirePK(c);
        credit.insertToTableWithHisto(refU, c);
    }

    public Balance[] setInitSoldeBalance(Balance[] liste, String daty) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            Balance tr = new Balance();
            tr.setNomTable("balance_groupe");
           // System.out.println("Set init balance");

            for (int a = 0; a < liste.length; a++) {
                String requete = "select exercice.id, balance_groupe.datedebut, balance_groupe.datefin, balance_groupe.societe, cast(compte  as integer) as compte, intitule, "
                        + "cast(sum(soldecredit)  as number(20,2))as initcredit, cast(sum(soldedebit)  as number(20,2)) as initdebit, cast(0  as number(20,2)) as mvtdebit, cast(0  as number(20,2)) as mvtcredit, max(daty) as daty, max(echeance) as echeance, "
                        + "cast(0  as number(20,2)) as soldedebit, cast(0  as number(20,2)) as soldecredit from balance_groupe join exercice on exercice.id = balance_groupe.exercice "
                        + "where ";

                if (daty != null && daty.compareTo("") != 0) {
                    requete += " daty > balance_groupe.datedebut and daty < '" + daty + "'";
                } else {
                    requete += " daty > balance_groupe.datedebut and daty < exercice.datedebut";
                }
                requete += " and balance_groupe.exercice='" + liste[a].getExercice() + "' and compte=" + liste[a].getCompte()
                        + " group by exercice.id ,balance_groupe.exercice, balance_groupe.datedebut, balance_groupe.datefin, balance_groupe.societe, compte, intitule";

              //  System.out.println("Blabla : " + requete);

                Balance[] trs = (Balance[]) CGenUtil.rechercher(tr, requete, c);
                if (trs.length == 0) {
                    liste[a].setInitdebit(0);
                    liste[a].setInitcredit(0);
                } else {
                    liste[a].setInitdebit(trs[0].getInitdebit());
                    liste[a].setInitcredit(trs[0].getInitcredit());
                }
                setSoldeFinalBalance(liste[a]);
            }
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
        return liste;
    }

    private void setSoldeFinalBalance(Balance b) throws Exception {
        double soldeFinal = (b.getInitdebit() + b.getMvtdebit()) - (b.getInitcredit() + b.getMvtcredit());
        if (soldeFinal > 0) {
            b.setSoldedebit(soldeFinal);
            b.setSoldecredit(0);
        } else if (soldeFinal < 0) {
            b.setSoldedebit(0);
            b.setSoldecredit(soldeFinal * -1);
        } else {
            b.setSoldedebit(0);
            b.setSoldecredit(0);
        }
    }

    public BalanceTiers[] setInitSoldeBalanceTiers(BalanceTiers[] liste, String daty) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            BalanceTiers tr = new BalanceTiers();
            tr.setNomTable("balancetiers_groupe");

            for (int a = 0; a < liste.length; a++) {
                String requete = "select exercice.id, balancetiers_groupe.datedebut, balancetiers_groupe.datefin, societe, comptetiers, intitule, "
                        + "sum(soldecredit) as initcredit, sum(soldedebit) as initdebit, 0 as mvtdebit, 0 as mvtcredit, "
                        + "0 as montantdebit, 0 as montantcredit from balancetiers_groupe join exercice on exercice.id = balancetiers_groupe.exercice "
                        + "where ";

                if (daty != null && daty.compareTo("") != 0) {
                    requete += " daty > balancetiers_groupe.datedebut and daty < '" + daty + "'";
                } else {
                    requete += " daty > balancetiers_groupe.datedebut and daty < exercice.datedebut ";
                }

                requete += " and balancetiers_groupe.exercice='" + liste[a].getExercice() + "' and comptetiers='" + liste[a].getComptetiers() + "'"
                        + " group by exercice.id, balancetiers_groupe.datedebut, balancetiers_groupe.datefin, societe, comptetiers, intitule";

System.out.println("Requete "+requete);				
				
                BalanceTiers[] trs = (BalanceTiers[]) CGenUtil.rechercher(tr, requete, c);
                if (trs.length == 0) {
                    liste[a].setInitdebit(0);
                    liste[a].setInitcredit(0);
                } else {

                    liste[a].setInitdebit(trs[0].getInitdebit());
                    liste[a].setInitcredit(trs[0].getInitcredit());
                }
                setSoldeFinalBalance(liste[a]);
            }
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
        return liste;
    }

    private String[] getTypeFromCompte(String[] comptes) throws Exception {
        String[] types = new String[comptes.length];

        for (int iterator = 0; iterator < comptes.length; iterator++) {
            if (comptes[iterator].startsWith("40")) {
                types[iterator] = "F";
            } else if (comptes[iterator].startsWith("41")) {
                types[iterator] = "C";
            } else if (comptes[iterator].startsWith("42")) {
                types[iterator] = "E";
            } else {
                throw new Exception("Compte ne correspond pas un type tiers");
            }
        }
        return types;
    }

    public void insertTiersMultipleCompte(String reftiers, String comptes, Connection c, String refU) throws Exception {
        String[] listecompte = Utilitaire.split(comptes, ";");
        String[] types = getTypeFromCompte(listecompte);

        Client tr = new Client();
        tr.setIdClient(reftiers);
        Client[] clients = (Client[]) CGenUtil.rechercher(tr, null, null, c, "");
        if (clients.length == 0) {
            throw new Exception("Client n'existe pas");
        }

        Societe soc = new Societe();
        Societe[] societes = (Societe[]) CGenUtil.rechercher(soc, null, null, c, "");

        for (int iterator = 0; iterator < societes.length; iterator++) {
            for (int iterator2 = 0; iterator2 < listecompte.length; iterator2++) {
                CompteTiers cpt = new CompteTiers();
                cpt.setIdsociete(societes[iterator].getId());
                cpt.setCompte(listecompte[iterator2]);
                cpt.setReftiers(reftiers);
                cpt.setNom(clients[0].getNom());
                cpt.setNif(clients[0].getNif());
                cpt.setTelephone(clients[0].getTelephone());
                cpt.setAdresse(clients[0].getAdresse());
                cpt.setStat(clients[0].getNumstat());
                cpt.setRcs(clients[0].getRc());
                cpt.setTypetiers(types[iterator2]);
                cpt.construirePK(c);
                cpt.insertToTableWithHisto(refU, c);
            }
        }
    }

    public void updateTiers(String reftiers, Connection c, String refUser) throws Exception {
        Client tr = new Client();
        tr.setIdClient(reftiers);
        Client[] clients = (Client[]) CGenUtil.rechercher(tr, null, null, c, "");
        if (clients.length == 0) {
            throw new Exception("Client n'existe pas");
        }

        CompteTiers trs = new CompteTiers();
        trs.setReftiers(reftiers);
        CompteTiers[] comptetiers = (CompteTiers[]) CGenUtil.rechercher(trs, null, null, c, "");
        if (comptetiers.length == 0) {
            throw new Exception("Compte tiers n'existe pas");
        }

        for (int iterator = 0; iterator < comptetiers.length; iterator++) {
            comptetiers[iterator].setNom(clients[0].getNom());
            comptetiers[iterator].setNif(clients[0].getNif());
            comptetiers[iterator].setTelephone(clients[0].getTelephone());
            comptetiers[iterator].setAdresse(clients[0].getAdresse());
            comptetiers[iterator].setStat(clients[0].getNumstat());
            comptetiers[iterator].setRcs(clients[0].getRc());
            comptetiers[iterator].updateToTableWithHisto(refUser, c);
        }

    }

    public void transcrireClientFournisseur(String refUser) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);

            Client tr = new Client();
            Client[] clients = (Client[]) CGenUtil.rechercher(tr, null, null, c, "");

            System.out.println("DEBUT : TRANSCRIPTION TIERS");

            for (int iterator = 0; iterator < clients.length; iterator++) {
                System.out.println("numero : " + iterator + " - " + clients[iterator].getIdClient());
                insertTiersMultipleCompte(clients[iterator].getIdClient(), "411101;401101;411102;401102;", c, refUser);
            }

            System.out.println("FIN : TRANSCRIPTION TIERS");

            c.commit();
        } catch (Exception ex) {
            if (c != null) {
                c.rollback();
            }
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    //transcription depense + vente
    public void transcrireDepense(int annee, String refUser) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            Visa vs = new Visa();
            vs.setNomTable("VISAFACTUREF");
            Visa[] visas = (Visa[]) CGenUtil.rechercher(vs, null, null, c, " and extract(year from daty)=" + annee);

            System.out.println("DEBUT : TRANSCRIPTION DEPENSE");

            /* Probleme : 2124/FF082365 */
            for (int iterator = 0; iterator < visas.length; iterator++) {
                System.out.println("numero : " + iterator + " - " + visas[iterator].getIdObjet());
                ecrireFactureF(visas[iterator].getIdObjet(), c, refUser);
                if (iterator % 100 == 0) {
                    c.commit();
                    System.out.println("OK atreto : " + iterator);
                }
            }

            System.out.println("FIN : TRANSCRIPTION DEPENSE");
            c.commit();
        } catch (Exception ex) {
            if (c != null) {
                c.rollback();
            }
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void transcrireVente(int annee, String refUser) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            Visa vs = new Visa();
            vs.setNomTable("VISAFACTURECLIENT");
            Visa[] visas = (Visa[]) CGenUtil.rechercher(vs, null, null, c, " and extract(year from daty)=" + annee);

            System.out.println("DEBUT : TRANSCRIPTION VENTE");
            for (int iterator = 0; iterator < visas.length; iterator++) {
                System.out.println("numero : " + iterator + " - " + visas[iterator].getIdObjet());
                ecrireFactureC(visas[iterator].getIdObjet(), c, refUser);
                if (iterator % 100 == 0) {
                    c.commit();
                    System.out.println("OK atreto : " + iterator);
                }
            }

            System.out.println("FIN : TRANSCRIPTION VENTE");
            c.commit();
        } catch (Exception ex) {
            if (c != null) {
                c.rollback();
            }
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

	/* misy erreur : MVT184932, MVT185029, MVT185034, MVT185035, MVT185048, MVT185049, MVT185050, MVT185051, MVT185052, MVT185053 , MVT185196 */
    public void transcrireTresorerie(int annee, String refUser) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);

            MvtCaisse vs = new MvtCaisse();
            vs.setNomTable("MVTCAISSE");
            MvtCaisse[] visas = (MvtCaisse[]) CGenUtil.rechercher(vs, null, null, c, " and extract(year from daty)=" + annee + " and daty<'19/05/2017' order by id asc");
            System.out.println("DEBUT : TRANSCRIPTION TRESORERIE");

            for (int iterator = 5500; iterator < 7000; iterator++) {
				/* tsy vita : 5418 -> 5420/99 - commité : 5500*/
				if (iterator == 5543) continue;
				System.out.println("numero : " + iterator + " - ");
                String type = "";
                if (visas[iterator].getCredit() == 0) {
                    type = "F";
                } else if (visas[iterator].getDebit() == 0) {
                    type = "C";
                }

                ecrireMvt(visas[iterator].getId(), type, c, refUser);
                if (iterator % 100 == 0) {
                    c.commit();
                    System.out.println("OK atreto : " + iterator);
                }
            }
            System.out.println("FIN : TRANSCRIPTION TRESORERIE");

            c.commit();
        } catch (Exception ex) {
            if (c != null) {
                c.rollback();
            }
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public double[] calculSommeInit(Balance[] listeR) throws Exception {
        double resultats[] = new double[4];
        resultats[0] = 0;
        resultats[1] = 0;
        resultats[2] = 0;
        resultats[3] = 0;
        for (int i = 0; i < listeR.length; i++) {
            resultats[0] += listeR[i].getInitdebit();
            resultats[1] += listeR[i].getInitcredit();
            resultats[2] += listeR[i].getSoldedebit();
            resultats[3] += listeR[i].getSoldecredit();
        }

        if (resultats[0] - resultats[1] > 0) {
            resultats[0] = resultats[0] - resultats[1];
            resultats[1] = 0;
        } else if (resultats[0] - resultats[1] < 0) {
            resultats[0] = 0;
            resultats[1] = resultats[1] - resultats[0];
        } else if (resultats[0] - resultats[1] == 0) {
            resultats[0] = 0;
            resultats[1] = 0;
        }

        if (resultats[2] - resultats[3] > 0) {
            resultats[2] = resultats[2] - resultats[3];
            resultats[3] = 0;
        } else if (resultats[2] - resultats[3] < 0) {
            resultats[2] = 0;
            resultats[3] = resultats[3] - resultats[2];
        } else if (resultats[2] - resultats[3] == 0) {
            resultats[2] = 0;
            resultats[3] = 0;
        }

        return resultats;
    }

    public void reporter(String exercice, java.sql.Date daty, String refU) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);

            reporter(exercice, daty, refU, c);

            c.commit();
        } catch (Exception ex) {
            if (c != null) {
                c.rollback();
            }
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void reporter(String exercice, java.sql.Date daty, String refU, Connection c) throws Exception {
        Exercice exo = new Exercice();
        exo.setId(exercice);
        Exercice[] exos = (Exercice[]) CGenUtil.rechercher(exo, null, null, c, "");
        if (exos.length == 0) {
            throw new Exception("Exercice n'existe pas");
        }
        java.sql.Date daty1 = exos[0].getDatedebut();

        Exercice test = new Exercice();
        Exercice[] areporter = (Exercice[]) CGenUtil.rechercher(test, null, null, c, " and idsociete = '" + exos[0].getIdsociete() + "' and datedebut < '" + Utilitaire.formatterDaty(daty1) + "' order by datedebut desc");
        if (areporter.length == 0) {
            throw new Exception("Aucun exercice à reporter");
        }

        System.out.println("REPORTER : DEBUT");

        Balance b = new Balance();
        b.setNomTable("balance_areporter");
        b.setSociete(exos[0].getIdsociete());
        b.setExercice(areporter[0].getId());
        Balance[] bs = (Balance[]) CGenUtil.rechercher(b, null, null, c, " and compte > 100000 and compte < 599999");

        Balance[] listeR = (Balance[]) setInitSoldeBalance(bs, null);

        int num = getNumeroEcriture(c);

        for (int i = 0; i < listeR.length; i++) {
            Ecriture ecrt = new Ecriture();
            ecrt.setDaty(daty1);
            ecrt.setCodejournal("JOU000005");
            ecrt.setCompte(String.valueOf(listeR[i].getCompte()));
            ecrt.setSociete(exos[0].getIdsociete());
            ecrt.setExercice(exercice);
            ecrt.setComptetiers(null);
            ecrt.setLibelle("Report à nouveau : " + listeR[i].getIntitule());
            ecrt.setNumpiece("-");
            ecrt.setEtat(0);
            ecrt.setIdobjet(null);
            ecrt.setEcheance(null);
            ecrt.setMontantdebit(listeR[i].getSoldedebit());
            ecrt.setMontantcredit(listeR[i].getSoldecredit());
            ecrt.setNumero(num);
            ecrt.construirePK(c);
            ecrt.insertToTableWithHisto(refU, c);
        }

        BalanceTiers p = new BalanceTiers();
        p.setNomTable("balancetiers_areporter");
        p.setSociete(exos[0].getIdsociete());
        p.setExercice(areporter[0].getId());
        BalanceTiers[] ps = (BalanceTiers[]) CGenUtil.rechercher(p, null, null, c, "");
        BalanceTiers[] listeT = setInitSoldeBalanceTiers(ps, "");
        for (int i = 0; i < listeT.length; i++) {
            Ecriture ecrt = new Ecriture();
            ecrt.setDaty(daty1);
            ecrt.setCodejournal("JOU000005");
            ecrt.setCompte(String.valueOf(listeT[i].getCompte()));
            ecrt.setSociete(exos[0].getIdsociete());
            ecrt.setExercice(exercice);
            ecrt.setComptetiers(listeT[i].getComptetiers());
            ecrt.setLibelle("Report à nouveau : " + listeT[i].getIntitule());
            ecrt.setNumpiece("-");
            ecrt.setEtat(0);
            ecrt.setIdobjet(null);
            ecrt.setEcheance(null);
            ecrt.setMontantdebit(listeT[i].getSoldedebit());
            ecrt.setMontantcredit(listeT[i].getSoldecredit());
            ecrt.setNumero(num);
            ecrt.construirePK(c);
            ecrt.insertToTableWithHisto(refU, c);
        }
        Balance balance2 = new Balance();
        balance2.setNomTable("avantreport67");
        balance2.setSociete(exos[0].getIdsociete());
        Balance[] balances2 = (Balance[]) CGenUtil.rechercher(balance2, null, null, c, "");
        if (balances2.length == 0) {
            throw new Exception("Aucune exercice à reporter");
        }

        double credit2 = balances2[0].getSoldecredit();
        double debit2 = balances2[0].getSoldedebit();
        String journal67 = "120001";
        if (debit2 - credit2 > 0) {
            debit2 = debit2 - credit2;
            credit2 = 0;
        } else {
            credit2 = credit2 - debit2;
            debit2 = 0;
            journal67 = "129001";
        }

        Ecriture ecrt2 = new Ecriture();
        ecrt2.setDaty(daty1);
        ecrt2.setCodejournal("JOU000005");
        ecrt2.setCompte(journal67);
        ecrt2.setSociete(exos[0].getIdsociete());
        ecrt2.setExercice(exercice);
        ecrt2.setComptetiers(null);
        ecrt2.setLibelle("Report à nouveau : 6-7");
        ecrt2.setNumpiece("-");
        ecrt2.setEtat(0);
        ecrt2.setIdobjet(null);
        ecrt2.setEcheance(null);
        ecrt2.setMontantdebit(debit2);
        ecrt2.setMontantcredit(credit2);
        ecrt2.setNumero(num);
        ecrt2.construirePK(c);
        ecrt2.insertToTableWithHisto(refU, c);

        System.out.println("REPORT FIN");
    }

    public Exercice cloturerExercice(String exercice, java.sql.Date daty, String refUser, Connection c) throws Exception {
        Exercice tr = new Exercice();
        tr.setId(exercice);
        Exercice[] exos = (Exercice[]) CGenUtil.rechercher(tr, null, null, c, "");
        if (exos.length == 0) {
            throw new Exception("Exercice n'existe pas");
        }

        exos[0].setEtat(1);
        exos[0].setDatefin(daty);
        exos[0].updateToTableWithHisto(refUser, c);
        return exos[0];
    }

    public Exercice cloturerExercice(String exercice, java.sql.Date daty, String refU) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);

            Exercice result = cloturerExercice(exercice, daty, refU, c);

            c.commit();
            return result;
        } catch (Exception ex) {
            if (c != null) {
                c.rollback();
            }
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public Exercice getExerciceAfter(Exercice exoClos, Connection c) throws Exception {
        Exercice tr = new Exercice();
        tr.setIdsociete(exoClos.getIdsociete());
        Exercice[] exos = (Exercice[]) CGenUtil.rechercher(tr, null, null, c, " and datedebut > '" + Utilitaire.datetostring(exoClos.getDatefin()) + "' order by datedebut desc");
        if (exos.length == 0) {
            throw new Exception("Aucune exercice suive cette exercice");
        }
        return exos[0];
    }

    public void cloturerEtReporter(String exercice, java.sql.Date daty, String refUser) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);

            Exercice exoClos = cloturerExercice(exercice, daty, refUser, c);

            Exercice anouveau = getExerciceAfter(exoClos, c);

            reporter(anouveau.getId(), anouveau.getDatedebut(), refUser, c);

            c.commit();
        } catch (Exception ex) {
            if (c != null) {
                c.rollback();
            }
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void lettrageAutomatique(String refUser) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);

            //getAllEcritureNonLettre
            Ecriture p = new Ecriture();
            p.setNomTable("grand_livre_alettre_auto");
            Ecriture[] ecritures = (Ecriture[]) CGenUtil.rechercher(p, null, null, c, "");

            ArrayList listesDejaLettre = new ArrayList();

            //reconnaitres les ecritures pouvant etre lettrer
            for (int iterator1 = 0; iterator1 < ecritures.length - 1; iterator1++) {
                if (!listesDejaLettre.contains(ecritures[iterator1].getId())) {
                    Ecriture ecr = ecritures[iterator1];
                    double montantD = ecr.getMontantdebit();
                    double montantC = ecr.getMontantcredit();
                    for (int iterator2 = iterator1 + 1; iterator2 < ecritures.length; iterator2++) {
                        double tempC = ecritures[iterator2].getMontantcredit();
                        double tempD = ecritures[iterator2].getMontantdebit();
                        // ? sao tokony mitovy ko ilay compte??
                        if (!listesDejaLettre.contains(ecritures[iterator2].getId()) && tempC == montantD && tempD == montantC
                                && ecritures[iterator2].getCompte() == ecr.getCompte() && ecritures[iterator2].getComptetiers() == ecr.getComptetiers()) {
                            Ecriture[] alettrer = new Ecriture[2];
                            alettrer[0] = ecr;
                            alettrer[1] = ecritures[iterator2];

                            lettrerEcriture(alettrer, refUser, c);
                            listesDejaLettre.add(ecr.getId());
                            listesDejaLettre.add(ecritures[iterator2].getId());
                            break;
                        }
                    }
                }
            }

            c.commit();
        } catch (Exception ex) {
            if (c != null) {
                c.rollback();
            }
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    private Ecriture[] regrouper(String[] id, String libelle, Connection c) throws Exception {
        if (id == null || id.length == 0) {
            return null;
        }

        String ids = Utilitaire.stringToTab(id, "'", ",");

        return regrouper(ids, libelle, c);
    }

    private Ecriture[] regrouper(String ids, String libelle, Connection c) throws Exception {
        if (ids.compareTo("") == 0) {
            return null;
        }

        Ecriture p = new Ecriture();
        Ecriture[] ecritures = (Ecriture[]) CGenUtil.rechercher(p, " select compte, societe, exercice, '" + libelle + "' as libelle, "
                + "sum(montantdebit) as montantdebit, sum(montantcredit) as montantcredit from adeclarer where id in (" + ids + ")"
                + " group by compte, societe, exercice order by compte asc", c);

        for (int i = 0; i < ecritures.length; i++) {
            double temp = ecritures[i].getMontantdebit();
            ecritures[i].setMontantdebit(ecritures[i].getMontantcredit());
            ecritures[i].setMontantcredit(temp);
            if (ecritures[i].getMontantdebit() * ecritures[i].getMontantcredit() != 0) {
                double ecart = ecritures[i].getMontantdebit() - ecritures[i].getMontantcredit();
                if (ecart > 0) {
                    ecritures[i].setMontantdebit(ecart);
                    ecritures[i].setMontantcredit(0);
                } else {
                    ecritures[i].setMontantdebit(0);
                    ecritures[i].setMontantcredit(ecart * -1);
                }
            }
        }
        return ecritures;
    }

    private Ecriture getEcart(Ecriture[] ecri1, Ecriture[] ecri2, String libelle) throws Exception {
        Ecriture result = null;
        double ecart = 0, debit = 0, credit = 0;
        if (ecri1 != null) {
            for (int i = 0; i < ecri1.length; i++) {
                debit += ecri1[i].getMontantdebit();
                credit += ecri1[i].getMontantcredit();
            }
        }

        if (ecri2 != null) {
            for (int i = 0; i < ecri2.length; i++) {
                debit += ecri2[i].getMontantdebit();
                credit += ecri2[i].getMontantcredit();
            }
        }

        ecart = debit - credit;

        if (ecart > 0) {
            result = new Ecriture();
            result.setLibelle(libelle);
            result.setMontantcredit(ecart);
            result.setMontantdebit(0);
        }
        if (ecart < 0) {
            result = new Ecriture();
            result.setLibelle(libelle);
            result.setMontantcredit(0);
            result.setMontantdebit(ecart * -1);
        }

        return result;
    }

    public Ecriture[] getPrevDeclaration(String[] debitD, String[] creditD, String[] debitU, String[] creditU) throws Exception {
        Connection c = null;

        try {
            c = new UtilDB().GetConn();

            Ecriture[] ecritureDD = regrouper(debitD, "Declaration", c);
            Ecriture[] ecritureCD = regrouper(creditD, "Declaration", c);
            Ecriture ecartD = getEcart(ecritureDD, ecritureCD, "Declaration");
            Ecriture[] ecritureDU = regrouper(debitU, "Reste a declarer", c);
            Ecriture[] ecritureCU = regrouper(creditU, "Reste a declarer", c);
            Ecriture ecartU = getEcart(ecritureDU, ecritureCU, "Reste a declarer");
            int taille = 0;
            if (ecritureDD != null) {
                taille += ecritureDD.length;
            }
            if (ecritureCD != null) {
                taille += ecritureCD.length;
            }
            if (ecritureDU != null) {
                taille += ecritureDU.length;
            }
            if (ecritureCU != null) {
                taille += ecritureCU.length;
            }
            if (ecartD != null) {
                taille += 1;
            }
            if (ecartU != null) {
                taille += 1;
            }
            Ecriture[] resultats = new Ecriture[taille];
            int compteur = 0;
            if (ecritureDD != null) {
                for (int i = 0; i < ecritureDD.length; i++) {
                    resultats[compteur] = ecritureDD[i];
                    compteur++;
                }
            }
            if (ecritureCD != null) {
                for (int i = 0; i < ecritureCD.length; i++) {
                    resultats[compteur] = ecritureCD[i];
                    compteur++;
                }
            }
            if (ecartD != null) {
                resultats[compteur] = ecartD;
                compteur++;
            }

            if (ecritureDU != null) {
                for (int i = 0; i < ecritureDU.length; i++) {
                    resultats[compteur] = ecritureDU[i];
                    compteur++;
                }
            }
            if (ecritureCU != null) {
                for (int i = 0; i < ecritureCU.length; i++) {
                    resultats[compteur] = ecritureCU[i];
                    compteur++;
                }
            }
            if (ecartU != null) {
                resultats[compteur] = ecartU;
                compteur++;
            }
            return resultats;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void lettrerDeclaration(int numE, String debitD, String creditD, String debitU, String creditU, String refU) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);

            Ecriture fact = new Ecriture();
            Ecriture[] declarations = (Ecriture[]) CGenUtil.rechercher(fact, null, null, c, " and numero = " + numE);
            //regrouperna ny debitD
            Ecriture[] debitDg = regrouper(debitD, "Declaration", c);
            Ecriture[] creditDg = regrouper(creditD, "Declaration", c);
            Ecriture[] debitUg = regrouper(debitU, "Reste a declarer", c);
            Ecriture[] creditUg = regrouper(creditU, "Reste a declarer", c);
            //jerena anaty declarations hoe iza no mifanaraka anazy ao d iny no lettrerna

            for (int i = 0; i < declarations.length; i++) {
                if (debitDg != null) {
                    for (int j = 0; j < debitDg.length; j++) {
                        if (declarations[i].getCompte().compareTo(debitDg[j].getCompte()) == 0 && declarations[i].getMontantdebit() == debitDg[j].getMontantdebit()
                                && declarations[i].getMontantcredit() == debitDg[j].getMontantcredit()) {
                            //getdebitD where compte == compte
                            Ecriture[] debitDs = (Ecriture[]) CGenUtil.rechercher(fact, null, null, c, " and id in (" + debitD + ") and compte like '" + debitDg[j].getCompte() + "'");
                            lettrerMultiple(declarations[i], debitDs, refU, c);
                        }
                    }
                }
                if (creditDg != null) {
                    for (int j = 0; j < creditDg.length; j++) {
                        if (declarations[i].getCompte().compareTo(creditDg[j].getCompte()) == 0 && declarations[i].getMontantdebit() == creditDg[j].getMontantdebit()
                                && declarations[i].getMontantcredit() == creditDg[j].getMontantcredit()) {
                            //getdebitD where compte == compte
                            Ecriture[] creditDs = (Ecriture[]) CGenUtil.rechercher(fact, null, null, c, " and id in (" + creditD + ") and compte like '" + creditDg[j].getCompte() + "'");
                            lettrerMultiple(declarations[i], creditDs, refU, c);
                        }
                    }
                }
                if (debitUg != null) {
                    for (int j = 0; j < debitUg.length; j++) {
                        if (declarations[i].getCompte().compareTo(debitUg[j].getCompte()) == 0 && declarations[i].getMontantdebit() == debitUg[j].getMontantdebit()
                                && declarations[i].getMontantcredit() == debitUg[j].getMontantcredit()) {
                            //getdebitD where compte == compte
                            Ecriture[] debitUs = (Ecriture[]) CGenUtil.rechercher(fact, null, null, c, " and id in (" + debitU + ") and compte like '" + debitUg[j].getCompte() + "'");
                            lettrerMultiple(declarations[i], debitUs, refU, c);
                        }
                    }
                }
                if (creditUg != null) {
                    for (int j = 0; j < creditUg.length; j++) {
                        if (declarations[i].getCompte().compareTo(creditUg[j].getCompte()) == 0 && declarations[i].getMontantdebit() == creditUg[j].getMontantdebit()
                                && declarations[i].getMontantcredit() == creditUg[j].getMontantcredit()) {
                            //getdebitD where compte == compte
                            Ecriture[] creditUs = (Ecriture[]) CGenUtil.rechercher(fact, null, null, c, " and id in (" + creditU + ") and compte like '" + creditUg[j].getCompte() + "'");
                            lettrerMultiple(declarations[i], creditUs, refU, c);
                        }
                    }
                }
            }

            c.commit();
        } catch (Exception ex) {
            if (c != null) {
                c.rollback();
            }
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    private void lettrerMultiple(Ecriture ecriture, Ecriture[] ecritures, String refUser, Connection c) throws Exception {
        String lettr = getLettre(c);
        for (int a = 0; a < ecritures.length; a++) {
            Lettrage lettre = new Lettrage();
            lettre.setSociete(ecritures[a].getSociete());
            lettre.setExercice(ecritures[a].getExercice());
            lettre.setIdecriture(ecritures[a].getId());
            lettre.setLettres(lettr);
            lettre.setDaty(Utilitaire.dateDuJourSql());
            lettre.setMontantdebit(ecritures[a].getMontantdebit());
            lettre.setMontantcredit(ecritures[a].getMontantcredit());
            lettre.setEtat(1);
            lettre.construirePK(c);
            lettre.insertToTableWithHisto(refUser, c);
        }
        Lettrage lettre = new Lettrage();
        lettre.setSociete(ecriture.getSociete());
        lettre.setExercice(ecriture.getExercice());
        lettre.setIdecriture(ecriture.getId());
        lettre.setLettres(lettr);
        lettre.setDaty(Utilitaire.dateDuJourSql());
        lettre.setMontantdebit(ecriture.getMontantdebit());
        lettre.setMontantcredit(ecriture.getMontantcredit());
        lettre.setEtat(1);
        lettre.construirePK(c);
        lettre.insertToTableWithHisto(refUser, c);
    }

    public void transcrireEmployeMultiple(String ids, String entites, String noms, String prenoms, String telephones,
            String adresses, String fonctions, String postes, String matricules, String refUser) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            String[] id = ids.split(";");
            String[] entite = entites.split(";");
            String[] nom = noms.split(";");
            String[] prenom = prenoms.split(";");
            String[] telephone = telephones.split(";");
            String[] adresse = adresses.split(";");
            String[] fonction = fonctions.split(";");
            String[] poste = postes.split(";");
            String[] matricule = matricules.split(";");
            for (int i = 0; i < id.length; i++) {
                transcrireEmploye(id[i], entite[i], nom[i], prenom[i], telephone[i], adresse[i], fonction[i],
                        poste[i], matricule[i], refUser, c);
            }
            c.commit();
        } catch (Exception ex) {
            if (c != null) {
                c.rollback();
            }
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    private void transcrireEmploye(String id, String entite, String nom, String prenom, String telephone,
            String adresse, String fonction, String poste, String matricule, String refUser, Connection c) throws Exception {

        SocieteEntite socEnt = getSociete(entite, c);

        String[] listecompte = Utilitaire.split("421001;425001;", ";");
        String[] types = getTypeFromCompte(listecompte);

        for (int i = 0; i < listecompte.length; i++) {
            CompteTiers cpt = new CompteTiers();
            cpt.setIdsociete(socEnt.getIdsociete());
            cpt.setCompte(listecompte[i]);
            cpt.setReftiers(id);
            cpt.setNom(nom + " " + prenom);
            cpt.setNif(matricule);
            cpt.setTelephone(telephone);
            cpt.setAdresse(adresse);
            cpt.setStat(fonction);
            cpt.setRcs(poste);
            cpt.setTypetiers(types[i]);
            cpt.construirePK(c);
            cpt.insertToTableWithHisto(refUser, c);
        }
    }

    private double getSoldeFromCompte(String exercice, String compte, boolean actif, Connection c) throws Exception {
        String[] comptes = Utilitaire.split(compte, ",");
        if (comptes.length == 1 && comptes[0].compareTo("") == 0) {
            return 0;
        } else {
            double solde = 0;
            for (int iterator = 0; iterator < comptes.length; iterator++) {
                int taille = 6 - comptes[iterator].length();
                int compteD = Utilitaire.stringToInt(comptes[iterator]) * (int) Math.pow(10, taille);
                int debut = compteD - 1;
                int fin = compteD + (int) (Math.pow(10, taille) - 1);

                String requete = "select exercice,societe, cast(compte  as integer) as compte,intitule, cast(sum(initdebit)  as number(20,2)) as initdebit, "
                        + " cast(sum(initcredit)  as number(20,2)) as initcredit, cast(sum(mvtdebit)  as number(20,2)) as mvtdebit, cast(sum(mvtcredit)  as number(20,2)) as mvtcredit, "
                        + " cast(sum(soldedebit)  as number(20,2)) as soldedebit, cast(sum(soldecredit)  as number(20,2)) as soldecredit, datefin, datedebut, max(daty) as daty, max(echeance) as echeance from balance_groupe_libelle "
                        + " where 1<2 and upper(exercice) like ('" + exercice + "') AND compte >" + debut + " AND compte <" + fin + " "
                        + " group by exercice, societe, compte, intitule, datefin, datedebut  order by compte DESC";
                Balance tr = new Balance();
                tr.setNomTable("balance_groupe_libelle");
                Balance[] trs = (Balance[]) CGenUtil.rechercher(tr, requete, c);
                if (trs.length == 0) {
                    continue;
                }
                Balance[] listeR = (Balance[]) setInitSoldeBalance(trs, "");
                double[] sommes = (double[]) calculSommeInit(listeR);
                if (actif) {
                    solde += sommes[2] - sommes[3];
                } else {
                    solde += sommes[3] - sommes[2];
                }

            }
            return solde;
        }
    }

    private Exercice getExercicePrev(String exercice, Connection c) throws Exception {
        Exercice exo = new Exercice();
        exo.setId(exercice);
        Exercice[] exos = (Exercice[]) CGenUtil.rechercher(exo, null, null, c, "");
        java.sql.Date daty1 = exos[0].getDatedebut();
        Exercice test = new Exercice();
        Exercice[] areporter = (Exercice[]) CGenUtil.rechercher(test, null, null, c, " and idsociete = '" + exos[0].getIdsociete() + "' and datedebut < '" + Utilitaire.formatterDaty(daty1) + "' order by datedebut desc");
        if (areporter.length == 0) {
            return null;
        }
        return areporter[0];
    }

    public Bilan getBilan(String intitule, String compte, String amort, String exercice, boolean actif, Connection c) throws Exception {
        double brutV = getSoldeFromCompte(exercice, compte, actif, c);
        double amortV = getSoldeFromCompte(exercice, amort, !actif, c);

        Bilan bilan = new Bilan();
        bilan.setBrut(brutV);
        bilan.setAmort(amortV);
        bilan.setNetCalc();
        bilan.setIntitule(intitule);
        bilan.setExercice(exercice);

        return bilan;
    }

    public Bilan genererBilan(String intitule, String compte, String amort, String exercice, boolean actif, Connection c) throws Exception {
        Bilan bilan = getBilan(intitule, compte, amort, exercice, actif, c);
        Exercice prev = getExercicePrev(exercice, c);
        if (prev != null) {
            Bilan bilanprev = getBilan(intitule, compte, amort, prev.getId(), actif, c);
            bilan.setNetPrev(bilanprev.getNet());
            bilan.setExercicePrev(bilanprev.getExercice());
        }
        return bilan;
    }

    public Bilan[] genererActifs(String exercice) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();

            Vector vect = new Vector();
            vect.add(new Bilan(exercice, "<strong>ACTIFS NON COURANTS</strong>", 0, 0));
            vect.add(genererBilan("Immobilisations incorporelles", "20", "280,290", exercice, true, c));
            vect.add(genererBilan("Immobilisations corporelles", "21", "281,291", exercice, true, c));
            vect.add(genererBilan("Immobilisations en-cours", "23", "293", exercice, true, c));
            vect.add(genererBilan("Immobilisations financières", "26,27", "296,297", exercice, true, c));
            vect.add(genererBilan("<strong>TOTAL ACTIFS NON COURANTS</strong>", "20,21,23,26,27", "28,29", exercice, true, c));

            vect.add(new Bilan(exercice, "<strong>ACTIFS COURANTS</strong>", 0, 0));
            vect.add(genererBilan("Stocks de marchandises", "3", "", exercice, true, c));
            vect.add(genererBilan("Créances et emplois assimilés", "", "", exercice, true, c));
            vect.add(genererBilan("Client et comptes rattachés", "41", "491", exercice, true, c));
            vect.add(genererBilan("Etats et organismes sociaux", "43", "", exercice, true, c));
            vect.add(genererBilan("Autres créances", "4", "", exercice, true, c));
            vect.add(genererBilan("Créances diverses", "", "", exercice, true, c));
            vect.add(genererBilan("Trésorerie et équivalence de trésorerie", "5", "", exercice, true, c));
            vect.add(genererBilan("Trésorerie (fonds en caisse et dépôt à vue)", "", "", exercice, true, c));
            vect.add(genererBilan("<strong>TOTAL ACTIFS COURANTS</strong>", "3,4", "", exercice, true, c));
            vect.add(genererBilan("<strong>TOTAL DES ACTIFS</strong>", "20,21,23,26,27,3,4,5", "28,29,49", exercice, true, c));

            Bilan[] resultats = new Bilan[vect.size()];
            vect.copyInto(resultats);
            return resultats;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    @Override
    public Bilan[] genererPassifs(String exercice) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();

            Vector vect = new Vector();

            vect.add(new Bilan(exercice, "<strong>CAPITAUX PROPRES</strong>", 0, 0));
            vect.add(genererBilan("Capital social", "101001", "", exercice, false, c));
            vect.add(genererBilan("Report à nouveau", "110001,119001", "", exercice, false, c));
            vect.add(genererBilan("Résultat en instance d'affectation", "120001,129001", "", exercice, false, c));
            vect.add(genererBilan("Résultat de l'exercice", "", "", exercice, false, c));
            vect.add(genererBilan("<strong>TOTAL CAPITAUX PROPRES</strong>", "10,11,12", "", exercice, false, c));

            vect.add(new Bilan(exercice, "<strong>PASSIFS NON COURANTS</strong>", 0, 0));
            vect.add(new Bilan(exercice, "<strong>TOTAL PASSIFS NON COURANTS</strong>", 0, 0));

            vect.add(new Bilan(exercice, "<strong>PASSIFS COURANTS</strong>", 0, 0));
            vect.add(genererBilan("Fournisseur et comptes rattachés", "40", "", exercice, false, c));
            vect.add(genererBilan("Autres dettes", "", "", exercice, false, c));
            vect.add(genererBilan("Etats : Impôts et Taxes à payer", "", "", exercice, false, c));
            vect.add(genererBilan("Dettes diverses", "", "", exercice, false, c));
            vect.add(genererBilan("<strong>TOTAL PASSIFS COURANTS</strong>", "40", "", exercice, false, c));

            vect.add(genererBilan("<strong>TOTAL DES PASSIFS</strong>", "", "", exercice, false, c));

            Bilan[] resultats = new Bilan[vect.size()];
            vect.copyInto(resultats);
            return resultats;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }
    public Bilan[] getResultatActifs(String exercice,int annee) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();

            Vector vect = new Vector();
            vect.add(getBilanResultat("<strong>ACTIFS NON COURANTS</strong>","","",annee,exercice,true,c));
            vect.add(getBilanResultat("Immobilisations incorporelles", "20","280", annee,exercice,true, c));
            vect.add(getBilanResultat("Immobilisations corporelles", "21","281", annee, exercice,true, c));
            vect.add(getBilanResultat("Immobilisations en-cours", "23","",annee, exercice,true,  c));
            vect.add(getBilanResultat("Immobilisations financières", "26,27","",annee,exercice,true, c));
            vect.add(getBilanResultat("<strong>TOTAL ACTIFS NON COURANTS</strong>", "20,21,23,26,27","280,281", annee,exercice,true,c));
            vect.add(getBilanResultat("<strong>ACTIFS COURANTS</strong>", "","", annee,exercice,true,c));
            vect.add(getBilanResultat("Stocks de marchandises", "3","", annee, exercice,true, c));
            vect.add(getBilanResultat("Créances et emplois assimilés", "","", annee, exercice,true, c));
            vect.add(getBilanResultat("Client et comptes rattachés", "41","49",annee, exercice,true,  c));
            vect.add(getBilanResultat("Etats et organismes sociaux", "43,44","", annee, exercice,true, c));
            vect.add(getBilanResultat("Autres créances", "42,40,48","", annee, exercice,true, c));
            vect.add(getBilanResultat("Créances diverses", "45,46,47","", annee, exercice,true,  c));
            vect.add(getBilanResultat("Trésorerie et équivalence de trésorerie", "","", annee, exercice,true, c));
            vect.add(getBilanResultat("Trésorerie (fonds en caisse et dépôt à vue)", "5","",annee, exercice,true, c));
            vect.add(getBilanResultat("<strong>TOTAL ACTIFS COURANTS</strong>", "3,41,43,44,42,40,48,45,46,47,5","49", annee, exercice,true,  c));
            vect.add(getBilanResultat("<strong>TOTAL DES ACTIFS</strong>", "20,21,23,26,27,3,41,43,44,42,40,48,45,46,47,5","280,281,49", annee, exercice,true, c));

            Bilan[] resultats = new Bilan[vect.size()];
            vect.copyInto(resultats);
            return resultats;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public Bilan[] getResultatPassifs(String exercice,int annee) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();

            Vector vect = new Vector();

            vect.add(getBilanResultat("<strong>CAPITAUX PROPRES</strong>","","", annee,exercice,false,c));
            vect.add(getBilanResultat("Capital social", "10","", annee, exercice,false, c));
            vect.add(getBilanResultat("Report à nouveau", "11,12", "",annee, exercice,false, c));
            vect.add(getBilanResultat("Résultat en instance d'affectation", "","", annee, exercice,false,c));
            vect.add(getBilanResultat("Résultat de l'exercice", "","", annee, exercice,false, c));
            vect.add(getBilanResultat("<strong>TOTAL CAPITAUX PROPRES</strong>", "10,11,12","", annee, exercice,false,c));

            vect.add(getBilanResultat("<strong>PASSIFS NON COURANTS</strong>", "","", annee,exercice,false,c));
            vect.add(getBilanResultat("emprunt + 1 an", "1640","", annee,exercice,false,c));
            vect.add(getBilanResultat("<strong>TOTAL PASSIFS NON COURANTS</strong>","1640","", annee, exercice,false,c));

            vect.add(getBilanResultat("<strong>PASSIFS COURANTS</strong>","","",annee, exercice,false,c));
            vect.add(getBilanResultat("emprunt - 1 an", "1641","", annee, exercice,false, c));
            vect.add(getBilanResultat("Fournisseur et comptes rattachés", "40","", annee, exercice,false, c));
            vect.add(getBilanResultat("Autres dettes", "41,42,48","",annee, exercice,false, c));
            vect.add(getBilanResultat("Etats : Impôts et Taxes à payer", "43,44","",annee, exercice,false, c));
            vect.add(getBilanResultat("Dettes diverses", "45,46,47","", annee, exercice,false, c));
            vect.add(getBilanResultat("decouvert bancaire", "5","", annee, exercice,false, c));
            vect.add(getBilanResultat("<strong>TOTAL PASSIFS COURANTS</strong>", "1641,40,41,42,48,43,44,45,46,47,5","",annee, exercice,false, c));

            vect.add(getBilanResultat("<strong>TOTAL DES PASSIFS</strong>", "1641,40,41,42,48,43,44,45,46,47,5,10,11,12,1640","", annee, exercice,false, c));

            Bilan[] resultats = new Bilan[vect.size()];
            vect.copyInto(resultats);
            return resultats;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }
    public Bilan[] genererCompteResultat(String exercice) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();

            Vector vect = new Vector();

            vect.add(genererBilan("Chiffre d'affaires", "70", "", exercice, true, c));
            vect.add(genererBilan("Productions stockés", "71", "", exercice, true, c));
            vect.add(genererBilan("Production immobilisée", "", "", exercice, true, c));
            vect.add(genererBilan("<strong>I - Production de l'exercice </strong>", "", "", exercice, true, c));
            vect.add(genererBilan("Achats consommés", "", "", exercice, true, c));
            vect.add(genererBilan("Services extérieurs & autres consommations", "", "", exercice, true, c));
            vect.add(genererBilan("<strong>II -  Consommation de l'exercice </strong>", "", "", exercice, true, c));
            vect.add(genererBilan("<strong>III - Valeur ajoutée d'exploitation (I - II)", "", "", exercice, true, c));
            vect.add(genererBilan("Charge de personnel", "", "", exercice, true, c));
            vect.add(genererBilan("Impôt taxes & versements assimilés", "", "", exercice, true, c));
            vect.add(genererBilan("<strong>IV - EXCEDENT BRUT D'EXPLOITATION</strong>", "", "", exercice, true, c));
            vect.add(genererBilan("Autres produits opérationnels", "", "", exercice, true, c));
            vect.add(genererBilan("Autres charges opérationnelles", "", "", exercice, true, c));
            vect.add(genererBilan("Dotations aux amortissements, provisions & pertes de valeurs", "", "", exercice, true, c));
            vect.add(genererBilan("Reprise sur provisions et pertes de valeurs", "", "", exercice, true, c));
            vect.add(genererBilan("<strong>V - RESULTAT OPERATIONNEL</strong>", "", "", exercice, true, c));
            vect.add(genererBilan("Produits financiers", "", "", exercice, true, c));
            vect.add(genererBilan("Charges financières", "", "", exercice, true, c));
            vect.add(genererBilan("<strong>VI - RESULTAT FINANCIER</strong>", "", "", exercice, true, c));
            vect.add(genererBilan("<strong>VII - RESULTAT AVANT IMPOT (V + VI)</strong>", "", "", exercice, true, c));
            vect.add(genererBilan("Impôts exigibles sur résultats", "", "", exercice, true, c));
            vect.add(genererBilan("", "", "", exercice, true, c));

            Bilan[] resultats = new Bilan[vect.size()];
            vect.copyInto(resultats);
            return resultats;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
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

    public void insertEmploye(String id, String entite, String nom, String prenom, String telephone,
            String adresse, String fonction, String poste, String matricule, String refUser) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            transcrireEmploye(id, entite, nom, prenom, telephone, adresse, fonction,
                    poste, matricule, refUser, c);
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }
    public double  getSolde(String compte,String exercice,int annee,Connection c) throws Exception
    {
        Balance [] balance;
        try{
        String [] resSpilt=Utilitaire.split(compte, ",");
        String apresWhere="";
        double solde=0;
        if(resSpilt.length>1)
        {
            apresWhere=apresWhere+" and (exercice='"+exercice+"' and annee='"+annee+"') and (compte like '"+resSpilt[0]+"%'";
            for(int i=0;i<resSpilt.length;i++)
            {
                apresWhere=apresWhere+" or compte like '"+resSpilt[i+1]+"%'";
                if(i+1==resSpilt.length-1)
                break;
            }
            apresWhere=apresWhere+")";
            balance=(Balance [])CGenUtil.rechercher(new Balance(), null, null, c,apresWhere);
        }
        else if(resSpilt.length==1)
        {
            apresWhere="and exercice='"+exercice+"' and annee='"+annee+"' and compte like '"+resSpilt[0]+"%'";
            balance=(Balance [])CGenUtil.rechercher(new Balance(), null, null, c,apresWhere);
        }
        else
        {
            return 0;
        }
        for(int compter=0;compter<balance.length;compter++)
        {
            if(String.valueOf(balance[compter].getCompte()).startsWith("7") || String.valueOf(balance[compter].getCompte()).startsWith("28"))
            {
                
                solde=solde+(balance[compter].getMvtcredit()-balance[compter].getMvtdebit());
            }
            else if(String.valueOf(balance[compter].getCompte()).startsWith("6") || String.valueOf(balance[compter].getCompte()).startsWith("2") && !String.valueOf(balance[compter].getCompte()).startsWith("28")|| String.valueOf(balance[compter].getCompte()).startsWith("3"))
            {
                solde=solde+(balance[compter].getMvtdebit()-balance[compter].getMvtcredit());
            }
            else if(String.valueOf(balance[compter].getCompte()).startsWith("4") || String.valueOf(balance[compter].getCompte()).startsWith("5") && !String.valueOf(balance[compter].getCompte()).startsWith("49"))
            {
                solde=solde+(balance[compter].getMvtdebit());
            }
            else if(String.valueOf(balance[compter].getCompte()).startsWith("49"))
            {
                solde=solde+(balance[compter].getMvtcredit());
            }
            else
            {
                solde=0;
            }
        }
        return solde;
        }
        catch(Exception ex)
        {
            throw ex;
        }
    }
    public double  getSoldePassif(String compte,String exercice,int annee,Connection c) throws Exception
    {
        Balance [] balance;
        try{
        String [] resSpilt=Utilitaire.split(compte, ",");
        String apresWhere=" ";
        double solde=0;
        if(resSpilt.length>1)
        {
            apresWhere=apresWhere+" and (exercice='"+exercice+"' and annee='"+annee+"') and (compte like '"+resSpilt[0]+"%'";
            for(int i=0;i<resSpilt.length;i++)
            {
                apresWhere=apresWhere+" or compte like '"+resSpilt[i+1]+"%'";
                if(i+1==resSpilt.length-1)
                break;
            }
            apresWhere=apresWhere+")";
            balance=(Balance [])CGenUtil.rechercher(new Balance(), null, null, c,apresWhere);
        }
        else if(resSpilt.length==1)
        {
            apresWhere="and exercice='"+exercice+"' and annee='"+annee+"' and compte like '"+resSpilt[0]+"%'";
            balance=(Balance [])CGenUtil.rechercher(new Balance(), null, null, c,apresWhere);
        }
        else
        {
            return 0;
        }
        for(int compter=0;compter<balance.length;compter++)
        {
            if(String.valueOf(balance[compter].getCompte()).startsWith("10") || String.valueOf(balance[compter].getCompte()).startsWith("11") || String.valueOf(balance[compter].getCompte()).startsWith("12"))
            {
                
                solde=solde+(balance[compter].getMvtcredit()-balance[compter].getMvtdebit());
            }
            
            else if(String.valueOf(balance[compter].getCompte()).startsWith("16") || String.valueOf(balance[compter].getCompte()).startsWith("4")||String.valueOf(balance[compter].getCompte()).startsWith("5"))
            {
                solde=solde+(balance[compter].getMvtcredit());
            }
            else
            {
                solde=0;
            }
        }
        return solde;
        }
        catch(Exception ex)
        {
            throw ex;
        }
    }
    public Bilan getBilanResultat(String intitule, String compte,String amorti,int annee,String exercice,boolean actif,Connection c) throws Exception {
        try{
            int anneeprev=annee-1;
        double netP =getSoldePassif(compte,exercice,annee,c);
        double netPprev =getSoldePassif(compte,exercice,anneeprev,c);
        double brut =getSolde(compte,exercice,annee,c);
         double amort =getSolde(amorti,exercice,annee,c);
         double brutprev =getSolde(compte,exercice,anneeprev,c);
         double amortprev =getSolde(amorti,exercice,anneeprev,c);
         double net1 =brut-amort;
         double net2=brutprev-amortprev;
        Bilan bilanA = new Bilan();
        Bilan bilanP = new Bilan();
        if(actif)
        {
            bilanA.setNet(net1);
            bilanA.setNetPrev(net2);
            bilanA.setBrut(brut);
            bilanA.setAmort(amort);
             bilanA.setIntitule(intitule);
            bilanA.setExercice(exercice);
            return bilanA;
        }
        else
        {
            bilanP.setNet(netP);
            bilanP.setNetPrev(netPprev);
            bilanP.setIntitule(intitule);
            bilanP.setExercice(exercice);
            return bilanP;
        }
        }
        catch(Exception ex)
        {
            throw ex;
        }
    }
    public Bilan getBilanResultat(String intitule, String compte,int annee,String exercice,Connection c) throws Exception {
        try{
            int anneeprev=annee-1;
        double net =getSolde(compte,exercice,annee,c);
        double netPrev = getSolde(compte,exercice ,anneeprev,c);
        Bilan bilan = new Bilan();
        bilan.setNet(net);
        bilan.setNetPrev(netPrev);
        bilan.setIntitule(intitule);
        bilan.setExercice(exercice);
        return bilan;
        
        }
        catch(Exception ex)
        {
            throw ex;
        }
    }
     public Bilan[] genererResultat(String exercice,int annee) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();

            Vector vect = new Vector();

            vect.add(getBilanResultat("Chiffre d'affaires", "70",annee, exercice, c));
            vect.add(getBilanResultat("Productions stockés", "71", annee,exercice, c));
            vect.add(getBilanResultat("Production immobilisée", "",annee, exercice, c));
            vect.add(getBilanResultat("<strong>I - Production de l'exercice</strong>", "",annee, exercice, c));
            vect.add(getBilanResultat("Achats consommés", "60","", annee, exercice,false, c));
            vect.add(getBilanResultat("Services extérieurs & autres consommations", "61,62", annee, exercice, c));
            vect.add(getBilanResultat("<strong>II -  Consommation de l'exercice</strong>", "", annee, exercice, c));
            vect.add(getBilanResultat("<strong>III - Valeur ajoutée d'exploitation (I - II)", "",annee, exercice, c));
            vect.add(getBilanResultat("Charge de personnel", "64", annee, exercice,c));
            vect.add(getBilanResultat("Impôt taxes & versements assimilés", "63", annee, exercice, c));
            vect.add(getBilanResultat("<strong>IV - EXCEDENT BRUT D'EXPLOITATION</strong>", "",annee, exercice, c));
            vect.add(getBilanResultat("Autres produits opérationnels", "75", annee, exercice,c));
            vect.add(getBilanResultat("Autres charges opérationnelles", "65",annee, exercice,c));
            vect.add(getBilanResultat("Dotations aux amortissements, provisions & pertes de valeurs", "68", annee,exercice,c));
            vect.add(getBilanResultat("Reprise sur provisions et pertes de valeurs", "78", annee,exercice,  c));
            vect.add(getBilanResultat("<strong>V - RESULTAT OPERATIONNEL</strong>", "",  annee,exercice,  c));
            vect.add(getBilanResultat("Produits financiers", "76", annee, exercice,  c));
            vect.add(getBilanResultat("Charges financières", "66", annee, exercice,  c));
            vect.add(getBilanResultat("<strong>VI - RESULTAT FINANCIER</strong>", "", annee, exercice, c));
            vect.add(getBilanResultat("<strong>VII - RESULTAT AVANT IMPOT (V + VI)</strong>", "",annee, exercice,  c));
            vect.add(getBilanResultat("Impôts exigibles sur résultats", "691001", annee,exercice,c));
            vect.add(getBilanResultat("Impôts différés ( variations )", "695001",annee, exercice,c));
            vect.add(getBilanResultat("<strong>TOTAL DES PRODUITS DES ACTIVITES ORDINAIRES</strong>", "", annee,exercice,c));
            vect.add(getBilanResultat("<strong>TOTAL DES CHARGES DES ACTIVITES ORDINAIRES</strong>", "",annee, exercice, c));
            vect.add(getBilanResultat("<strong>RESULTAT NET DES ACTIVITES ORDINAIRES</strong>", "", annee,exercice, c));
            vect.add(getBilanResultat("Éléments extraordinaires ( produits )- à préciser", "77", annee,exercice, c));
            vect.add(getBilanResultat("Éléments extraordinaires ( charges ) - à préciser", "67", annee,exercice,c));
            vect.add(getBilanResultat("<strong>IX- RESULTAT EXTRAORDINAIRE</strong>", "",annee,exercice, c));
            vect.add(getBilanResultat("<strong>X- RÉSULTAT NET DE L'EXERCICE</strong>", "",annee, exercice, c));
            
            Bilan[] resultats = new Bilan[vect.size()];
            vect.copyInto(resultats);
            return resultats;
        } catch (Exception ex) {
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }
    public Bilan [] getResultatAvecFormule(String exercice,int annee) throws Exception
    {
        Bilan res[]=this.genererResultat(exercice,annee);
        double net1=0;
        double net1prev=0;
        double net2=0;
        double net2prev=0;
        double net3prev=0;
        double net3=0;
        double net4=0;
        double net4prev=0;
        double net5=0;
        double net5prev=0;
        double net6=0;
        double net6prev=0;
        int indice=0;
        int ind1=0,ind4=0,ind5=0;
        double totalnet1=0,totalnet2=0,totalnetprev1=0,totalnetprev2=0,net8=0,net8prev=0,net9=0,net9prev=0;
        try{
        for(int i=0;i<res.length;i++)
        {
            
           if(res[i].getIntitule().contains("I - Production de l'exercice"))
            {
                for(int j=0;j<i;j++)
                {
                    net1=net1+res[j].getNet();
                    net1prev=+net1prev+res[j].getNetPrev();
                }
                res[i].setNet(net1);
                res[i].setNetPrev(net1prev);
                indice=i;
                ind1=i;
            }
            if(res[i].getIntitule().contains("II -  Consommation de l'exercice"))
            {
                double temp=0;
                double temp1=0;
               for(int j=indice+1;j<i;j++)
               {
                    temp=temp+res[j].getNet();
                    temp1=temp1+res[j].getNetPrev();
               }
               net2=temp;
               net2prev=temp1;
                res[i].setNet(net2);
                res[i].setNetPrev(net2prev);
            }
            if(res[i].getIntitule().contains("III - Valeur ajoutée d'exploitation (I - II)"))
            {
               net3=net1-net2;
               net3prev=net1prev-net2prev;
               res[i].setNet(net3);
               res[i].setNetPrev(net3prev);
               indice=i;
            }
            if(res[i].getIntitule().contains("IV - EXCEDENT BRUT D'EXPLOITATION"))
            {
                double temp1=0;
                double temp2=0;
               for(int j=indice+1;j<i;j++)
               {
                   temp1=temp1+res[j].getNet();
                   temp2=temp2+res[j].getNetPrev();
               }
               net4=net3-temp1;
               net4prev=net3prev-temp2;
               res[i].setNet(net4);
               res[i].setNetPrev(net4prev);
               indice=i;
               ind4=i;
            }
            if(res[i].getIntitule().contains("V - RESULTAT OPERATIONNEL"))
            {
               double temp1=0;
                double temp2=0;
               temp1=net4+res[indice+1].getNet();
               temp2=net4prev+res[indice+1].getNetPrev();
               for(int j=indice+2;j<i-1;j++)
               {
                   temp1=temp1-res[j].getNet();
                   temp2=temp2-res[j].getNetPrev();
               }
               net5=temp1+res[i-1].getNet();
               net5prev=temp2+res[i+1].getNetPrev();
               res[i].setNet(net5);
               res[i].setNetPrev(net5prev);
               indice=i;
               ind5=i;
            }
            if(res[i].getIntitule().contains("VI - RESULTAT FINANCIER"))
            {
               net6=res[indice+1].getNet()-res[indice+2].getNet();
               net6prev=res[indice+1].getNetPrev()-res[indice+2].getNetPrev();
               res[i].setNet(net6);
               res[i].setNetPrev(net6prev);
            }
            if(res[i].getIntitule().contains("VII - RESULTAT AVANT IMPOT (V + VI)"))
            {
               res[i].setNet(net5+net6);
               res[i].setNetPrev(net5prev+net6prev);
               indice=i;
            }
            if(res[i].getIntitule().contains("TOTAL DES PRODUITS DES ACTIVITES ORDINAIRES"))
            {
                totalnet1=res[ind1].getNet()+res[ind4+1].getNet()+res[ind5-1].getNet()+res[ind5+1].getNet();
                totalnetprev1=res[ind1].getNetPrev()+res[ind4+1].getNetPrev()+res[ind5-1].getNetPrev()+res[ind5+1].getNetPrev();
               res[i].setNet(totalnet1);
               res[i].setNetPrev(totalnetprev1);
            }
            if(res[i].getIntitule().contains("TOTAL DES CHARGES DES ACTIVITES ORDINAIRES"))
            {
                totalnet2=net2+res[ind4-1].getNet()+res[ind4-2].getNet()+res[ind4+2].getNet()+res[ind4+3].getNet()+res[ind5+2].getNet()+res[indice+1].getNet();
                totalnetprev2=net2prev+res[ind4-1].getNetPrev()+res[ind4-2].getNetPrev()+res[ind4+2].getNetPrev()+res[ind4+3].getNetPrev()+res[ind5+2].getNetPrev()+res[indice+1].getNetPrev();
               res[i].setNet(totalnet2);
               res[i].setNetPrev(totalnetprev2);
            }
            if(res[i].getIntitule().contains("RESULTAT NET DES ACTIVITES ORDINAIRES"))
            {
                net8=totalnet1-totalnet2;
                net8prev=totalnetprev1-totalnetprev2;
               res[i].setNet(net8);
               res[i].setNet(net8prev);
               indice=i;
            }
            if(res[i].getIntitule().contains("IX- RESULTAT EXTRAORDINAIRE"))
            {
               net9=res[indice+1].getNet()-res[indice+2].getNet();
               net9prev=res[indice+1].getNetPrev()-res[indice+2].getNetPrev();
               res[i].setNet(net9);
               res[i].setNetPrev(net9prev);
            }
            if(res[i].getIntitule().contains("X- RÉSULTAT NET DE L'EXERCICE"))
            {
              res[i].setNet(net8+net9);
              res[i].setNetPrev(net8prev+net9prev);
            }
        }
        return res;
        }
        catch(Exception ex)
        {
            throw ex;
        }
    }
    public Bilan [] getResultatActifFinal(String exercice,int annee) throws Exception
    {       
        try{
        Bilan res[]=this.getResultatActifs(exercice,annee);
        double net=0;
        double netprev=0;
        double amort=0;
        double brut=0;
        for(int i=0;i<res.length;i++)
        {
            net=net+res[i].getNet();
            netprev=netprev+res[i].getNetPrev();
            brut=brut+res[i].getBrut();
            amort=amort+res[i].getAmort();
            if(res[i].getIntitule().contains("TOTAL DES ACTIFS"))
            {
                res[i].setBrut(brut);
                res[i].setNet(net);
                res[i].setAmort(amort);
                res[i].setNetPrev(netprev);
            }
        }
        return res;
        }
        catch(Exception ex)
        {
            throw ex;
        }
    
    }
    public Bilan [] getResultatPassifFinal(String exercice,int annee) throws Exception
    {       
        try{
        Bilan res[]=this.getResultatPassifs(exercice,annee);
        Bilan res1[]=this.getResultatAvecFormule(exercice,annee);
        double net=0;
        double netprev=0;
        double amort=0;
        double brut=0;
        double netR=0;
        double netRPrev=0;
        for(int i=0;i<res1.length;i++)
        {
            
            if(res1[i].getIntitule().contains("RÉSULTAT NET DE L'EXERCICE"))
            {
                
                netR=res1[i].getNet();
                netRPrev=res1[i].getNetPrev();
            }
        }
        for(int i=0;i<res.length;i++)
        {
            if(res[i].getIntitule().contains("Résultat de l'exercice"))
            {
                res[i].setNet(netR);
                res[i].setNetPrev(netRPrev);
                
            }
            if(res[i].getIntitule().contains("TOTAL DES PASSIFS"))
            {
                netR=netR+res[i].getNet();
                netRPrev=netRPrev+res[i].getNetPrev();
               res[i].setNet(netR);
               res[i].setNetPrev(netRPrev);
            }
        }
        return res;
        }
        catch(Exception ex)
        {
            throw ex;
        }
    
    }
}

