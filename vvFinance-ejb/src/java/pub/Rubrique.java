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

public class Rubrique extends ClassMAPTable {

  public Rubrique() {
    super.setNomTable("rubrique");
  }

  String id;
  private String journal;
  private String libelle;
  private java.sql.Date datyoperation;
  public String getAttributIDName() {
    return "id";
  }
  public String getTuppleID() {
    return id;
  }
  public void construirePK(Connection c) throws Exception
  {
    super.setNomTable("rubrique");
    this.preparePk("RUB","getSeqRubrique");
    this.setId(makePK(c));
  }
  public void setJournal(String journal) {
    this.journal = journal;
  }
  public String getJournal() {
    return journal;
  }
  public void setLibelle(String libelle) {
    this.libelle = libelle;
  }
  public String getLibelle() {
    return libelle;
  }
  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public void setDatyoperation(java.sql.Date daty) {
  this.datyoperation = daty;
}
public java.sql.Date getDatyoperation() {
  return datyoperation;
  }
}