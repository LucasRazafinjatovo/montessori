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

public class CompteRenduLcd  extends ClassMAPTable{

  private String designation;
  private int mois;
  private int annee;
  private double montantdepassement;
  public CompteRenduLcd() {
  }
  public String getTuppleID()
   {
       return null;
   }

   public String getAttributIDName()
   {
       return "designation";
    }
  public String getDesignation() {
    return designation;
  }
  public void setDesignation(String designation) {
    this.designation = designation;
  }
  public void setMois(int mois) {
    this.mois = mois;
  }
  public int getMois() {
    return mois;
  }
  public void setAnnee(int annee) {
    this.annee = annee;
  }
  public int getAnnee() {
    return annee;
  }
  public void setMontantdepassement(double montantdepassement) {
    this.montantdepassement = montantdepassement;
  }
  public double getMontantdepassement() {
    return montantdepassement;
  }

}