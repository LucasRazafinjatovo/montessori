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

public class PrevisionState extends ClassMAPTable{

  private java.sql.Date daty;
  private double debit;
  private double credit;
  private double solde;
  public PrevisionState() {
    super.setNomTable("PREVISIONGLOBALSTATE");
  }
  public java.sql.Date getDaty() {
    return daty;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }

public String getAttributIDName(){
  return "";
  }
  public String getTuppleID(){
  return null;
  }
  public void setDebit(double debit) {
    this.debit = debit;
  }
  public double getDebit() {
    return debit;
  }
  public void setCredit(double credit) {
    this.credit = credit;
  }
  public double getCredit() {
    return credit;
  }
  public void setSolde(double solde) {
    this.solde = solde;
  }
  public double getSolde() {
    return solde;
  }

}