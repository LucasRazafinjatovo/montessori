// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   FactMere.java
package facture;

import bean.ClassMAPTable;
import bean.GenUtil;
import java.io.PrintStream;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.Utilitaire;

// Referenced classes of package facture:
//            FactureFilleUtil, SCatServiceUtil, SCatService, TvaUtil,
//            Tva, ClientUtil, Client, ChangeUtil,
//            Change, EtatFacture, EtatFactureUtil, FactureFille
public class FactMere extends ClassMAPTable {

    public FactMere(int num) {
        super.setNomTable("FactureMere");
    }

    public FactMere() {
        super.setNomTable("FactureMere");
    }

    public FactMere(String idFactureMere, Date daty, Date periodeDebut, Date periodeFin, String idClient, String noteExplicative, int idTva,
            String idFactureEn, String idDeviseEn, int reduction, double idCoursChange, String idEtat, Date dateLimitePaiement,
            double montantAP, String idSCatServic, String idTypePaiem, String respe, String entit, String parutio) {
        super.setNomTable("FactureMere");
        setIdFactureMere(idFactureMere);
        setDaty(daty);
        setPeriodeDebut(periodeDebut);
        setPeriodeFin(periodeFin);
        setIdClient(idClient);
        setNoteExplicative(noteExplicative);
        setIdTva(idTva);
        setIdFactureEn(idFactureEn);
        setIdDeviseEn(idDeviseEn);
        setReduction(reduction);
        setIdCoursChange(idCoursChange);
        setIdEtat(idEtat);
        setDateLimitePaiement(dateLimitePaiement);
        setMontantAPayer(montantAP);
        setIdSCatService(idSCatServic);
        setIdTypePaiement(idTypePaiem);
        setResp(respe);
        setEntite(entit);
        setParution(parutio);
    }

    public FactMere(String idFactureMere, Date daty, Date periodeDebut, Date periodeFin, String idClient, String noteExplicative, int idTva,
            String idFactureEn, String idDeviseEn, int reduction, double idCoursChange, String idEtat, Date dateLimitePaiement,
            double montantAP, String idSCatServic, String idTypePaiem, String respe, String entit, String parutio, String etat) {
        super.setNomTable("FactureMereProforma");
        setIdFactureMere(idFactureMere);
        setDaty(daty);
        setPeriodeDebut(periodeDebut);
        setPeriodeFin(periodeFin);
        setIdClient(idClient);
        setNoteExplicative(noteExplicative);
        setIdTva(idTva);
        setIdFactureEn(idFactureEn);
        setIdDeviseEn(idDeviseEn);
        setReduction(reduction);
        setIdCoursChange(idCoursChange);
        setIdEtat(idEtat);
        setDateLimitePaiement(dateLimitePaiement);
        setMontantAPayer(montantAP);
        setIdSCatService(idSCatServic);
        setIdTypePaiement(idTypePaiem);
        setResp(respe);
        setEntite(entit);
        setParution(parutio);
    }

    public FactMere(Date daty, Date periodeDebut, Date periodeFin, String idClient, String noteExplicative, int idTva, String idFactureEn,
            String idDeviseEn, int reduction, double idCoursChange, String idEtat, Date dateLimitePaiement, double montantAP, String idSCatServic) {
        super.setNomTable("FactureMere");
        setDaty(daty);
        setPeriodeDebut(periodeDebut);
        setPeriodeFin(periodeFin);
        setIdClient(idClient);
        setNoteExplicative(noteExplicative);
        setIdTva(idTva);
        setIdFactureEn(idFactureEn);
        setIdDeviseEn(idDeviseEn);
        setReduction(reduction);
        setIdCoursChange(idCoursChange);
        setIdEtat(idEtat);
        setDateLimitePaiement(dateLimitePaiement);
        setIndicePk("FM");
        setNomProcedureSequence("getSeqFactureMere");
        setIdFactureMere(makePK());
        setMontantAPayer(montantAP);
        setIdSCatService(idSCatServic);
    }

