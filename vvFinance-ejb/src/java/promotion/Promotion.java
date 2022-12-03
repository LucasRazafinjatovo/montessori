package promotion;

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

public class Promotion extends ClassMAPTable{

  private String id;
  private String nom;
  private java.sql.Date dateEntree;
  private String remarque;
  public Promotion() {
    super.setNomTable("promotion");
  }
  public String getTuppleID(){
  return id;
}
public String getAttributIDName(){
  return "id";
}
public void construirePK(Connection c) throws Exception{
 super.setNomTable("promotion");
 this.preparePk("PROMO","getSeqPromotion");
 this.setId(makePK(c));
  }
  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public void setNom(String nom) throws Exception{
 //   if(nom.compareToIgnoreCase("")==0) throw new Exception("Nom de promotion vide");
    this.nom = nom;
  }
  public String getNom() {
    return nom;
  }
  public void setDateEntree(java.sql.Date dateEntree) {
    this.dateEntree = dateEntree;
  }
  public java.sql.Date getDateEntree() {
    return dateEntree;
  }
  public void setRemarque(String remarque) {
    this.remarque = remarque;
  }
  public String getRemarque() {
    return remarque;
  }
}