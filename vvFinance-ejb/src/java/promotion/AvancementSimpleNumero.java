package promotion;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class AvancementSimpleNumero extends AvancementSimple {

  private String numero;
  public AvancementSimpleNumero() {
    setNomTable("AvancementSimpleNumero");
  }
  public String getNumero() {
    return numero;
  }
  public void setNumero(String numero) {
    this.numero = numero;
  }
}