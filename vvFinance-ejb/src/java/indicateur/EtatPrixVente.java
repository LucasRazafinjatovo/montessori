package indicateur;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.*;

public class EtatPrixVente extends ClassMAPTable{
	private String mois, journal;
	private double prixventeprevision;
	private int annee;
	
	public EtatPrixVente() {
		super.setNomTable("MONTANTVENTEPREVISION");
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
	
	public void setPrixventeprevision(double _nb) throws Exception{
		if (_nb<0) throw new Exception("Prix de vente invalide");
		this.prixventeprevision= _nb;
	}
	public double getPrixventeprevision() {
		return prixventeprevision;
	}
}