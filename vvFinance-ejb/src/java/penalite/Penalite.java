// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   Penalite.java

package penalite;

import bean.ClassMAPTable;
import java.sql.Date;
import utilitaire.Utilitaire;

public class Penalite extends ClassMAPTable
{

    public Penalite(String id, Date dateDeb, Date dateFin, String des, double mont, String idSCat, 
            String c1, float c2, float c3, float c4)
    {
        super.setNomTable("penalite");
        setIdPenalite(id);
        setDateDebut(dateDeb);
        setDateFin(dateFin);
        setDesignation(des);
        setMontant(mont);
        setIdSCatService(idSCat);
        setChamp1(c1);
        setChamp2(c2);
        setChamp3(c3);
        setChamp4(c4);
    }

    public Penalite(Date dateDeb, Date dateFin, String des, double mont, String idSCat, String c1, 
            float c2, float c3, float c4)
    {
        super.setNomTable("penalite");
        setIndicePk("PE");
        setNomProcedureSequence("getSeqPenalite");
        setIdPenalite(makePK());
        setDateDebut(dateDeb);
        setDateFin(dateFin);
        setDesignation(des);
        setMontant(mont);
        setIdSCatService(idSCat);
        setChamp1(c1);
        setChamp2(c2);
        setChamp3(c3);
        setChamp4(c4);
    }

    public Penalite(String dateDeb, String dateFin, String des, String mont, String idSCat, String c1, String c2, 
            String c3, String c4)
    {
        super.setNomTable("penalite");
        setIndicePk("PE");
        setNomProcedureSequence("getSeqPenalite");
        setIdPenalite(makePK());
        if(String.valueOf(dateDeb).compareTo("") == 0 || dateDeb == null)
            setDateDebut(Utilitaire.dateDuJourSql());
        else
            setDateDebut(Utilitaire.string_date("dd/MM/yyyy", dateDeb));
        if(String.valueOf(dateFin).compareTo("") == 0 || dateFin == null)
            setDateFin(Utilitaire.dateDuJourSql());
        else
            setDateFin(Utilitaire.string_date("dd/MM/yyyy", dateFin));
        if(des.compareTo("") == 0 || des == null)
            setDesignation("-");
        else
            setDesignation(des);
        if(String.valueOf(mont).compareTo("") == 0)
            setMontant(0.0D);
        else
            setMontant(Utilitaire.stringToDouble(mont));
        if(idSCat.compareTo("") == 0 || idSCat == null)
            setIdSCatService("-");
        else
            setIdSCatService(idSCat);
        if(c1.compareTo("") == 0 || c1 == null)
            setChamp1("-");
        else
            setChamp1(c1);
        if(String.valueOf(c2).compareTo("") == 0)
            setChamp2(0.0D);
        else
            setChamp2(Utilitaire.stringToDouble(c2));
        if(String.valueOf(c3).compareTo("") == 0)
            setChamp3(0.0D);
        else
            setChamp3(Utilitaire.stringToDouble(c3));
        if(String.valueOf(c4).compareTo("") == 0)
            setChamp4(0.0D);
        else
            setChamp4(Utilitaire.stringToDouble(c4));
    }

    public String getAttributIDName()
    {
        return "idPenalite";
    }

    public String getTuppleID()
    {
        return getIdPenalite();
    }

    public void setIdPenalite(String idPenalite)
    {
        this.idPenalite = idPenalite;
    }

    public String getIdPenalite()
    {
        return idPenalite;
    }

    public void setDateDebut(Date dateDebut)
    {
        if(String.valueOf(dateDebut).compareTo("") == 0 || dateDebut == null)
            this.dateDebut = Utilitaire.dateDuJourSql();
        else
            this.dateDebut = dateDebut;
    }

    public Date getDateDebut()
    {
        return dateDebut;
    }

    public void setDateFin(Date dateFin)
    {
        if(String.valueOf(dateFin).compareTo("") == 0 || dateFin == null)
            this.dateFin = Utilitaire.dateDuJourSql();
        else
            this.dateFin = dateFin;
    }

    public Date getDateFin()
    {
        return dateFin;
    }

    public void setDesignation(String designation)
    {
        if(designation.compareTo("") == 0 || designation == null)
            this.designation = "-";
        else
            this.designation = designation;
    }

    public String getDesignation()
    {
        return designation;
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

    public void setIdSCatService(String idSCatService)
    {
        this.idSCatService = idSCatService;
    }

    public String getIdSCatService()
    {
        return idSCatService;
    }

    public void setChamp1(String champ1)
    {
        if(champ1.compareTo("") == 0 || champ1 == null)
            this.champ1 = "-";
        else
            this.champ1 = champ1;
    }

    public String getChamp1()
    {
        return champ1;
    }

    public void setChamp2(double champ2)
    {
        if(String.valueOf(champ2).compareTo("") == 0)
            this.champ2 = 0.0D;
        else
            this.champ2 = champ2;
    }

    public double getChamp2()
    {
        return champ2;
    }

    public void setChamp3(double champ3)
    {
        if(String.valueOf(champ3).compareTo("") == 0)
            this.champ3 = 0.0D;
        else
            this.champ3 = champ3;
    }

    public double getChamp3()
    {
        return champ3;
    }

    public void setChamp4(double champ4)
    {
        if(String.valueOf(champ4).compareTo("") == 0)
            this.champ4 = 0.0D;
        else
            this.champ4 = champ4;
    }

    public double getChamp4()
    {
        return champ4;
    }

    public String idPenalite;
    public Date dateDebut;
    public Date dateFin;
    public String designation;
    public double montant;
    public String idSCatService;
    public String champ1;
    public double champ2;
    public double champ3;
    public double champ4;
}
