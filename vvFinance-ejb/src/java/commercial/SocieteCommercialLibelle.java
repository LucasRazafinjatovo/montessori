package commercial;
import bean.ClassMAPTable;
import java.sql.Date;
public class SocieteCommercialLibelle extends ClassMAPTable {

  private String id;
  private Date daty;
  private String nom;
  private String produits;
  private String categorie;
  private String etat;
  private Date daterdv;
  private String adresse;
  private String telephone;
  private String mail;
  private String site;
  private String reseausociaux;
  private String persresponsable;
  private String contactpers;
  private String commercial;
  private String observation;
  private String idcomm;

  public SocieteCommercialLibelle(){
    this.setNomTable("SOCIETECOMMRESP");
  }

  public String getAttributIDName() {
    return "id";
  }
  public String getTuppleID() {
    return id;
  }
  public String getAdresse() {
    return adresse;
  }
  public void setAdresse(String adresse) {
    this.adresse = adresse;
  }
  public void setCategorie(String categorie) {
    this.categorie = categorie;
  }
  public String getCategorie() {
    return categorie;
  }
  public String getId() {
    return id;
  }
  public String getMail() {
    return mail;
  }
  public String getNom() {
    return nom;
  }
  public String getProduits() {
    return produits;
  }
  public String getReseausociaux() {
    return reseausociaux;
  }
  public String getSite() {
    return site;
  }
  public String getTelephone() {
    return telephone;
  }
  public void setTelephone(String telephone) {
    this.telephone = telephone;
  }
  public void setSite(String site) {
    this.site = site;
  }
  public void setReseausociaux(String reseausociaux) {
    this.reseausociaux = reseausociaux;
  }
  public void setProduits(String produits) {
    this.produits = produits;
  }
  public void setNom(String nom) {
    this.nom = nom;
  }
  public void setMail(String mail) {
    this.mail = mail;
  }
  public void setId(String id) {
    this.id = id;
  }
  public String getCommercial() {
    return commercial;
  }
  public String getContactpers() {
    return contactpers;
  }
  public Date getDaty() {
    return daty;
  }
  public void setDaty(Date daty) {
    this.daty = daty;
  }
  public void setContactpers(String contactpers) {
    this.contactpers = contactpers;
  }
  public void setCommercial(String commercial) {
    this.commercial = commercial;
  }
  public String getObservation() {
    return observation;
  }
  public String getPersresponsable() {
    return persresponsable;
  }
  public void setPersresponsable(String persresponsable) {
    this.persresponsable = persresponsable;
  }
  public void setObservation(String observation) {
    this.observation = observation;
  }
  public String getEtat() {
    return etat;
  }
  public void setEtat(String etat) {
    this.etat = etat;
  }
  public Date getDaterdv() {
    return daterdv;
  }
  public void setDaterdv(Date daterdv) {
    this.daterdv = daterdv;
  }
  public String getIdcomm() {
    return idcomm;
  }
  public void setIdcomm(String idcomm) {
    this.idcomm = idcomm;
  }

}
