package facturefournisseur;

public class FactureFournisseurCompte extends FactureFournisseur {

  private String comptetype;
  public FactureFournisseurCompte() {
    setNomTable("FACTUREFCOMPTE");
  }
  public String getComptetype() {
    return comptetype;
  }
  public void setComptetype(String comptetype) {
    this.comptetype = comptetype;
  }
}