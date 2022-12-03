// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   SCatService.java

package facture;

import bean.ClassMAPTable;
import utilitaire.Utilitaire;

public class SCatService extends ClassMAPTable
{

    public SCatService(String i, String nomSC, String cat, int periFact, String factEn)
    {
        super.setNomTable("SCATSERVICE");
        setIdScatService(i);
        setNomSCatService(nomSC);
        setIdCategorie(cat);
        setPeriodeFacturation(periFact);
        setFactureEn(factEn);
    }
    public SCatService()
   {
       super.setNomTable("SCATSERVICE");
    }
    public SCatService(String nomSC, String cat, int periFact, String factEn)
    {
        super.setNomTable("SCATSERVICE");
        setIndicePk("scat");
        setNomProcedureSequence("getSeqSCatService");
        setIdScatService(makePK());
        setNomSCatService(nomSC);
        setIdCategorie(cat);
        setPeriodeFacturation(periFact);
        setFactureEn(factEn);
    }

    public SCatService(String nomSC, String cat, String periFact, String factEn)
    {
        super.setNomTable("SCATSERVICE");
        setIndicePk("scat");
        setNomProcedureSequence("getSeqSCatService");
        setIdScatService(makePK());
        if(nomSC.compareTo("") == 0 || nomSC == null)
            setNomSCatService("-");
        else
            setNomSCatService(nomSC);
        if(cat.compareTo("") == 0 || cat == null)
            setIdCategorie("-");
        else
            setIdCategorie(cat);
        if(String.valueOf(periFact).compareTo("") == 0)
            setPeriodeFacturation(0);
        else
            setPeriodeFacturation(Utilitaire.stringToInt(periFact));
        if(factEn.compareTo("") == 0 || factEn == null)
            setFactureEn("-");
        else
            setFactureEn(factEn);
    }

    public String getAttributIDName()
    {
        return "idScatService";
    }

    public String getTuppleID()
    {
        return String.valueOf(idScatService);
    }

    public void setIdScatService(String idScatService)
    {
        this.idScatService = idScatService;
    }

    public String getIdScatService()
    {
        return idScatService;
    }

    public void setNomSCatService(String nomSCatService)
    {
        if(nomSCatService.compareTo("") == 0 || nomSCatService == null)
            this.nomSCatService = "-";
        else
            this.nomSCatService = nomSCatService;
    }

    public String getNomSCatService()
    {
        return nomSCatService;
    }

    public void setIdCategorie(String idCategorie)
    {
        this.idCategorie = idCategorie;
    }

    public String getIdCategorie()
    {
        return idCategorie;
    }

    public void setPeriodeFacturation(int periodeFacturation)
    {
        if(String.valueOf(periodeFacturation).compareTo("") == 0)
            this.periodeFacturation = 0;
        else
            this.periodeFacturation = periodeFacturation;
    }

    public int getPeriodeFacturation()
    {
        return periodeFacturation;
    }

    public void setFactureEn(String factureEn)
    {
        this.factureEn = factureEn;
    }

    public String getFactureEn()
    {
        return factureEn;
    }

    public String idScatService;
    public String nomSCatService;
    public String idCategorie;
    public int periodeFacturation;
    public String factureEn;
}
