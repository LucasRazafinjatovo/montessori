package facturefournisseur;
import bean.*;
import java.util.*;
import java.sql.Connection;
/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class LiaisonFFPrevisionLc extends ClassMAPTable{

  private String id;
  private String idff;
  private String idlc;
  private String remarque;
  private double montantmere;
  private double etat;
  public LiaisonFFPrevisionLc() {
    super.setNomTable("liaisonffprevisionlc");
  }
  public void construirePK(Connection c) throws Exception{
    super.setNomTable("liaisonffprevisionlc");
    this.preparePk("LFL","getSeqLiaisonFFPrevisionLc");
    this.setId(makePK(c));
  }
  public String getAttributIDName() {
     return "id";
   }
  public String getTuppleID() {
     return id;
  }
  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public void setIdff(String idff) {
    this.idff = idff;
  }
  public String getIdff() {
    return idff;
  }
  public void setIdlc(String idlc) {
    this.idlc = idlc;
  }
  public String getIdlc() {
    return idlc;
  }
  public void setRemarque(String remarque) {
    this.remarque = remarque;
  }
  public String getRemarque() {
    return remarque;
  }
  public void setMontantmere(double montantmere) {
    this.montantmere = montantmere;
  }
  public double getMontantmere() {
    return montantmere;
  }
  public void setEtat(double etat) {
    this.etat = etat;
  }
  public double getEtat() {
    return etat;
  }
}