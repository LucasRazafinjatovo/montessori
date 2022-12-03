package ded;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class Analyse_compta_oppayelc extends Oppaye{

  private String entite;
  private String typeligne;
  public Analyse_compta_oppayelc() {
    super.setNomTable("Analyse_compta_oppayelc");
  }
  public String getEntite() {
    return entite;
  }
  public void setEntite(String entite) {
    this.entite = entite;
  }
  public void setTypeligne(String typeligne) {
    this.typeligne = typeligne;
  }
  public String getTypeligne() {
    return typeligne;
  }
}