package comptabilite;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.*;

public class Tiers extends ClassMAPTable{
	private String id, nom, nif,
		telephone, adresse, stat, rcs, typetiers;

	public Tiers() {
		super.setNomTable("Tiers");
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
	public void setNom(String nom) {
		this.nom = nom;
	}
	public String getNom() {
		return nom;
	}

	public void setAdresse(String adresse) {
		this.adresse = adresse;
	}
	public String getAdresse() {
		return adresse;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setStat(String stat) {
		this.stat = stat;
	}
	public String getStat() {
		return stat;
	}
	public void setNif(String nif) {
		this.nif = nif;
	}
	public String getNif() {
		return nif;
	}
	public void setRcs(String rcs) {
		this.rcs = rcs;
	}
	public String getRcs() {
		return rcs;
	}
	public void setTypetiers(String type) {
		this.typetiers = type;
	}
	public String getTypetiers() {
		return typetiers;
	}
}