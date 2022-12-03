package ventegazety;

import bean.*;
import java.sql.Date;
import java.sql.Connection;

public class LivraisonLibelle extends ClassMAPTable{

  //info abonnee
  private String abonne;
  private String adresse;
  private String quartier;
  private String secteur;
  private String journal;
  private String id;
  private String idcoursier;
  private Date daty;

  public LivraisonLibelle(){
    this.setNomTable("livraison_libelle");
  }


  public String getAttributIDName() {
   return "id";
 }
 public String getTuppleID() {
   return id;
  }

  public String getId() {
    return id;
  }
  public String getIdcoursier() {
    return idcoursier;
  }
  public void setIdcoursier(String idcoursier) {
    this.idcoursier = idcoursier;
  }
  public void setId(String id) {
    this.id = id;
  }
  public String getAbonne() {
    return abonne;
  }
  public String getAdresse() {
    return adresse;
  }
  public Date getDaty() {
    return daty;
  }
  public String getJournal() {
    return journal;
  }
  public String getQuartier() {
    return quartier;
  }
  public String getSecteur() {
    return secteur;
  }
  public void setSecteur(String secteur) {
    this.secteur = secteur;
  }
  public void setQuartier(String quartier) {
    this.quartier = quartier;
  }
  public void setJournal(String journal) {
    this.journal = journal;
  }
  public void setDaty(Date daty) {
    this.daty = daty;
  }
  public void setAdresse(String adresse) {
    this.adresse = adresse;
  }
  public void setAbonne(String abonne) {
    this.abonne = abonne;
  }


}

