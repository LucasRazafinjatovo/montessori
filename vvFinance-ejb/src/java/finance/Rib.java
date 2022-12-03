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

public class Rib extends ClassMAPTable{

  private String id;
  private String numcheque;
  private String numreference;
  private String remarque;
  private java.sql.Date daty;
  private String designation;
  private double debit;
  private double credit;
  private String type;
  private double montant;
  private String caisse;
  public Rib(String numcheque, String numreference, String rem, java.sql.Date daty)
     {
         super.setNomTable("rib");
         setNumcheque(numcheque);
         setNumreference(numreference);
         setRemarque(rem);
         setDaty(daty);
     }

     public Rib()
     {
         this.setNomTable("rib");
    }
    public void construirePK(Connection c) throws Exception{
    super.setNomTable("rib");
    this.preparePk("RIB","getSeqRib");
    this.setId(makePK(c));
  }
    public String getAttributIDName()
    {
        return "id";
    }

    public String getTuppleID()
    {
        return String.valueOf(id);
    }
  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public void setNumcheque(String numcheque) {
    this.numcheque = numcheque;
  }
  public String getNumcheque() {
    return numcheque;
  }
  public void setNumreference(String numreference) {
    this.numreference = numreference;
  }
  public String getNumreference() {
    return numreference;
  }
  public void setRemarque(String remarque) {
    this.remarque = remarque;
  }
  public String getRemarque() {
    return remarque;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public java.sql.Date getDaty() {
    return daty;
  }
  public void setDesignation(String designation) {
    this.designation = designation;
  }
  public String getDesignation() {
    return designation;
  }
  public void setDebit(double debit) {
    this.debit = debit;
  }
  public double getDebit() {
    return debit;
  }
  public void setCredit(double credit) {
    this.credit = credit;
  }
  public double getCredit() {
    return credit;
  }
  public void setType(String type) {
    this.type = type;
  }
  public String getType() {
    return type;
  }
  public void setMontant(double montant) {
    this.montant = montant;
  }
  public double getMontant() {
    return montant;
  }
  public void setCaisse(String caisse) {
    this.caisse = caisse;
  }
  public String getCaisse() {
    return caisse;
  }
}