package ventegazety;

import bean.*;

public class PrixjournalLibelle extends ClassMAPTable{

  private String id;
  private double prix;
  private String journal;
  private String nom;

  public PrixjournalLibelle() {
    this.setNomTable("PRIXJOURNALLIBELLE");
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
  public void setId(String id) {
    this.id = id;
  }
  public String getJournal() {
    return journal;
  }
  public void setJournal(String journal) {
    this.journal = journal;
  }
  public void setPrix(double prix) {
    this.prix = prix;
  }
  public double getPrix() {
    return prix;
  }
  public String getNom() {
    return nom;
  }
  public void setNom(String nom) {
    this.nom = nom;
  }
}