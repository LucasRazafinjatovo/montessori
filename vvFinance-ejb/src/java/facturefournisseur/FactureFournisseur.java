package facturefournisseur;

import bean.*;
import utilitaire.Utilitaire;
import java.sql.Date;
import ded.Visa;
import ded.VisaUtil;
import java.sql.Connection;
import ded.OrdonnerPayement;
import ded.OpUtil;
import lc.LigneCredit;
import utilitaire.UtilDB;
import facture.Client;

/**
 * <p>
 * Title: Gestion des recettes </p>
 * <p>
 * Description: </p>
 * <p>
 * Copyright: Copyright (c) 2005</p>
 * <p>
 * Company: </p>
 *
 * @author unascribed
 * @version 1.0
 */
public class FactureFournisseur extends ClassMAPTable {

    public String numFact;
    public String idFactureFournisseur;
    public java.sql.Date daty;
    public String idFournisseur;
    public String idDevise;
    public double montantTTC;
    public String remarque;
    public double idTVA;
    public String designation;
    public java.sql.Date dateEmission;
    private String resp;
    private java.sql.Date datyecheance;
    //private int essai;

    public FactureFournisseur() {
        super.setNomTable("FactureFournisseur");
        //this.setNombreChamp(10);
    }

    public FactureFournisseur(String nomTable) {
        super.setNomTable(nomTable);
    }

    public FactureFournisseur(String nomTable, String idf, String numFact, String designation, String daty, String fournisseur, String tva, String montantTTC, String remarque, String dateemission, String idDevise) {
        super.setNomTable(nomTable);
        setNumFact(numFact);
        setIdFactureFournisseur(idf);
        setDesignation(designation);
        setDateEmission(java.sql.Date.valueOf(dateemission));
        setIdFournisseur(fournisseur);
        setMontantTTC((new Double(montantTTC)).doubleValue());

        setIdTVA(Integer.parseInt(tva));
        setRemarque(remarque);
        setIdDevise(idDevise);

    }

    public FactureFournisseur(String nomTable, String idf, String numFact, String designation, java.sql.Date daty, String fournisseur, double tva, double montantTTC, String remarque, java.sql.Date dateemission, String idDevise) {
        super.setNomTable(nomTable);
        setNumFact(numFact);
        setIdFactureFournisseur(idf);
        setDesignation(designation);
        setDateEmission(dateemission);
        setIdFournisseur(fournisseur);
        setMontantTTC(montantTTC);
        setDaty(daty);
        setIdTVA(tva);
        setRemarque(remarque);
        setIdDevise(idDevise);

    }

    public FactureFournisseur(String idFF, String numFact, String designation, java.sql.Date dE, Date daty, String idFrns, int idTVA, double mTTC, String rmq, String idDevise) {
        //utilisée pour la méthode recherche
        //super.setNomTable(nomTable);
        setNumFact(numFact);
        setIdFactureFournisseur(idFF);
        this.setDaty(daty);
        setDateEmission(dE);
        setIdFournisseur(idFrns);
        setMontantTTC(mTTC);
        setIdTVA(idTVA);
        setRemarque(rmq);
        setIndicePk("FF");
        setDesignation(designation);
        setIdDevise(idDevise);

    }

    public FactureFournisseur(String nomTable, String numFact, String designation, String dE, String dR, String idFrns, String idTVA, String mTTC, String rmq, String idDevise) throws Exception {
        //Utilisée pour la méthode création
        super.setNomTable(nomTable);
        setNumFact(numFact);
        if (String.valueOf(dE).compareTo("") == 0 || dE == null) {
            setDateEmission(Utilitaire.dateDuJourSql());
        } else {
            setDateEmission((Utilitaire.string_date("dd/MM/yyyy", dE)));
        }
        this.setDaty(Utilitaire.string_date("dd/MM/yyyy", dR));
        setIdFournisseur(Client.getIdDyn(idFrns));
        setMontantTTC(Utilitaire.stringToDouble(mTTC));

        setIdTVA(Utilitaire.stringToDouble(idTVA));
        setRemarque(rmq);
        setIdDevise(idDevise);
        setDesignation(designation);
        CaractTable ct = (CaractTable) new bean.CaractTableUtil().rechercher(2, nomTable)[0];
        setIndicePk(ct.getNomSeq());
        setNomProcedureSequence(ct.getNomProc());
        setIdFactureFournisseur(makePK());
    }


