package ded;

public class Oppaye_tdp extends OpLc {

  private double paye;
  private String parution;
  private String ded_id;
  private String idFournisseur;
  private java.sql.Date date_paiement;
  private String typee;
  public Oppaye_tdp() {
    super.setNomTable("oppayelc_tdp");
  }
  public double getPaye() {
    return paye;
  }
  public void setPaye(double paye) {
    this.paye = paye;
  }
  public void setParution(String parution) {
    this.parution = parution;
  }
  public String getParution() {
    return parution;
  }
  public String getDed_id() {
    return ded_id;
  }
  public void setDed_id(String ded_id) {
    this.ded_id = ded_id;
  }
  public void setIdFournisseur(String idFournisseur) {
    this.idFournisseur = idFournisseur;
  }
  public String getIdFournisseur() {
    return idFournisseur;
  }
  public String getTypee() {
    return typee;
  }
  public void setTypee(String typee) {
    this.typee = typee;
  }
  public java.sql.Date getDate_paiement() {
    return date_paiement;
  }
  public void setDate_paiement(java.sql.Date date_paiement) {
    this.date_paiement = date_paiement;
  }

}