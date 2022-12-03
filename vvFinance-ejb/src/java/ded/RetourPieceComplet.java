package ded;
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

public class RetourPieceComplet extends ClassMAPTable{

  private String id;
  private String coursier;
  private String tel;
  private String poste;
  private String societe;
  private String designation;
  private String montant;
  private String ded_id;
  //private String remarque;
  private java.sql.Date datyop;
  private String beneffinale;
  public String getTuppleID(){
    return id;
  }
  public String getAttributIDName(){
    return "id";
  }
  public void setId(String id) {
    this.id = id;
  }
  public String getId() {
    return id;
  }
  public void setCoursier(String coursier) {
    this.coursier = coursier;
  }
  public String getCoursier() {
    return coursier;
  }
  public void setTel(String tel) {
    this.tel = tel;
  }
  public String getTel() {
    return tel;
  }
  public void setPoste(String poste) {
    this.poste = poste;
  }
  public String getPoste() {
    return poste;
  }
  public void setSociete(String societe) {
    this.societe = societe;
  }
  public String getSociete() {
    return societe;
  }
  public void setDesignation(String designation) {
    this.designation = designation;
  }
  public String getDesignation() {
    return designation;
  }
  public void setMontant(String montant) {
    this.montant = montant;
  }
  public String getMontant() {
    return montant;
  }
  public void setDed_id(String ded_id) {
    this.ded_id = ded_id;
  }
  public String getDed_id() {
    return ded_id;
  }
  public void setDatyop(java.sql.Date datyop) {
    this.datyop = datyop;
  }
  public java.sql.Date getDatyop() {
    return datyop;
  }
  public void setBeneffinale(String beneffinale) {
    this.beneffinale = beneffinale;
  }
  public String getBeneffinale() {
    return beneffinale;
  }
  public RetourPieceComplet() {
    super.setNomTable("RetourPieceComplet");
  }
}