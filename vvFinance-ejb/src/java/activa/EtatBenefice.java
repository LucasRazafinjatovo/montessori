package activa;

public class EtatBenefice extends EtatLivraisonProduction{

  private double perte;
  private double beneficeTheorique;
  private double beneficePratique;
  private String idDevis;
  public EtatBenefice() {
    super.setNomTable("EtatBeneficerv");
  }
  public double getPerte() {
    return perte;
  }
  public void setPerte(double perte) {
    this.perte = perte;
  }
  public void setBeneficeTheorique(double beneficeTheorique) {
    this.beneficeTheorique = beneficeTheorique;
  }
  public double getBeneficeTheorique() {
    return beneficeTheorique;
  }
  public void setBeneficePratique(double beneficePratique) {
    this.beneficePratique = beneficePratique;
  }
  public double getBeneficePratique() {
    return beneficePratique;
  }
  public void setIdDevis(String idDevis) {
    this.idDevis = idDevis;
  }
  public String getIdDevis() {
    return idDevis;
  }
}