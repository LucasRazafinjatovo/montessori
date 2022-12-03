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

public class CompteRenduCommercial extends ClassMAPTable{

  private java.sql.Date daty;
  private String journal;
  private double montantpub;
  private int nbrepub;
  public CompteRenduCommercial() {
    super.setNomTable("CompteRenduCommercial");
  }
  public String getTuppleID(){
   return journal;
 }
 public String getAttributIDName(){
   return "journal";
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public java.sql.Date getDaty() {
    return daty;
  }
  public void setJournal(String journal) {
    this.journal = journal;
  }
  public String getJournal() {
    return journal;
  }
  public void setMontantpub(double montantpub) {
    this.montantpub = montantpub;
  }
  public double getMontantpub() {
    return montantpub;
  }
  public void setNbrepub(int nbrepub) {
    this.nbrepub = nbrepub;
  }
  public int getNbrepub() {
    return nbrepub;
  }
}