package crieur;

import bean.*;

public class InvenducLib extends ClassMAPTable{

  private String id;
  private String journal;
  private String nom;
  private String parution;
  private int nombreinvendu;
  private java.sql.Date daty;
  private String grossiste;
  private String remarque;
  private String place;
  private String type;
  private String province;
  private String matricule;
  public InvenducLib() {
    setNomTable("INVENDUCRTYPE");
  }
  public static double getAllSommeMontant(InvenducLib[] l){
                    double mont= 0; //6 colonne
                    for(int i=0; i<l.length; i++){
                      mont=mont+ l[i].getNombreinvendu();
                    }
                    return mont;
 }
  public String getAttributIDName() {
   return "id";
 }
 public String getTuppleID() {
   return id;
  }
  public String getNom() {
    return nom;
  }
  public void setNom(String nom) {
    this.nom = nom;
  }
  public void setJournal(String journal) {
    this.journal = journal;
  }
  public String getJournal() {
    return journal;
  }
  public void setParution(String parution) {
    this.parution = parution;
  }
  public String getParution() {
    return parution;
  }
  public void setId(String id) {
    this.id = id;
  }
  public String getId() {
    return id;
  }
  public void setType(String type) {
    this.type = type;
  }
  public String getType() {
    return type;
  }
  public void setNombreinvendu(int nombreinvendu) {
    this.nombreinvendu = nombreinvendu;
  }
  public int getNombreinvendu() {
    return nombreinvendu;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public java.sql.Date getDaty() {
    return daty;
  }
  public void setRemarque(String remarque) {
    this.remarque = remarque;
  }
  public String getRemarque() {
    return remarque;
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
  public String getGrossiste() {
    return grossiste;
  }
  public void setGrossiste(String grossiste) {
    this.grossiste = grossiste;
  }
  public void setMatricule(String matricule) {
    this.matricule = matricule;
  }
  public String getMatricule() {
    return matricule;
  }
}

