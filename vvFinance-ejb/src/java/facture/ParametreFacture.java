// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   ParametreFacture.java

package facture;

import bean.ClassMAPTable;
import java.sql.Date;
import utilitaire.Utilitaire;

public class ParametreFacture extends ClassMAPTable
{

    public ParametreFacture(String i, int delai, double bonus, int red, Date daty)
    {
        super.setNomTable("ParametreFacture");
        setIdParametreFacture(i);
        setDelaiPaiement(delai);
        setBonusEVP(bonus);
        setDatedebutvalid(daty);
        setReductionTrafic(red);
    }

    public ParametreFacture(int delai, double bonus, int red, Date daty)
    {
        super.setNomTable("ParametreFacture");
        setIndicePk("PF");
        setNomProcedureSequence("getSeqParametreFact");
        setIdParametreFacture(makePK());
        setDelaiPaiement(delai);
        setBonusEVP(bonus);
        setReductionTrafic(red);
        setDatedebutvalid(daty);
    }

    public ParametreFacture(String delai, String bonus, String red, String daty)
    {
        super.setNomTable("ParametreFacture");
        setIndicePk("PF");
        setNomProcedureSequence("getSeqParametreFact");
        setIdParametreFacture(makePK());
        if(String.valueOf(delai).compareTo("") == 0)
            setDelaiPaiement(0);
        else
            setDelaiPaiement(Utilitaire.stringToInt(delai));
        if(String.valueOf(bonus).compareTo("") == 0)
            setBonusEVP(200000D);
        else
            setBonusEVP(Utilitaire.stringToDouble(bonus));
        if(String.valueOf(red).compareTo("") == 0)
            setReductionTrafic(20);
        else
            setReductionTrafic(Utilitaire.stringToInt(red));
        if(String.valueOf(daty).compareTo("") == 0 || daty == null)
            setDatedebutvalid(Utilitaire.dateDuJourSql());
        else
            setDatedebutvalid(Utilitaire.string_date("dd/MM/yyyy", daty));
    }

    public String getAttributIDName()
    {
        return "idParametreFacture";
    }

    public String getTuppleID()
    {
        return String.valueOf(idParametreFacture);
    }

    public void setIdParametreFacture(String idParametreFacture)
    {
        this.idParametreFacture = idParametreFacture;
    }

    public String getIdParametreFacture()
    {
        return idParametreFacture;
    }

    public void setDelaiPaiement(int delaiPaiement)
    {
        this.delaiPaiement = delaiPaiement;
    }

    public int getDelaiPaiement()
    {
        return delaiPaiement;
    }

    public void setBonusEVP(double bonusEVP)
    {
        this.bonusEVP = bonusEVP;
    }

    public double getBonusEVP()
    {
        return bonusEVP;
    }

    public void setDatedebutvalid(Date datedebutvalid)
    {
        this.datedebutvalid = datedebutvalid;
    }

    public Date getDatedebutvalid()
    {
        return datedebutvalid;
    }

    public void setReductionTrafic(int reductionTrafic)
    {
        this.reductionTrafic = reductionTrafic;
    }

    public int getReductionTrafic()
    {
        return reductionTrafic;
    }

    public String idParametreFacture;
    public int delaiPaiement;
    public double bonusEVP;
    public Date datedebutvalid;
    public int reductionTrafic;
}
