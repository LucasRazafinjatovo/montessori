/***********************************************************************
 * Module:  VERIFICATION.java
 * Author:  lalaina
 * Created: mercredi 17 septembre 2008 04:49:23
 * Purpose: Defines the Class VERIFICATION
 ***********************************************************************/

package stock;

import java.sql.*;
import bean.ClassMAPTable;

public class Verification extends ClassMAPTable
{
   public java.lang.String id;
   public java.sql.Date daty;
   public java.lang.String mag;
   public double reste;
   public java.lang.String unite;
   public java.lang.String controleur;
   public java.lang.String remarque;

   public Verification(){

   }
   public Verification(String id, Date daty, String mag, double reste, String unite, String controleur, String remarque){
     super.setNomTable("Verification");
     setId(id);
     setDaty(daty);
     setMag(mag);
     setReste(reste);
     setUnite(unite);
     setControleur(controleur);
     setRemarque(remarque);
   }
   public Verification(Date daty, String mag, double reste, String unite, String controleur, String remarque){
     super.setNomTable("Verification");
     setIndicePk("PR");
    setNomProcedureSequence("getSeqParution");
    setId(makePK());
     setDaty(daty);
     setMag(mag);
     setReste(reste);
     setUnite(unite);
     setControleur(controleur);
     setRemarque(remarque);
   }
   public Verification(String daty, String mag, String reste, String unite, String controleur, String remarque){
    super.setNomTable("Verification");
    setIndicePk("VR");
   setNomProcedureSequence("getSeqVerification");
   setId(makePK());
    setDaty(utilitaire.Utilitaire.string_date("dd/MM/yyyy",daty));
    setMag(mag);
    setReste(utilitaire.Utilitaire.stringToDouble(reste));
    setUnite(unite);
    setControleur(controleur);
    setRemarque(remarque);
  }
  public Verification(String mag, String reste, String unite, String controleur, String remarque){
   super.setNomTable("Verification");
   setIndicePk("VR");
  setNomProcedureSequence("getSeqVerification");
  setId(makePK());
   daty = utilitaire.Utilitaire.dateDuJourSql();
   setMag(mag);
   setReste(utilitaire.Utilitaire.stringToDouble(reste));
   setUnite(unite);
   setControleur(controleur);
   setRemarque(remarque);
 }



   public String getTuppleID()
   {
     return id;
   }

  public String getAttributIDName()
  {
    return "id";
   }
  public String getControleur() {
    return controleur;
  }
  public java.sql.Date getDaty() {
    return daty;
  }
  public String getId() {
    return id;
  }
  public String getMag() {
    return mag;
  }
  public String getRemarque() {
    return remarque;
  }
  public double getReste() {
    return reste;
  }
  public String getUnite() {
    return unite;
  }
  public void setControleur(String controleur) {
    this.controleur = controleur;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public void setId(String id) {
    this.id = id;
  }
  public void setMag(String mag) {
    this.mag = mag;
  }
  public void setRemarque(String remarque) {
    this.remarque = remarque;
  }
  public void setReste(double reste) {
    this.reste = reste;
  }
  public void setUnite(String unite) {
    this.unite = unite;
  }

}

