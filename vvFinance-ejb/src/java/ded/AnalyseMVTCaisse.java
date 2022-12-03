/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ded;

import bean.ClassMAPTable;
import java.sql.Date;

/**
 *
 * @author Doudou Tiarilala
 */
public class AnalyseMVTCaisse extends ClassMAPTable {

    private int mois;
    private double montantop, oppaye, opreste, montantor, orpaye, orreste, prevu, pratique, prevucumul, pratiquecumul;
    private Date daty;
    private int annee;

    public double getMontantop() {
        return montantop;
    }

    public void setMontantop(double montantop) {
        this.montantop = montantop;
    }

    public double getPrevucumul() {
        return prevucumul;
    }

    public void setPrevucumul(double prevucumul) {
        this.prevucumul = prevucumul;
    }

    public double getPratiquecumul() {
        return pratiquecumul;
    }

    public void setPratiquecumul(double pratiquecumul) {
        this.pratiquecumul = pratiquecumul;
    }

    public double getOppaye() {
        return oppaye;
    }

    public void setOppaye(double oppaye) {
        this.oppaye = oppaye;
    }

    public double getOpreste() {
        return opreste;
    }

    public void setOpreste(double opreste) {
        this.opreste = opreste;
    }

    public double getMontantor() {
        return montantor;
    }

    public void setMontantor(double montantor) {
        this.montantor = montantor;
    }

    public double getOrpaye() {
        return orpaye;
    }

    public void setOrpaye(double orpaye) {
        this.orpaye = orpaye;
    }

    public double getOrreste() {
        return orreste;
    }

    public void setOrreste(double orreste) {
        this.orreste = orreste;
    }

    public double getPrevu() {
        return prevu;
    }

    public void setPrevu(double prevu) {
        this.prevu = prevu;
    }

    public double getPratique() {
        return pratique;
    }

    public void setPratique(double pratique) {
        this.pratique = pratique;
    }

    @Override
    public String getTuppleID() {
        return "";
    }

    public AnalyseMVTCaisse(String table) {
        this.setNomTable(table);

    }

    public AnalyseMVTCaisse() {
        this.setNomTable("analysemvtcaisse2");
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public int getMois() {
        return mois;
    }

    public void setMois(int mois) {
        this.mois = mois;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }
    
    public static void traiterCumul(AnalyseMVTCaisse[] op, double report){
        for(int i=0; i<op.length ; i++){
            if(i == 0){
                op[i].setPrevucumul(op[i].getPrevu()+report);
                op[i].setPratiquecumul(op[i].getPratique()+report);
            }else{
                if(i>0){
                    op[i].setPrevucumul(op[i-1].getPrevucumul()+op[i].getPrevu());
                    op[i].setPratiquecumul(op[i-1].getPratiquecumul()+op[i].getPratique());
                }
            }
        }
    }

    public int getAnnee() {
        return annee;
    }

    public void setAnnee(int annee) {
        this.annee = annee;
    }        
}
