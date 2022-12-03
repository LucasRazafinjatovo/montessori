package pub;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */
import bean.*;
import java.sql.Connection;
import bean.*;
public class PubFacture extends ClassMAPTable{


  private String id;
  private String id1;
  private String id2;
  private String remarque;
  private double montantmere;
  private int etat;
  public PubFacture() {
    this.setNomTable("PubFacture");
  }
  public PubFacture(String idpub,String idfact, String rem,double montant,int eta) throws Exception{
    super.setNomTable("PubFacture");
    this.preparePk("PBF","getSEQPUBFACTURE");
    this.setId(makePK());
    this.setId1(idpub);
    this.setId2(idfact);
    this.setRemarque(rem);
    this.setMontantmere(montant);
    this.setEtat(eta);
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
  public void setId1(String id1) {
    this.id1 = id1;
  }
  public String getId1() {
    return id1;
  }
  public void setId2(String id2) {
    this.id2 = id2;
  }
  public String getId2() {
    return id2;
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
  public void setEtat(int etat) {
    this.etat = etat;
  }
  public int getEtat() {
    return etat;
  }

}