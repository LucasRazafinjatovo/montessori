package lc;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class LigneCreditDatee extends LigneCredit{

  private java.sql.Date daty;
  public LigneCreditDatee() {
    super.setNomTable("LigneCreditDatee");
  }
  public java.sql.Date getDaty() {
    return daty;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }

}