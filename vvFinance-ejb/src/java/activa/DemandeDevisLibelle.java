package activa;

public class DemandeDevisLibelle extends DemandeDevis {
  private String nomclient;
  private String coderv;
  private String article;
  private double nombreimpression;
  private double prix;
  public DemandeDevisLibelle() {
    super.setNomTable("demandedevisarticleprix");
  }
  public String getNomclient() {
    return nomclient;
  }

  public void setNomclient(String nomclient){
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
  public void setNombreimpression(double nombreimpression) {
    this.nombreimpression = nombreimpression;
  }
  public double getNombreimpression() {
    return nombreimpression;
  }
  public void setPrix(double prix) {
    this.prix = prix;
  }
  public double getPrix() {
    return prix;
  }
}