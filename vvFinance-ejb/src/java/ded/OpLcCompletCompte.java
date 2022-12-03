package ded;

import bean.ClassMAPTable;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class OpLcCompletCompte extends ClassMAPTable{
  private String id;
  private String ded_id;
  private String idLigne;
  private java.sql.Date daty;
  private double montant;
  private String remarque;
  private int etat;
  public String designationLc;
  public double creditInitial;
  public double creditModifier;
  public double montantEng;
  public double montantVis;//Montant payé facture
  public double montantFac;
  public String idTypeLigne;
  public String numCompte;
  public String idEntite;
  public String idDirection;
  public int annee;
  public String parution;
  private int mois;
  private double paye;
  private String idFournisseur;
  private String compte;

  public OpLcCompletCompte() {
  }
  public String getAttributIDName() {
    return "id";
  }
  public String getTuppleID() {
    return id;
  }
  public int getAnnee() {
    return annee;
  }
  public double getCreditInitial() {
    return creditInitial;
  }
  public double getCreditModifier() {
    return creditModifier;
  }
  public java.sql.Date getDaty() {
    return daty;
  }
  public String getDesignationLc() {
    return designationLc;
  }
  public int getEtat() {
    return etat;
  }
  public String getId() {
    return id;
  }
  public String getDed_id() {
    return ded_id;
  }
  public String getIdDirection() {
    return idDirection;
  }
  public String getIdEntite() {
    return idEntite;
  }
  public String getIdLigne() {
    return idLigne;
  }
  public String getIdTypeLigne() {
    return idTypeLigne;
  }
  public int getMois() {
    return mois;
  }
  public double getMontant() {
    return montant;
  }
  public double getMontantEng() {
    return montantEng;
  }
  public double getMontantFac() {
    return montantFac;
  }
  public double getMontantVis() {
    return montantVis;
  }
  public String getNumCompte() {
    return numCompte;
  }
  public String getParution() {
    return parution;
  }
  public String getRemarque() {
    return remarque;
  }
  public void setRemarque(String remarque) {
    this.remarque = remarque;
  }
  public void setParution(String parution) {
    this.parution = parution;
  }
  public void setNumCompte(String numCompte) {
    this.numCompte = numCompte;
  }
  public void setMontantVis(double montantVis) {
    this.montantVis = montantVis;
  }
  public void setMontantFac(double montantFac) {
    this.montantFac = montantFac;
  }
  public void setMontantEng(double montantEng) {
    this.montantEng = montantEng;
  }
  public void setMontant(double montant) {
    this.montant = montant;
  }
  public void setMois(int mois) {
    this.mois = mois;
  }
  public void setIdTypeLigne(String idTypeLigne) {
    this.idTypeLigne = idTypeLigne;
  }
  public void setIdLigne(String idLigne) {
    this.idLigne = idLigne;
  }
  public void setIdEntite(String idEntite) {
    this.idEntite = idEntite;
  }
  public void setIdDirection(String idDirection) {
    this.idDirection = idDirection;
  }
  public void setDed_id(String ded_id) {
    this.ded_id = ded_id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public void setEtat(int etat) {
    this.etat = etat;
  }
  public void setDesignationLc(String designationLc) {
    this.designationLc = designationLc;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public void setCreditModifier(double creditModifier) {
    this.creditModifier = creditModifier;
  }
  public void setCreditInitial(double creditInitial) {
    this.creditInitial = creditInitial;
  }
  public void setAnnee(int annee) {
    this.annee = annee;
  }
  public void setPaye(double paye) {
    this.paye = paye;
  }
  public double getPaye() {
    return paye;
  }
  public void setIdFournisseur(String idFournisseur) {
    this.idFournisseur = idFournisseur;
  }
  public String getIdFournisseur() {
    return idFournisseur;
  }
  public String getCompte() {
    return compte;
  }
  public void setCompte(String compte) {
    this.compte = compte;
  }
}