    public FactMere(Date daty, Date periodeDebut, Date periodeFin, String idClient, String noteExplicative, int idTva, String idFactureEn,
            String idDeviseEn, int reduction, String idEtat, Date dateLimitePaiement, double montantAP, String idSCatServic) {
        try {
            super.setNomTable("FactureMere");
            setIndicePk("FM");
            setNomProcedureSequence("getSeqFactureMere");
            setIdFactureMere(makePK());
            setDaty(daty);
            setPeriodeDebut(periodeDebut);
            setPeriodeFin(periodeFin);
            setIdClient(idClient);
            setNoteExplicative(noteExplicative);
            setIdTva(idTva);
            setIdFactureEn(idFactureEn);
            setIdDeviseEn(idDeviseEn);
            setReduction(reduction);
            setIdCoursChange(getChange(idDeviseEn, idFactureEn));
            setIdEtat(idEtat);
            setDateLimitePaiement(dateLimitePaiement);
            setMontantAPayer(montantAP);
            setIdSCatService(idSCatServic);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    }

    public FactMere(String daty, String periodeDebut, String periodeFin, String idClient, String noteExplicative, String idTva, String idFactureEn,
            String idDeviseEn, String reduction, String idEtat, String dateLimitePaiement, String montantAP, String idSCatServic, String idTypePaiem,
            String respe, String entit, String parutio) {
        super.setNomTable("FactureMere");
        setResp(respe);
        setIndicePk("FM");
        setNomProcedureSequence("getSeqFactureMere");
        setIdFactureMere(makePK());
        if (String.valueOf(daty).compareTo("") == 0 || daty == null) {
            setDaty(Utilitaire.dateDuJourSql());
        } else {
            setDaty(Utilitaire.string_date("dd/MM/yyyy", daty));
        }
        if (String.valueOf(periodeDebut).compareTo("") == 0 || periodeDebut == null) {
            setPeriodeDebut(Utilitaire.dateDuJourSql());
        } else {
            setPeriodeDebut(Utilitaire.string_date("dd/MM/yyyy", periodeDebut));
        }
        if (String.valueOf(periodeFin).compareTo("") == 0 || periodeFin == null) {
            setPeriodeFin(Utilitaire.dateDuJourSql());
        } else {
            setPeriodeFin(Utilitaire.string_date("dd/MM/yyyy", periodeFin));
        }
        if (idClient.compareTo("") == 0 || idClient == null) {
            setIdClient("-");
        } else {
            setIdClient(idClient);
        }
        if (noteExplicative.compareTo("") == 0 || noteExplicative == null) {
            setNoteExplicative("-");
        } else {
            setNoteExplicative(noteExplicative);
        }
        if (String.valueOf(idTva).compareTo("") == 0) {
            setIdTva(0);
        } else {
            setIdTva(Utilitaire.stringToInt(idTva));
        }
        if (idFactureEn.compareTo("") == 0 || idFactureEn == null) {
            setIdFactureEn("-");
        } else {
            setIdFactureEn(idFactureEn);
        }
        if (parutio.compareTo("") == 0 || parutio == null) {
            setParution("-");
        } else {
            setParution(parutio);
        }
        if (idDeviseEn.compareTo("") == 0 || idDeviseEn == null) {
            setIdDeviseEn("-");
        } else {
            setIdDeviseEn(idDeviseEn);
        }
        if (String.valueOf(reduction).compareTo("") == 0) {
            setReduction(0);
        } else {
            setReduction(Utilitaire.stringToInt(reduction));
        }
        try {
            setIdCoursChange(getChange(idDeviseEn, idFactureEn));
        } catch (Exception exception) {
        }
        if (idEtat.compareTo("") == 0 || idEtat == null) {
            setIdEtat("-");
        } else {
            setIdEtat(idEtat);
        }
        if (String.valueOf(dateLimitePaiement).compareTo("") == 0 || dateLimitePaiement == null) {
            setDateLimitePaiement(Utilitaire.dateDuJourSql());
        } else {
            setDateLimitePaiement(Utilitaire.string_date("dd/MM/yyyy", dateLimitePaiement));
        }
        if (String.valueOf(montantAP).compareTo("") == 0) {
            setMontantAPayer(0.0D);
        } else {
            setMontantAPayer(Utilitaire.stringToDouble(montantAP));
        }
        setIdSCatService(idSCatServic);
        setIdTypePaiement(idTypePaiem);
        setEntite(entit);
    }

    public FactMere(String daty, String periodeDebut, String periodeFin, String idClient, String noteExplicative, String idTva, String idFactureEn,
            String idDeviseEn, String reduction, String idEtat, String dateLimitePaiement, String montantAP, String idSCatServic, String idTypePaiem,
            String respe, String entit, String parutio, String etat) {
        super.setNomTable("FactureMereProforma");
        setResp(respe);
        setIndicePk("FMP");
        setNomProcedureSequence("getSeqFactureMereProforma");
        setIdFactureMere(makePK());
        if (String.valueOf(daty).compareTo("") == 0 || daty == null) {
            setDaty(Utilitaire.dateDuJourSql());
        } else {
            setDaty(Utilitaire.string_date("dd/MM/yyyy", daty));
        }
        if (String.valueOf(periodeDebut).compareTo("") == 0 || periodeDebut == null) {
            setPeriodeDebut(Utilitaire.dateDuJourSql());
        } else {
            setPeriodeDebut(Utilitaire.string_date("dd/MM/yyyy", periodeDebut));
        }
        if (String.valueOf(periodeFin).compareTo("") == 0 || periodeFin == null) {
            setPeriodeFin(Utilitaire.dateDuJourSql());
        } else {
            setPeriodeFin(Utilitaire.string_date("dd/MM/yyyy", periodeFin));
        }
        if (idClient.compareTo("") == 0 || idClient == null) {
            setIdClient("-");
        } else {
            setIdClient(idClient);
        }
        if (noteExplicative.compareTo("") == 0 || noteExplicative == null) {
            setNoteExplicative("-");
        } else {
            setNoteExplicative(noteExplicative);
        }
        if (String.valueOf(idTva).compareTo("") == 0) {
            setIdTva(0);
        } else {
            setIdTva(Utilitaire.stringToInt(idTva));
        }
        if (idFactureEn.compareTo("") == 0 || idFactureEn == null) {
            setIdFactureEn("-");
        } else {
            setIdFactureEn(idFactureEn);
        }
        if (parutio.compareTo("") == 0 || parutio == null) {
            setParution("-");
        } else {
            setParution(parutio);
        }
        if (idDeviseEn.compareTo("") == 0 || idDeviseEn == null) {
            setIdDeviseEn("-");
        } else {
            setIdDeviseEn(idDeviseEn);
        }
        if (String.valueOf(reduction).compareTo("") == 0) {
            setReduction(0);
        } else {
            setReduction(Utilitaire.stringToInt(reduction));
        }
        try {
            setIdCoursChange(getChange(idDeviseEn, idFactureEn));
        } catch (Exception exception) {
        }
        if (idEtat.compareTo("") == 0 || idEtat == null) {
            setIdEtat("-");
        } else {
            setIdEtat(idEtat);
        }
        if (String.valueOf(dateLimitePaiement).compareTo("") == 0 || dateLimitePaiement == null) {
            setDateLimitePaiement(Utilitaire.dateDuJourSql());
        } else {
            setDateLimitePaiement(Utilitaire.string_date("dd/MM/yyyy", dateLimitePaiement));
        }
        if (String.valueOf(montantAP).compareTo("") == 0) {
            setMontantAPayer(0.0D);
        } else {
            setMontantAPayer(Utilitaire.stringToDouble(montantAP));
        }
        setIdSCatService(idSCatServic);
        setIdTypePaiement(idTypePaiem);
        setEntite(entit);
    }

    public FactMere(Date dt, int cl, int tax, String bce, String textee, String ordree, String rem,
            int mt) {
        super.setNomTable("FactureMere");
    }

    public FactMere(int cl, int tax, String bce, String textee, String ordree, String rem, int mt) {
        super.setNomTable("FactureMere");
    }

    public String getTuppleID() {
        return String.valueOf(idFactureMere);
    }

    public String getAttributIDName() {
        return "idFactureMere";
    }

    public float calculMontantFacture() {
        return 0.0F;
    }

    public FactureFille[] getFactureFille(Connection c) {
        try {
            FactureFille afacturefille[] = (FactureFille[]) (new FactureFilleUtil()).rechercher(2, getTuppleID(), c);
            return afacturefille;
        } catch (Exception e) {
            e.printStackTrace();
            FactureFille afacturefille1[] = null;
            return afacturefille1;
        }
    }

    public FactureFille[] getFactureFille() {
        try {
            FactureFille afacturefille[] = (FactureFille[]) (new FactureFilleUtil()).rechercher(2, getTuppleID());
            return afacturefille;
        } catch (Exception e) {
            e.printStackTrace();
            FactureFille afacturefille1[] = null;
            return afacturefille1;
        }
    }

    public FactureFille[] getFactureFilleProforma() {
        try {
            FactureFilleUtil factfille = new FactureFilleUtil();
            factfille.setNomTable("facturefilleproforma");
            FactureFille afacturefille[] = (FactureFille[]) factfille.rechercher(2, getTuppleID());
            //System.out.print("vavava:"+afacturefille[0].getIdFactureFille());
            return afacturefille;
        } catch (Exception e) {
            FactureFille afacturefille1[] = null;
            return afacturefille1;
        }
    }

    public FactureFille[] getFactureFilleProforma(Connection c) {
        try {
            FactureFilleUtil factfille = new FactureFilleUtil();
            factfille.setNomTable("facturefilleproforma");
            FactureFille afacturefille[] = (FactureFille[]) factfille.rechercher(2, getTuppleID(), c);
            //System.out.print("vavava:"+afacturefille[0].getIdFactureFille());
            return afacturefille;
        } catch (Exception e) {
            FactureFille afacturefille1[] = null;
            return afacturefille1;
        }
    }
    
    public void setIdFactureMere(String idFactureMere) {
        this.idFactureMere = idFactureMere;
    }

    public String getIdFactureMere() {
        return idFactureMere;
    }

    public void setPeriodeDebut(Date periodeDebut) {
        if (String.valueOf(periodeDebut).compareTo("") == 0 || periodeDebut == null) {
            this.periodeDebut = Utilitaire.dateDuJourSql();
        } else {
            this.periodeDebut = periodeDebut;
        }
    }

    public Date getPeriodeDebut() {
        return periodeDebut;
    }

    public void setPeriodeFin(Date periodeFin) {
        if (String.valueOf(periodeFin).compareTo("") == 0 || periodeFin == null) {
            this.periodeFin = Utilitaire.dateDuJourSql();
        } else {
            this.periodeFin = periodeFin;
        }
    }

    public Date getPeriodeFin() {
        return periodeFin;
    }

    public void setIdClient(String idClient) {
        this.idClient = idClient;
    }

    public String getIdClient() {
        return idClient;
    }

    public void setNoteExplicative(String noteExplicative) {
        if (noteExplicative.compareTo("") == 0 || noteExplicative == null) {
            this.noteExplicative = "-";
        } else {
            this.noteExplicative = noteExplicative;
        }
    }

    public String getNoteExplicative() {
        return noteExplicative;
    }

    public void setIdTva(int idTva) {
        this.idTva = idTva;
    }

    public int getIdTva() {
        return idTva;
    }

    public void setIdFactureEn(String idFactureEn) {
        this.idFactureEn = idFactureEn;
    }

    public String getIdFactureEn() {
        return idFactureEn;
    }

    public void setIdDeviseEn(String idDeviseEn) {
        this.idDeviseEn = idDeviseEn;
    }

    public String getIdDeviseEn() {
        return idDeviseEn;
    }

    public void setReduction(int reduction) {
        if (String.valueOf(reduction).compareTo("") == 0) {
            this.reduction = 0;
        } else {
            this.reduction = reduction;
        }
    }

    public int getReduction() {
        return reduction;
    }

    public void setIdCoursChange(double idCoursChange) {
        this.idCoursChange = idCoursChange;
    }

    public double getIdCoursChange() {
        return idCoursChange;
    }

    public void setIdEtat(String idEtat) {
        this.idEtat = idEtat;
    }

    public String getIdEtat() {
        return idEtat;
    }

    public void setDateLimitePaiement(Date dateLimitePaiement) {
        if (String.valueOf(dateLimitePaiement).compareTo("") == 0 || dateLimitePaiement == null) {
            this.dateLimitePaiement = Utilitaire.dateDuJourSql();
        } else {
            this.dateLimitePaiement = dateLimitePaiement;
        }
    }

    public Date getDateLimitePaiement() {
        return dateLimitePaiement;
    }

    public void setDaty(Date daty) {
        if (String.valueOf(daty).compareTo("") == 0 || daty == null) {
            this.daty = Utilitaire.dateDuJourSql();
        } else {
            this.daty = daty;
        }
    }

    public Date getDaty() {
        return daty;
    }

    public double getMontantSansReduction() {
        FactureFille ff[] = getFactureFille();
        double montantSansReduction = 0.0D;
        for (int i = 0; i < ff.length; i++) {
            montantSansReduction = ff[i].getMontant() + montantSansReduction;
        }

        return montantSansReduction * getIdCoursChange();
    }

    public double getMontantSansReduction(Connection c) {
        FactureFille ff[] = getFactureFille(c);
        double montantSansReduction = 0;
        for (int i = 0; i < ff.length; i++) {
            montantSansReduction = ff[i].getMontant() + montantSansReduction;
        }

        return montantSansReduction * getIdCoursChange();
    }
    
    public double getMontantSansReductionProforma() {
        FactureFille ff[] = getFactureFilleProforma();
        double montantSansReduction = 0.0D;
        for (int i = 0; i < ff.length; i++) {
            montantSansReduction = ff[i].getMontant() + montantSansReduction;
        }

        return montantSansReduction * getIdCoursChange();
    }

    public double getMontantReduction() {
        double montantReduction = 0.0D;
        montantReduction = (getMontantSansReduction() * (double) getReduction()) / (double) 100;
        return montantReduction * getIdCoursChange();
    }

    public double getMontantReduction(Connection c) {
        double montantReduction = 0;
        montantReduction = (getMontantSansReduction(c) * (double) getReduction()) / (double) 100;
        return montantReduction * getIdCoursChange();
    }
    
    public double getMontantReductionProforma() {
        double montantReduction = 0.0D;
        montantReduction = (getMontantSansReductionProforma() * (double) getReduction()) / (double) 100;
        return montantReduction * getIdCoursChange();
    }

    public double getMontantHTva() {
        return getMontantSansReduction() - getMontantReduction();
    }

    public double getMontantHTva(Connection c) {
        return getMontantSansReduction(c) - getMontantReduction();
    }
    
    public double getMontantHTvaProforma() {
        return getMontantSansReductionProforma() - getMontantReductionProforma();
    }

    public double getMontantTva(Connection c) {
        double montantTva = 0;
        //montantTva=Utilitaire.arrondir(getMontantAPayer()-(getMontantAPayer()/(1+((double)getIdTva()) / (double)100)),2);
        montantTva = (getMontantHTva(c) * (double) getIdTva()) / 100;
        //System.out.println("montant HT = " + getMontantHTva() + " montant TVA = " + montantTva);
        return montantTva;
    }
    
    public double getMontantTva() {
        double montantTva = 0;
        //montantTva=Utilitaire.arrondir(getMontantAPayer()-(getMontantAPayer()/(1+((double)getIdTva()) / (double)100)),2);
        montantTva = (getMontantHTva() * (double) getIdTva()) / 100;
        //System.out.println("montant HT = " + getMontantHTva() + " montant TVA = " + montantTva);
        return montantTva;
    }

    public double getMontantTvaProforma() {
        double montantTva = 0;
        //montantTva=Utilitaire.arrondir(getMontantAPayer()-(getMontantAPayer()/(1+((double)getIdTva()) / (double)100)),2);
        montantTva = (getMontantHTvaProforma() * getIdTva()) / 100;
        //System.out.println("montant HT = "+getMontantHTva()+" montant TVA = "+montantTva);
        return montantTva;
    }

    public double getMontantTtc() {
        return getMontantTva() + getMontantHTva();
    }

    public double getMontantTtc(Connection c) {
        return getMontantTva(c) + getMontantHTva(c);
    }
    public double getMontantTtcProforma() {
        return getMontantTvaProforma() + getMontantHTvaProforma();
    }

    public void setMontantAPayer(double montantAPayer) {
        if (String.valueOf(montantAPayer).compareTo("") == 0) {
            this.montantAPayer = 0.0D;
        } else {
            this.montantAPayer = montantAPayer;
        }
    }

    public double getMontantAPayer() {
        return montantAPayer;
    }

    public void setIdSCatService(String idSCatService) {
        this.idSCatService = idSCatService;
    }

    public String getIdSCatService() {
        return idSCatService;
    }

    public SCatService getScatService() {
        return (SCatService) (new SCatServiceUtil()).rechercher(1, getIdSCatService())[0];
    }

    public Tva getTva() {
        return (Tva) (new TvaUtil()).rechercher(2, String.valueOf(getIdTva()))[0];
    }

    public Client getClient() {
        return (Client) (new ClientUtil()).rechercher(1, getIdClient())[0];
    }

    public Change getChange() {
        return (Change) (new ChangeUtil()).rechercher(2, String.valueOf(getIdCoursChange()))[0];
    }

    public double getChange(String devise1, String devise2)
            throws Exception {
        try {
            Change ch1 = null;
            Change ch2 = null;
            float rapport = 0.0F;
            ch1 = (new ChangeUtil()).loadChangeValide(devise1, Utilitaire.formatterDaty(periodeFin));
            ch2 = (new ChangeUtil()).loadChangeValide(devise2, Utilitaire.formatterDaty(periodeFin));
            rapport = (float) ch1.getValeurEnAriary() / (float) ch2.getValeurEnAriary();
            double d = rapport;
            return d;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public double getRAP() {
        EtatFactureUtil efu = new EtatFactureUtil();
        efu.setNomTable("ETATFACTURERESPENTITE");
        EtatFacture et = (EtatFacture) efu.rechercher(1, getTuppleID())[0];
        return et.getReste();
    }

    public EtatFacture getEtatFacture() {
        return (EtatFacture) (new EtatFactureUtil()).rechercher(1, getTuppleID())[0];
    }

    public void setIdTypePaiement(String idTypePaiement) {
        this.idTypePaiement = idTypePaiement;
    }

    public String getIdTypePaiement() {
        return idTypePaiement;
    }

    public String getResp() {
        return resp;
    }

    public void setResp(String resp) {
        this.resp = resp;
    }

    public void setEntite(String entite) {
        this.entite = entite;
    }

    public String getEntite() {
        return entite;
    }

    public void setParution(String parution) {
        this.parution = parution;
    }

    public String getParution() {
        return parution;
    }

    public void setModepaiement(String modepaiement) {
        this.modepaiement = modepaiement;
    }

    public String getModepaiement() {
        return modepaiement;
    }

    public String idFactureMere;
    public Date daty;
    public Date periodeDebut;
    public Date periodeFin;
    public String idClient;
    public String noteExplicative;
    public String idFactureEn;
    public String idDeviseEn;
    public int reduction;
    public String idEtat;
    public Date dateLimitePaiement;
    public String idSCatService;
    public double montantAPayer;
    public int idTva;
    public double idCoursChange;
    public String idTypePaiement;
    public String modepaiement;
    public String resp;
    public String entite;
    public String parution;
}
