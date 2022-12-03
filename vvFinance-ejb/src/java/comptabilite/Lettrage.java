package comptabilite;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.*;

public class Lettrage extends ClassMAPTable{
	private String id, societe, exercice, idecriture, lettres;
	private Date daty;
	private double montantdebit, montantcredit;
	private int etat;

	public Lettrage() {
		super.setNomTable("LETTRAGECOMPTA");
	}

	public void construirePK(Connection c) throws Exception{
		super.setNomTable("LETTRAGECOMPTA");
		this.preparePk("LETTR","GETSEQLETTRAGECOMPTA");
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
	public void setIdecriture(String id) {
		this.idecriture = id;
	}
	public String getIdecriture() {
		return idecriture;
	}
	public void setDaty(Date daty) {
		this.daty = daty;
	}
	public Date getDaty() {
		return daty;
	}
	public void setLettres(String _lettres) throws Exception{
		if (_lettres.compareTo("")==0) throw new Exception("Lettre invalide");
		this.lettres = _lettres;
	}
	public String getLettres() {
		return lettres;
	}
	public void setMontantdebit(double montantdebit) {
		this.montantdebit = montantdebit;
	}
	public double getMontantdebit() {
		return montantdebit;
	}
	public void setMontantcredit(double montantcredit) {
		this.montantcredit = montantcredit;
	}
	public double getMontantcredit() {
		return montantcredit;
	}
	public void setSociete(String societe) {
		this.societe = societe;
	}
	public String getSociete() {
		return societe;
	}
	public void setExercice(String exercice) {
		this.exercice = exercice;
	}
	public String getExercice() {
		return exercice;
	}
	
	//etat : cree : 1 / vise : 0 / annuler : -1
	public void setEtat(int _etat){
		this.etat = _etat;
	}
	public int getEtat(){
		return this.etat;
	}
	
	public String getEtatLibelle(){
		if (etat == 1) return "CREEE";
		else if (etat == 0) return "VISEE";
		else return "ANNULEE";
	}
	
}