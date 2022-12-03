/***********************************************************************
 * Module:  Vendeur.java
 * Author:  said
 * Purpose: Defines the Class Vendeur
 ***********************************************************************/
package ventegazety;

import bean.*;
import java.sql.Connection;


public class Vendeur extends ClassMAPTable{
  public Vendeur(){
  super.setNomTable("vendeur");
  }
  public void construirePK(Connection c) throws Exception
 {
   super.setNomTable("vendeur");
   this.preparePk("VEN","getSeqVend");
   //this.preparePk("VED","getSeqVend"); //ankorondrano
   this.setId(makePK(c));
  }
  public void controler(Connection c) throws Exception
 {

 }
 public static Vendeur getDetailVendeur(String matricule)throws Exception{
  try{
    Vendeur v = new Vendeur();
    v.setNomTable("VENDEURLIB");
    Vendeur[] list = (Vendeur[])CGenUtil.rechercher(v,null,null," and upper(nummatricule) = upper('"+matricule+"')");
  return list[0];
  }catch(Exception ex){
    throw new Exception(ex.getMessage());
  }
  }
  public Vendeur(String nom, String prenom, String surnom, String type, String place, String taux) throws Exception
  {
    super.setNomTable("vendeur");
   this.preparePk("VEN","getSeqVend");
   this.setId(makePK());
   setNom(nom);
   setPrenom(prenom);
   setSurnom(surnom);
   setType(type);
   setIdplace(place);
   setTaux(utilitaire.Utilitaire.stringToDouble(taux));
 }
 public Vendeur(String nom, String prenom, String surnom, String type, String place, String taux, Connection c) throws Exception
  {
   super.setNomTable("vendeur");
   this.preparePk("VEN","getSeqVend");
   setNom(nom);
   setPrenom(prenom);
   setSurnom(surnom);
   setType(type);
   setIdplace(place);
   setTaux(utilitaire.Utilitaire.stringToDouble(taux));
   if(c==null)
   {
     c= new utilitaire.UtilDB().GetConn();
   }
   this.setId(makePK(c));
  }
   String id;
   private String nom;
   private String prenom;
   private String surnom;
  private String type;
  private double taux;
  private String idplace;
  private  java.sql.Date dateembauche;
  private String etat;
  private String grossiste;
  private  String datesortie;
  private String nummatricule;

  public String getAttributIDName() {
   return "id";
 }
 public String getTuppleID() {
   return id;
  }
  public double getTaux() {
    return taux;
  }
  public void setTaux(double taux)throws Exception {
    if((taux<=0 || taux>1)&&(this.getMode().compareToIgnoreCase("insert")==0))throw new Exception("taux non valide");
    this.taux = taux;
  }
  public String getNom() {
    return nom;
  }
  public void setNom(String nom) throws Exception{
  if (getMode().compareToIgnoreCase("modif") == 0) {
            if (nom != null && nom.compareToIgnoreCase("") != 0) {
                this.nom = nom;
                return;
            } else {
                throw new Exception("Nom invalide");
            }
        }
    this.nom = nom;
  }
  public String getPrenom() {
    return prenom;
  }
  public void setPrenom(String prenom) {
    this.prenom = prenom;
  }
  public String getSurnom() {
    return surnom;
  }
  public void setSurnom(String surnom) {
    this.surnom = surnom;
  }
  public String getId() {
   return id;
 }
 public void setId(String id) {
   this.id = id;
  }
  public void setType(String type) {
    this.type = type;
  }
  public String getType() {
    return type;
  }
  public void setIdplace(String idplace) {
    this.idplace = idplace;
  }
  public String getIdplace() {
    return idplace;
  }
  public void setDateembauche(java.sql.Date dateembauche){
    this.dateembauche = dateembauche;
  }
  public java.sql.Date getDateembauche() {
    return dateembauche;
  }
  public void setDatesortie(String datesortie){
    this.datesortie = datesortie;
  }
  public String getDatesortie() {
    return datesortie;
  }
  public void setEtat(String etat) {
   this.etat = etat;
 }
 public String getEtat() {
   return etat;
  }
  public void setNummatricule(String nummatricule) {
    this.nummatricule = nummatricule;
  }
  public String getNummatricule() {
    return nummatricule;
  }
  public String getGrossiste() {
    return grossiste;
  }
  public void setGrossiste(String grossiste) {
    this.grossiste = grossiste;
  }
}