package etudiant;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class Provenance {

  private String id;
  private String ecole;
  private String nature;
  private Number niveau;
  public Provenance() {
  }
  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public void setEcole(String ecole) {
    this.ecole = ecole;
  }
  public String getEcole() {
    return ecole;
  }
  public void setNature(String nature) {
    this.nature = nature;
  }
  public String getNature() {
    return nature;
  }
  public void setNiveau(Number niveau) {
    this.niveau = niveau;
  }
  public Number getNiveau() {
    return niveau;
  }
}