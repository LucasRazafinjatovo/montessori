package comptabilite;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.*;

public class Balance extends ClassMAPTable{
	private String exercice, societe,  intitule;
	private int compte,annee;
	private double initdebit, initcredit, mvtdebit, 
	mvtcredit, soldedebit, soldecredit;
	private Date datedebut, datefin, daty, echeance;
	
	public Balance() {
		super.setNomTable("balance_groupe_libelle");
	}

	public String getTuppleID(){
		return exercice;
	}
	public String getAttributIDName(){
		return "exercice";
	}
	public void setSociete(String societe) {
		this.societe = societe;
	}
	public String getSociete() {
		return societe;
	}
	public void setExercice(String exercice) {
		this.exercice = exercice;
	}
	public String getExercice() {
		return exercice;
	}
	public void setCompte(int compte) {
		this.compte = compte;
	}
	public int getCompte() {
		return compte;
	}
	public void setIntitule(String intitule) {
		this.intitule = intitule;
	}
	public String getIntitule() {
		return intitule;
	}
	public void setInitdebit(double initdebit) {
		this.initdebit = initdebit;
	}
	public double getInitdebit() {
		return initdebit;
	}
	public void setInitcredit(double initcredit) {
		this.initcredit = initcredit;
	}
	public double getInitcredit() {
		return initcredit;
	}
	public void setMvtdebit(double mvtdebit) {
		this.mvtdebit = mvtdebit;
	}
	public double getMvtdebit() {
		return mvtdebit;
	}
	public void setMvtcredit(double mvtcredit) {
		this.mvtcredit = mvtcredit;
	}
	public double getMvtcredit() {
		return mvtcredit;
	}
	public void setSoldedebit(double soldedebit) {
		this.soldedebit = soldedebit;
	}
	public double getSoldedebit() {
		return soldedebit;
	}
	public void setSoldecredit(double soldecredit) {
		this.soldecredit = soldecredit;
	}
	public double getSoldecredit() {
		return soldecredit;
	}
	
	public void setDatedebut(Date daty) {
		this.datedebut = daty;
	}
	public Date getDatedebut() {
		return datedebut;
	}
	public void setDatefin(Date daty) {
		this.datefin = daty;
	}
	public Date getDatefin() {
		return datefin;
	}
	public void setDaty(Date daty) {
		this.daty = daty;
	}
	public Date getDaty() {
		return daty;
	}
	public void setEcheance(Date daty) {
		this.echeance = daty;
	}
	public Date getEcheance() {
		return echeance;
	}

    /**
     * @return the annee
     */
    public int getAnnee() {
        return annee;
    }

    /**
     * @param annee the annee to set
     */
    public void setAnnee(int annee) {
        this.annee = annee;
    }
}