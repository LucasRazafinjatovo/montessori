// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   Service.java

package facture;

import bean.ClassMAPTable;
import java.sql.Date;
import utilitaire.Utilitaire;

public class Service extends ClassMAPTable
{

    public Service(String i, String idSCat, Date dat, String unite, String des, double pu, 
            String dev, int tva, String clt)
    {
        super.setNomTable("service");
        setIdService(i);
        setIdSCatService(idSCat);
        setIdUnite(unite);
        setDesignation(des);
        setIdDevise(dev);
        setIdTva(tva);
        setPrixUnitaire(pu);
        setDatyDebutValid(dat);
        setIdClient(clt);
    }

    public Service(String idSCat, Date dat, String unite, String des, double pu, String dev, 
            int tva, String clt)
    {
        super.setNomTable("service");
        setIndicePk("serv");
        setNomProcedureSequence("getSeqService");
        setIdService(makePK());
        setIdSCatService(idSCat);
        setIdUnite(unite);
        setDesignation(des);
        setIdDevise(dev);
        setIdTva(tva);
        setPrixUnitaire(pu);
        setDatyDebutValid(dat);
        setIdClient(clt);
    }

    public Service(String idSCat, String dat, String unite, String des, String pu, String dev, String tva, 
            String clt)
    {
        super.setNomTable("service");
        setIndicePk("serv");
        setNomProcedureSequence("getSeqService");
        setIdService(makePK());
        if(idSCat.compareTo("") == 0 || idSCat == null)
            setIdSCatService("-");
        else
            setIdSCatService(idSCat);
        if(unite.compareTo("") == 0 || unite == null)
            setIdUnite("unite");
        else
            setIdUnite(unite);
        if(des.compareTo("") == 0 || des == null)
            setDesignation("-");
        else
            setDesignation(des);
        if(dev.compareTo("") == 0 || dev == null)
            setIdDevise("-");
        else
            setIdDevise(dev);
        if(String.valueOf(tva).compareTo("") == 0)
            setIdTva(0);
        else
            setIdTva(Utilitaire.stringToInt(tva));
        if(String.valueOf(pu).compareTo("") == 0)
            setPrixUnitaire(0.0D);
        else
            setPrixUnitaire(Utilitaire.stringToDouble(pu));
        if(String.valueOf(dat).compareTo("") == 0 || dat == null)
            setDatyDebutValid(Utilitaire.dateDuJourSql());
        else
            setDatyDebutValid(Utilitaire.string_date("dd/MM/yyyy", dat));
        if(clt.compareTo("") == 0 || clt == null)
            setIdClient("-");
        else
            setIdClient(clt);
    }

    public String getAttributIDName()
    {
        return "idService";
    }

    public String getTuppleID()
    {
        return String.valueOf(idService);
    }

    public void setIdService(String idService)
    {
        this.idService = idService;
    }

    public String getIdService()
    {
        return idService;
    }

    public void setIdSCatService(String idSCatService)
    {
        this.idSCatService = idSCatService;
    }

    public String getIdSCatService()
    {
        return idSCatService;
    }

    public void setDatyDebutValid(Date datyDebutValid)
    {
        this.datyDebutValid = datyDebutValid;
    }

    public Date getDatyDebutValid()
    {
        return datyDebutValid;
    }

    public void setIdUnite(String idUnite)
    {
        this.idUnite = idUnite;
    }

    public String getIdUnite()
    {
        return idUnite;
    }

    public void setDesignation(String designation)
    {
        this.designation = designation;
    }

    public String getDesignation()
    {
        return designation;
    }

    public void setPrixUnitaire(double prixUnitaire)
    {
        this.prixUnitaire = prixUnitaire;
    }

    public double getPrixUnitaire()
    {
        return prixUnitaire;
    }

    public void setIdDevise(String idDevise)
    {
        this.idDevise = idDevise;
    }

    public String getIdDevise()
    {
        return idDevise;
    }

    public void setIdTva(int idTva)
    {
        this.idTva = idTva;
    }

    public int getIdTva()
    {
        return idTva;
    }

    public void setIdClient(String idClient)
    {
        this.idClient = idClient;
    }

    public String getIdClient()
    {
        return idClient;
    }

    public String idService;
    public String idSCatService;
    public String idUnite;
    public String designation;
    public String idDevise;
    public double prixUnitaire;
    public Date datyDebutValid;
    public String idClient;
    public int idTva;
}
