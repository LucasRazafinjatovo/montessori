package ded;
import bean.ClassMAPTable;
import java.sql.Connection;
public class OpTypeDatePaiement extends ClassMAPTable {
  private String id;
  private String idop;
  private java.sql.Date date_paiement;
  private String typee;
  private String remarque;
  public String getAttributIDName() {
    return "id";
  }
  public String getTuppleID() {
    return id;
  }
  public OpTypeDatePaiement(){
    this.setNomTable("type_date_paiement");
  }

  public void construirePK(Connection c) throws Exception{
      super.setNomTable("type_date_paiement");
      this.preparePk("ODP","GETSEQtypedatepaiement");
      this.setId(makePK(c));
  }
  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public void setIdop(String idop) {
    this.idop = idop;
  }
  public String getIdop() {
    return idop;
  }
  public void setDate_paiement(java.sql.Date date_paiement) {
    this.date_paiement = date_paiement;
  }
  public java.sql.Date getDate_paiement() {
    return date_paiement;
  }
  public void setTypee(String typee) {
    this.typee = typee;
  }
  public String getTypee() {
    return typee;
  }
  public void setRemarque(String remarque) {
    this.remarque = remarque;
  }
  public String getRemarque() {
    return remarque;
  }


}
