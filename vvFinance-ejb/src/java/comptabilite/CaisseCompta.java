package comptabilite;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.*;

public class CaisseCompta extends ClassMAPTable{
	private String idcaisse, idsociete, compte;

	public CaisseCompta() {
		super.setNomTable("CaisseCompta");
	}

	public String getTuppleID(){
		return idcaisse;
	}
	public String getAttributIDName(){
		return "idcaisse";
	}
	public void setIdcaisse(String idcaisse) {
		this.idcaisse = idcaisse;
	}
	public String getIdcaisse() {
		return idcaisse;
	}
	public void setIdsociete(String idsociete) {
		this.idsociete= idsociete;
	}
	public String getIdsociete() {
		return idsociete;
	}
	public void setCompte(String compte) {
		this.compte= compte;
	}
	public String getCompte() {
		return compte;
	}
}