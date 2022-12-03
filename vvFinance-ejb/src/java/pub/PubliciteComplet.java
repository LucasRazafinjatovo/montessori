package pub;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class PubliciteComplet extends Publicite {

  private double montant;
  private double remise;
  private double montantReste;
  public PubliciteComplet() {
    this.setNomTable("PubComplet");
  }
  public double getMontant() {
    return montant;
  }
  public void setMontant(double montant) {
    this.montant = montant;
  }
  public void setRemise(double remise) {
    this.remise = remise;
  }
  public double getRemise() {
    return remise;
  }
  public void setMontantReste(double montantReste) {
    this.montantReste = montantReste;
  }
  public double getMontantReste() {
    return montantReste;
  }
}