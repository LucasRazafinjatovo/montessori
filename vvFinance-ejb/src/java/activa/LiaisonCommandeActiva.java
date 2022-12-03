package activa;

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

public class LiaisonCommandeActiva extends ClassMAPTable {

  private String id;
  private String idcommande;
  private String noteExplicative;
  private java.sql.Date daty;
  private java.sql.Date datyLivraison;
  private int reduction;
  public LiaisonCommandeActiva() {
    super.setNomTable("LiaisonCommandeActiva");
  }
  public void construirePK(Connection c) throws Exception{
    super.setNomTable("LiaisonCommandeActiva");
    this.preparePk("LCA","getSeqLiaisonCommandeActiva");
    this.setId(makePK(c));
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
  public void setIdcommande(String idcommande) {
    this.idcommande = idcommande;
  }
  public String getIdcommande() {
    return idcommande;
  }
  public void setNoteExplicative(String noteExplicative) {
    this.noteExplicative = noteExplicative;
  }
  public String getNoteExplicative() {
    return noteExplicative;
  }
  public void setReduction(int reduction) {
    this.reduction = reduction;
  }
  public int getReduction() {
    return reduction;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public java.sql.Date getDaty() {
    return daty;
  }
  public void setDatyLivraison(java.sql.Date datyLivraison) {
    this.datyLivraison = datyLivraison;
  }
  public java.sql.Date getDatyLivraison() {
    return datyLivraison;
  }
}