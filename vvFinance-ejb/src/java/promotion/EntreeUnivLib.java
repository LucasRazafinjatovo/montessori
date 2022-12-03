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

public class EntreeUnivLib extends ClassMAPTable{

  private String id;
  private String promotion;
  private String etudiant;
  private java.sql.Date daty;
  public EntreeUnivLib() {
    super.setNomTable("entreeunivlib");
  }
  public String getTuppleID(){
 return id;
}
public String getAttributIDName(){
 return "id";
}
  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public void setPromotion(String promotion) {
    this.promotion = promotion;
  }
  public String getPromotion() {
    return promotion;
  }
  public void setEtudiant(String etudiant) {
    this.etudiant = etudiant;
  }
  public String getEtudiant() {
    return etudiant;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public java.sql.Date getDaty() {
    return daty;
  }
}