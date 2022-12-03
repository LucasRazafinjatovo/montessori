package ventegazety;

import bean.*;

public class RecetteLibelle extends ClassMAPTable{

  private double montant;
  private String id;
  private String nom;
  private String journal;
  private String numparution;
  private java.sql.Date daty;
  private String place;
  private String province;
  public RecetteLibelle() {
    super.setNomTable("RECETTELIBELLE");
  }
  public String getAttributIDName() {
   return "id";
 }
 public String getTuppleID() {
   return id;
  }
  public String getNumparution() {
    return numparution;
  }
  public void setNumparution(String numparution) {
    this.numparution = numparution;
  }
  public void setMontant(double montant) {
    this.montant = montant;
  }
  public double getMontant() {
    return montant;
  }
  public void setId(String id) {
    this.id = id;
  }
  public String getId() {
    return id;
  }
  public void setNom(String nom) {
    this.nom = nom;
  }
  public String getNom() {
    return nom;
  }
  public void setJournal(String journal) {
    this.journal = journal;
  }
  public String getJournal() {
    return journal;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public java.sql.Date getDaty() {
    return daty;
  }
  public void setPlace(String place) {
    this.place = place;
  }
  public String getPlace() {
    return place;
  }
  public void setProvince(String province) {
    this.province = province;
  }
  public String getProvince() {
    return province;
  }
}

