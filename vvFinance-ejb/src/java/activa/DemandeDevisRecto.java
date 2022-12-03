package activa;

public class DemandeDevisRecto extends DemandeDevisLibelle{
  private double cout;
  private double benefice;
  public DemandeDevisRecto() {
    super.setNomTable("demandedevisarticlerv");
  }
  public double getCout() {
    return cout;
  }
  public void setCout(double cout) {
    this.cout = cout;
  }
  public void setBenefice(double benefice) {
    this.benefice = benefice;
  }
  public double getBenefice() {
    return benefice;
  }
}