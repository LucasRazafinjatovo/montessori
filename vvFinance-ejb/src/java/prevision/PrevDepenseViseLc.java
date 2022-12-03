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

public class PrevDepenseViseLc extends EtatPrevGroupeeLC{

  private double creditinitial;
  private double creditmodifier;
  private double montanteng;
  private double montantfac;
  private double montantvis;
  public PrevDepenseViseLc() {
    super.setNomTable("PREVDEPLCCALC");
  }
  public double getCreditinitial() {
    return creditinitial;
  }
  public void setCreditinitial(double creditinitial) {
    this.creditinitial = creditinitial;
  }
  public void setCreditmodifier(double creditmodifier) {
    this.creditmodifier = creditmodifier;
  }
  public double getCreditmodifier() {
    return creditmodifier;
  }
  public void setMontanteng(double montanteng) {
    this.montanteng = montanteng;
  }
  public double getMontanteng() {
    return montanteng;
  }
  public void setMontantfac(double montantfac) {
    this.montantfac = montantfac;
  }
  public double getMontantfac() {
    return montantfac;
  }
  public void setMontantvis(double montantvis) {
    this.montantvis = montantvis;
  }
  public double getMontantvis() {
    return montantvis;
  }
 }