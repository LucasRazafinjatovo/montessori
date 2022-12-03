/***********************************************************************
 * Module:  Typevendeur.java
 * Author:  said
 * Purpose: Defines the Class Typevendeur
 ***********************************************************************/
package ventegazety;

import bean.*;
import java.sql.Connection;


public class Typevendeur extends ClassMAPTable{
  public Typevendeur(){
    super.setNomTable("typevendeur");
  }
  public Typevendeur(String val, String desce) throws Exception
  {
    super.setNomTable("typevendeur");
    this.preparePk("TPV","getSeqTypv");
    this.setId(makePK());
    setVal(val);
    setDesce(desce);
  }
  public Typevendeur(String val, String desce,Connection c) throws Exception
  {
    super.setNomTable("typevendeur");
    this.preparePk("TPV","getSeqTypv");
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