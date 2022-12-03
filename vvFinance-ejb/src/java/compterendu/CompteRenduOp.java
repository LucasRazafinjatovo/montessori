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

public class CompteRenduOp extends ClassMAPTable{

  private java.sql.Date daty;
  private double montant;
  private String designation;
  public CompteRenduOp() {
  }
  public String getTuppleID()
   {
       return null;
   }

   public String getAttributIDName()
   {
       return "designation";
    }
  public java.sql.Date getDaty() {
    return daty;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public void setMontant(double montant) {
    this.montant = montant;
  }
  public double getMontant() {
    return montant;
  }
  public void setDesignation(String designation) {
    this.designation = designation;
  }
  public String getDesignation() {
    return designation;
  }

}