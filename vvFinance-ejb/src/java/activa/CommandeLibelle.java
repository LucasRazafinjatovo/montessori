package activa;

public class CommandeLibelle extends Commande{

  private String nomclient;
  private String coderv;
  private String article;
  private String designation;
  private java.sql.Date dateDevis;
  private int nombreImpression;
  private double remise;
  private double nombre;
  public CommandeLibelle() {
    super.setNomTable("commandelibelle");
  }
  public String getNomclient() {
    return nomclient;
  }
  public void setNomclient(String nomclient) {
    this.nomclient = nomclient;
  }
  public void setCoderv(String coderv) {
    this.coderv = coderv;
  }
  public String getCoderv() {
    return coderv;
  }
  public void setArticle(String article) {
    this.article = article;
  }
  public String getArticle() {
    return article;
  }
  public void setDesignation(String designation) {
    this.designation = designation;
  }
  public String getDesignation() {
    return designation;
  }
  public void setNombreImpression(int nombreImpression) {
    this.nombreImpression = nombreImpression;
  }
  public int getNombreImpression() {
    return nombreImpression;
  }
  public void setDateDevis(java.sql.Date dateDevis) {
    this.dateDevis = dateDevis;
  }
  public java.sql.Date getDateDevis() {
    return dateDevis;
  }
  public void setRemise(double remise) {
    this.remise = remise;
  }
  public double getRemise() {
    return remise;
  }
  public void setNombre(double nombre) {
    this.nombre = nombre;
  }
  public double getNombre() {
    return nombre;
  }
}