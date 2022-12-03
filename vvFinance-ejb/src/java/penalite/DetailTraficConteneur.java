// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   DetailTraficConteneur.java

package penalite;

import bean.ClassMAPTable;
import java.sql.Date;
import utilitaire.Utilitaire;

public class DetailTraficConteneur extends ClassMAPTable
{

    public DetailTraficConteneur(String nmCtn, Date dmin, Date dmax)
    {
        setNmctn(nmCtn);
        setMinDtop(dmin);
        setMaxDtop(dmax);
    }

    public String getAttributIDName()
    {
        throw new UnsupportedOperationException("Method getAttributIDName() not yet implemented.");
    }

    public String getTuppleID()
    {
        throw new UnsupportedOperationException("Method getTuppleID() not yet implemented.");
    }

    public void setNmctn(String nmctn)
    {
        if(nmctn.compareTo("") == 0 || nmctn == null)
            this.nmctn = "-";
        else
            this.nmctn = nmctn;
    }

    public String getNmctn()
    {
        return nmctn;
    }

    public void setMinDtop(Date minDtop)
    {
        if(String.valueOf(minDtop).compareTo("") == 0 || minDtop == null)
            this.minDtop = Utilitaire.dateDuJourSql();
        else
            this.minDtop = minDtop;
    }

    public Date getMinDtop()
    {
        return minDtop;
    }

    public void setMaxDtop(Date maxDtop)
    {
        if(String.valueOf(maxDtop).compareTo("") == 0 || maxDtop == null)
            this.maxDtop = Utilitaire.dateDuJourSql();
        else
            this.maxDtop = maxDtop;
    }

    public Date getMaxDtop()
    {
        return maxDtop;
    }

    private String nmctn;
    private Date minDtop;
    private Date maxDtop;
}
