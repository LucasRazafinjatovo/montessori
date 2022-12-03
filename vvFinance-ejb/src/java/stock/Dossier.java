/***********************************************************************
 * Module:  DOSSIER.java
 * Author:  lalaina
 * Created: mercredi 17 septembre 2008 04:49:23
 * Purpose: Defines the Class DOSSIER
 ***********************************************************************/

package stock;

import java.sql.*;
import bean.ClassMAPTable;

public class Dossier extends ClassMAPTable
{
   public java.lang.String id;
   public java.lang.String mvtStock;
   public java.lang.String typeDossier;
   public java.lang.String designation;
   public java.lang.String numero;
   public java.sql.Date daty;
   public java.lang.String tiers;
   public double qtetot;
   public double monttot;
   public java.lang.String remarque;

   public Dossier(){

   }
   public Dossier(String id, String mvtStock, String typeD, String design, String num, Date daty, String tiers, double qte, double mont, String rmq){
     super.setNomTable("Dossier");
     setId(id);
     setMvtStock(mvtStock);
     setTypeDossier(typeD);
     setDesignation(design);
     setNumero(num);
     setDaty(daty);
     setTiers(tiers);
     setQtetot(qte);
     setMonttot(mont);
     setRemarque(rmq);

   }
   public Dossier(String mvtStock, String typeD, String design, String num, Date daty, String tiers, double qte, double mont, String rmq){
    super.setNomTable("Dossier");
    setIndicePk("DS");
    setNomProcedureSequence("getSeqDossier");
    setId(makePK());
    setMvtStock(mvtStock);
    setTypeDossier(typeD);
    setDesignation(design);
    setNumero(num);
    setDaty(daty);
    setTiers(tiers);
    setQtetot(qte);
    setMonttot(mont);
    setRemarque(rmq);

   }
   public Dossier(String mvtStock, String typeD, String design, String num, String daty, String tiers, String qte, String mont, String rmq){
   super.setNomTable("Dossier");
   setIndicePk("DS");
   setNomProcedureSequence("getSeqDossier");
   setId(makePK());
   setMvtStock(mvtStock);
   setTypeDossier(typeD);
   setDesignation(design);
   setNumero(num);
   setDaty(utilitaire.Utilitaire.string_date("dd/MM/yyyy",daty));
   setTiers(tiers);
   setQtetot(utilitaire.Utilitaire.stringToDouble(qte));
   setMonttot(utilitaire.Utilitaire.stringToDouble(mont));
   setRemarque(rmq);

   }
  public java.sql.Date getDaty() {
    return daty;
  }
  public String getDesignation() {
    return designation;
  }
  public String getId() {
    return id;
  }
  public double getMonttot() {
    return monttot;
  }
  public String getNumero() {
    return numero;
  }
  public double getQtetot() {
    return qtetot;
  }
  public String getRemarque() {
    return remarque;
  }
  public String getTiers() {
    return tiers;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public void setDesignation(String designation) {
    this.designation = designation;
  }
  public void setId(String id) {
    this.id = id;
  }
  public void setMonttot(double monttot) {
    this.monttot = monttot;
  }
  public void setNumero(String numero) {
    this.numero = numero;
  }
  public void setQtetot(double qtetot) {
    this.qtetot = qtetot;
  }
  public void setRemarque(String remarque) {
    this.remarque = remarque;
  }
  public void setTiers(String tiers) {
    this.tiers = tiers;
  }
  public String getTuppleID()
{
    return id;
}

public String getAttributIDName()
{
    return "id";
   }
  public String getMvtStock() {
    return mvtStock;
  }
  public void setMvtStock(String mvtStock) {
    this.mvtStock = mvtStock;
  }
  public String getTypeDossier() {
    return typeDossier;
  }
  public void setTypeDossier(String typeDossier) {
    this.typeDossier = typeDossier;
  }

}

