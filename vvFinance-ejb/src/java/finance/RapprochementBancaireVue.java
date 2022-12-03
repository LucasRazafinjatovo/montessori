package finance;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.Utilitaire;

public class RapprochementBancaireVue extends ClassMAPTable
{
  private String id;
  private String designation;
  private String numcheque;
  private String numreference;
  private String remarque;
  private Date daty;
  private double debit;
  private double credit;
  private String type;
  private String caisse;



  public RapprochementBancaireVue() {
    super.setNomTable("RapprochementBancaire");
  }

  public String getAttributIDName() {
    return "id";
  }
  public String getTuppleID() {
    return this.id;
  }

  public void setDesignation(String designation) {
    this.designation = designation;
  }
  public String getDesignation() {
    return this.designation;
  }



  public void setId(String id)
  {
    this.id = id;
  }
  public String getId() {
    return this.id;
  }
  public String getCaisse() {
    return caisse;
  }
  public double getCredit() {
    return credit;
  }
  public Date getDaty() {
    return daty;
  }
  public double getDebit() {
    return debit;
  }
  public String getNumcheque() {
    return numcheque;
  }
  public String getNumreference() {
    return numreference;
  }
  public String getRemarque() {
    return remarque;
  }
  public String getType() {
    return type;
  }
  public void setType(String type) {
    this.type = type;
  }
  public void setRemarque(String remarque) {
    this.remarque = remarque;
  }
  public void setNumreference(String numreference) {
    this.numreference = numreference;
  }
  public void setNumcheque(String numcheque) {
    this.numcheque = numcheque;
  }
  public void setDebit(double debit) {
    this.debit = debit;
  }
  public void setDaty(Date daty) {
    this.daty = daty;
  }
  public void setCredit(double credit) {
    this.credit = credit;
  }
  public void setCaisse(String caisse) {
    this.caisse = caisse;
  }


}