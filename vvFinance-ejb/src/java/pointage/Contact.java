package pointage;
import java.sql.Connection;
import bean.*;


public class Contact extends ClassMAPTable {

  private String id;
  private String nom;
  private String prenom;
  private String tel1;
  private String tel2;
  private String mail;
  private String adresse;
  private java.sql.Date naissance;
  private String typecontact;
  public Contact() {
    setNomTable("contact");
  }
  public void construirePK(Connection c) throws Exception{
    super.setNomTable("contact");
    this.preparePk("CT","getSeqContact");
    this.setId(makePK(c));
  }
  public String getAttributIDName() {
    return "id";
  }
  public String getTuppleID() {
    return id;
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
  public void setPrenom(String prenom) {
    this.prenom = prenom;
  }
  public String getPrenom() {
    return prenom;
  }
  public void setTel1(String tel1) {
    this.tel1 = tel1;
  }
  public String getTel1() {
    return tel1;
  }
  public void setTel2(String tel2) {
    this.tel2 = tel2;
  }
  public String getTel2() {
    return tel2;
  }
  public void setMail(String mail) {
    this.mail = mail;
  }
  public String getMail() {
    return mail;
  }
  public void setAdresse(String adresse) {
    this.adresse = adresse;
  }
  public String getAdresse() {
    return adresse;
  }
  public void setNaissance(java.sql.Date naissance) {
    this.naissance = naissance;
  }
  public java.sql.Date getNaissance() {
    return naissance;
  }
  public void setTypecontact(String typecontact) {
    this.typecontact = typecontact;
  }
  public String getTypecontact() {
    return typecontact;
  }
}