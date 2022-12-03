package ventegazety;

import bean.*;

public class InvenduLibelle extends ClassMAPTable{

  private String id;
  private String journal;
  private String nom;
  private String parution;
  private int nombreinvendu;
  private java.sql.Date daty;
  private String remarque;
  private String place;
  private String province;
  public InvenduLibelle() {
    setNomTable("INVENDULIB");
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
}

