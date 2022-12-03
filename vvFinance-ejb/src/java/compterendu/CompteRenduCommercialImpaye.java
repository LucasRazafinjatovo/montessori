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

public class CompteRenduCommercialImpaye extends ClassMAPTable{

  private int mois;
  private int annee;
  private double montantimpaye;

  public CompteRenduCommercialImpaye(){
    super.setNomTable("CompteRenduCommercialImpaye");
  }

  public String getTuppleID()
  {
    return null;
  }

  public String getAttributIDName()
  {
    return "province";
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
  public void setMontantimpaye(double montantimpaye) {
    this.montantimpaye = montantimpaye;
  }
  public double getMontantimpaye() {
    return montantimpaye;
  }
}