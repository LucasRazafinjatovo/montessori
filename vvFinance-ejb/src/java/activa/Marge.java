package activa;

import bean.*;
import java.util.*;
import java.sql.Connection;

public class Marge extends ClassMAPTable{
  private String idMarge;
  private double valeur;
  private java.sql.Date daty;

  public Marge(){
    super.setNomTable("marge");
  }

  public void construirePK(Connection c) throws Exception{
    super.setNomTable("marge");
    this.preparePk("MAR","getSeqMarge");
    this.setIdMarge(makePK(c));
  }

  public Marge(String val,String d){
    super.setNomTable("marge");
    this.setValeur(utilitaire.Utilitaire.stringToDouble(val));
    setDaty(java.sql.Date.valueOf(d));
    setIndicePk("MAR");
    setNomProcedureSequence("getSeqMarge");
    setIdMarge(makePK());
  }

  public String getAttributIDName() {
    return "idmarge";
  }

 public String getTuppleID() {
  return idMarge;
  }

  public String getIdMarge() {
    return idMarge;
  }
  public void setIdMarge(String idMarge) {
    this.idMarge = idMarge;
  }
  public void setValeur(double valeur) {
    this.valeur = valeur;
  }
  public double getValeur() {
    return valeur;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public java.sql.Date getDaty() {
    return daty;
  }
}
