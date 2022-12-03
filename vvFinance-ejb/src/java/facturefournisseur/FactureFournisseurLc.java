package facturefournisseur;

public class FactureFournisseurLc extends FactureFournisseur {

  private String designationlc;
  private double creditinitial;
  private double creditmodifier;
  private double montanteng;
  private double montantvis;
  private double montantfac;
  private String idtypeligne;
  public FactureFournisseurLc() {
  }
  public String getDesignationlc() {
    return designationlc;
  }
  public void setDesignationlc(String designationlc) {
    this.designationlc = designationlc;
  }
  public void setCreditinitial(double creditinitial) {
    this.creditinitial = creditinitial;
  }
  public double getCreditinitial() {
    return creditinitial;
  }
  public void setCreditmodifier(double creditmodifier) {
    this.creditmodifier = creditmodifier;
  }
  public double getCreditmodifier() {
    return creditmodifier;
  }
  public void setMontanteng(double montanteng) {
    this.montanteng = montanteng;
  }
  public double getMontanteng() {
    return montanteng;
  }
  public void setMontantvis(double montantvis) {
    this.montantvis = montantvis;
  }
  public double getMontantvis() {
    return montantvis;
  }
  public void setMontantfac(double montantfac) {
    this.montantfac = montantfac;
  }
  public double getMontantfac() {
    return montantfac;
  }
  public void setIdtypeligne(String idtypeligne) {
    this.idtypeligne = idtypeligne;
  }
  public String getIdtypeligne() {
    return idtypeligne;
  }
}