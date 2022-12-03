// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   ChiffreAffTAc.java

package penalite;

import bean.ClassMAPTable;
import utilitaire.Utilitaire;

public class ChiffreAffTac extends ClassMAPTable
{

    public ChiffreAffTac(String i, int moi, int an, double mont)
    {
        super.setNomTable("ChiffreAffaireTac");
        setIdChiffre(i);
        setMois(moi);
        setAnnee(an);
        setMontant(mont);
    }

    public ChiffreAffTac(int moi, int an, double mont)
    {
        super.setNomTable("ChiffreAffaireTac");
        setIndicePk("ca");
        setNomProcedureSequence("getSeqChiffreAffaireTac");
        setIdChiffre(makePK());
        setMois(moi);
        setAnnee(an);
        setMontant(mont);
    }

    public ChiffreAffTac(String moi, String an, String mont)
    {
        super.setNomTable("ChiffreAffaireTac");
        setIndicePk("ca");
        setNomProcedureSequence("getSeqChiffreAffaireTac");
        setIdChiffre(makePK());
        if(String.valueOf(moi).compareTo("") == 0)
            setMois(0);
        else
            setMois(Utilitaire.stringToInt(moi));
        if(String.valueOf(an).compareTo("") == 0)
            setAnnee(0);
        else
            setAnnee(Utilitaire.stringToInt(an));
        if(String.valueOf(mont).compareTo("") == 0)
            setMontant(0.0D);
        else
            setMontant(Utilitaire.stringToDouble(mont));
    }

    public String getAttributIDName()
    {
        return "idChiffre";
    }

    public String getTuppleID()
    {
        return String.valueOf(idChiffre);
    }

    public void setIdChiffre(String idChiffre)
    {
        this.idChiffre = idChiffre;
    }

    public String getIdChiffre()
    {
        return idChiffre;
    }

    public void setMois(int mois)
    {
        if(String.valueOf(mois).compareTo("") == 0)
            this.mois = 0;
        else
            this.mois = mois;
    }

    public int getMois()
    {
        return mois;
    }

    public void setAnnee(int annee)
    {
        if(String.valueOf(annee).compareTo("") == 0)
            this.annee = 0;
        else
            this.annee = annee;
    }

    public int getAnnee()
    {
        return annee;
    }

    public void setMontant(double montant)
    {
        if(String.valueOf(montant).compareTo("") == 0)
            this.montant = 0.0D;
        else
            this.montant = montant;
    }

    public double getMontant()
    {
        return montant;
    }

    public String idChiffre;
    public int mois;
    public int annee;
    public double montant;
}
