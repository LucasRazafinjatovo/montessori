package ded;

import bean.ClassMAPTable;
/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class OpLcCalc extends ClassMAPTable{

  private String id;
  private String idtyligne;
  private String identite;
  private String designationlc;
  private double montantvis;
  private double creditmodifier;
  private double montant;
  public OpLcCalc() {
    super.setNomTable("OpLcCalc");
  }
  public String getAttributIDName() {
    return "id";
  }
  public String getTuppleID() {
    return id;
  }
  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public void setIdtyligne(String idtyligne) {
    this.idtyligne = idtyligne;
  }
  public String getIdtyligne() {
    return idtyligne;
  }
  public void setIdentite(String identite) {
    this.identite = identite;
  }
  public String getIdentite() {
    return identite;
  }
  public void setDesignationlc(String designationlc) {
    this.designationlc = designationlc;
  }
  public String getDesignationlc() {
    return designationlc;
  }
  public void setMontantvis(double montantvis) {
    this.montantvis = montantvis;
  }
  public double getMontantvis() {
    return montantvis;
  }
  public void setCreditmodifier(double creditmodifier) {
    this.creditmodifier = creditmodifier;
  }
  public double getCreditmodifier() {
    return creditmodifier;
  }
  public void setMontant(double montant) {
    this.montant = montant;
  }
  public double getMontant() {
    return montant;
  }
}