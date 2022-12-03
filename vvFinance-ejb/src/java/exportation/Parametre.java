package exportation;

import bean.*;
import java.sql.Connection;


public class Parametre extends ClassMAPTable {

  private String id;
  private java.sql.Date dateInf;
  private java.sql.Date dateSup;

  public Parametre() throws Exception {
    super.setNomTable("INTERVALDATEEXPORT");
  }

  public void construirePK(Connection c) throws Exception{
     super.setNomTable("INTERVALDATEEXPORT");
    this.preparePk("INT","getSeqIntervalDateExport");
     this.setId(makePK(c));
  }
  public String getAttributIDName() {
    /**@todo Implement this bean.ClassMAPTable abstract method*/
    return "id";
  }
  public String getTuppleID() {
    /**@todo Implement this bean.ClassMAPTable abstract method*/
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public String getId() {
    return id;
  }
  public void setDateInf(java.sql.Date dateInf) {
    this.dateInf = dateInf;
  }
  public java.sql.Date getDateInf() {
    return dateInf;
  }
  public void setDateSup(java.sql.Date dateSup) {
    this.dateSup = dateSup;
  }
  public java.sql.Date getDateSup() {
    return dateSup;
  }
}