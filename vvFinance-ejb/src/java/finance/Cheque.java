package finance;

import bean.*;


/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class Cheque extends ClassMAPTable
{
  private String id;
  private String idMvt;
  private java.sql.Date datySaisie;
  private java.sql.Date datyValeur;
  private String remarque;
  private String numCheque;
  private String caisse;
  private double montant;
  private String etat;
  private String designation;
  public Cheque() {
    this.setNomTable("Cheque");
  }
  public Cheque(String mvt,String datyS,String datyV,String ord,String rem,String numC,String ca,String mont)
  {
    this.setNomTable("Cheque");
    this.setIndicePk("CHQ");
    this.setNomProcedureSequence("getSeqCheque");
    this.setId(this.makePK());
    this.setIdMvt(mvt);
    this.setDatySaisie(utilitaire.Utilitaire.string_date ("dd/MM/yyyy",datyS));
    this.setDatyValeur(utilitaire.Utilitaire.string_date ("dd/MM/yyyy",datyV));
    this.setRemarque(rem);
    this.setNumCheque(numC);
    this.setCaisse(ca);
    this.setMontant(utilitaire.Utilitaire.stringToDouble(mont));
  }
  public String getAttributIDName() {
    return "id";
  }
  public String getTuppleID() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public String getId() {
    return id;
  }
  public void setIdMvt(String idMvt) {
    this.idMvt = idMvt;
  }
  public String getIdMvt() {
    return idMvt;
  }
  public void setDatySaisie(java.sql.Date datySaisie) {
    this.datySaisie = datySaisie;
  }
  public java.sql.Date getDatySaisie() {
    return datySaisie;
  }
  public String getDatySaisieLettre()
  {
    return utilitaire.Utilitaire.formatterDatySql(getDatySaisie());
  }
  public void setDatyValeur(java.sql.Date datyValeur) {
    this.datyValeur = datyValeur;
  }
  public java.sql.Date getDatyValeur() {
    return datyValeur;
  }
  public String getDatyValeurLettre()
  {
    return (utilitaire.Utilitaire.formatterDatySql(getDatyValeur()));
  }
  public void setRemarque(String remarque) {
    this.remarque = remarque;
  }
  public String getRemarque() {
    return remarque;
  }
  public void setNumCheque(String numCheque) {
    this.numCheque = numCheque;
  }
  public String getNumCheque() {
    return numCheque;
  }
  public void setCaisse(String caisse) {
    this.caisse = caisse;
  }
  public String getCaisse() {
    return caisse;
  }
  public void setMontant(double montant) {
    this.montant = montant;
  }
  public double getMontant() {
    return montant;
  }
  public String getMontantLettre()
  {
    return utilitaire.Utilitaire.formaterAr(getMontant());
  }
  public void setEtat(String etat) {
    this.etat = etat;
  }
  public String getEtat() {
    return etat;
  }
  public void setDesignation(String designation) {
    this.designation = designation;
  }
  public String getDesignation() {
    return designation;
  }
}