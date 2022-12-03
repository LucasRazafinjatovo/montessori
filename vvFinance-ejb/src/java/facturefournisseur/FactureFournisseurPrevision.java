package facturefournisseur;
import bean.*;
import java.util.*;
import java.sql.Connection;
/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class FactureFournisseurPrevision extends ClassMAPTable{

  private String id;
  private String idfournisseur;
  private String remarque;
  private String designation;
  private String iddevise;
  private String numfact;
  private String resp;
  private java.sql.Date daty;
  private java.sql.Date dateemission;
  private double montantttc;
  private double tva;
  public FactureFournisseurPrevision() {
    super.setNomTable("facturefournisseurprevision");
  }
  public void construirePK(Connection c) throws Exception{
    super.setNomTable("facturefournisseurprevision");
    this.preparePk("FFP","getSeqFFPrevision");
    this.setId(makePK(c));
  }
  public String getAttributIDName() {
     return "id";
   }
  public String getTuppleID() {
     return id;
  }
  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public java.sql.Date getDaty() {
    return daty;
  }
  public void setIdfournisseur(String idfournisseur) {
    this.idfournisseur = idfournisseur;
  }
  public String getIdfournisseur() {
    return idfournisseur;
  }
  public void setTva(double tva) {
    this.tva = tva;
  }
  public double getTva() {
    return tva;
  }
  public void setMontantttc(double montantttc) {
    this.montantttc = montantttc;
  }
  public double getMontantttc() {
    return montantttc;
  }
  public void setRemarque(String remarque) {
    this.remarque = remarque;
  }
  public String getRemarque() {
    return remarque;
  }
  public void setDateemission(java.sql.Date dateemission) {
    this.dateemission = dateemission;
  }
  public java.sql.Date getDateemission() {
    return dateemission;
  }
  public void setDesignation(String designation) {
    this.designation = designation;
  }
  public String getDesignation() {
    return designation;
  }
  public void setIddevise(String iddevise) {
    this.iddevise = iddevise;
  }
  public String getIddevise() {
    return iddevise;
  }
  public void setNumfact(String numfact) {
    this.numfact = numfact;
  }
  public String getNumfact() {
    return numfact;
  }
  public void setResp(String resp) {
    this.resp = resp;
  }
  public String getResp() {
    return resp;
  }
}