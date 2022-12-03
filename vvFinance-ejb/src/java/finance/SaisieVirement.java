package finance;

import bean.*;
import ded.VisaUtil;
import ded.Visa;
import java.sql.Connection;
import utilitaire.UtilDB;


/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class SaisieVirement extends ClassMAPTable {

  private String id;
  private double montant;
  private String devise;
  private String caisseDep;
  private String caisseArr;
  private String modePay;
  private String remarque;
  private java.sql.Date daty;
  private String numcheque ;
public void setNumcheque(String numcheque) {
   this.numcheque = numcheque;
 }
 public String getNumcheque() {
   return numcheque;
 }
public SaisieVirement(double mont,String dev,String cD,String cA,String mP,String rem,String daty,String numcheque) {
 this.setNomTable("saisieVirement");
 this.setNomProcedureSequence("getseqSaisieVirement");
 this.setIndicePk("VIR");
 this.setId(makePK());
 this.setMontant(mont);
 this.setDevise(dev);
 this.setCaisseDep(cD);
 this.setCaisseArr(cA);
 this.setModePay(mP);
 this.setRemarque(rem);
 this.setNumcheque(numcheque);
 this.setDaty(utilitaire.Utilitaire.string_date("dd/MM/yyyy",daty));
 }

  public SaisieVirement() {
    this.setNomTable("saisieVirement");
  }
  public SaisieVirement(double mont,String dev,String cD,String cA,String mP,String rem,String daty) {
    this.setNomTable("saisieVirement");
    this.setNomProcedureSequence("getseqSaisieVirement");
    this.setIndicePk("VIR");
    this.setId(makePK());
    this.setMontant(mont);
    this.setDevise(dev);
    this.setCaisseDep(cD);
    this.setCaisseArr(cA);
    this.setModePay(mP);
    this.setRemarque(rem);
    this.setDaty(utilitaire.Utilitaire.string_date("dd/MM/yyyy",daty));
  }
  public String getAttributIDName() {
    return "id";
  }
  public Visa getVisa()throws Exception
  {
    Connection c=null;
    try {
      c=new UtilDB().GetConn();
      return getVisa(c);
    }
    catch (Exception ex) {
      ex.printStackTrace();
      throw new Exception(ex.getMessage()) ;
    }
    finally{
      if(c!=null)c.close();
    }
  }
  public ded.Visa getVisa(Connection c) throws Exception
  {
    VisaUtil vu=new VisaUtil();
    vu.setNomTable("visaVirement");
    Visa[]v=(Visa[])vu.rechercher(4,this.getTuppleID(),c);
    if (v.length==0)return null;
    return v[0];
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
  public void setMontant(double montant) {
    this.montant = montant;
  }
  public double getMontant() {
    return montant;
  }
  public void setDevise(String devise) {
    this.devise = devise;
  }
  public String getDevise() {
    return devise;
  }
  public void setCaisseDep(String caisseDep) {
    this.caisseDep = caisseDep;
  }
  public String getCaisseDep() {
    return caisseDep;
  }
  public void setCaisseArr(String caisseArr) {
    this.caisseArr = caisseArr;
  }
  public String getCaisseArr() {
    return caisseArr;
  }
  public void setModePay(String modePay) {
    this.modePay = modePay;
  }
  public String getModePay() {
    return modePay;
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
}