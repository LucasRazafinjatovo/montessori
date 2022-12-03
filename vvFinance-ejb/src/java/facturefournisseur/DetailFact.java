package facturefournisseur;

import bean.*;


/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class DetailFact extends ClassMAPTable {

  private String id;
  private String idMere;
  private String designation;
  private double qte;
  private double pubHT;
  private String remarque;
  public DetailFact() {
  }
  public String getAttributIDName() {
    /**@todo Implement this bean.ClassMAPTable abstract method*/
    throw new java.lang.UnsupportedOperationException("Method getAttributIDName() not yet implemented.");
  }
  public String getTuppleID() {
    /**@todo Implement this bean.ClassMAPTable abstract method*/
    throw new java.lang.UnsupportedOperationException("Method getTuppleID() not yet implemented.");
  }
  public void setId(String id) {
    this.id = id;
  }
  public String getId() {
    return id;
  }
  public void setIdMere(String idMere) {
    this.idMere = idMere;
  }
  public String getIdMere() {
    return idMere;
  }
  public void setDesignation(String designation) {
    this.designation = designation;
  }
  public String getDesignation() {
    return designation;
  }
  public void setQte(double qte) {
    this.qte = qte;
  }
  public double getQte() {
    return qte;
  }
  public void setPubHT(double pubHT) {
    this.pubHT = pubHT;
  }
  public double getPubHT() {
    return pubHT;
  }
  public void setRemarque(String remarque) {
    this.remarque = remarque;
  }
  public String getRemarque() {
    return remarque;
  }
}