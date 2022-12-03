package ventegazety;

import bean.*;
import java.sql.Connection;
import java.sql.Date;

public class Livraisonmultiple_abonne extends ClassMAPTable{

  private String id;
  private String civilite;
  private String nomvendeur;
  private String prenomvendeur;
  private java.sql.Date datenaissance;
  private String cin_abonne;
  private String telephone_abonne;
  private String adresse_abonne;
  private String quartier;
  private String secteur;
  private java.sql.Date datedebut_abonnement;
  private java.sql.Date datefin_abonnement;

  public Livraisonmultiple_abonne(){
	super.setNomTable("Livraisonmultiple_abonne");
  }
  public String getAttributIDName() {
   return "id";
 }
 public String getTuppleID() {
   return id;
  }

  public void setCivilite(String civilite) {
    this.civilite = civilite;
  }
  public String getCivilite() {
    return civilite;
  }
  public void setNomvendeur(String nomvendeur) {
    this.nomvendeur = nomvendeur;
  }
  public String getNomvendeur() {
    return nomvendeur;
  }
  public void setPrenomvendeur(String prenomvendeur) {
    this.prenomvendeur = prenomvendeur;
  }
  public String getPrenomvendeur() {
    return prenomvendeur;
  }
  public void setDatenaissance(java.sql.Date datenaissance) {
    this.datenaissance = datenaissance;
  }
  public java.sql.Date getDatenaissance() {
    return datenaissance;
  }
  public void setCin_abonne(String cin_abonne) {
    this.cin_abonne = cin_abonne;
  }
  public String getCin_abonne() {
    return cin_abonne;
  }
  public void setTelephone_abonne(String telephone_abonne) {
    this.telephone_abonne = telephone_abonne;
  }
  public String getTelephone_abonne() {
    return telephone_abonne;
  }
  public void setAdresse_abonne(String adresse_abonne) {
    this.adresse_abonne = adresse_abonne;
  }
  public String getAdresse_abonne() {
    return adresse_abonne;
  }
  public void setQuartier(String quartier) {
    this.quartier = quartier;
  }
  public String getQuartier() {
    return quartier;
  }
  public void setSecteur(String secteur) {
    this.secteur = secteur;
  }
  public String getSecteur() {
    return secteur;
  }
  public void setDatedebut_abonnement(java.sql.Date datedebut_abonnement) {
    this.datedebut_abonnement = datedebut_abonnement;
  }
  public java.sql.Date getDatedebut_abonnement() {
    return datedebut_abonnement;
  }
  public void setDatefin_abonnement(java.sql.Date datefin_abonnement) {
    this.datefin_abonnement = datefin_abonnement;
  }
  public java.sql.Date getDatefin_abonnement() {
    return datefin_abonnement;
  }
  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }


}