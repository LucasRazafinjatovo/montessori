package indicateur;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.*;

public class ComparaisonPrixVente extends ClassMAPTable{
	private String mois, journal;
	private int annee;
	private double prixventeprevision, venteeffectif, paiement, impaye;

	public ComparaisonPrixVente() {
		super.setNomTable("COMPARAISONPRIX");
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
	//prixventeprevision, venteeffectif, paiement, impaye
	public void setPrixventeprevision(double _nb) throws Exception{
		if (_nb<0) throw new Exception("Prevision invalide");
		this.prixventeprevision= _nb;
	}
	public double getPrixventeprevision() {
		return prixventeprevision;
	}

	public void setVenteeffectif(double _nb) throws Exception{
		if (_nb<0) throw new Exception("Effectif invalide");
		this.venteeffectif= _nb;
	}
	public double getVenteeffectif() {
		return venteeffectif;
	}
	public void setPaiement(double _nb) throws Exception{
		if (_nb<0) throw new Exception("Paye invalide");
		this.paiement= _nb;
	}
	public double getPaiement() {
		return paiement;
	}
	public void setImpaye(double _nb) throws Exception{
		this.impaye= _nb;
	}
	public double getImpaye() {
		return impaye;
	}

}