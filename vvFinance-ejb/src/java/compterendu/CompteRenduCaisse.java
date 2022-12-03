package compterendu;

import bean.*;


/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class CompteRenduCaisse extends ClassMAPTable {

  public String idCaisse;
  public String descCaisse;
  public java.sql.Date daty;
  public double reportpratique;
  public double reporttheorique;
  public CompteRenduCaisse() {
    this.setNomTable("CompteRenduCaisse");
  }

  public String getAttributIDName() {
    return "CompteRenduCaisse";
  }
  public String getTuppleID() {
    return idCaisse;
  }
  public void setIdCaisse(String id) {
    this.idCaisse = id;
  }
  public String getIdCaisse() {
    return idCaisse;
  }
  public void setDescCaisse(String desc) {
  this.descCaisse = desc;
  }
  public String getDescCaisse() {
  return descCaisse;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public java.sql.Date getDaty() {
    return daty;
  }
  public void setReportpratique(double montant) {
    this.reportpratique = montant;
  }
  public double getReportpratique() {
    return reportpratique;
  }
  public double getDifference(){
    return this.getReportpratique()-this.getReporttheorique();
  }
  public void setReporttheorique(double montant) {
    this.reporttheorique = montant;
  }
  public double getReporttheorique() {
    return reporttheorique;
  }
}