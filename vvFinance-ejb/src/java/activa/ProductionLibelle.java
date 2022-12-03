package activa;

public class ProductionLibelle extends Production{
  private String nomclient;
  private String coderv;
  private String article;
  private String designation;
  private int nombreimpression;
  private java.sql.Date dateDevis;
  private java.sql.Date datelivraisoncmd;
  private String idDevis;
  private double nombre;
  public ProductionLibelle() {
    super.setNomTable("productionlibelle");
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
  public void setNombreimpression(int nombreimpression) {
    this.nombreimpression = nombreimpression;
  }
  public int getNombreimpression() {
    return nombreimpression;
  }
  public void setDateDevis(java.sql.Date dateDevis) {
    this.dateDevis = dateDevis;
  }
  public java.sql.Date getDateDevis() {
    return dateDevis;
  }
  public void setDatelivraisoncmd(java.sql.Date datelivraisoncmd) {
    this.datelivraisoncmd = datelivraisoncmd;
  }
  public java.sql.Date getDatelivraisoncmd() {
    return datelivraisoncmd;
  }
  public void setIdDevis(String idDevis) {
    this.idDevis = idDevis;
  }
  public String getIdDevis() {
    return idDevis;
  }
  public void setNombre(double nombre) {
    this.nombre = nombre;
  }
  public double getNombre() {
    return nombre;
  }
}