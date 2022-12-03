package ded;

public class Oppaye extends OpLc {

  private double paye;
  private String parution;
  private String ded_id;
  private String idFournisseur;
  public Oppaye() {
    super.setNomTable("oppayelc");
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

}