// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   DetailPointCtn.java

package penalite;

import bean.ClassMAPTable;

public class DetailPointCtn extends ClassMAPTable
{

    public DetailPointCtn(String cdDetPointCtn, String nmCtn, String cdPointCtn, String cdClt, String nomClt, String etat, String typeOpt, 
            String nmTrac, String nmConn, String nmBonEmb, String nmBonEnl, String nmBs, String nmFact)
    {
        setCdDetPointCtn(cdDetPointCtn);
        setNmCtn(nmCtn);
        setCdPointCtn(cdPointCtn);
        setCdClt(cdClt);
        setEtat(etat);
        setTypeOpt(typeOpt);
        setNmTrac(nmTrac);
        setNmConn(nmConn);
        setNmBonEmb(nmBonEmb);
        setNmBonEnl(nmBonEnl);
        setNmBs(nmBs);
        setNmFact(nmFact);
        setNomTable("DetailPointCtnVue");
    }

    public String getAttributIDName()
    {
        throw new UnsupportedOperationException("Method getAttributIDName() not yet implemented.");
    }

    public String getTuppleID()
    {
        throw new UnsupportedOperationException("Method getTuppleID() not yet implemented.");
    }

    public void setNmCtn(String nmCtn)
    {
        this.nmCtn = nmCtn;
    }

    public String getNmCtn()
    {
        return nmCtn;
    }

    public void setCdPointCtn(String cdPointCtn)
    {
        this.cdPointCtn = cdPointCtn;
    }

    public String getCdPointCtn()
    {
        return cdPointCtn;
    }

    public void setCdClt(String cdClt)
    {
        this.cdClt = cdClt;
    }

    public String getCdClt()
    {
        return cdClt;
    }

    public void setNomClt(String nomClt)
    {
        this.nomClt = nomClt;
    }

    public String getNomClt()
    {
        return nomClt;
    }

    public void setEtat(String etat)
    {
        this.etat = etat;
    }

    public String getEtat()
    {
        return etat;
    }

    public void setTypeOpt(String typeOpt)
    {
        this.typeOpt = typeOpt;
    }

    public String getTypeOpt()
    {
        return typeOpt;
    }

    public void setNmTrac(String nmTrac)
    {
        this.nmTrac = nmTrac;
    }

    public String getNmTrac()
    {
        return nmTrac;
    }

    public void setNmConn(String nmConn)
    {
        this.nmConn = nmConn;
    }

    public String getNmConn()
    {
        return nmConn;
    }

    public void setNmBonEmb(String nmBonEmb)
    {
        this.nmBonEmb = nmBonEmb;
    }

    public String getNmBonEmb()
    {
        return nmBonEmb;
    }

    public void setNmBonEnl(String nmBonEnl)
    {
        this.nmBonEnl = nmBonEnl;
    }

    public String getNmBonEnl()
    {
        return nmBonEnl;
    }

    public void setNmBs(String nmBs)
    {
        this.nmBs = nmBs;
    }

    public String getNmBs()
    {
        return nmBs;
    }

    public void setNmFact(String nmFact)
    {
        this.nmFact = nmFact;
    }

    public String getNmFact()
    {
        return nmFact;
    }

    public void setCdDetPointCtn(String cdDetPointCtn)
    {
        this.cdDetPointCtn = cdDetPointCtn;
    }

    public String getCdDetPointCtn()
    {
        return cdDetPointCtn;
    }

    private String nmCtn;
    private String cdPointCtn;
    private String cdClt;
    private String nomClt;
    private String etat;
    private String typeOpt;
    private String nmTrac;
    private String nmConn;
    private String nmBonEmb;
    private String nmBonEnl;
    private String nmBs;
    private String nmFact;
    private String cdDetPointCtn;
}
