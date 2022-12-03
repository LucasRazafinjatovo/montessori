/***********************************************************************
 * Module:  MVTSTOCK.java
 * Author:  lalaina
 * Created: mercredi 17 septembre 2008 04:49:23
 * Purpose: Defines the Class MVTSTOCK
 ***********************************************************************/

package stock;

import java.sql.*;
import bean.ClassMAPTable;

public class MvtCompte extends ClassMAPTable
{
   public java.lang.String id;
   public java.sql.Date daty;
   public java.lang.String designation;
   public java.lang.String typeMvt;
   public double debit = 0;
   public double credit = 0;
   public java.lang.String compte;
   public java.lang.String uniteMvt;
   public java.lang.String remarque;
   public java.lang.String val;
   public java.lang.String desce;


   public MvtCompte(){

   }
   public MvtCompte(String id, Date daty, String design, String typeM, double debit, double credit, String compte, String uniteM, String rmq, String val, String desce){
     super.setNomTable("MvtCompte");
     setId(id);
     setDaty(daty);
     setDesignation(design);
     setTypeMvt(typeM);
     setDebit(debit);
     setCredit(credit);
     setCompte(compte);
     setUniteMvt(uniteM);
     setRemarque(rmq);
     setVal(val);
     setDesce(desce);
   }

  public String getCompte() {
    return compte;
  }
  public double getCredit() {
    return credit;
  }
  public java.sql.Date getDaty() {
    return daty;
  }
  public double getDebit() {
    return debit;
  }
  public String getDesignation() {
    return designation;
  }
  public String getId() {
    return id;
  }
  public String getRemarque() {
    return remarque;
  }
  public String getUniteMvt() {
    return uniteMvt;
  }
  public String getTypeMvt() {
    return typeMvt;
  }
  public void setCompte(String compte) {
    this.compte = compte;
  }
  public void setCredit(double credit) {
    this.credit = credit;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public void setDebit(double debit) {
    this.debit = debit;
  }
  public void setDesignation(String designation) {
    this.designation = designation;
  }
  public void setId(String id) {
    this.id = id;
  }
  public void setRemarque(String remarque) {
    this.remarque = remarque;
  }
  public void setTypeMvt(String typeMvt) {
    this.typeMvt = typeMvt;
  }
  public void setUniteMvt(String uniteMvt) {
    this.uniteMvt = uniteMvt;
  }
  public String getTuppleID()
{
  return id;
}

public String getAttributIDName()
{
  return "id";
   }
  public String getVal() {
    return val;
  }
  public void setVal(String val) {
    this.val = val;
  }
  public String getDesce() {
    return desce;
  }
  public void setDesce(String desce) {
    this.desce = desce;
  }

}

