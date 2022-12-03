// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   OccupJournalier.java

package penalite;

import bean.ClassMAPTable;
import java.sql.Date;

public class OccupJournalier extends ClassMAPTable
{

    public OccupJournalier(String id, Date dt, double occ)
    {
        setNomTable("OccupJournalier");
        setIdQuai(id);
        setDaty(dt);
        setOccup(occ);
    }

    public String getAttributIDName()
    {
        throw new UnsupportedOperationException("Method getAttributIDName() not yet implemented.");
    }

    public String getTuppleID()
    {
        throw new UnsupportedOperationException("Method getTuppleID() not yet implemented.");
    }

    public void setIdQuai(String idQuai)
    {
        this.idQuai = idQuai;
    }

    public String getIdQuai()
    {
        return idQuai;
    }

    public void setOccup(double occup)
    {
        this.occup = occup;
    }

    public double getOccup()
    {
        return occup;
    }

    public void setDaty(Date daty)
    {
        this.daty = daty;
    }

    public Date getDaty()
    {
        return daty;
    }

    public String idQuai;
    public Date daty;
    public double occup;
}
