package finance;

import bean.*;


/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class Report extends ClassMAPTable {

  public String id;
  public java.sql.Date daty;
  public double montant;
  public String devise;
  public String caisse;
  public Report() {
    this.setNomTable("report");
  }
  public Report(java.sql.Date dt,String mt,String dev,String css)
  {
    this.setNomTable("report");
    this.setIndicePk("REP");
    this.setNomProcedureSequence("getseqReport");
    this.setId(this.makePK());
    this.setDaty(dt);
    this.setMontant(utilitaire.Utilitaire.stringToDouble(mt));
    this.setDevise(dev);
    this.setCaisse(css);
  }
    public Report(String dt,String mt,String dev,String css)
   {
     this.setNomTable("report");
     this.setIndicePk("REP");
     this.setNomProcedureSequence("getseqReport");
     this.setId(this.makePK());
     this.setDaty(utilitaire.Utilitaire.string_date("dd/MM/yyyy",dt));
     this.setMontant(utilitaire.Utilitaire.stringToDouble(mt));
     this.setDevise(dev);
     this.setCaisse(css);

  }
  public String getAttributIDName() {
    return "id";
  }
  public String getTuppleID() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public String getId() {
    return id;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public java.sql.Date getDaty() {
    return daty;
  }
  public void setMontant(double montant) {
    this.montant = montant;
  }
  public double getMontant() {
    return montant;
  }
  public void setDevise(String devise) {
    this.devise = devise;
  }
  public String getDevise() {
    return devise;
  }
  public void setCaisse(String caisse) {
    this.caisse = caisse;
  }
  public String getCaisse() {
    return caisse;
  }
}