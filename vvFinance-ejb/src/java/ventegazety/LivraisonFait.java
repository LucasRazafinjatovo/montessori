package ventegazety;

import bean.*;
import java.sql.Date;
import java.sql.Connection;

public class LivraisonFait extends ClassMAPTable{

  private String id;
  private String coursier;
  private Date datelivraison;
  private String vendeur;
  private String quartier;
  private String secteur;
  private Date datedebut;
  private Date datefin;

  public LivraisonFait(){
    this.setNomTable("livraison_fait");
  }

  public String getAttributIDName() {
   return "id";
 }
 public String getTuppleID() {
   return id;
  }
  public Date getDatelivraison() {
    return datelivraison;
  }
  public String getId() {
    return id;
  }

  public void setId(String id) {
    this.id = id;
  }
  public void setDatelivraison(Date datelivraison) {
    this.datelivraison = datelivraison;
  }
  public String getCoursier() {
    return coursier;
  }
  public Date getDatedebut() {
    return datedebut;
  }
  public Date getDatefin() {
    return datefin;
  }
  public String getQuartier() {
    return quartier;
  }
  public String getSecteur() {
    return secteur;
  }
  public String getVendeur() {
    return vendeur;
  }
  public void setCoursier(String coursier) {
    this.coursier = coursier;
  }
  public void setDatedebut(Date datedebut) {
    this.datedebut = datedebut;
  }
  public void setDatefin(Date datefin) {
    this.datefin = datefin;
  }
  public void setQuartier(String quartier) {
    this.quartier = quartier;
  }
  public void setSecteur(String secteur) {
    this.secteur = secteur;
  }
  public void setVendeur(String vendeur) {
    this.vendeur = vendeur;
  }

}

