package ventegazety;
import bean.*;
/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class ComparaisonProductionPrise extends ClassMAPTable{

  private String journal;
  private java.sql.Date daty;
  private int production;
  private int totalprise;
  private int difference;
  private String etat;
  public ComparaisonProductionPrise() {
    super.setNomTable("ComparaisonProductionPrise");
  }
  public String getAttributIDName() {
   return "";
 }
 public String getTuppleID() {
   return null;
  }
  public String getJournal() {
    return journal;
  }
  public void setJournal(String journal) {
    this.journal = journal;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public java.sql.Date getDaty() {
    return daty;
  }
  public void setProduction(int production) {
    this.production = production;
  }
  public int getProduction() {
    return production;
  }
  public void setTotalprise(int totalprise) {
    this.totalprise = totalprise;
  }
  public int getTotalprise() {
    return totalprise;
  }
  public void setDifference(int difference) {
    this.difference = difference;
  }
  public int getDifference() {
    return difference;
  }
  public void setEtat(String etat) {
    this.etat = etat;
  }
  public String getEtat() {
    return etat;
  }

}