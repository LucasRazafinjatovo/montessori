package activa;

import bean.*;
import java.util.*;
import java.sql.Connection;

public class CodeRV extends ClassMAPTable{
  String id;
  int nb;
  private String idCodeRV;
  private String val;
  private String desce;

  public CodeRV(){
    super.setNomTable("coderv");
  }

  public CodeRV(String idCodeRV,String val,String desce){
     super.setNomTable("coderv");
     this.setIdCodeRV(idCodeRV);
     setVal(val);
     setDesce(desce);
  }

  public void construirePK(Connection c) throws Exception{
     super.setNomTable("coderv");
     this.preparePk("CODE","getSeqCodeRV");
     this.setIdCodeRV(makePK(c));
  }

  public CodeRV(String idCodeRV,String val,String desce,Connection c){
    super.setNomTable("coderv");
    this.setIdCodeRV(idCodeRV);
    setVal(val);
    setDesce(desce);
    if(c==null){
       c = new utilitaire.UtilDB().GetConn();
    }
  }

  public String getAttributIDName() {
    return "idcoderv";
  }
  public String getTuppleID() {
    return idCodeRV;
  }
  public void setIdCodeRV(String idCodeRV) {
    this.idCodeRV = idCodeRV;
  }
  public String getIdCodeRV() {
    return idCodeRV;
  }
  public void setVal(String val) {
    this.val = val;
  }
  public String getVal() {
    return val;
  }
  public void setDesce(String desce) {
    this.desce = desce;
  }
  public String getDesce() {
    return desce;
  }

}
