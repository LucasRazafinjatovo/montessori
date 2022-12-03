package comptabilite;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.*;

public class SocieteEntite extends ClassMAPTable{
	private String identite, idsociete;
	
	public SocieteEntite() {
		super.setNomTable("SocieteEntite");
	}
	
	public String getTuppleID(){
		return identite;
	}
	public String getAttributIDName(){
		return "identie";
	}
	public void setIdentite(String identite) {
		this.identite = identite;
	}
	public String getIdentite() {
		return identite;
	}
	public void setIdsociete(String idsociete) {
		this.idsociete = idsociete;
	}
	public String getIdsociete() {
		return idsociete;
	}
}