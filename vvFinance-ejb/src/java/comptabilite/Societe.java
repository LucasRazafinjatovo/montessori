package comptabilite;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.*;

public class Societe extends ClassMAPTable{
	private String id, nom, regime, adresse, telephone, fax, email, gerant,
	nif,
		numstat, rc, capital, quittance;

	public Societe() {
		super.setNomTable("Societe");
	}
	public Societe(String idSociete, String nom, String regime, String tel, String fax,
                                     String email, String gerant, String nif, String numstat, String rc, String capital, String quittance) {
		super.setNomTable("Societe");
		this.setId(idSociete);
		this.setNom(nom);
		this.setRegime(regime);
		this.setTelephone(tel);
		this.setFax(fax);
		this.setEmail(email);
		this.setGerant(gerant);
		this.setNif(nif);
		this.setNumstat(numstat);
		this.setRc(rc);
		this.setCapital(capital);
		this.setQuittance(quittance);
	}

	public void construirePK(Connection c) throws Exception{
		super.setNomTable("Societe");
		this.preparePk("SOC","GETSEQSOCIETE");
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
	public void setNom(String nom) {
		this.nom = nom;
	}
	public String getNom() {
		return nom;
	}
	public void setRegime(String regime) {
		this.regime = regime;
	}
	public String getRegime() {
		return regime;
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
	public void setFax(String fax) {
		this.fax = fax;
	}
	public String getFax() {
		return fax;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getEmail() {
		return email;
	}
	public void setGerant(String gerant) {
		this.gerant = gerant;
	}
	public String getGerant() {
		return gerant;
	}
	public void setNif(String nif) {
		this.nif = nif;
	}
	public String getNif() {
		return nif;
	}
	public void setNumstat(String numstat) {
		this.numstat = numstat;
	}
	public String getNumstat() {
		return numstat;
	}
	public void setRc(String rc) {
		this.rc = rc;
	}
	public String getRc() {
		return rc;
	}
	public void setCapital(String capital) {
		this.capital = capital;
	}
	public String getCapital() {
		return capital;
	}
	public void setQuittance(String quittance) {
		this.quittance = quittance;
	}
	public String getQuittance() {
		return quittance;
	}

}