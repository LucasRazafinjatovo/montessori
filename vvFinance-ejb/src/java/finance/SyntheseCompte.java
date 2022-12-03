package finance;

import java.sql.Date;
import bean.ClassMAPTable;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class SyntheseCompte extends ClassMAPTable{

  private java.sql.Date daty;
  private double montant;
  private String idCaisse;
  private String caisse;
  private String catCompte;
  private String cat;
  private String idType;
  private String val;
  public SyntheseCompte() {
  }
  public SyntheseCompte(Date d,double mont,String idC,String cais,String catC,String ca) {
    this.setDaty(d);
    this.setMontant(mont);
    this.setIdCaisse(idC);
    this.setCaisse(cais);
    this.setCatCompte(catC);
    this.setCat(ca);
  }
  public SyntheseCompte(Date d,double mont,String idC,String cais,String catC,String ca,String idT,String v) {
    this.setDaty(d);
    this.setMontant(mont);
    this.setIdCaisse(idC);
    this.setCaisse(cais);
    this.setCatCompte(catC);
    this.setCat(ca);
    this.setIdType(idT);
    this.setVal(v);
  }
  public java.sql.Date getDaty() {
    return daty;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public void setMontant(double montant) {
    this.montant = montant;
  }
  public double getMontant() {
    return montant;
  }
  public void setIdCaisse(String idCaisse) {
    this.idCaisse = idCaisse;
  }
  public String getIdCaisse() {
    return idCaisse;
  }
  public void setCaisse(String caisse) {
    this.caisse = caisse;
  }
  public String getCaisse() {
    return caisse;
  }
  public void setCatCompte(String catCompte) {
    this.catCompte = catCompte;
  }
  public String getCatCompte() {
    return catCompte;
  }
  public void setCat(String cat) {
    this.cat = cat;
  }
  public String getCat() {
    return cat;
  }
  public String getAttributIDName()
  {
      return "daty";
  }

  public String getTuppleID()
  {
      return String.valueOf(daty);
    }
  public void setIdType(String idType) {
    this.idType = idType;
  }
  public String getIdType() {
    return idType;
  }
  public void setVal(String val) {
    this.val = val;
  }
  public String getVal() {
    return val;
  }
}