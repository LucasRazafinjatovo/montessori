package activa;
import bean.*;
import java.util.*;
import java.sql.Connection;

public class GestionPrix extends ClassMAPTable{
  private String idGestion;
  private String idArticle;
  private double prix;
  private java.sql.Date daty;
  public GestionPrix() {
    super.setNomTable("gestionprix");
  }
  public String getIdGestion() {
    return idGestion;
  }
  public void construirePK(Connection c) throws Exception{
    super.setNomTable("gestionprix");
    this.preparePk("GEST","getSeqGestionPrix");
    this.setIdGestion(makePK(c));
  }

  public String getAttributIDName() {
    return "idGestion";
  }
  public String getTuppleID() {
    return idGestion;
  }
  public void setIdGestion(String idGestion) {
    this.idGestion = idGestion;
  }
  public void setIdArticle(String idArticle) {
    this.idArticle = idArticle;
  }
  public String getIdArticle() {
    return idArticle;
  }
  public void setPrix(double prix) {
    this.prix = prix;
  }
  public double getPrix() {
    return prix;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public java.sql.Date getDaty() {
    return daty;
  }
}