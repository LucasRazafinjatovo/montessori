/***********************************************************************
 * Module:  Place.java
 * Author:  said
 * Purpose: Defines the Class Place
 ***********************************************************************/
package ventegazety;

import bean.*;
import java.sql.Connection;


public class Place extends ClassMAPTable{
  public Place(){
    super.setNomTable("place");
  }
  public Place(String val, String desce) throws Exception
  {
    super.setNomTable("place");
    this.preparePk("PLC","getSeqPlace");
    this.setId(makePK());
    setVal(val);
    setDesce(desce);
  }
  public Place(String val, String desce,Connection c) throws Exception
 {
   super.setNomTable("place");
   this.preparePk("PLC","getSeqPlace");
   setVal(val);
   setDesce(desce);
   if(c==null){
     c=new utilitaire.UtilDB().GetConn();
   }
   this.setId(makePK(c));
  }

   String id;
   private String val;
   private String desce;


   private Vendeur[] reference16;

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