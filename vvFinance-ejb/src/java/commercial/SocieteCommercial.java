package commercial;
import bean.ClassMAPTable;
import java.sql.Date;
import java.sql.Connection;
public class SocieteCommercial extends ClassMAPTable {

  private String id;
  private Date daty;
  private String nom;
  private String produits;
  private String categorie;
  private String adresse;
  private String telephone;
  private String mail;
  private String site;
  private String reseausociaux;

  public SocieteCommercial(){
    this.setNomTable("SOCIETECOMMERCIAL");
  }

  public void construirePK(Connection c) throws Exception
  {
      super.setNomTable("SOCIETECOMMERCIAL");
      this.preparePk("STE","getSeqSocieteComm");
      this.setId(makePK(c));
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
  public Date getDaty() {
    return daty;
  }
  public void setDaty(Date daty) {
    this.daty = daty;
  }

}
