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

public class OpSolde extends ClassMAPTable{

  private String id;
  private String idop;
  private String idsolde;
  public OpSolde() {
    super.setNomTable("OpSolde");
  }
  public OpSolde(String o,String s) {
    super.setNomTable("OpSolde");
    setIndicePk("OPS");
    setNomProcedureSequence("getSeqopSolde");
    setId(makePK());
    this.setIdop(o);
    this.setIdsolde(s);
  }
  public void construirePK(Connection c) throws Exception{
   super.setNomTable("OpSolde");
   this.preparePk("OPS","getSeqopSolde");
   this.setId(makePK(c));
  }
  public String getTuppleID(){
    return id;
  }
  public String getAttributIDName(){
    return "id";
  }
  public void setId(String id) {
    this.id = id;
  }
  public String getId() {
    return id;
  }
  public void setIdop(String idop) {
    this.idop = idop;
  }
  public String getIdop() {
    return idop;
  }
  public void setIdsolde(String idsolde) {
    this.idsolde = idsolde;
  }
  public String getIdsolde() {
    return idsolde;
  }
}