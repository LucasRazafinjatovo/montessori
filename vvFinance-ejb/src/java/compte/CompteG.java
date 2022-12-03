package compte;

import bean.ClassMAPTable;
import java.sql.Connection;
import utilitaire.*;

public class CompteG extends ClassMAPTable{

  private String id;
  private String val;
  private String desce;
  private java.sql.Date datyDebutValid;
  public CompteG() {
    super.setNomTable("compteG");
  }

  public String getTuppleID(){
    return id;
  }
  public String getAttributIDName(){
    return "id";
  }

  public void construirePK(Connection c) throws Exception{
    super.setNomTable("compteG");
    this.preparePk("CPT","getSeqCompteG");
    this.setId(makePK(c));
  }
  public void setId(String id) {
    this.id = id;
  }
  public String getId() {
    return id;
  }
  public void setVal(String val) {
    this.val = val;
  }
  public String getVal() {
    return val;
  }
  public void setDatyDebutValid(java.sql.Date datyDebutValid) {
    this.datyDebutValid = datyDebutValid;
  }
  public java.sql.Date getDatyDebutValid() {
    return datyDebutValid;
  }
  public void setDesce(String desce) {
    this.desce = desce;
  }
  public String getDesce() {
    return desce;
  }
}