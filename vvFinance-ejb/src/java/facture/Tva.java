// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   Tva.java

package facture;

import bean.ClassMAPTable;
import java.sql.Date;
import utilitaire.Utilitaire;

public class Tva extends ClassMAPTable
{

    public Tva(String i, int val, Date dat)
    {
        super.setNomTable("Tva");
        setIdTva(i);
        setValTva(val);
        setDatyDebutValid(dat);
    }

    public Tva(String val, String dat)
    {
        super.setNomTable("Tva");
        setIndicePk("TV");
        setNomProcedureSequence("getSeqTva");
        setIdTva(makePK());
        if(String.valueOf(val).compareTo("") == 0)
            setValTva(0);
        else
            setValTva(Utilitaire.stringToInt(val));
        if(String.valueOf(dat).compareTo("") == 0 || dat == null)
            setDatyDebutValid(Utilitaire.dateDuJourSql());
        else
            setDatyDebutValid(Utilitaire.string_date("dd/MM/yyyy", dat));
    }

    public String getAttributIDName()
    {
        return "idTva";
    }

    public Tva(int val, Date dat)
    {
        super.setNomTable("Tva");
        super.setNomTable("Tva");
        setIndicePk("TV");
        setNomProcedureSequence("getSeqTva");
        setIdTva(makePK());
        setValTva(val);
        setDatyDebutValid(dat);
    }

    public String getTuppleID()
    {
        return String.valueOf(idTva);
    }

    public void setIdTva(String idTva)
    {
        this.idTva = idTva;
    }

    public String getIdTva()
    {
        return idTva;
    }

    public void setValTva(int valeurTva)
    {
        this.valeurTva = valeurTva;
    }

    public int getValTva()
    {
        return valeurTva;
    }

    public void setDatyDebutValid(Date datyDebutValid)
    {
        this.datyDebutValid = datyDebutValid;
    }

    public Date getDatyDebutValid()
    {
        return datyDebutValid;
    }

    public String idTva;
    public int valeurTva;
    public Date datyDebutValid;
}
