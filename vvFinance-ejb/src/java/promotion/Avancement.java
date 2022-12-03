package promotion;

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

public class Avancement extends ClassMAPTable{

  private String id;
  private String semestre;
  private String entree;
  private String remarque;
  private String options;

  public Avancement() {
    super.setNomTable("avancement");
  }
  public Avancement(String sem, String entre, String rem, String opt) {
    this.setSemestre(sem);
    this.setEntree(entre);
    this.setRemarque(rem);
    this.setOptions(opt);
  }
  public String getTuppleID(){
  return id;
}
public String getAttributIDName(){
  return "id";
}
public void construirePK(Connection c) throws Exception{
 super.setNomTable("avancement");
 this.preparePk("AVA","getSeqAvancement");
 this.setId(makePK(c));
  }
  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public void setSemestre(String semestre) {
    this.semestre = semestre;
  }
  public String getSemestre() {
    return semestre;
  }
  public void setEntree(String entree) {
    this.entree = entree;
  }
  public String getEntree() {
    return entree;
  }
  public void setRemarque(String remarque) {
    this.remarque = remarque;
  }
  public String getRemarque() {
    return remarque;
  }
  public void setOptions(String options) {
    this.options = options;
  }
  public String getOptions() {
    return options;
  }
}