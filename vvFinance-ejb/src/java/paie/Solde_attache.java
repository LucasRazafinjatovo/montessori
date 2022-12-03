package paie;

import bean.ClassMAPTable;
import java.sql.Connection;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class Solde_attache extends ClassMAPTable
{
  private String id;
  private String ordrepaiement;
  private String solde;
  private String employe;
  private double montant;
  private java.sql.Date date_saisie;
  private int mois;
  private int annee;
  private String mode_paiement;
  private String etablissement;
  public Solde_attache()
  {
    super.setNomTable("solde_attache");
  }
  public String getId()
  {
    return this.id;
  }
  public void setId(String id)
  {
    this.id = id;
  }
  public String getTuppleID()
  {
    return id;
  }
  public String getAttributIDName()
  {
    return "id";
  }
  public void  construirePK(Connection c)throws Exception
  {
    super.setNomTable("solde_attache");
    this.preparePk("SOLAT","getSolde_attache");
    this.setId(makePK(c));
  }
  public int getAnnee() {
    return annee;
  }
  public void setAnnee(int annee) {
    this.annee = annee;
  }
  public java.sql.Date getDate_saisie() {
    return date_saisie;
  }
  public void setDate_saisie(java.sql.Date date_saisie) {
    this.date_saisie = date_saisie;
  }
  public String getEmploye() {
    return employe;
  }
  public void setEmploye(String employe) {
    this.employe = employe;
  }
  public String getEtablissement() {
    return etablissement;
  }
  public void setEtablissement(String etablissement) {
    this.etablissement = etablissement;
  }
  public String getMode_paiement() {
    return mode_paiement;
  }
  public void setMode_paiement(String mode_paiement) {
    this.mode_paiement = mode_paiement;
  }
  public int getMois() {
    return mois;
  }
  public void setMois(int mois) {
    this.mois = mois;
  }
  public double getMontant() {
    return montant;
  }
  public void setMontant(double montant) {
    this.montant = montant;
  }
  public String getOrdrepaiement() {
    return ordrepaiement;
  }
  public void setOrdrepaiement(String ordrepaiement) {
    this.ordrepaiement = ordrepaiement;
  }
  public String getSolde() {
    return solde;
  }
  public void setSolde(String solde) {
    this.solde = solde;
  }
  public Solde_attache(String ordre, String solde, String emp, double montant, java.sql.Date date_saisie,int mois, int annee, String mode_paiement,String etablissement)
  {
    super.setNomTable("solde_attache");
    this.setOrdrepaiement(ordre);
    this.setSolde(solde);
    this.setEmploye(emp);
    this.setMontant(montant);
    this.setDate_saisie(date_saisie);
    this.setMois(mois);
    this.setAnnee(annee);
    this.setMode_paiement(mode_paiement);
    this.setEtablissement(etablissement);
  }
}