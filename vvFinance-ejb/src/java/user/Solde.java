package user;


import java.rmi.RemoteException;
import bean.*;

import java.sql.*;

public class Solde extends ClassMAPTable{
  private String id;
  private double montant;
  private Date daty;

  public Solde(){
    this.setNomTable("solde");
  }
  public void construirePK(Connection c) throws Exception{
      super.setNomTable("solde");
      this.preparePk("SL","getSeqSolde");
      this.setId(makePK(c));
    }
    public String getAttributIDName()
      {
          return "id";
      }

      public String getTuppleID()
      {
          return id;
    }
  public Date getDaty() {
    return daty;
  }
  public String getId() {
    return id;
  }
  public double getMontant() {
    return montant;
  }
  public void setMontant(double montant) {
    this.montant = montant;
  }
  public void setId(String id) {
    this.id = id;
  }
  public void setDaty(Date daty) {
    this.daty = daty;
  }
}
