package prevision;

import bean.*;
import java.sql.Connection;
import utilitaire.UtilDB;
import finance.MvtCaisse;
import finance.MvtCaisseUtil;
import facturefournisseur.FactureFournisseurLc;
import lc.LigneCredit;
/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class OrdonnerPayementLC extends ClassMAPTable {

  private String id;
  private String ded_Id;
  private String idLigne;
  private java.sql.Date daty;
  private double montant;
  private String remarque;
  private String designationlc;
  public OrdonnerPayementLC() {
    this.setNomTable("OrdonnerPayementLC");
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
  public void setDed_Id(String ded_Id) {
    this.ded_Id = ded_Id;
  }
  public String getDed_Id() {
    return ded_Id;
  }
  public void setIdLigne(String idLigne) {
    this.idLigne = idLigne;
  }
  public String getIdLigne() {
    return idLigne;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public java.sql.Date getDaty() {
    return daty;
  }
  public void setMontant(double montant) {
    this.montant = montant;
  }
  public double getMontant() {
    return montant;
  }
  public void setRemarque(String remarque) {
    this.remarque = remarque;
  }
  public String getRemarque() {
    return remarque;
  }

  public String getDesignationlc() {
    return designationlc;
  }
  public void setDesignationlc(String designationlc) {
    this.designationlc = designationlc;
  }

}