// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   AutorisationAnnulation.java

package facture;

import bean.ClassMAPTable;
import java.sql.Date;
import utilitaire.Utilitaire;
import bean.TypeObjet;
import java.sql.Connection;
import bean.TypeObjetUtil;
import utilitaire.UtilDB;

public class AutorisationAnnulation extends ClassMAPTable
{

    public AutorisationAnnulation(String i, String idFM, String resp, Date dat, String mot, String typ)
    {
        super.setNomTable("autorisationannulation");
        setIdAutorisation(i);
        setIdObjet(idFM);
        setDaty(dat);
        setMotif(mot);
        setResponsable(resp);
        setIdTypeObjet(typ);
    }

    public AutorisationAnnulation(String idFM, String resp, Date dat, String mot, String typ)
    {
        super.setNomTable("autorisationannulation");
        setIndicePk("AA");
        setNomProcedureSequence("getSeqAutorisation");
        setIdAutorisation(makePK());
        setIdObjet(idFM);
        setDaty(dat);
        setMotif(mot);
        setResponsable(resp);
        setIdTypeObjet(typ);
    }

    public String getAttributIDName()
    {
        return "idAutorisation";
    }

    public String getTuppleID()
    {
        return String.valueOf(idAutorisation);
    }

    public void setIdAutorisation(String idAutorisation)
    {
        this.idAutorisation = idAutorisation;
    }

    public String getIdAutorisation()
    {
        return idAutorisation;
    }

    public void setIdObjet(String idObjet)
    {
        if(idObjet.compareTo("") == 0 || idObjet == null)
            this.idObjet = "-";
        else
            this.idObjet = idObjet;
    }

    public String getIdObjet()
    {
        return idObjet;
    }

    public void setDaty(Date daty)
    {
        if(String.valueOf(daty).compareTo("") == 0 || daty == null)
            this.daty = Utilitaire.dateDuJourSql();
        else
            this.daty = daty;
    }

    public Date getDaty()
    {
        return daty;
    }

    public void setMotif(String motif)
    {
        if(motif.compareTo("") == 0 || motif == null)
            this.motif = "-";
        else
            this.motif = motif;
    }

    public String getMotif()
    {
        return motif;
    }

    public void setResponsable(String responsable)
    {
        if(responsable.compareTo("") == 0 || responsable == null)
            this.responsable = "-";
        else
            this.responsable = responsable;
    }

    public String getResponsable()
    {
        return responsable;
    }

    public void setIdTypeObjet(String idTypeObjet)
    {
        this.idTypeObjet = idTypeObjet;
    }

    public String getIdTypeObjet()
    {
        return idTypeObjet;
    }
    public TypeObjet getValidation(Connection c) throws Exception
    {
      TypeObjetUtil tou=new TypeObjetUtil();
      tou.setNomTable("VALIDATIONAA");
      TypeObjet[] ret=(TypeObjet[])tou.rechercher(2,this.getTuppleID());
      if (ret.length==0)return null;
      return ret[0];
    }
    public TypeObjet getValidation()throws Exception
    {
      Connection c=null;
      try {
        c=new UtilDB().GetConn();
        return getValidation(c);
      }
      catch (Exception ex) {
        throw new Exception(ex.getMessage()) ;
      }
      finally{
        if(c!=null)c.close();
    }
    }
    public String idAutorisation;
    public String idObjet;
    public Date daty;
    public String motif;
    public String responsable;
    public String idTypeObjet;
}
