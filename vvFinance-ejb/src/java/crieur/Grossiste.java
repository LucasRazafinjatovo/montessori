package crieur;

import bean.*;
import java.sql.Connection;

public class Grossiste extends ClassMAPTable{
	public Grossiste(){
		this.setNomTable("Grossiste");
	}
	public void construirePK(Connection c) throws Exception
	{
		super.setNomTable("Grossiste");
		this.preparePk("GRO","getSeqGrossiste");
		this.setId(makePK(c));
	}

	private String id;
	private String nom;
	private String prenom;
	private String surnom;
	private String type;
	private double taux;
	private String idplace;
	private  java.sql.Date dateembauche;
	private String etat;
	private  String datesortie;
	private String nummatricule;

	public String getAttributIDName() {
		return "id";
	}
	public String getTuppleID() {
		return id;
	}
	public double getTaux() {
		return taux;
	}
	public void setTaux(double taux)throws Exception {
		if((taux<=0 || taux>1)&&(this.getMode().compareToIgnoreCase("insert")==0))throw new Exception("taux non valide");
		this.taux = taux;
	}
	public String getNom() {
		return nom;
	}
	public void setNom(String nom) {
		this.nom = nom;
	}
	public String getPrenom() {
		return prenom;
	}
	public void setPrenom(String prenom) {
		this.prenom = prenom;
	}
	public String getSurnom() {
		return surnom;
	}
	public void setSurnom(String surnom) {
		this.surnom = surnom;
	}
	public String getId() {
	return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getType() {
		return type;
	}
	public void setIdplace(String idplace) {
		this.idplace = idplace;
	}
	public String getIdplace() {
		return idplace;
	}
	public void setDateembauche(java.sql.Date dateembauche){
		this.dateembauche = dateembauche;
	}
	public java.sql.Date getDateembauche() {
		return dateembauche;
	}
	public void setDatesortie(String datesortie){
		this.datesortie = datesortie;
	}
	public String getDatesortie() {
		return datesortie;
	}
	public void setEtat(String etat) {
		this.etat = etat;
	}
	public String getEtat() {
		return etat;
	}
	public void setNummatricule(String nummatricule) {
		this.nummatricule = nummatricule;
	}
	public String getNummatricule() {
		return nummatricule;
	}
}