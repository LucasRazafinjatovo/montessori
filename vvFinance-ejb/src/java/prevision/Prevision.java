package prevision;
import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.*;
/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class Prevision  extends ClassMAPTable{

  private String id;
  private Date daty;
  private double montant;
  private String remarque;
  private int etat;

  public Prevision() {
    super.setNomTable("OPPREVISION");
  }

  public Prevision(String idprev, Date dat, double montant, String remarque){
    this.setRemarque(remarque);
    this.setDaty(dat);
    this.setMontant(montant);
    this.setId(idprev);
  }
  public String getTuppleID(){
   return id;
 }
 public String getAttributIDName(){
   return "id";
  }
  public void setId(String id) {
    this.id = id;
  }
  public String getId() {
    return id;
  }
  public Date getDaty() {
    return daty;
  }
  public void setDaty(Date datycreation) {
    this.daty = datycreation;
  }
  public int getEtat() {
    return etat;
  }
  public void setEtat(int etat) {
    this.etat = etat;
  }
  public double getMontant() {
    return montant;
  }
  public String getRemarque() {
    return remarque;
  }
  public void setRemarque(String remarque) {
    this.remarque = remarque;
  }
  public void setMontant(double montant) {
    this.montant = montant;
  }

}