    public FactureFournisseur(Connection c, String nomTable, String numFact, String designation, String dE, String dR, String idFrns, String idTVA, String mTTC, String rmq, String idDevise) throws Exception {
        //Utilisée pour la méthode création
        super.setNomTable(nomTable);
        setNumFact(numFact);
        if (String.valueOf(dE).compareTo("") == 0 || dE == null) {
            setDateEmission(Utilitaire.dateDuJourSql());
        } else {
            setDateEmission((Utilitaire.string_date("dd/MM/yyyy", dE)));
        }
        this.setDaty(Utilitaire.string_date("dd/MM/yyyy", dR));
        setIdFournisseur(Client.getIdDyn(idFrns));
        setMontantTTC(Utilitaire.stringToDouble(mTTC));

        setIdTVA(Utilitaire.stringToDouble(idTVA));
        setRemarque(rmq);
        setIdDevise(idDevise);
        setDesignation(designation);
        CaractTable ct = (CaractTable) new bean.CaractTableUtil().rechercher(2, nomTable, c)[0];
        setIndicePk(ct.getNomSeq());
        setNomProcedureSequence(ct.getNomProc());
        setIdFactureFournisseur(makePK(c));
    }
    
    public FactureFournisseur(String nomTable, String numFact, String designation, String dE, String dR, String idFrns, String idTVA, String mTTC, String rmq, String idDevise, String e, String a) throws Exception {
        //Utilisée pour la méthode création
        super.setNomTable(nomTable);
        setNumFact(numFact);
        if (String.valueOf(dE).compareTo("") == 0 || dE == null) {
            setDateEmission(Utilitaire.dateDuJourSql());
        } else {
            setDateEmission((Utilitaire.string_date("dd/MM/yyyy", dE)));
        }
        this.setDaty(Utilitaire.string_date("dd/MM/yyyy", dR));
        setIdFournisseur(Client.getIdDyn(idFrns));
        setMontantTTC(Utilitaire.stringToDouble(mTTC));

        setIdTVA(Utilitaire.stringToDouble(idTVA));
        setRemarque(rmq);
        setIdDevise(idDevise);
        setDesignation(designation);
        //CaractTable ct=(CaractTable)new bean.CaractTableUtil().rechercher(2,nomTable)[0];
        setIndicePk("FCP");
        setNomProcedureSequence("GETSEQFACTURECLIENTPROFORMA");
        setIdFactureFournisseur(makePK());
    }
    
    public FactureFournisseur(String nomTable, String numFact, String designation, String dE, String dR, String idFrns, String idTVA, String mTTC, String rmq, String idDevise, String e, String a, Connection c) throws Exception {
        //Utilisée pour la méthode création
        super.setNomTable(nomTable);
        setNumFact(numFact);
        if (String.valueOf(dE).compareTo("") == 0 || dE == null) {
            setDateEmission(Utilitaire.dateDuJourSql());
        } else {
            setDateEmission((Utilitaire.string_date("dd/MM/yyyy", dE)));
        }
        this.setDaty(Utilitaire.string_date("dd/MM/yyyy", dR));
        setIdFournisseur(Client.getIdDyn(idFrns));
        setMontantTTC(Utilitaire.stringToDouble(mTTC));

        setIdTVA(Utilitaire.stringToDouble(idTVA));
        setRemarque(rmq);
        setIdDevise(idDevise);
        setDesignation(designation);
        //CaractTable ct=(CaractTable)new bean.CaractTableUtil().rechercher(2,nomTable)[0];
        setIndicePk("FCP");
        setNomProcedureSequence("GETSEQFACTURECLIENTPROFORMA");
        setIdFactureFournisseur(makePK(c));
    }

