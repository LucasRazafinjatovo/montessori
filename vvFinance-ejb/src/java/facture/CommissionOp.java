package facture;
import bean.*;
import java.sql.Connection;
import utilitaire.UtilDB;

public class CommissionOp extends ClassMAPTable{

  private String id;
  private String factclient;
  private String idop;
  private String pourcentage;
  public CommissionOp() {
    this.setNomTable("commissionop");
  }
  public void construirePK(Connection c) throws Exception{
      super.setNomTable("commissionop");
      this.preparePk("CMO","getSeqCommissionOp");
      this.setId(makePK(c));
  }
  public CommissionOp(String facture, String op) throws Exception
{
   super.setNomTable("CommissionOp");
   this.preparePk("CMO","getSeqCommissionOp");
   this.setId(makePK());
   setFactclient(facture);
   setIdop(op);
 }
 public CommissionOp(String facture, String op,String pourcentage) throws Exception
{
   super.setNomTable("CommissionOp");
   this.preparePk("CMO","getSeqCommissionOp");
   this.setId(makePK());
   setFactclient(facture);
   setIdop(op);
   setPourcentage(pourcentage);
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
  public void setFactclient(String factclient) {
    this.factclient = factclient;
  }
  public String getFactclient() {
    return factclient;
  }
  public void setIdop(String idop) {
    this.idop = idop;
  }
  public String getIdop() {
    return idop;
  }
  public void setPourcentage(String pourcentage) {
    this.pourcentage = pourcentage;
  }
  public String getPourcentage() {
    return pourcentage;
  }
}