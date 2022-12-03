package finance;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class SaisieVirementLettreEtat extends SaisieVirement{
  private String etat;
  public SaisieVirementLettreEtat() {
    this.setNomTable("SaisieVirementLettreEtat");
  }

  public void setEtat(String etat) {
    this.etat = etat;
  }
  public String getEtat() {
    return etat;
  }
}