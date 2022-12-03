package indicateur;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.*;

public class PrixVentePrevision extends ClassMAPTable{
	private String id, journal;
	private double prix;
	private Date dateeffectivite;
	
	public PrixVentePrevision() {
		super.setNomTable("PRIXVENTEPREVISION");
	}
	
	public void construirePK(Connection c) throws Exception{
		super.setNomTable("PRIXVENTEPREVISION");
		this.preparePk("PXVNTPREV","GETSEQPRIXVENTEPREVISION");
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
	
	public void setPrix(double _prix) throws Exception{
		this.prix= _prix;
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