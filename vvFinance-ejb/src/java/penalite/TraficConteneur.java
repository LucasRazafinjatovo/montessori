// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   TraficConteneur.java

package penalite;

import bean.ClassMAPTable;
import java.sql.Date;
import utilitaire.Utilitaire;

public class TraficConteneur extends ClassMAPTable
{

    public TraficConteneur(String i, Date dat, Date datyD, Date datyF, double n, String re, 
            String idServ)
    {
        super.setNomTable("TraficConteneur");
        setIdTrafic(i);
        setDaty(dat);
        setPeriodeDebut(datyD);
        setPeriodeFin(datyF);
        setNombre(n);
        setRem(re);
        setIdService(idServ);
    }

    public TraficConteneur(Date dat, Date datyD, Date datyF, double n, String re, String idServ)
    {
        super.setNomTable("TraficConteneur");
        setIndicePk("trf");
        setNomProcedureSequence("getSeqTraficConteneur");
        setIdTrafic(makePK());
        setDaty(dat);
        setPeriodeDebut(datyD);
        setPeriodeFin(datyF);
        setNombre(n);
        setRem(re);
        setIdService(idServ);
    }

    public TraficConteneur(String dat, String datyD, String datyF, String n, String re, String idServ)
    {
        super.setNomTable("TraficConteneur");
        setIndicePk("trf");
        setNomProcedureSequence("getSeqTraficConteneur");
        setIdTrafic(makePK());
        if(String.valueOf(dat).compareTo("") == 0 || dat == null)
            setDaty(Utilitaire.dateDuJourSql());
        else
            setDaty(Utilitaire.string_date("dd/MM/yyyy", dat));
        if(String.valueOf(datyD).compareTo("") == 0 || datyD == null)
            setPeriodeDebut(Utilitaire.dateDuJourSql());
        else
            setPeriodeDebut(Utilitaire.string_date("dd/MM/yyyy", datyD));
        if(String.valueOf(datyF).compareTo("") == 0 || datyF == null)
            setPeriodeFin(Utilitaire.dateDuJourSql());
        else
            setPeriodeFin(Utilitaire.string_date("dd/MM/yyyy", datyF));
        if(String.valueOf(n).compareTo("") == 0)
            setNombre(0.0D);
        else
            setNombre(Utilitaire.stringToDouble(n));
        if(re.compareTo("") == 0 || re == null)
            setRem("-");
        else
            setRem(re);
        if(idServ.compareTo("") == 0 || idServ == null)
            setIdService("-");
        else
            setIdService(idServ);
    }

    public String getAttributIDName()
    {
        return "idTrafic";
    }

    public String getTuppleID()
    {
        return String.valueOf(idTrafic);
    }

    public void setIdTrafic(String idTrafic)
    {
        this.idTrafic = idTrafic;
    }

    public String getIdTrafic()
    {
        return idTrafic;
    }

    public void setDaty(Date daty)
    {
        if(String.valueOf(daty).compareTo("") == 0 || daty == null)
            this.daty = Utilitaire.dateDuJourSql();
        else
            this.daty = daty;
    }

    public Date getDaty()
    {
        return daty;
    }

    public void setRem(String rem)
    {
        if(rem.compareTo("") == 0 || rem == null)
            this.rem = "-";
        else
            this.rem = rem;
    }

    public String getRem()
    {
        return rem;
    }

    public void setPeriodeDebut(Date periodeDebut)
    {
        if(String.valueOf(periodeDebut).compareTo("") == 0 || periodeDebut == null)
            this.periodeDebut = Utilitaire.dateDuJourSql();
        else
            this.periodeDebut = periodeDebut;
    }

    public Date getPeriodeDebut()
    {
        return periodeDebut;
    }

    public void setPeriodeFin(Date periodeFin)
    {
        if(String.valueOf(periodeFin).compareTo("") == 0 || periodeFin == null)
            this.periodeFin = Utilitaire.dateDuJourSql();
        else
            this.periodeFin = periodeFin;
    }

    public Date getPeriodeFin()
    {
        return periodeFin;
    }

    public void setNombre(double nombre)
    {
        if(String.valueOf(nombre).compareTo("") == 0)
            this.nombre = 0.0D;
        else
            this.nombre = nombre;
    }

    public double getNombre()
    {
        return nombre;
    }

    public void setIdService(String idService)
    {
        this.idService = idService;
    }

    public String getIdService()
    {
        return idService;
    }

    public String idTrafic;
    public Date daty;
    public String rem;
    public Date periodeDebut;
    public Date periodeFin;
    public double nombre;
    public String idService;
}