    public FactureFournisseur(Date dE, Date dR, String idFrns, Double mTHT) {
        super.setNomTable("FactureFournisseur");
        setDateEmission(dE);
        /*setdateReception(dR);
         setidFournisseur(idFrns);
         setmontantTHT(mTHT);
         setmontantTTC(mTTC);
         setidTVA(idTVA);
         setremarque(rmq);
         setidProjet(idP);
         setIndicePk("FF");
         setNomProcedureSequence("getSeqFactureFournisseur");
         setidFactureFournisseur(makePK());*/
    }

    public String getAttributIDName() {
        return "idFactureFournisseur";
    }

    public String getTuppleID() {
        return this.getIdFactureFournisseur();
    }

    public static void main(String[] args) {
        FactureFournisseur factureFournisseur1 = new FactureFournisseur();
    }

    public void setNumFact(String numFact) {
        this.numFact = numFact;
    }

    public java.sql.Date getDateEmission() {
        return dateEmission;
    }

    public Visa estIlVise(Connection c) throws Exception {
        VisaUtil vu = new VisaUtil();
        vu.setNomTable("VISAFACTUREF");
        Visa[] v = (Visa[]) vu.rechercher(4, this.getTuppleID(), c);
        if (v.length == 0) {
            return null;
        }
        return v[0];
    }

    public Visa estIlVise(String nomTable, Connection c) throws Exception {
        VisaUtil vu = new VisaUtil();
        vu.setNomTable(nomTable);
        Visa[] v = (Visa[]) vu.rechercher(4, this.getTuppleID(), c);
        if (v.length == 0) {
            return null;
        }
        return v[0];
    }

    public OrdonnerPayement[] getOpCree(Connection c) throws Exception {
        return getOpRelatif("opvise", c);
    }

    public OrdonnerPayement[] getOpRelatif(String nomTable, Connection c) throws Exception {
        OpUtil opu = new OpUtil();
        opu.setNomTable(nomTable);
        return ((OrdonnerPayement[]) opu.rechercher(2, this.getTuppleID(), c));
    }

    public OrdonnerPayement[] getOrCree(Connection c) throws Exception {
        return getOpRelatif("orvise", c);
    }

    public OrdonnerPayement[] getOpVise(Connection c) throws Exception {
        OpUtil opu = new OpUtil();
        opu.setNomTable("OpVise");
        return ((OrdonnerPayement[]) opu.rechercher(2, this.getTuppleID(), c));
    }

    public OrdonnerPayement[] getOrVise(Connection c) throws Exception {
        OpUtil opu = new OpUtil();
        opu.setNomTable("orvise");
        return ((OrdonnerPayement[]) opu.rechercher(2, this.getTuppleID(), c));
    }

