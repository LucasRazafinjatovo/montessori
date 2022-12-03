package indicateur;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.*;

public class ComparaisonNombreVente extends ClassMAPTable{
	private String mois, journal;
	private int annee;
	private double production,impressionprev,venteprev,prise,vente,diffvente;
	
	public ComparaisonNombreVente() {
		super.setNomTable("COMPARAISONNOMBREVENTE");
	}
	
	public String getTuppleID(){
		return null;
	}
	public String getAttributIDName(){
		return "mois";
	}
	public void setMois(String mois) {
		this.mois = mois;
	}
	public String getMois() {
		return mois;
	}
	public void setJournal(String journal) {
		this.journal = journal;
	}
	public String getJournal() {
		return journal;
	}
	
	public void setAnnee(int _annee) throws Exception{
		if (_annee<1970) throw new Exception("Ann&eacute;e invalide");
		this.annee= _annee;
	}
	public int getAnnee() {
		return annee;
	}
	
	public void setProduction(double _nb) throws Exception{
		if (_nb<0) throw new Exception("Production invalide");
		this.production= _nb;
	}
	public double getProduction() {
		return production;
	}
	
	public void setImpressionprev(double _nb) throws Exception{
		if (_nb<0) throw new Exception("Impression invalide");
		this.impressionprev= _nb;
	}
	public double getImpressionprev() {
		return impressionprev;
	}
	public void setVenteprev(double _nb) throws Exception{
		if (_nb<0) throw new Exception("Vente prevu invalide");
		this.venteprev= _nb;
	}
	public double getVenteprev() {
		return venteprev;
	}
	public void setPrise(double _nb) throws Exception{
		if (_nb<0) throw new Exception("Pprise invalide");
		this.prise= _nb;
	}
	public double getPrise() {
		return prise;
	}
	public void setvente(double _nb) throws Exception{
		if (_nb<0) throw new Exception("Vente invalide");
		this.vente= _nb;
	}
	public double getVente() {
		return vente;
	}
	public void setDiffvente(double _nb) throws Exception{
		if (_nb<0) throw new Exception("Difference invalide");
		this.diffvente= _nb;
	}
	public double getDiffvente() {
		return diffvente;
	}
	
}