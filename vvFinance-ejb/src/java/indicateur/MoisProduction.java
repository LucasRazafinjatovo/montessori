package indicateur;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.*;

public class MoisProduction extends ClassMAPTable{
	private String id, journal;
	private int mois, annee, nbjrs;
	
	public MoisProduction() {
		super.setNomTable("MOISPRODUCTION");
	}
	
	public void construirePK(Connection c) throws Exception{
		super.setNomTable("MOISPRODUCTION");
		this.preparePk("MP","GETSEQMOISPRODUCTION");
		this.setId(makePK(c));
	}

	public String getTuppleID(){
		return id;
	}
	public String getAttributIDName(){
		return "id";
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getId() {
		return id;
	}
	public void setJournal(String journal) {
		this.journal = journal;
	}
	public String getJournal() {
		return journal;
	}
	
	public void setMois(int _mois) throws Exception{
		if (_mois<0 || _mois>12) throw new Exception("Mois invalide");
		this.mois= _mois;
	}
	public int getMois() {
		return mois;
	}
	
	public void setAnnee(int _annee) throws Exception{
		if (_annee<1970) throw new Exception("Ann&eacute;e invalide");
		this.annee= _annee;
	}
	public int getAnnee() {
		return annee;
	}
	
	public void setNbjrs(int _nbjrs) throws Exception{
		if (_nbjrs<0) throw new Exception("Nombre de jours invalide");
		this.nbjrs= _nbjrs;
	}
	public int getNbjrs() {
		return nbjrs;
	}
}