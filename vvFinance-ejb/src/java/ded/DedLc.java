package ded;

import bean.*;


/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class DedLc extends ClassMAPTable {
  private String id;
  private String designation;
  private java.sql.Date daty;
  private double montantHt;
  private double taxe;
  private String remarque;
  private String tiers;
  private String idLigne;
  private String etat;
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
  public DedLc() {
  }
  public String getAttributIDName() {
    return "id";
  }
  public String getTuppleID() {
    return id;
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
  public String getDesignation() {
    return designation;
  }
  public String getDesignationLc() {
    return designationLc;
  }
  public String getEtat() {
    return etat;
  }
  public String getId() {
    return id;
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
  public double getMontantEng() {
    return montantEng;
  }
  public double getMontantFac() {
    return montantFac;
  }
  public double getMontantHt() {
    return montantHt;
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
  public double getTaxe() {
    return taxe;
  }
  public String getTiers() {
    return tiers;
  }
  public int getAnnee() {
    return annee;
  }
  public void setAnnee(int annee) {
    this.annee = annee;
  }
  public void setCreditInitial(double creditInitial) {
    this.creditInitial = creditInitial;
  }
  public void setCreditModifier(double creditModifier) {
    this.creditModifier = creditModifier;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public void setDesignation(String designation) {
    this.designation = designation;
  }
  public void setDesignationLc(String designationLc) {
    this.designationLc = designationLc;
  }
  public void setEtat(String etat) {
    this.etat = etat;
  }
  public void setId(String id) {
    this.id = id;
  }
  public void setIdDirection(String idDirection) {
    this.idDirection = idDirection;
  }
  public void setIdEntite(String idEntite) {
    this.idEntite = idEntite;
  }
  public void setIdLigne(String idLigne) {
    this.idLigne = idLigne;
  }
  public void setIdTypeLigne(String idTypeLigne) {
    this.idTypeLigne = idTypeLigne;
  }
  public void setMois(int mois) {
    this.mois = mois;
  }
  public void setMontantEng(double montantEng) {
    this.montantEng = montantEng;
  }
  public void setMontantFac(double montantFac) {
    this.montantFac = montantFac;
  }
  public void setMontantHt(double montantHt) {
    this.montantHt = montantHt;
  }
  public void setMontantVis(double montantVis) {
    this.montantVis = montantVis;
  }
  public void setNumCompte(String numCompte) {
    this.numCompte = numCompte;
  }
  public void setParution(String parution) {
    this.parution = parution;
  }
  public void setRemarque(String remarque) {
    this.remarque = remarque;
  }
  public void setTaxe(double taxe) {
    this.taxe = taxe;
  }
  public void setTiers(String tiers) {
    this.tiers = tiers;
  }
}