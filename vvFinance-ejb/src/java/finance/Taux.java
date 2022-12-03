package finance;

import bean.*;


/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class Taux extends ClassMAPTable {
  public double dollar;
  public double euro;
  public int marge;
  public java.sql.Date dateDebutValidite;
  public String id;
  public Taux(String i,double doll,double eur,int marg,java.sql.Date dateDebutValidit) {
    super.setNomTable("Taux");
    id=i;
    dollar=doll;
    euro=eur;
    marge=marg;
    this.setDateDebutValidite(dateDebutValidit);
  }
  public Taux(double doll,double eur,int marg,java.sql.Date dateDebutValidit) {
    super.setNomTable("Taux");
    setIndicePk("TX");
    setNomProcedureSequence("getSeqTaux");
    this.setId(makePK());
    dollar=doll;
    euro=eur;
    marge=marg;
    this.setDateDebutValidite(dateDebutValidit);
  }
  public Taux(String i,double doll,double eur,int marg) {
    super.setNomTable("Taux");
    id=i;
    dollar=doll;
    euro=eur;
    marge=marg;
    this.setDateDebutValidite(utilitaire.Utilitaire.dateDuJourSql());
  }
  public Taux(double doll,double eur,int marg) {
    super.setNomTable("Taux");
    dollar=doll;
    euro=eur;
    marge=marg;
    this.setDateDebutValidite(utilitaire.Utilitaire.dateDuJourSql());
  }
  public String getAttributIDName() {
    return "id";
  }
  public String getTuppleID() {
    return String.valueOf(id);
  }
  public void setDollar(int dollar) {
    this.dollar = dollar;
  }
  public double getDollar() {
    return dollar;
  }
  public void setEuro(int euro) {
    this.euro = euro;
  }
  public double getEuro() {
    return euro;
  }
  public void setId(String id) {
    this.id = id;
  }
  public String getId() {
    return id;
  }
  public void setMarge(int marge) {
    this.marge = marge;
  }
  public int getMarge() {
    return marge;
  }
  public void setDateDebutValidite(java.sql.Date dateDebutValidite) {
    this.dateDebutValidite = dateDebutValidite;
  }
  public java.sql.Date getDateDebutValidite() {
    return dateDebutValidite;
  }
}