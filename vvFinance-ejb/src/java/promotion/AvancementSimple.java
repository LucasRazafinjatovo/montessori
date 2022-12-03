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

public class AvancementSimple extends ClassMAPTable{

  private String id;
  private String semestre;
  private String etudiant;
  public AvancementSimple() {
    super.setNomTable("avancementsimple");
  }
  public String getTuppleID(){
  return id;
}
public String getAttributIDName(){
  return "id";
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
  public void setEtudiant(String etudiant) {
    this.etudiant = etudiant;
  }
  public String getEtudiant() {
    return etudiant;
  }
}