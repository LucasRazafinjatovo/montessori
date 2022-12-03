// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   Facture.java

package facture;

import bean.ClassMAPTable;

public class Facture extends ClassMAPTable
{

    public Facture(String factFille, String factM, String des, String unit, int red, float qte, float pu)
    {
        setIdFactureFille(factFille);
        setIdFactureMere(factM);
        setDesignation(des);
        setIdUnite(unit);
        setReduction(red);
        setQuantite(qte);
        setPrixUnitaire(pu);
        setNomTable("factureFille");
    }

    public Facture(String factM, String des, String unit, int red, float qte, float pu)
    {
        setIdFactureMere(factM);
        setDesignation(des);
        setIdUnite(unit);
        setReduction(red);
        setQuantite(qte);
        setPrixUnitaire(pu);
        setIndicePk("FF");
        setNomProcedureSequence("GetSeqFactureFille");
        setIdFactureFille(makePK());
        setNomTable("factureFille");
    }

    public String getTuppleID()
    {
        return String.valueOf(idFactureFille);
    }

    public String getAttributIDName()
    {
        return "idFactureFille";
    }

    public void setIdFactureFille(String idFactureFille)
    {
        this.idFactureFille = idFactureFille;
    }

    public String getIdFactureFille()
    {
        return idFactureFille;
    }

    public void setIdFactureMere(String idFactureMere)
    {
        this.idFactureMere = idFactureMere;
    }

    public String getIdFactureMere()
    {
        return idFactureMere;
    }

    public void setDesignation(String designation)
    {
        this.designation = designation;
    }

    public String getDesignation()
    {
        return designation;
    }

    public void setQuantite(float quantite)
    {
        this.quantite = quantite;
    }

    public float getQuantite()
    {
        return quantite;
    }

    public void setIdUnite(String idUnite)
    {
        this.idUnite = idUnite;
    }

    public String getIdUnite()
    {
        return idUnite;
    }

    public void setPrixUnitaire(float prixUnitaire)
    {
        this.prixUnitaire = prixUnitaire;
    }

    public float getPrixUnitaire()
    {
        return prixUnitaire;
    }

    public void setReduction(int reduction)
    {
        this.reduction = reduction;
    }

    public int getReduction()
    {
        return reduction;
    }

    public String idFactureFille;
    public String idFactureMere;
    public String designation;
    public String idUnite;
    public int reduction;
    public float quantite;
    public float prixUnitaire;
}
