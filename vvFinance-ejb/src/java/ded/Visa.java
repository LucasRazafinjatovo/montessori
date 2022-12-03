package ded;

import bean.*;
import utilitaire.Utilitaire;


/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class Visa extends ClassMAPTable {

  private String id;
  private java.sql.Date daty;
  private String remarque;
  private String idObjet;
  public Visa() {
  }

  public Visa(String nomTable,String daty,String rem,String idO) throws Exception
  {
    super.setNomTable(nomTable);
    this.preparePk("VIS","getSeqVisa");
    this.setId(makePK());
    this.setDaty(Utilitaire.string_date("dd/MM/yyyy",daty));
    this.setRemarque(rem);
    this.setIdObjet(idO);
  }
  public Visa(String nomTable,String daty,String rem,String idO,int i) throws Exception
  {
    super.setNomTable(nomTable);
    this.preparePk("VIS","getSeqVisaPrevision");
    this.setId(makePK());
    this.setDaty(Utilitaire.string_date("dd/MM/yyyy",daty));
    this.setRemarque(rem);
    this.setIdObjet(idO);
  }
  public Visa(String nomTable,String nomProc,String suff,String daty,String rem,String idO) throws Exception
  {
    super.setNomTable(nomTable);
    this.preparePk(suff,nomProc);
    this.setId(makePK());
    this.setDaty(Utilitaire.string_date("dd/MM/yyyy",daty));
    this.setRemarque(rem);
    this.setIdObjet(idO);
  }
  public Visa(String nomTable,String id,String daty,String rem,String idO) throws Exception
  {
    super.setNomTable(nomTable);
    this.setId(id);
    this.setDaty(Utilitaire.string_date("dd/MM/yyyy",daty));
    this.setRemarque(rem);
    this.setIdObjet(idO);
  }
  public String getAttributIDName() {
    return "id";
  }
  public String getTuppleID() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public String getId() {
    return id;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public java.sql.Date getDaty() {
    return daty;
  }
  public void setRemarque(String remarque) {
    this.remarque = remarque;
  }
  public String getRemarque() {
    return remarque;
  }
  public void setIdObjet(String idObjet) {
    this.idObjet = idObjet;
  }
  public String getIdObjet() {
    return idObjet;
  }
}