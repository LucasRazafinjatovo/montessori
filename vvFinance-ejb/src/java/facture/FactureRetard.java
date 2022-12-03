// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   FactureRetard.java

package facture;

import bean.ClassMAPTable;
import java.sql.Date;

public class FactureRetard extends ClassMAPTable
{

    public FactureRetard(String idFac, String ref, String numF, Date pDeb, Date pFin)
    {
        setIdFactureMere(idFac);
        setRefObj(ref);
        setNumFact(numF);
        setPeriodeDebut(pDeb);
        setPeriodeFin(pFin);
    }

    public String getAttributIDName()
    {
        throw new UnsupportedOperationException("Method getAttributIDName() not yet implemented.");
    }

    public String getTuppleID()
    {
        throw new UnsupportedOperationException("Method getTuppleID() not yet implemented.");
    }

    public void setIdFactureMere(String idFactureMere)
    {
        this.idFactureMere = idFactureMere;
    }

    public String getIdFactureMere()
    {
        return idFactureMere;
    }

    public void setRefObj(String refObj)
    {
        this.refObj = refObj;
    }

    public String getRefObj()
    {
        return refObj;
    }

    public void setNumFact(String numFact)
    {
        this.numFact = numFact;
    }

    public String getNumFact()
    {
        return numFact;
    }

    public void setPeriodeDebut(Date periodeDebut)
    {
        this.periodeDebut = periodeDebut;
    }

    public Date getPeriodeDebut()
    {
        return periodeDebut;
    }

    public void setPeriodeFin(Date periodeFin)
    {
        this.periodeFin = periodeFin;
    }

    public Date getPeriodeFin()
    {
        return periodeFin;
    }

    private String idFactureMere;
    private String refObj;
    private String numFact;
    private Date periodeDebut;
    private Date periodeFin;
}
