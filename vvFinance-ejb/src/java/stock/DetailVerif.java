/***********************************************************************
 * Module:  DETAILVERIF.java
 * Author:  lalaina
 * Created: mercredi 17 septembre 2008 04:49:23
 * Purpose: Defines the Class DETAILVERIF
 ***********************************************************************/

package stock;

import java.sql.*;
import bean.ClassMAPTable;

public class DetailVerif extends ClassMAPTable
{
   public java.lang.String id;
   public java.lang.String bobinenum;
   public double pourcentagereste;
   public java.lang.String verification;
   public java.lang.String remarque;

   public DetailVerif(){

   }
   public DetailVerif(String id, String bobinenum, double pourcentage, String verif, String rmq){
     super.setNomTable("DetailVerif");
     setId(id);
     setBobinenum(bobinenum);
     setPourcentagereste(pourcentage);
     setVerification(verif);
     setRemarque(rmq);
   }
   public DetailVerif(String bobinenum, double pourcentage, String verif, String rmq){
    super.setNomTable("DetailVerif");
    setIndicePk("DB");
    setNomProcedureSequence("getSeqDetailVerif");
    setId(makePK());
    setBobinenum(bobinenum);
    setPourcentagereste(pourcentage);
    setVerification(verif);
    setRemarque(rmq);
   }
   public DetailVerif(String bobinenum, String pourcentage, String verif, String rmq){
      super.setNomTable("DetailVerif");
      setIndicePk("DV");
      setNomProcedureSequence("getSeqDetailVerif");
      setId(makePK());
      setBobinenum(bobinenum);
      setPourcentagereste(utilitaire.Utilitaire.stringToDouble(pourcentage));
      setVerification(verif);
      setRemarque(rmq);
   }
   public String getTuppleID()
 {
     return id;
 }

 public String getAttributIDName()
 {
     return "id";
   }
  public String getBobinenum() {
    return bobinenum;
  }
  public String getId() {
    return id;
  }
  public double getPourcentagereste() {
    return pourcentagereste;
  }
  public String getRemarque() {
    return remarque;
  }
  public String getVerification() {
    return verification;
  }
  public void setBobinenum(String bobinenum) {
    this.bobinenum = bobinenum;
  }
  public void setId(String id) {
    this.id = id;
  }
  public void setPourcentagereste(double pourcentagereste) {
    this.pourcentagereste = pourcentagereste;
  }
  public void setRemarque(String remarque) {
    this.remarque = remarque;
  }
  public void setVerification(String verification) {
    this.verification = verification;
  }

}




