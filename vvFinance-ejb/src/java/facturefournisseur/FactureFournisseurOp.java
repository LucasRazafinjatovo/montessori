package facturefournisseur;

public class FactureFournisseurOp extends FactureFournisseur {

  private double opmontant;
  private double reste;
  private String designationlc;
  private double creditinitial;
  private double creditmodifier;
  private double montanteng;
  private double montantvis;
  private double montantfac;
  private String idtypeligne;
  private String numcompte;
  private String identite;
  private String iddirection;
  private int mois;
  private int annee;
  private String parution;
  private String idligne;
  public FactureFournisseurOp() {
    this.setNomTable("FACTUREFOURNISSEUROPGROUPE");
  }
  public double getOpmontant() {
    return opmontant;
  }
  public void setOpmontant(double opmontant) {
    this.opmontant = opmontant;
  }
  public void setReste(double reste) {
    this.reste = reste;
  }
  public double getReste() {
    return reste;
  }
  public void setDesignationlc(String designationlc) {
    this.designationlc = designationlc;
  }
  public String getDesignationlc() {
    return designationlc;
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
  public void setNumcompte(String numcompte) {
    this.numcompte = numcompte;
  }
  public String getNumcompte() {
    return numcompte;
  }
  public void setIdentite(String identite) {
    this.identite = identite;
  }
  public String getIdentite() {
    return identite;
  }
  public void setIddirection(String iddirection) {
    this.iddirection = iddirection;
  }
  public String getIddirection() {
    return iddirection;
  }
  public void setMois(int mois) {
    this.mois = mois;
  }
  public int getMois() {
    return mois;
  }
  public void setAnnee(int annee) {
    this.annee = annee;
  }
  public int getAnnee() {
    return annee;
  }
  public void setParution(String parution) {
    this.parution = parution;
  }
  public String getParution() {
    return parution;
  }
  public void setIdligne(String idligne) {
    this.idligne = idligne;
  }
  public String getIdligne() {
    return idligne;
  }
}