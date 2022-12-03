// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   Caisse.java

package finance;

import bean.*;

public class Caisse extends ClassMAPTable
{

    public Caisse(String i, String descr, String res, String idEta)
    {
        super.setNomTable("Caisse");
        setIdCaisse(i);
        setDescCaisse(descr);
        setRespCaisse(res);
        setIdEtatCaisse(idEta);
    }

    public Caisse()
    {
        this.setNomTable("Caisse");
    }

    public Caisse(String i)
    {
        super.setNomTable("Caisse");
        idCaisse = i;
    }

    public Caisse(String descr, String res, String idEta)
    {
        super.setNomTable("Caisse");
        setIndicePk("CE");
        setNomProcedureSequence("getSeqCaisse");
        setIdCaisse(makePK());
        if(descr.compareTo("") == 0 || descr == null)
            setDescCaisse("-");
        else
            setDescCaisse(descr);
        if(res.compareTo("") == 0 || res == null)
            setRespCaisse("-");
        else
            setRespCaisse(res);
        if(idEta.compareTo("") == 0 || idEta == null)
            setIdEtatCaisse("etaCs2");
        else
            setIdEtatCaisse(idEta);
    }

    public String getAttributIDName()
    {
        return "idCaisse";
    }

    public String getTuppleID()
    {
        return String.valueOf(idCaisse);
    }

    public void setIdCaisse(String idCaisse)
    {
        this.idCaisse = idCaisse;
    }

    public String getIdCaisse()
    {
        return idCaisse;
    }

    public void setDescCaisse(String descCaisse)
    {
        if(descCaisse.compareTo("") == 0 || descCaisse == null)
            this.descCaisse = "-";
        else
            this.descCaisse = descCaisse;
    }

    public String getDescCaisse()
    {
        return descCaisse;
    }

    public void setRespCaisse(String respCaisse)
    {
        if(respCaisse.compareTo("") == 0 || respCaisse == null)
            this.respCaisse = "-";
        else
            this.respCaisse = respCaisse;
    }

    public String getRespCaisse()
    {
        return respCaisse;
    }

    public void setIdEtatCaisse(String idEtatCaisse)
    {
        this.idEtatCaisse = idEtatCaisse;
    }

    public String getIdEtatCaisse()
    {
        return idEtatCaisse;
    }

    public TypeObjet getInfoComptable()
    {
        TypeObjetUtil tu = new TypeObjetUtil();
        tu.setNomTable("Compte");
        return (TypeObjet)tu.rechercher(2, getTuppleID())[0];
    }
  public void setEtat(String etat) {
    this.etat = etat;
  }
  public String getEtat() {
    return etat;
  }

    public String idCaisse;
    public String descCaisse;
    public String respCaisse;
    public String idEtatCaisse;
  private String etat;
}
