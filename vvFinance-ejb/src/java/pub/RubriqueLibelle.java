package pub;

import bean.*;
import java.sql.Connection;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class RubriqueLibelle extends ClassMAPTable  {

  public RubriqueLibelle() {

    this.setNomTable("rubrique_libelle");
  }
  public String getAttributIDName() {
    return "id";
  }
  public String getTuppleID() {
    return id;
  }

  private String id;
  private String idjournal;
  private String libelle;
  private String val;
  private String desce;
  private java.sql.Date datyoperation;
  private String journal;




  public void setLibelle(String libelle) {
    this.libelle = libelle;
  }
  public String getLibelle() {
    return libelle;
  }

  public void setJournal(String journal) {
    this.journal = journal;
  }
  public String getJournal() {
    return journal;
  }

  public void setIdjournal(String idJ)
  {
    this.idjournal=idJ;
  }
  public String getIdjournal(){
    return idjournal;
  }
  public void setVal(String val)
  {
    this.val=val;
  }
  public String getVal(){
    return val;
  }
  public void setDesce(String desce)
  {
    this.desce=desce;
  }
  public String getDesce(){
    return desce;
  }
  public void setDatyoperation(java.sql.Date daty) {
this.datyoperation = daty;
}
public java.sql.Date getDatyoperation() {
return datyoperation;
  }
  public String getId() {
  return id;
}
public void setId(String id) {
  this.id = id;
  }


}