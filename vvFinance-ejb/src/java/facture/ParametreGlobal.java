// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   ParametreGlobal.java

package facture;

import bean.ClassMAPTable;
import utilitaire.Utilitaire;

public class ParametreGlobal extends ClassMAPTable
{

    public ParametreGlobal(String id, int nb)
    {
        super.setNomTable("parametreglobal");
        setIdParametreGlobal(id);
        setNbEnregParPage(nb);
    }

    public ParametreGlobal(int nb)
    {
        super.setNomTable("parametreglobal");
        setIndicePk("PG");
        setNomProcedureSequence("getSeqParametreGlobal");
        setIdParametreGlobal(makePK());
        setNbEnregParPage(nb);
    }

    public ParametreGlobal(String nb)
    {
        super.setNomTable("parametreglobal");
        setIndicePk("PG");
        setNomProcedureSequence("getSeqParametreGlobal");
        setIdParametreGlobal(makePK());
        if(String.valueOf(nb).compareTo("") == 0)
            setNbEnregParPage(0);
        else
            setNbEnregParPage(Utilitaire.stringToInt(nb));
    }

    public String getTuppleID()
    {
        return String.valueOf(idParametreGlobal);
    }

    public String getAttributIDName()
    {
        return "idParametreGlobal";
    }

    public void setIdParametreGlobal(String idParametreGlobal)
    {
        this.idParametreGlobal = idParametreGlobal;
    }

    public String getIdParametreGlobal()
    {
        return idParametreGlobal;
    }

    public void setNbEnregParPage(int nbEnregParPage)
    {
        this.nbEnregParPage = nbEnregParPage;
    }

    public int getNbEnregParPage()
    {
        return nbEnregParPage;
    }

    public String idParametreGlobal;
    public int nbEnregParPage;
}
