package compterendu;
import bean.ClassMAPTable;
import java.sql.Connection;
import utilitaire.*;
/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class CompteRenduDistributionRecette extends ClassMAPTable{

  private java.sql.Date daty;
  private String province;
  private double montantrecette;
  public CompteRenduDistributionRecette() {
    super.setNomTable("CompteRenduDistributionRecette");
  }
  public String getTuppleID()
  {
      return null;
  }

  public String getAttributIDName()
  {
      return "province";
    }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public java.sql.Date getDaty() {
    return daty;
  }
  public void setProvince(String province) {
    this.province = province;
  }
  public String getProvince() {
    return province;
  }
  public void setMontantrecette(double montantrecette) {
    this.montantrecette = montantrecette;
  }
  public double getMontantrecette() {
    return montantrecette;
  }
}