package facturefournisseur;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class FactureFournisseurPrevisionLc extends FactureFournisseurPrevision {

  private String lc;
  public FactureFournisseurPrevisionLc() {
     super.setNomTable("facturefournisseurprevisionlc");
  }
  public String getLc() {
    return lc;
  }
  public void setLc(String lc) {
    this.lc = lc;
  }
}