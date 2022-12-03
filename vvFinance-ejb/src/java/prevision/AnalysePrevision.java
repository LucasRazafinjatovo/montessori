package prevision;
import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.*;

/**
 * <p>Title: Gestion des Depenses </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class AnalysePrevision extends ClassMAPTable{

  private Date daty;
  private double rec_prev;
  private double rec_eff;
  private double ecart_rec;
  private double dep_prev;
  private double dep_eff;
  private double ecart_dep;
  private double soldeth;
  private double soldepr;

  public AnalysePrevision() {
    super.setNomTable("AnalysePrevisioneffectif");
  }
  public void setDaty(Date daty) {
    this.daty = daty;
  }

public String getAttributIDName(){
  return "";
  }
  public String getTuppleID(){
  return null;
  }
  public Date getDaty() {
    return daty;
  }
  public double getDep_eff() {
    return dep_eff;
  }
  public double getDep_prev() {
    return dep_prev;
  }
  public double getRec_eff() {
    return rec_eff;
  }
  public double getRec_prev() {
    return rec_prev;
  }
  public double getEcart_dep() {
    if(ecart_dep!=0) return ecart_dep;
    return ecart_dep;
  }
  public double getEcart_rec() {
    if(ecart_rec!=0) return ecart_rec;
    return ecart_rec;
  }
  public void setEcart_rec(double ecart_rec) {
    this.ecart_rec = ecart_rec;
  }
  public void setEcart_dep(double ecart_dep) {
    this.ecart_dep = ecart_dep;
  }
  public void setRec_prev(double rec_prev) {
    this.rec_prev = rec_prev;
  }
  public void setRec_eff(double rec_eff) {
    this.rec_eff = rec_eff;
  }
  public void setDep_prev(double dep_prev) {
    this.dep_prev = dep_prev;
  }
  public void setDep_eff(double dep_eff) {
    this.dep_eff = dep_eff;
  }

  public static double[] getAllSommeMontant(AnalysePrevision[] l){
        double mont[] = {0,0,0,0,0,0,0}; //7 colonne
        if(l!=null){
                for(int i=0; i<l.length; i++){

                                mont[0] += l[i].getRec_prev();
                                mont[1] += l[i].getRec_eff();
                                mont[2] += l[i].getEcart_rec();
                                mont[3] += l[i].getDep_prev();
                                mont[4] += l[i].getDep_eff();
                                mont[5] += l[i].getEcart_dep();
                                mont[6] +=1;

                }
          }
          return mont;

  }
  public void setSoldeth(double soldeth) {
    this.soldeth = soldeth;
  }
  public double getSoldeth() {
    return soldeth;
  }
  public void setSoldepr(double soldepr) {
    this.soldepr = soldepr;
  }
  public double getSoldepr() {
    return soldepr;
  }
}