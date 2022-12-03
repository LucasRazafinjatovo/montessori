// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   SyntheseEVP.java

package facture;

import bean.ClassMAPTable;
import java.sql.Date;

public class SyntheseEVP extends ClassMAPTable
{

    public SyntheseEVP(Date dt, int ving, int quar)
    {
        setNomTable("SyntheseEVP");
        setDaty(dt);
        setVingt(ving);
        setQuarante(quar);
    }

    public String getAttributIDName()
    {
        return "quarante";
    }

    public String getTuppleID()
    {
        return String.valueOf(quarante);
    }

    public void setDaty(Date daty)
    {
        this.daty = daty;
    }

    public Date getDaty()
    {
        return daty;
    }

    public void setVingt(int vingt)
    {
        this.vingt = vingt;
    }

    public int getVingt()
    {
        return vingt;
    }

    public void setQuarante(int quarante)
    {
        this.quarante = quarante;
    }

    public int getQuarante()
    {
        return quarante;
    }

    public int getEVP()
    {
        return 2 * getQuarante() + getVingt();
    }

    private Date daty;
    private int vingt;
    private int quarante;
}
