package bean;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class RgMultiple extends ClassMAPTable {

  private String[] colonneGroupe;
  private double[] sommeGroupe;
  private int nombre;
  public RgMultiple() {
  }
  public RgMultiple(String[] col,double[] s,int nb) {
    this.setColonneGroupe(col);
    this.setSommeGroupe(s);
    this.setNombre(nb);
  }
  public String getAttributIDName() {
    /**@todo Implement this bean.ClassMAPTable abstract method*/
    throw new java.lang.UnsupportedOperationException("Method getAttributIDName() not yet implemented.");
  }
  public String getTuppleID() {
    /**@todo Implement this bean.ClassMAPTable abstract method*/
    throw new java.lang.UnsupportedOperationException("Method getTuppleID() not yet implemented.");
  }
  public void setColonneGroupe(String[] colonneGroupe) {
    this.colonneGroupe = colonneGroupe;
  }
  public String[] getColonneGroupe() {
    return colonneGroupe;
  }
  public void setSommeGroupe(double[] sommeGroupe) {
    this.sommeGroupe = sommeGroupe;
  }
  public double[] getSommeGroupe() {
    return sommeGroupe;
  }
  public void setNombre(int nombre) {
    this.nombre = nombre;
  }
  public int getNombre() {
    return nombre;
  }
}