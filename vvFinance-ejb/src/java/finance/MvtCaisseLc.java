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

public class MvtCaisseLc extends ClassMAPTable{
  public String id;
  public java.sql.Date daty;
  public String designation;
  public double debit;
  public double credit;
  public String idDevise;
  public String idMode;
  public String idCaisse;
  public String remarque;
  public String agence;
  public String tiers;
  public String numPiece;
  public String typeMvt;
  public java.sql.Date datyValeur;
  public String idOrdre;
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
  private int mois;
 public int annee;
 public String parution;
  private String idLigne;


  public MvtCaisseLc() {
    this.setNomTable("MvtCaisseLc");
  }

  public String getAttributIDName() {
    return "id";
  }
  public String getTuppleID() {
    return id;
  }
  public String getAgence() {
    return agence;
  }
  public int getAnnee() {
    return annee;
  }
  public double getCredit() {
    return credit;
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
  public java.sql.Date getDatyValeur() {
    return datyValeur;
  }
  public double getDebit() {
    return debit;
  }
  public String getDesignation() {
    return designation;
  }
  public String getDesignationLc() {
    return designationLc;
  }
  public String getId() {
    return id;
  }
  public String getIdCaisse() {
    return idCaisse;
  }
  public String getIdDevise() {
    return idDevise;
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
  public String getIdMode() {
    return idMode;
  }
  public String getIdOrdre() {
    return idOrdre;
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
  public double getMontantVis() {
    return montantVis;
  }
  public String getNumCompte() {
    return numCompte;
  }
  public String getNumPiece() {
    return numPiece;
  }
  public String getParution() {
    return parution;
  }
  public String getRemarque() {
    return remarque;
  }
  public String getTiers() {
    return tiers;
  }
  public String getTypeMvt() {
    return typeMvt;
  }
  public void setAgence(String agence) {
    this.agence = agence;
  }
  public void setAnnee(int annee) {
    this.annee = annee;
  }
  public void setCredit(double credit) {
    this.credit = credit;
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
  public void setDatyValeur(java.sql.Date datyValeur) {
    this.datyValeur = datyValeur;
  }
  public void setDebit(double debit) {
    this.debit = debit;
  }
  public void setDesignationLc(String designationLc) {
    this.designationLc = designationLc;
  }
  public void setDesignation(String designation) {
    this.designation = designation;
  }
  public void setId(String id) {
    this.id = id;
  }
  public void setIdCaisse(String idCaisse) {
    this.idCaisse = idCaisse;
  }
  public void setIdDevise(String idDevise) {
    this.idDevise = idDevise;
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
  public void setIdMode(String idMode) {
    this.idMode = idMode;
  }
  public void setIdOrdre(String idOrdre) {
    this.idOrdre = idOrdre;
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
  public void setMontantVis(double montantVis) {
    this.montantVis = montantVis;
  }
  public void setNumCompte(String numCompte) {
    this.numCompte = numCompte;
  }
  public void setNumPiece(String numPiece) {
    this.numPiece = numPiece;
  }
  public void setParution(String parution) {
    this.parution = parution;
  }
  public void setRemarque(String remarque) {
    this.remarque = remarque;
  }
  public void setTiers(String tiers) {
    this.tiers = tiers;
  }
  public void setTypeMvt(String typeMvt) {
    this.typeMvt = typeMvt;
  }
}