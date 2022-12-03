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

public class EtatCaisseReste extends ClassMAPTable implements java.io.Serializable {

  private java.sql.Date daty;
  private String idCaisse;
  private String descCaisse;
  private String entite;
  private double credit=0;
  private double debit=0;
  private double reste=0;
  private double repEntree;
  private double repDepense;

  public String getTuppleID()
  {
      return null;
  }

  public String getAttributIDName()
  {
      return "idSortie";
    }
  public EtatCaisseReste() {
  }
  public EtatCaisseReste(java.sql.Date dt,String idCaisse,String descC,String entite,double credit,double deb,double res,double repE, double repD) {
    this.setDaty(dt);
    this.setEntite(entite);
    this.setDescCaisse(descC);
    this.setIdCaisse(idCaisse);
    this.setCredit(credit);
    this.setDebit(deb);
    this.setReste(res);
    this.setRepEntree(repE);
    this.setRepDepense(repD);
  }
  public EtatCaisseReste(String ben,String ca,String credit,String deb) {

  }
  public String getEntite() {
    return entite;
  }
  public void setEntite(String entite) {
    this.entite = entite;
  }
  public void setIdCaisse(String idCaisse) {
    this.idCaisse = idCaisse;
  }
  public String getIdCaisse() {
    return idCaisse;
  }

  public double getDebit() {
    return debit;
  }

  public double getCredit() {
    return credit;
  }
  public void setReste(double reste) {
    this.reste = reste;
  }
  public double getReste() {
    return reste;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public java.sql.Date getDaty() {
    return daty;
  }
  public void setDescCaisse(String descCaisse) {
    this.descCaisse = descCaisse;
  }
  public String getDescCaisse() {
    return descCaisse;
  }
  public void setCredit(double credit) {
    this.credit = credit;
  }
  public void setDebit(double debit) {
    this.debit = debit;
  }
  public void setRepEntree(double repEntree) {
    this.repEntree = repEntree;
  }
  public double getRepEntree() {
    return repEntree;
  }
  public double getResteCalc()
  {
    return (this.getRepEntree()+this.getCredit()-this.getDebit());
  }
  public void calculReste()
  {
    this.setReste(this.getRepEntree()+this.getCredit()-this.getDebit());
  }
  public void setRepDepense(double repDepense) {
    this.repDepense = repDepense;
  }
  public double getRepDepense() {
    return repDepense;
  }
}