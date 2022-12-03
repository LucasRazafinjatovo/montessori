package crieur;

import bean.*;

public class Prisecrieurlib extends ClassMAPTable{

  private int numparution;
  private int nbreprise;
  private double prix;
  private String id;
  private String vendeur;
  private String grossiste;
  private java.sql.Date daty;
  private String journal;
  private String type;
  private String idplace;
  private String province;
  private String titre;
  private String matricule;
  public Prisecrieurlib() {
    super.setNomTable("Prisecrieurlib");
  }
  public String getAttributIDName() {
   return "id";
 }
 public String getTuppleID() {
   return id;
  }
  public int getNumparution() {
    return numparution;
  }
  public void setNumparution(int numparution) {
    this.numparution = numparution;
  }
  public void setNbreprise(int nbreprise) {
    this.nbreprise = nbreprise;
  }
  public int getNbreprise() {
    return nbreprise;
  }
  public void setPrix(double prix) {
    this.prix = prix;
  }
  public double getPrix() {
    return prix;
  }
  public void setId(String id) {
    this.id = id;
  }
  public String getId() {
    return id;
  }
  public void setVendeur(String vendeur) {
    this.vendeur = vendeur;
  }
  public String getVendeur() {
    return vendeur;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public java.sql.Date getDaty() {
    return daty;
  }
  public void setJournal(String journal) {
    this.journal = journal;
  }
  public String getJournal() {
    return journal;
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
  public void setProvince(String province) {
    this.province = province;
  }
  public String getProvince() {
    return province;
  }
  public void setTitre(String titre) {
    this.titre = titre;
  }
  public String getTitre() {
    return titre;
  }
  public void setMatricule(String matricule) {
    this.matricule = matricule;
  }
  public String getMatricule() {
    return matricule;
  }
  public String getGrossiste() {
    return grossiste;
  }
  public void setGrossiste(String grossiste) {
    this.grossiste = grossiste;
  }
}

