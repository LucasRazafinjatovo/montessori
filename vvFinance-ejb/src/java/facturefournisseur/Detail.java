package facturefournisseur;

import bean.ClassMAPTable;
import bean.CaractTable;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class Detail extends ClassMAPTable{

 private String id;
 private String idMere;
 private String designation;
 private double qte;
 private double puHT;
 private String remarque;

  public Detail() {
  }
  public Detail(String id, String idMere, String designation, double qte, double puHT, String rem) {
    this.setId(id);
    this.setIdMere(idMere);
    this.setDesignation(designation);
    this.setQte(qte);
    this.setPuHT(puHT);
    this.setRemarque(rem);
  }
  public Detail(String nomTable, String idMere, String designation, String qte, String puHT, String rem)throws Exception {
    this.setNomTable(nomTable);
    CaractTable ct=(CaractTable)new bean.CaractTableUtil().rechercher(2,nomTable)[0];
    this.setIndicePk(ct.getNomSeq());
    this.setNomProcedureSequence(ct.getNomProc());
    this.setId(makePK());
    this.setIdMere(idMere);
    this.setDesignation(designation);
    this.setQte(utilitaire.Utilitaire.stringToDouble(qte));
    this.setPuHT(utilitaire.Utilitaire.stringToDouble(puHT));
    this.setRemarque(rem);
  }
  public String getAttributIDName() {
   return "id";
 }
 public String getTuppleID() {
   return id;
  }
  public String getDesignation() {
    return designation;
  }
  public String getId() {
    return id;
  }
  public String getIdMere() {
    return idMere;
  }
  public double getPuHT() {
    return puHT;
  }
  public double getQte() {
    return qte;
  }
  public String getRemarque() {
    return remarque;
  }
  public void setRemarque(String remarque) {
    this.remarque = remarque;
  }
  public void setQte(double qte) {
    this.qte = qte;
  }
  public void setPuHT(double puHT) {
    this.puHT = puHT;
  }
  public void setIdMere(String idMere) {
    this.idMere = idMere;
  }
  public void setId(String id) {
    this.id = id;
  }
  public void setDesignation(String designation) {
    this.designation = designation;
  }
}