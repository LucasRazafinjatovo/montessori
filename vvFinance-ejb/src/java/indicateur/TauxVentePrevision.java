package indicateur;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.*;

public class TauxVentePrevision extends ClassMAPTable{
	private String id, journal;
	private double prix;
	private Date dateeffectivite;
	
	public TauxVentePrevision() {
		super.setNomTable("TAUXVENTEPREVISION");
	}
	
	public void construirePK(Connection c) throws Exception{
		super.setNomTable("TAUXVENTEPREVISION");
		this.preparePk("TXVNTPREV","GETSEQTAUXVENTEPREVISION");
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
		this.journal= journal;
	}
	public String getJournal() {
		return journal;
	}
	
	public void setPrix(double _valeur) throws Exception{
		this.prix= _valeur;
	}
	public double getPrix() {
		return prix;
	}
	
	public void setDateeffectivite (Date _date){
		this.dateeffectivite = _date;
	}
	public Date getDateeffectivite (){
		return this.dateeffectivite;
	}
}