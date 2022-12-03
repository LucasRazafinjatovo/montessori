package etudiant;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class EtudiantPromo extends Etudiant {

  private String promotion;
  private int numero;
  private java.sql.Date daty;
  public EtudiantPromo() {
    setNomTable("etudiantPromo");
  }
  public String getPromotion() {
    return promotion;
  }
  public void setPromotion(String promotion) {
    this.promotion = promotion;
  }
  public int getNumero() {
    return numero;
  }
  public void setNumero(int numero) {
    this.numero = numero;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public java.sql.Date getDaty() {
    return daty;
  }
}