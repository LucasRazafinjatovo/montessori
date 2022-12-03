package finance;

import bean.ClassMAPTable;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class EtatDeCaisse extends ClassMAPTable implements java.io.Serializable {


  private String caisse;
  private java.sql.Date daty;
  private double credit_caisse=0;
  private double debit_caisse=0;
  private double soldec=0;
  private double debit_rib=0;
  private double credit_rib=0;
  private double solde_rib=0;
  private double debit_theorique=0;
  private double credit_theorique=0;
  private double debit_non_rapprocherib=0;
  private double credit_non_rapprocherib=0;
  private double solde=0;
  public String getTuppleID()
  {
      return null;
  }

  public String getAttributIDName()
  {
      return "";
    }
  public void setCaisse(String caisse) {
    this.caisse = caisse;
  }
  public String getCaisse() {
    return caisse;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public java.sql.Date getDaty() {
    return daty;
  }
  public void setCredit_caisse(double credit_caisse) {
    this.credit_caisse = credit_caisse;
  }
  public double getCredit_caisse() {
    return credit_caisse;
  }
  public void setDebit_caisse(double debit_caisse) {
    this.debit_caisse = debit_caisse;
  }
  public double getDebit_caisse() {
    return debit_caisse;
  }
  public void setSoldec(double soldec) {
    this.soldec = soldec;
  }
  public double getSoldec() {
    return soldec;
  }
  public void setDebit_rib(double debit_rib) {
    this.debit_rib = debit_rib;
  }
  public double getDebit_rib() {
    return debit_rib;
  }
  public void setCredit_rib(double credit_rib) {
    this.credit_rib = credit_rib;
  }
  public double getCredit_rib() {
    return credit_rib;
  }
  public void setSolde_rib(double solde_rib) {
    this.solde_rib = solde_rib;
  }
  public double getSolde_rib() {
    return solde_rib;
  }
  public void setDebit_theorique(double debit_theorique) {
    this.debit_theorique = debit_theorique;
  }
  public double getDebit_theorique() {
    return debit_theorique;
  }
  public void setCredit_theorique(double credit_theorique) {
    this.credit_theorique = credit_theorique;
  }
  public double getCredit_theorique() {
    return credit_theorique;
  }
  public void setDebit_non_rapprocherib(double debit_non_rapprocherib) {
    this.debit_non_rapprocherib = debit_non_rapprocherib;
  }
  public double getDebit_non_rapprocherib() {
    return debit_non_rapprocherib;
  }
  public void setCredit_non_rapprocherib(double credit_non_rapprocherib) {
    this.credit_non_rapprocherib = credit_non_rapprocherib;
  }
  public double getCredit_non_rapprocherib() {
    return credit_non_rapprocherib;
  }
  public void setSolde(double solde) {
    this.solde = solde;
  }
  public double getSolde() {
    return solde;
  }
  public EtatDeCaisse() {
    this.setNomTable("etat_caisse");
  }
}