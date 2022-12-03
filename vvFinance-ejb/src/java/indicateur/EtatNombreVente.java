package indicateur;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.*;

public class EtatNombreVente extends ClassMAPTable{
	private String mois, journal;
	private int  annee;
	private double nombreventeprevisionnel, nombreimpression;
	
	public EtatNombreVente() {
		super.setNomTable("NBVENTEPREVISION");
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
	
	public void setNombreventeprevisionnel(double _nb) throws Exception{
		if (_nb<0) throw new Exception("Nombre de vente invalide");
		this.nombreventeprevisionnel= _nb;
	}
	public double getNombreventeprevisionnel() {
		return nombreventeprevisionnel;
	}
	
	public void setNombreimpression(double _nb) throws Exception{
		if (_nb<0) throw new Exception("Nombre d'impression invalide");
		this.nombreimpression= _nb;
	}
	public double getNombreimpression() {
		return nombreimpression;
	}
}