/***********************************************************************
 * Module:  Invendu.java
 * Author:  said
 * Purpose: Defines the Class Invendu
 ***********************************************************************/
package ventegazety;

import bean.*;
import java.sql.Connection;


public class EtatComparaisonPoidsInvendu extends ClassMAPTable{
  public EtatComparaisonPoidsInvendu(){
    super.setNomTable("INVENDUTHEORIQUEETFACTURE");
  }


  public String getAttributIDName() {
     return "";
   }
  public String getTuppleID() {
     return "";
  }
  public java.sql.Date getDaty() {
    return daty;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public double getDiference() {
    return diference;
  }
  public double getFacture() {
    return facture;
  }
  public double getTheorique() {
    return theorique;
  }
  public void setTheorique(double theorique) {
    this.theorique = theorique;
  }
  public void setFacture(double facture) {
    this.facture = facture;
  }
  public void setDiference(double diference) {
    this.diference = this.getTheorique() - this.getFacture();
  }
 private java.sql.Date daty;
 private double theorique;
  private double facture;
  private double diference;



}