    public String getNumFact() {
        return numFact;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public String getDesignation() {
        return designation;
    }

    public void setIdFactureFournisseur(String idFactureFournisseur) {
        this.idFactureFournisseur = idFactureFournisseur;
    }

    public String getIdFactureFournisseur() {
        return idFactureFournisseur;
    }

    public void setDaty(java.sql.Date daty) {
        this.daty = daty;
    }

    public java.sql.Date getDaty() {
        return daty;
    }

    public void setIdFournisseur(String idFournisseur) {
        this.idFournisseur = idFournisseur;
    }

    public String getIdFournisseur() {
        return idFournisseur;
    }

    public void setIdDevise(String idDevise) {
        this.idDevise = idDevise;
    }

    public String getIdDevise() {
        return idDevise;
    }

    public void setMontantTTC(double montantTTC) {
        this.montantTTC = montantTTC;
    }

    public double getMontantTTC() {
        return montantTTC;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setIdTVA(double idTVA) {
        this.idTVA = idTVA;
    }

    public double getIdTVA() {
        return idTVA;
    }

    public double calculMontantTva() {
        return getIdTVA();
    }

    public void setDateEmission(java.sql.Date dateEmission) {
        //if(String.valueOf(dateEmission).compareTo("") == 0 || dateEmission == null)

        this.dateEmission = dateEmission;
    }

    public LigneCredit[] getLigne(String nomTable, Connection c) throws Exception {
        if (nomTable.compareToIgnoreCase("FACTURECLIENTLC") == 0) {
            return getLigne(nomTable, c, "LigneCreditRecette");
        }
        if (nomTable.compareToIgnoreCase("FACTUREFOURNISSEURLC") == 0) {
            return getLigne(nomTable, c, "LigneCredit");
        }
        return null;
    }

    public LigneCredit[] getLigneClient(Connection c) throws Exception {
        return getLigne("FACTURECLIENTLC", c);
    }

    public LigneCredit[] getLigneFourn(Connection c) throws Exception {
        return getLigne("FACTUREFOURNISSEURLC", c);
    }

    public LigneCredit[] getLigne(String nomTable, Connection c, String nomTableLc) throws Exception {
        UnionIntraTable iut = new UnionIntraTable();
        iut.setNomTable(nomTable);
        iut.setId1(this.getIdFactureFournisseur());
        UnionIntraTable result[] = (UnionIntraTable[]) CGenUtil.rechercher(iut, null, null, c, "");
        LigneCredit lc = new LigneCredit();
        lc.setNomTable(nomTableLc);
        LigneCredit[] valiny = new LigneCredit[result.length];
        for (int i = 0; i < result.length; i++) {
            lc.setIdLigne(result[i].getId2());
            valiny[i] = ((LigneCredit[]) CGenUtil.rechercher(lc, null, null, c, ""))[0];
        }
        return valiny;
    }

    public boolean estPub(Connection c) throws Exception {
        FactureFournisseurCompte ffc = new FactureFournisseurCompte();
        ffc.setNomTable("FACTURECLIENTCOMPTE");
        ffc.setIdFactureFournisseur(getTuppleID());
        FactureFournisseurCompte[] listeFc = (FactureFournisseurCompte[]) CGenUtil.rechercher(ffc, null, null, c, " and compteType not like '7011%'");
        if (listeFc.length > 0) {
            throw new Exception("Ceci n est pas une facture de publicite");
        }
        return false;
    }

    public boolean estVente(Connection c) throws Exception {
        FactureFournisseurCompte ffc = new FactureFournisseurCompte();
        ffc.setNomTable("FACTURECLIENTCOMPTE");
        ffc.setIdFactureFournisseur(getTuppleID());
        //FactureFournisseurCompte[] listeFc=(FactureFournisseurCompte[])CGenUtil.rechercher(ffc,null,null,c," and compteType not like '7010%'");
        //if(listeFc.length>0) throw new Exception("Ceci n est pas une facture de vente");
        return true;
    }

    public Visa getVisa(Connection c, String nomTable) throws Exception {
        VisaUtil vu = new VisaUtil();
        vu.setNomTable(nomTable);
        Visa[] v = (Visa[]) vu.rechercher(4, this.getTuppleID(), c);
        if (v.length == 0) {
            return null;
        }
        return v[0];
    }

    public boolean estAnnulable() throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            return estAnnulable(c);
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public boolean estAnnulable(Connection c) throws Exception {
        OrdonnerPayement[] op = this.getOpVise(c);
        Visa v = getVisa(c, "VISAFACTUREF");
        if (op.length > 0 || v == null) {
            return false;
        }
        return true;
    }

    public boolean estAnnulableClient() throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            return estAnnulableClient(c);
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public boolean estAnnulableClient(Connection c) throws Exception {
        OrdonnerPayement[] op = this.getOrVise(c);
        Visa v = getVisa(c, "VISAFACTURECLIENT");
        if (op.length > 0 || v == null) {
            return false;
        }
        return true;
    }

    public void setResp(String resp) {
        this.resp = resp;
    }

    public String getResp() {
        return resp;
    }

    public void setDatyecheance(java.sql.Date datyecheance) {
        this.datyecheance = datyecheance;
    }

    public java.sql.Date getDatyecheance() {
        return datyecheance;
    }
}
