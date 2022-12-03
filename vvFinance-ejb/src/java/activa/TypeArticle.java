package activa;

import bean.*;
import java.util.*;
import java.sql.Connection;
import java.sql.Date;

public class TypeArticle extends ClassMAPTable {
  //String id;

 private String idTypeArticle;
  private String val;
  private String desce;

  public TypeArticle(){
   super.setNomTable("typeArticle");
 }

 public TypeArticle(String idTypeArticle,String val,String desce) throws Exception{
   super.setNomTable("typearticle");
   this.idTypeArticle = idTypeArticle;
   this.setVal(val);
   this.setDesce(desce);
 }

 public void construirePK(Connection c) throws Exception{
    super.setNomTable("typeArticle");
    this.preparePk("TYP","getSeqTypeArticle");
    this.setIdTypeArticle(makePK(c));
 }


 public TypeArticle(String idTypeArticle,String val,String desce,Connection c) {
   super.setNomTable("typeArticle");
   this.setIdTypeArticle(idTypeArticle);
    setVal(val);
    setDesce(desce);
  if(c==null){
    c= new utilitaire.UtilDB().GetConn();
  }
   setIndicePk("TYP");
   setNomProcedureSequence("getSeqTypeArticle");
    this.setIdTypeArticle(makePK());
 }

  public String getAttributIDName() {
    return "idTypeArticle";
  }

  public String getTuppleID() {
   return idTypeArticle;
  }
  public void setIdTypeArticle(String idTypeArticle) {
    this.idTypeArticle = idTypeArticle;
  }
  public String getIdTypeArticle() {
    return idTypeArticle;
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
