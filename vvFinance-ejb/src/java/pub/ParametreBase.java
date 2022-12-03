package pub;
import bean.ClassMAPTable;
import java.sql.Connection;
/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class ParametreBase extends ClassMAPTable{

  private String id;
  private double hauteur;
  private double largeur;
  private double poids;
  private double marge;
  private java.sql.Date dateEffectivite;
  public ParametreBase() {
    super.setNomTable("parametrepaier");
  }
  public String getTuppleID(){
 return id;
}
public String getAttributIDName(){
  return "id";
}

public void construirePK(Connection c) throws Exception{
  super.setNomTable("parametrepaier");
  this.preparePk("PRMT","getSeqParametreBase");
  this.setId(makePK(c));
 }
  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public void setHauteur(double hauteur) {
    this.hauteur = hauteur;
  }
  public double getHauteur() {
    return hauteur;
  }
  public void setLargeur(double largeur) {
    this.largeur = largeur;
  }
  public double getLargeur() {
    return largeur;
  }
  public void setPoids(double poids) {
    this.poids = poids;
  }
  public double getPoids() {
    return poids;
  }
  public void setMarge(double marge) {
    this.marge = marge;
  }
  public double getMarge() {
    return marge;
  }
  public void setDateEffectivite(java.sql.Date dateEffectivite) {
    this.dateEffectivite = dateEffectivite;
  }
  public java.sql.Date getDateEffectivite() {
    return dateEffectivite;
  }
}