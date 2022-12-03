package facture;
import bean.ClassMAPTable;
import bean.GenUtil;
import java.io.PrintStream;
import java.sql.Date;
import utilitaire.Utilitaire;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class FactureClientTVAHT extends ClassMAPTable{

  private String idfacturefournisseur;
  private String idfournisseur;
  private String numfact;
  private java.sql.Date daty;
  private String iddevise;
  private double montantttc;
  private double montantht;
  private String remarque;
  private double idtva;
  public String designation;
  public java.sql.Date dateemission;
  private String resp;
  private java.sql.Date datyecheance;

  public FactureClientTVAHT() {
    super.setNomTable("factureclienttvaht");
  }
  public String getTuppleID()
    {
        return String.valueOf(idfournisseur);
    }

    public String getAttributIDName()
    {
        return "idfournisseur";
    }
  public void setIdfacturefournisseur(String idfacturefournisseur) {
    this.idfacturefournisseur = idfacturefournisseur;
  }
  public String getIdfacturefournisseur() {
    return idfacturefournisseur;
  }
  public void setIdfournisseur(String idfournisseur) {
    this.idfournisseur = idfournisseur;
  }
  public String getIdfournisseur() {
    return idfournisseur;
  }
  public void setNumfact(String numfact) {
    this.numfact = numfact;
  }
  public String getNumfact() {
    return numfact;
  }
  public java.sql.Date getDateemission() {
    return dateemission;
  }
  public java.sql.Date getDaty() {
    return daty;
  }
  public java.sql.Date getDatyecheance() {
    return datyecheance;
  }
  public String getDesignation() {
    return designation;
  }
  public String getIddevise() {
    return iddevise;
  }
  public double getIdtva() {
    return idtva;
  }
  public double getMontantttc() {
    return montantttc;
  }
  public String getRemarque() {
    return remarque;
  }
  public String getResp() {
    return resp;
  }
  public void setResp(String resp) {
    this.resp = resp;
  }
  public void setRemarque(String remarque) {
    this.remarque = remarque;
  }
  public void setMontantttc(double montantTTC) {
    this.montantttc = montantTTC;
  }
  public void setIdtva(double idtva) {
    this.idtva = idtva;
  }
  public void setIddevise(String iddevise) {
    this.iddevise = iddevise;
  }
  public void setDesignation(String designation) {
    this.designation = designation;
  }
  public void setDatyecheance(java.sql.Date datyecheance) {
    this.datyecheance = datyecheance;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public void setDateemission(java.sql.Date dateemission) {
    this.dateemission = dateemission;
  }
  public double getMontantht() {
    return montantht;
  }
  public void setMontantht(double montantht) {
    this.montantht = montantht;
  }
}