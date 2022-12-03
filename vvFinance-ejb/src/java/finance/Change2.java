// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   Change2.java

package finance;

import bean.ClassMAPTable;
import java.sql.Date;
import utilitaire.Utilitaire;

public class Change2 extends ClassMAPTable
{

    public Change2(String idChange, String idDevise, double valeurEnAriary, Date daty)
    {
        setIdChange(idChange);
        setIdDevise(idDevise);
        setValeurEnAriary(valeurEnAriary);
        setDatydebutvalid(daty);
        super.setNomTable("Change");
    }

    public Change2(String idDevise, double valeurEnAriary, Date daty)
    {
        super.setNomTable("Change");
        setIndicePk("chg");
        setNomProcedureSequence("getSeqChange");
        setIdChange(makePK());
        setIdDevise(idDevise);
        setValeurEnAriary(valeurEnAriary);
        setDatydebutvalid(daty);
    }

    public String getAttributIDName()
    {
        return "idChange";
    }

    public String getTuppleID()
    {
        return getIdChange();
    }

    public void setIdChange(String idChange)
    {
        this.idChange = idChange;
    }

    public String getIdChange()
    {
        return idChange;
    }

    public void setValeurEnAriary(double valeurEnAriary)
    {
        if(valeurEnAriary > (double)0 || String.valueOf(valeurEnAriary).compareTo("") > 0)
            this.valeurEnAriary = valeurEnAriary;
    }

    public double getValeurEnAriary()
    {
        return valeurEnAriary;
    }

    public void setIdDevise(String idDevise)
    {
        this.idDevise = idDevise;
    }

    public String getIdDevise()
    {
        return idDevise;
    }

    public void setDatydebutvalid(Date datydebutvalid)
    {
        if(String.valueOf(datydebutvalid).compareTo("") == 0 || datydebutvalid == null)
            this.datydebutvalid = Utilitaire.dateDuJourSql();
        else
            this.datydebutvalid = datydebutvalid;
    }

    public Date getDatydebutvalid()
    {
        return datydebutvalid;
    }

    public String idChange;
    public Date datydebutvalid;
    public String idDevise;
    public double valeurEnAriary;
}
