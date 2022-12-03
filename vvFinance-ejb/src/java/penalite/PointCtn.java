// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   PointCtn.java

package penalite;

import bean.ClassMAPTable;
import java.sql.Date;

public class PointCtn extends ClassMAPTable
{

    public PointCtn(String cdPointCtn, String num_Mat, String nmEsc, String shift, Date hrDeb, Date hrFin, int nmCale, 
            Date dtOpt)
    {
        super.setNomTable("PointCtnVue");
        setCdPointCtn(cdPointCtn);
        setNum_Mat(num_Mat);
        setNmEsc(nmEsc);
        setShift(shift);
        setHrDeb(hrDeb);
        setHrFin(hrFin);
        setNmCale(nmCale);
        setDtOpt(dtOpt);
    }

    public String getAttributIDName()
    {
        throw new UnsupportedOperationException("Method getAttributIDName() not yet implemented.");
    }

    public String getTuppleID()
    {
        throw new UnsupportedOperationException("Method getTuppleID() not yet implemented.");
    }

    public void setCdPointCtn(String cdPointCtn)
    {
        this.cdPointCtn = cdPointCtn;
    }

    public String getCdPointCtn()
    {
        return cdPointCtn;
    }

    public void setNum_Mat(String num_Mat)
    {
        this.num_Mat = num_Mat;
    }

    public String getNum_Mat()
    {
        return num_Mat;
    }

    public void setNmEsc(String nmEsc)
    {
        this.nmEsc = nmEsc;
    }

    public String getNmEsc()
    {
        return nmEsc;
    }

    public void setDtOpt(Date dtOpt)
    {
        this.dtOpt = dtOpt;
    }

    public Date getDtOpt()
    {
        return dtOpt;
    }

    public void setShift(String shift)
    {
        this.shift = shift;
    }

    public String getShift()
    {
        return shift;
    }

    public void setHrDeb(Date hrDeb)
    {
        this.hrDeb = hrDeb;
    }

    public Date getHrDeb()
    {
        return hrDeb;
    }

    public void setHrFin(Date hrFin)
    {
        this.hrFin = hrFin;
    }

    public Date getHrFin()
    {
        return hrFin;
    }

    public void setNmCale(int nmCale)
    {
        this.nmCale = nmCale;
    }

    public int getNmCale()
    {
        return nmCale;
    }

    public String cdPointCtn;
    public String num_Mat;
    public String nmEsc;
    public String shift;
    public Date hrDeb;
    public Date hrFin;
    public int nmCale;
    public Date dtOpt;
}
