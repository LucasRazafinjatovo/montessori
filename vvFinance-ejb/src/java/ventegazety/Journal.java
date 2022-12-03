/***********************************************************************
 * Module:  Journal.java
 * Author:  said
 * Purpose: Defines the Class Place
 ***********************************************************************/
package ventegazety;

import bean.*;
import java.sql.Connection;


public class Journal extends ClassMAPTable{
  public Journal(){
    super.setNomTable("journal");
  }
  public Journal(String val, String desce) throws Exception
  {
    super.setNomTable("journal");
    this.preparePk("jrn","getSeq_Journal");
    this.setId(makePK());
    setVal(val);
    setDesce(desce);
  }
  public Journal(String val, String desce,Connection c) throws Exception
 {
   super.setNomTable("journal");
   this.preparePk("j","getSeq_Journal");
   setVal(val);
   setDesce(desce);
   if(c==null){
     c=new utilitaire.UtilDB().GetConn();
   }
   this.setId(makePK(c));
  }
  public void construirePK(Connection c) throws Exception
  {
    this.preparePk("j","getSeq_Journal");
    this.setId(makePK(c));
  }

   String id;
   private String val;
   private String desce;

   public String getAttributIDName() {
   return "id";
   }
   public String getTuppleID() {
     return id;
   }
   public String getDesce() {
    return desce;
  }
  public void setDesce(String desce) {
    this.desce = desce;
  }
  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public String getVal() {
    return val;
  }
  public void setVal(String val) {
    this.val = val;
  }

}