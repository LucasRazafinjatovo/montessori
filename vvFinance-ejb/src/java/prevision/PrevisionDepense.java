package prevision;
import bean.ClassMAPTable;
import java.sql.Connection;
import utilitaire.*;
/**
 * <p>Title: Gestion des depenses </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class PrevisionDepense extends ClassMAPTable{

  private String id;
  private java.sql.Date daty;
  private double montant;
  private String remarque;
  private String idor;
  public PrevisionDepense() {
    super.setNomTable("opvita");
  }
  public PrevisionDepense(java.sql.Date daty,String description,double montant,String idor) {
    super.setNomTable("opvita");
    setIndicePk("OPV");
    setNomProcedureSequence("getSeqOpVita");
    setId(makePK());
    setDaty(daty);
    setRemarque(description);
    setMontant(montant);
    setIdor(idor);
  }
  public String getTuppleID(){
    return id;
  }
  public String getAttributIDName(){
    return "id";
  }
  public void construirePK(Connection c) throws Exception{
    super.setNomTable("opvita");
    this.preparePk("OPV","getSeqOpVita");
    this.setId(makePK(c));
  }
  public void setId(String id) {
    this.id = id;
  }
  public String getId() {
    return id;
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
  public void setRemarque(String description) {
    this.remarque = description;
  }
  public String getRemarque() {
    return remarque;
  }
  public String getIdor() {
    return idor;
  }
  public void setIdor(String idor) {
    this.idor = idor;
  }


}