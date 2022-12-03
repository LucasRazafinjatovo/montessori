// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   SynthesePointage.java

package penalite;

import bean.ClassMAPTable;
import java.sql.Date;

public class SynthesePointage extends ClassMAPTable
{

    public SynthesePointage(Date dtOpt, String cdPointCtn, String nmEsc, int nombre, float duree)
    {
        setNomTable("SynthPointage");
        setDtOpt(dtOpt);
        setCdPointCtn(cdPointCtn);
        setNmEsc(nmEsc);
        setNombre(nombre);
        setDuree(duree);
    }

    public String getAttributIDName()
    {
        throw new UnsupportedOperationException("Method getAttributIDName() not yet implemented.");
    }

    public String getTuppleID()
    {
        throw new UnsupportedOperationException("Method getTuppleID() not yet implemented.");
    }

    public void setDtOpt(Date dtOpt)
    {
        this.dtOpt = dtOpt;
    }

    public Date getDtOpt()
    {
        return dtOpt;
    }

    public void setCdPointCtn(String cdPointCtn)
    {
        this.cdPointCtn = cdPointCtn;
    }

    public String getCdPointCtn()
    {
        return cdPointCtn;
    }

    public void setNmEsc(String nmEsc)
    {
        this.nmEsc = nmEsc;
    }

    public String getNmEsc()
    {
        return nmEsc;
    }

    public void setNombre(int nombre)
    {
        if(String.valueOf(nombre) == null || String.valueOf(nombre) == "")
            this.nombre = 0;
        else
            this.nombre = nombre;
    }

    public int getNombre()
    {
        return nombre;
    }

    public void setDuree(float duree)
    {
        this.duree = duree;
    }

    public float getDuree()
    {
        return duree;
    }

    private Date dtOpt;
    private String cdPointCtn;
    private String nmEsc;
    private int nombre;
    private float duree;
}
