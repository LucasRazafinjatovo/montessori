// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   FactMere.java

package facture;

import bean.ClassMAPTable;
import bean.GenUtil;
import java.io.PrintStream;
import java.sql.Date;
import utilitaire.Utilitaire;

// Referenced classes of package facture:
//            FactureFilleUtil, SCatServiceUtil, SCatService, TvaUtil,
//            Tva, ClientUtil, Client, ChangeUtil,
//            Change, EtatFacture, EtatFactureUtil, FactureFille

public class FactureMereProforma extends ClassMAPTable
{

    public FactureMereProforma()
   {
       super.setNomTable("FactureMereProforma");
    }

    public String getTuppleID()
    {
        return String.valueOf(idFactureMere);
    }

    public String getAttributIDName()
    {
        return "idFactureMere";
    }

   public void setIdFactureMere(String idFactureMere)
    {
        this.idFactureMere = idFactureMere;
    }

    public String getIdFactureMere()
    {
        return idFactureMere;
    }

    public void setPeriodeDebut(Date periodeDebut)
    {
        if(String.valueOf(periodeDebut).compareTo("") == 0 || periodeDebut == null)
            this.periodeDebut = Utilitaire.dateDuJourSql();
        else
            this.periodeDebut = periodeDebut;
    }

    public Date getPeriodeDebut()
    {
        return periodeDebut;
    }

    public void setPeriodeFin(Date periodeFin)
    {
        if(String.valueOf(periodeFin).compareTo("") == 0 || periodeFin == null)
            this.periodeFin = Utilitaire.dateDuJourSql();
        else
            this.periodeFin = periodeFin;
    }

    public Date getPeriodeFin()
    {
        return periodeFin;
    }

    public void setIdClient(String idClient)
    {
        this.idClient = idClient;
    }

    public String getIdClient()
    {
        return idClient;
    }

    public void setNoteexplicative(String noteexplicative)
    {
        if(noteexplicative.compareTo("") == 0 || noteexplicative == null)
            this.noteexplicative = "-";
        else
            this.noteexplicative = noteexplicative;
    }

    public String getNoteexplicative()
    {
        return noteexplicative;
    }

    public void setIdTva(int idTva)
    {
        this.idTva = idTva;
    }

    public int getIdTva()
    {
        return idTva;
    }

    public void setIdFactureEn(String idFactureEn)
    {
        this.idFactureEn = idFactureEn;
    }

    public String getIdFactureEn()
    {
        return idFactureEn;
    }

    public void setIdDeviseEn(String idDeviseEn)
    {
        this.idDeviseEn = idDeviseEn;
    }

    public String getIdDeviseEn()
    {
        return idDeviseEn;
    }

    public void setReduction(int reduction)
    {
        if(String.valueOf(reduction).compareTo("") == 0)
            this.reduction = 0;
        else
            this.reduction = reduction;
    }

    public int getReduction()
    {
        return reduction;
    }

    public void setIdCoursChange(double idCoursChange)
    {
        this.idCoursChange = idCoursChange;
    }

    public double getIdCoursChange()
    {
        return idCoursChange;
    }

    public void setIdEtat(String idEtat)
    {
        this.idEtat = idEtat;
    }

    public String getIdEtat()
    {
        return idEtat;
    }

    public void setDateLimitePaiement(Date dateLimitePaiement)
    {
        if(String.valueOf(dateLimitePaiement).compareTo("") == 0 || dateLimitePaiement == null)
            this.dateLimitePaiement = Utilitaire.dateDuJourSql();
        else
            this.dateLimitePaiement = dateLimitePaiement;
    }

    public Date getDateLimitePaiement()
    {
        return dateLimitePaiement;
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

    public void setMontantAPayer(double montantAPayer)
    {
        if(String.valueOf(montantAPayer).compareTo("") == 0)
            this.montantAPayer = 0.0D;
        else
            this.montantAPayer = montantAPayer;
    }

    public double getMontantAPayer()
    {
        return montantAPayer;
    }

    public void setIdscatservice(String idscatservice)
    {
        this.idscatservice = idscatservice;
    }

    public String getIdscatservice()
    {
        return idscatservice;
    }
    public Tva getTva()
    {
        return (Tva)(new TvaUtil()).rechercher(2, String.valueOf(getIdTva()))[0];
    }

    public Client getClient()
    {
        return (Client)(new ClientUtil()).rechercher(1, getIdClient())[0];
    }

    public Change getChange()
    {
        return (Change)(new ChangeUtil()).rechercher(2, String.valueOf(getIdCoursChange()))[0];
    }
   public void setIdTypePaiement(String idTypePaiement)
    {
        this.idTypePaiement = idTypePaiement;
    }

    public String getIdTypePaiement()
    {
        return idTypePaiement;
    }

    public String getResp()
    {
        return resp;
    }

    public void setResp(String resp)
    {
        this.resp = resp;
    }
  public void setEntite(String entite) {
    this.entite = entite;
  }
  public String getEntite() {
    return entite;
  }
  public void setParution(String parution) {
    this.parution = parution;
  }
  public String getParution() {
    return parution;
  }

    public String idFactureMere;
    public Date daty;
    public Date periodeDebut;
    public Date periodeFin;
    public String idClient;
    public String noteexplicative;
    public String idFactureEn;
    public String idDeviseEn;
    public int reduction;
    public String idEtat;
    public Date dateLimitePaiement;
    public String idscatservice;
    public double montantAPayer;
    public int idTva;
    public double idCoursChange;
    public String idTypePaiement;
    public String resp;
  public String entite;
  public String parution;
}
