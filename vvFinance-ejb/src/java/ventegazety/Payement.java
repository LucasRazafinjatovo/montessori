/***********************************************************************
 * Module:  Vendeur.java
 * Author:  said
 * Purpose: Defines the Class Vendeur
 ***********************************************************************/
package ventegazety;

import bean.*;
import java.sql.Connection;
import java.sql.Date;


public class Payement extends ClassMAPTable{
  public Payement(){
  super.setNomTable("payement");
  }
  public Payement(String idPrise, String montant, String remarque, String daty) throws Exception
  {
    super.setNomTable("payement");
   this.preparePk("PAY","getSeqPayement");
   this.setId(makePK());
   setIdPrise(idPrise);
   setMontant(utilitaire.Utilitaire.stringToDouble(montant));
   setRemarque(remarque);
   setDaty(utilitaire.Utilitaire.string_date("dd/mm/yyyy",daty));
 }
 public Payement(String idPrise, String montant, String remarque, String daty, Connection c) throws Exception
  {
   super.setNomTable("payement");
   this.preparePk("PAY","getSeqPayement");
   setIdPrise(idPrise);
    setMontant(utilitaire.Utilitaire.stringToDouble(montant));
    setRemarque(remarque);
   setDaty(utilitaire.Utilitaire.string_date("dd/mm/yyyy",daty));
   if(c==null)
   {
     c= new utilitaire.UtilDB().GetConn();
   }
   this.setId(makePK(c));
  }
   private String id;
   private String idPrise;
  private String remarque;
  private double montant;
  private java.sql.Date daty;


  public String getAttributIDName() {
    return "id";
  }
 public String getTuppleID() {
    return id;
  }
  public double getMontant() {
    return montant;
  }
  public void setMontant(double montant) {
    this.montant = montant;
  }
  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public String getIdPrise() {
    return idPrise;
  }
  public void setIdPrise(String idPrise) {
    this.idPrise = idPrise;
  }
  public void setRemarque(String remarque) {
    this.remarque = remarque;
  }
  public String getRemarque() {
    return remarque;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public java.sql.Date getDaty() {
    return daty;
  }

}