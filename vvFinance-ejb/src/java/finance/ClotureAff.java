package finance;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class ClotureAff extends Cloture {

  private java.sql.Date datySup;
  public ClotureAff() {
    super.setNomTable("ClotureAff");
  }
  public java.sql.Date getDatySup() {
    return datySup;
  }
  public void setDatySup(java.sql.Date datySup) throws Exception {
    //if(utilitaire.Utilitaire.compareDaty(datySup,this.getDaty())<0)throw new Exception("Date sup non valide");
    this.datySup = datySup;
  }
}