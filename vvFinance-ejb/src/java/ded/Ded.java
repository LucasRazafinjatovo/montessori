package ded;

import bean.*;
import utilitaire.Utilitaire;


/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class Ded extends ClassMAPTable {

  private String id;
  private String designation;
  private java.sql.Date daty;
  private double montantHt;
  private double taxe;
  private String remarque;
  private String tiers;
  private String idLigne;
  private String etat;
  public Ded() {
    super.setNomTable("Ded");
  }
  public Ded(String id,String desi,String dt,String mtht,String taxe,String rem,String eta,String tier,String idLigne)
  {
    super.setNomTable("Ded");
    this.setId(id);
    this.setDesignation(desi);
    this.setDaty((Utilitaire.string_date("dd/MM/yyyy",dt)));
    this.setMontantHt(Utilitaire.stringToDouble(mtht));
    this.setTaxe(Utilitaire.stringToDouble(taxe));
    this.setRemarque(rem);
    this.setEtat(eta);
    this.setTiers(tier);
    this.setIdLigne(idLigne);
  }
  public Ded(String desi,String dt,String mtht,String taxe,String rem,String eta,String tier,String idLigne) throws Exception
  {
    super.setNomTable("Ded");
    this.preparePk("DED","getSeqDed");
    this.setId(makePK());
    this.setDesignation(desi);
    this.setDaty((Utilitaire.string_date("dd/MM/yyyy",dt)));
    this.setMontantHt(Utilitaire.stringToDouble(mtht));
    this.setTaxe(Utilitaire.stringToDouble(taxe));
    this.setRemarque(rem);
    this.setEtat(eta);
    this.setTiers(tier);
    this.setIdLigne(idLigne);
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
  public void setDesignation(String designation) {
    this.designation = designation;
  }
  public String getDesignation() {
    return designation;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public java.sql.Date getDaty() {
    return daty;
  }
  public void setMontantHt(double montantHt) {
    this.montantHt = montantHt;
  }
  public double getMontantHt() {
    return montantHt;
  }
  public void setTaxe(double taxe) {
    this.taxe = taxe;
  }
  public double getTaxe() {
    return taxe;
  }
  public void setRemarque(String remarque) {
    this.remarque = remarque;
  }
  public String getRemarque() {
    return remarque;
  }
  public void setEtat(String etat) {
    this.etat = etat;
  }
  public String getEtat() {
    return etat;
  }
  public void setTiers(String tiers) {
    this.tiers = tiers;
  }
  public String getTiers() {
    return tiers;
  }
  public double getMttc()
  {
    return this.getMontantHt()+this.getTaxe();
  }
  public void setIdLigne(String idLigne) {
    this.idLigne = idLigne;
  }
  public String getIdLigne() {
    return idLigne;
  }
}