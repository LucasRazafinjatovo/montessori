package prevision;
import bean.ClassMAPTable;
import java.sql.Connection;
import utilitaire.*;
/**
 * <p>Title: Gestion des Depenses </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class EtatPrevOP extends ClassMAPTable{

  private java.sql.Date daty;
  private double depense;
  private double prevision;
  private double diff;
  public EtatPrevOP() {
    super.setNomTable("ETATPREVDEPENSE");
  }
  public java.sql.Date getDaty() {
    return daty;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public String getTuppleID(){
    return "";
  }
  public String getAttributIDName(){
    return "idligne";
  }
  public double getDiff() {
    return diff;
  }
  public double getPrevision() {
    return prevision;
  }

  public void setDiff(double diff) {
    this.diff = diff;
  }
  public void setPrevision(double prevision) {
    this.prevision = prevision;
  }
  public double getDepense() {
    return depense;
  }
  public void setDepense(double depense) {
    this.depense = depense;
  }


}