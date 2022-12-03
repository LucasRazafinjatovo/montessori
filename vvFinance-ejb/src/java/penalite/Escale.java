// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   Escale.java

package penalite;

import bean.ClassMAPTable;
import java.sql.Date;

public class Escale extends ClassMAPTable
{

    public Escale(String nmEsc, String nmAvi, String cdPor, String libPor, Date dtArr, Date hrArr, Date dtDep,
            Date hrDep, String traiter)
    {
        super.setNomTable("EscaleVue");
        setNmEsc(nmEsc);
        setNmAvi(nmAvi);
        setCdPor(cdPor);
        setLibPor(libPor);
        setDtArr(dtArr);
        setHrArr(hrArr);
        setDtDep(dtDep);
        setHrDep(hrDep);
        setTraiter(traiter);
    }

    public String getAttributIDName()
    {
        return "nmEsc";
    }

    public String getTuppleID()
    {
        return nmEsc;
    }

    public void setNmEsc(String nmEsc)
    {
        this.nmEsc = nmEsc;
    }

    public String getNmEsc()
    {
        return nmEsc;
    }

    public void setNmAvi(String nmAvi)
    {
        this.nmAvi = nmAvi;
    }

    public String getNmAvi()
    {
        return nmAvi;
    }

    public void setCdPor(String cdPor)
    {
        this.cdPor = cdPor;
    }

    public String getCdPor()
    {
        return cdPor;
    }

    public void setLibPor(String libPor)
    {
        this.libPor = libPor;
    }

    public String getLibPor()
    {
        return libPor;
    }

    public void setDtArr(Date dtArr)
    {
        this.dtArr = dtArr;
    }

    public Date getDtArr()
    {
        return dtArr;
    }

    public void setHrArr(Date hrArr)
    {
        this.hrArr = hrArr;
    }

    public Date getHrArr()
    {
        return hrArr;
    }

    public void setDtDep(Date dtDep)
    {
        this.dtDep = dtDep;
    }

    public Date getDtDep()
    {
        return dtDep;
    }

    public void setHrDep(Date hrDep)
    {
        this.hrDep = hrDep;
    }

    public Date getHrDep()
    {
        return hrDep;
    }

    public void setTraiter(String traiter)
    {
        this.traiter = traiter;
    }

    public String getTraiter()
    {
        return traiter;
    }
  public void setJiji(String jiji) {
    this.jiji = jiji;
  }
  public String getJiji() {
    return jiji;
  }

    public String nmEsc;
    public String nmAvi;
    public String cdPor;
    public String libPor;
    public String traiter;
    private Date dtArr;
    private Date dtDep;
    private Date hrArr;
    private Date hrDep;
  private String jiji;
}
