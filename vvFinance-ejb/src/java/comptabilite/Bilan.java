package comptabilite;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.*;

public class Bilan extends ClassMAPTable{
	private String exercice, exercicePrev, intitule;
	private double brut, amort, net, netPrev;
	
	public Bilan (){
		super.setNomTable("");
	}
	
	public Bilan (String exercice, String intitule, double brut, double amort){
		super.setNomTable("");
		this.setExercice(exercice);
		this.setIntitule(intitule);
		this.setBrut(brut);
		this.setAmort(amort);
		this.setNetCalc();
	}
	
	public String getTuppleID(){
		return exercice;
	}
	public String getAttributIDName(){
		return "exercice";
	}
	public void setExercice(String exercice) {
		this.exercice = exercice;
	}
	public String getExercice() {
		return exercice;
	}
	public void setExercicePrev(String exercicePrev) {
		this.exercicePrev = exercicePrev;
	}
	public String getExercicePrev() {
		return exercicePrev;
	}
	public void setIntitule(String intitule) {
		this.intitule = intitule;
	}
	public String getIntitule() {
		return intitule;
	}
	public void setBrut(double brut) {
		this.brut = brut;
	}
	public double getBrut() {
		return brut;
	}
	public void setAmort(double amort) {
		this.amort = amort;
	}
	public double getAmort() {
		return amort;
	}
	public void setNet(double net) {
		this.net = net;
	}
	public double getNet() {
		return net;
	}
	public void setNetPrev(double netPrev) {
		this.netPrev = netPrev;
	}
	public double getNetPrev() {
		return netPrev;
	}
	public void setNetCalc() {
		this.setNet(this.getBrut()-this.getAmort());
	}
}