package ded;

import bean.*;
import utilitaire.Utilitaire;
import java.sql.Connection;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class LiaisonOrdrePayement extends ClassMAPTable {

  private String id;
  private String id1;
  private java.sql.Date daty;
  private String remarque;
  public LiaisonOrdrePayement() {
    super.setNomTable("LiaisonOrdrePayement");
  }
  public LiaisonOrdrePayement(String id1, String idordre,String rmq){
    super.setNomTable("LiaisonOrdrePayement");
    this.setId1(id1);
    this.setDaty(Utilitaire.dateDuJourSql());
    this.setRemarque(rmq);
  }

  public String getAttributIDName() {
    return "id";
  }
  public String getTuppleID() {
    return id;
  }
  public void construirePK(Connection c) throws Exception{
    super.setNomTable("LiaisonOrdrePayement");
    this.preparePk("LOP","getSeqLiaisonOrdrePayement");
    this.setId(makePK(c));
  }
  public java.sql.Date getDaty() {
    return daty;
  }
  public String getId() {
    return id;
  }
  public String getId1() {
    return id1;
  }
  public String getRemarque() {
    return remarque;
  }
  public void setRemarque(String remarque) {
    this.remarque = remarque;
  }
  public void setId1(String id1) {
    this.id1 = id1;
  }
  public void setId(String id) {
    this.id = id;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }

}