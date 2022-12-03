// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   Avoir.java

package facture;

import bean.ClassMAPTable;
import bean.GenUtil;
import java.sql.Date;
import utilitaire.Utilitaire;

// Referenced classes of package facture:
//            FactureMereUtil, FactMere

public class Avoir extends ClassMAPTable
{

    public Avoir(String idAv, String idFact, String resp, Date da, String mot, double mont, 
            String typ)
    {
        super.setNomTable("Avoir");
        setIdAvoir(idAv);
        setIdFactureMere(idFact);
        setResponsable(resp);
        setDaty(da);
        setMotif(mot);
        setMontant(mont);
        setType(typ);
    }

    public Avoir(String idFact, String resp, Date da, String mot, double mont, String typ)
    {
        super.setNomTable("Avoir");
        setIndicePk("AV");
        setNomProcedureSequence("getSeqAvoir");
        idAvoir = makePK();
        setIdFactureMere(idFact);
        setResponsable(resp);
        setDaty(da);
        setMotif(mot);
        setMontant(mont);
        setType(typ);
    }

    public Avoir(String idFact, String resp, String da, String mot, String mont, String type)
    {
        super.setNomTable("Avoir");
        setIdFactureMere(idFact);
        setType(type);
        if(resp.compareTo("") == 0 || resp == null)
            setResponsable("-");
        else
            setResponsable(resp);
        if(String.valueOf(da).compareTo("") == 0 || da == null)
            setDaty(Utilitaire.dateDuJourSql());
        else
            setDaty(Utilitaire.string_date("dd/MM/yyyy", da));
        if(mot.compareTo("") == 0 || mot == null)
            setMotif("-");
        else
            setMotif(mot);
        if(String.valueOf(mont).compareTo("") == 0)
            setMontant(0.0D);
        else
            setMontant(Utilitaire.stringToDouble(mont));
        setIndicePk(makeIndiceAvoir());
        setNomProcedureSequence("getSeqAvoir");
        idAvoir = makePK();
    }

    public Avoir(String idAv, String idFact, String resp, String da, String mot, String mont, String type)
    {
        super.setNomTable("Avoir");
        setIdAvoir(idAv);
        setIdFactureMere(idFact);
        if(resp.compareTo("") == 0 || resp == null)
            setResponsable("-");
        else
            setResponsable(resp);
        if(String.valueOf(da).compareTo("") == 0 || da == null)
            setDaty(Utilitaire.dateDuJourSql());
        else
            setDaty(Utilitaire.string_date("dd/MM/yyyy", da));
        if(mot.compareTo("") == 0 || mot == null)
            setMotif("-");
        else
            setMotif(mot);
        if(String.valueOf(mont).compareTo("") == 0)
            setMontant(0.0D);
        else
            setMontant(Utilitaire.stringToDouble(mont));
        setType(type);
    }

    public String getAttributIDName()
    {
        return "idAvoir";
    }

    public String getTuppleID()
    {
        return String.valueOf(idAvoir);
    }

    public void setIdAvoir(String idAv)
    {
        idAvoir = idAv;
    }

    public String getIdAvoir()
    {
        return idAvoir;
    }

    public void setIdFactureMere(String idFact)
    {
        idFactureMere = idFact;
    }

    public String getIdFactureMere()
    {
        return idFactureMere;
    }

    public void setResponsable(String resp)
    {
        if(resp.compareTo("") == 0 || resp == null)
            responsable = "-";
        else
            responsable = resp;
    }

    public String getResponsable()
    {
        return responsable;
    }

    public void setDaty(Date da)
    {
        if(String.valueOf(da).compareTo("") == 0 || da == null)
            daty = Utilitaire.dateDuJourSql();
        else
            daty = da;
    }

    public Date getDaty()
    {
        return daty;
    }

    public void setMotif(String mot)
    {
        if(mot.compareTo("") == 0 || mot == null)
            motif = "-";
        else
            motif = mot;
    }

    public String getMotif()
    {
        return motif;
    }

    public void setMontant(double mont)
    {
        if(String.valueOf(mont).compareTo("") == 0)
            montant = 0.0D;
        else
            montant = mont;
    }

    public double getMontant()
    {
        return montant;
    }

    public void setType(String type)
    {
        this.type = type;
    }

    public String getType()
    {
        return type;
    }

    public FactMere getFacture()
    {
        return (FactMere)(new FactureMereUtil()).rechercher(1, getIdFactureMere())[0];
    }

    private String makeIndiceAvoir()
    {
        String retour = "AV";
        if(getType().compareToIgnoreCase("interne") == 0)
            retour = String.valueOf(String.valueOf(retour)).concat("I");
        else
            retour = String.valueOf(String.valueOf(retour)).concat("E");
        String an = String.valueOf(Utilitaire.getAnnee(getDaty()));
        String mois = String.valueOf(Utilitaire.getMois(getDaty()));
        retour = String.valueOf(retour) + String.valueOf(String.copyValueOf(an.toCharArray(), 2, 2));
        retour = String.valueOf(retour) + String.valueOf(mois);
        return retour;
    }

    public String idAvoir;
    public String idFactureMere;
    public String responsable;
    public String motif;
    public double montant;
    public Date daty;
    public String type;
}
