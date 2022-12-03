package finance;

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

public class Cloture extends ClassMAPTable {

  private String id;
  private java.sql.Date datySaisie;
  private java.sql.Date daty;
  private String remarque;
  private String typeObjet;
  private String objet;
  public Cloture() {
    super.setNomTable("Cloture");
  }
  public void construirePK(Connection c) throws Exception{
     super.setNomTable("cloture");
     this.preparePk("CLO","getSeqCloture");
     this.setId(makePK(c));
  }
  public Cloture(String idC,java.sql.Date d,String r,java.sql.Date dS,String typeObjet)
  {
    super.setNomTable("cloture");
    //setId(i);
    setObjet(idC);
    setDaty(d);
    setRemarque(r);
    setDatySaisie(dS);
    setTypeObjet(typeObjet);
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
  public void setDatySaisie(java.sql.Date datySaisie) {
    this.datySaisie = datySaisie;
  }
  public java.sql.Date getDatySaisie() {
    return datySaisie;
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
  public void setTypeObjet(String typeObjet) {
    this.typeObjet = typeObjet;
  }
  public String getTypeObjet() {
    return typeObjet;
  }
  public void setObjet(String objet) {
    this.objet = objet;
  }
  public String getObjet() {
    return objet;
  }
}