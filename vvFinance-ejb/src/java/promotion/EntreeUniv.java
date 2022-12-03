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

public class EntreeUniv extends ClassMAPTable{

  private String id;
  private String promotion;
  private String etudiant;
  private int numero;
  private java.sql.Date daty;
  public EntreeUniv() {
    super.setNomTable("entreeuniv");
  }
  public String getTuppleID(){
  return id;
}
public String getAttributIDName(){
  return "id";
}
public void construirePK(Connection c) throws Exception{
 super.setNomTable("entreeuniv");
 this.preparePk("EUN","getSeqEntreeUniv");
 this.setId(makePK(c));
  }
  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public void setPromotion(String promotion) throws Exception{
    //if(promotion.compareToIgnoreCase("")==0) throw new Exception("Champ Promotion vide");
    this.promotion = promotion;
  }
  public String getPromotion() {

    return promotion;
  }
  public void setEtudiant(String etudiant) throws Exception{
 //   if(etudiant.compareToIgnoreCase("")==0) throw new Exception("Champ etudiant vide");
    this.etudiant = etudiant;
  }
  public String getEtudiant() {
    return etudiant;
  }
  public int getNumero() {
   return numero;
 }
 public void setNumero(int numero) {
   this.numero = numero;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public java.sql.Date getDaty() {
    return daty;
  }
}