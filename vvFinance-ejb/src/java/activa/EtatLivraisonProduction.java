package activa;

public class EtatLivraisonProduction extends ProductionLibelle{
  private double quantiteLivre;
  private double quantiteRestant;
  public EtatLivraisonProduction(){
    super.setNomTable("EtatLivraisonProduction");
  }
  public double getQuantiteLivre() {
    return quantiteLivre;
  }
  public void setQuantiteLivre(double quantiteLivre) {
    this.quantiteLivre = quantiteLivre;
  }
  public void setQuantiteRestant(double quantiteRestant) {
    this.quantiteRestant = quantiteRestant;
  }
  public double getQuantiteRestant() {
    return quantiteRestant;
  }
}