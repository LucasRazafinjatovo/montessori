package activa;

public class VisaDevisLibelle extends VisaDevis {

  private String nomclient;
  private String coderv;
  private String article;
  private String designation;
  private String nombreimpression;
  private double remise;
  private java.sql.Date datedevis;
  public VisaDevisLibelle() {
    super.setNomTable("demandevisa");
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
  public void setNombreimpression(String nombreimpression) {
    this.nombreimpression = nombreimpression;
  }
  public String getNombreimpression() {
    return nombreimpression;
  }
  public void setDatedevis(java.sql.Date datedevis) {
    this.datedevis = datedevis;
  }
  public java.sql.Date getDatedevis() {
    return datedevis;
  }
  public void setRemise(double remise) {
    this.remise = remise;
  }
  public double getRemise() {
    return remise;
  }
}