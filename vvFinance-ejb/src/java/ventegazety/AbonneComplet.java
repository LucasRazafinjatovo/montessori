package ventegazety;

import bean.*;
import java.sql.Connection;
import java.sql.Date;

public class AbonneComplet extends ClassMAPTable{

  private String id;
  private String idcivilite;
  private String nom;
  private String prenom;
  private Date datenaissance;
  private String cin;
  private String telephone;
  private  String adresse;
  private String idquartier;
  private String idsecteur;
  private String etat;

  public AbonneComplet(){
	super.setNomTable("abonne_vue");
  }
  public String getAttributIDName() {
   return "id";
 }
 public String getTuppleID() {
   return id;
  }

  public String getIdcivilite() {
   return idcivilite;
 }
 public void setIdcivilite(String idcivilite) {
   this.idcivilite = idcivilite;
  }
  public void setDatenaissance(Date datenaissance){
    this.datenaissance = datenaissance;
  }
  public Date getDatenaissance() {
    return datenaissance;
  }
  public String getCin() {
   return cin;
 }
 public void setCin(String cin) {
   this.cin = cin;
  }
  public String getTelephone() {
   return telephone;
 }
 public void setTelephone(String telephone) {
   this.telephone = telephone;
  }
  public String getAdresse() {
   return adresse;
 }
 public void setAdresse(String adresse) {
   this.adresse = adresse;
  }
  public String getIdquartier() {
   return idquartier;
 }
 public void setIdquartier(String idquartier) {
   this.idquartier = idquartier;
  }
  public String getEtat() {
    return etat;
  }
  public String getId() {
    return id;
  }
  public String getIdsecteur() {
    return idsecteur;
  }
  public String getNom() {
    return nom;
  }
  public String getPrenom() {
    return prenom;
  }
  public void setPrenom(String prenom) {
    this.prenom = prenom;
  }
  public void setNom(String nom) {
    this.nom = nom;
  }
  public void setIdsecteur(String idsecteur) {
    this.idsecteur = idsecteur;
  }
  public void setId(String id) {
    this.id = id;
  }
  public void setEtat(String etat) {
    this.etat = etat;
  }
}