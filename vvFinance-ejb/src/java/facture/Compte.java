// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   Compte.java

package facture;

import bean.ClassMAPTable;
import java.sql.Date;
import utilitaire.Utilitaire;

public class Compte extends ClassMAPTable
{
  public Compte()
  {
    setNomTable("Compte");
  }
    public Compte(String i, String va, String des, Date datyDebutV)
    {
        super.setNomTable("Compte");
        setId(i);
        setVal(va);
        setDesce(des);
        setDatyDebutValid(datyDebutV);
    }
    public Compte(String client)
    {
      setId("");
      setVal("44");
      setDesce(client);
    }
    public Compte(String va, String des, Date datyDebutV)
    {
        super.setNomTable("Compte");
        setIndicePk("CM");
        setNomProcedureSequence("getSeqCompte");
        setId(makePK());
        if(va.length() < 4)
        {
            int maxSeq = Utilitaire.getMaxSeq("getSeqCompteComptable");
            String nombre = Utilitaire.completerInt(2, maxSeq);
            setVal("41".concat(String.valueOf(String.valueOf(nombre))));
        }
        else setVal(va);
        setDesce(des);
        setDatyDebutValid(datyDebutV);
    }

    public String getAttributIDName()
    {
        return "id";
    }

    public String getTuppleID()
    {
        return getId();
    }

    public void setId(String i)
    {
        id = i;
    }

    public String getId()
    {
        return id;
    }

    public void setVal(String va)
    {
        val = va;
    }

    public String getVal()
    {
        return val;
    }

    public void setDesce(String des)
    {
        desce = des;
    }

    public String getDesce()
    {
        return desce;
    }

    public void setDatyDebutValid(Date datyDebutV)
    {
        datyDebutValid = datyDebutV;
    }

    public Date getDatyDebutValid()
    {
        return datyDebutValid;
    }

    public String id;
    public String val;
    public String desce;
    public Date datyDebutValid;
}
