package comptabilite;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.*;

public class Ecriture extends ClassMAPTable{
	private String id, codejournal, compte, comptetiers,
		libelle, numpiece, societe, exercice, idobjet;
				
	private Date daty, echeance;
	private double montantdebit, montantcredit;
	private int etat, numero;

	public Ecriture() {
		super.setNomTable("ECRITURECOMPTA");
	}


	public Ecriture (Date daty, String societe, String codejournal, String numpiece, String compte,
			String tiers, Date echeance, String libelle, double montantdebit, double montantcredit) throws Exception{
		super.setNomTable("ECRITURECOMPTA");
		this.setDaty(daty);
		this.setSociete(societe);
		this.setCodejournal(codejournal);
		this.setNumpiece(numpiece);
		this.setCompte(compte);
		this.setComptetiers(tiers);
		this.setEcheance(echeance);
		this.setLibelle(libelle);
		this.setMontantdebit(montantdebit);
		this.setMontantcredit(montantcredit);
	}

	public void construirePK(Connection c) throws Exception{
		super.setNomTable("ECRITURECOMPTA");
		this.preparePk("ECR","GETSEQECRITURECOMPTA");
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

	public void setCodejournal(String codejournal) {
		this.codejournal = codejournal;
	}
	public String getCodejournal() {
		return codejournal;
	}
	public void setCompte(String compte) {
		this.compte = compte;
	}
	public String getCompte() {
		return compte;
	}
	public void setComptetiers(String comptetiers) {
		this.comptetiers = comptetiers;
	}
	public String getComptetiers() {
		return comptetiers;
	}
	public void setDaty(Date daty) {
		this.daty = daty;
	}
	public Date getDaty() {
		return daty;
	}
	public void setEcheance(Date echeance) {
		this.echeance = echeance;
	}
	public Date getEcheance() {
		return echeance;
	}
	public void setLibelle(String _libelle) throws Exception{
		if (_libelle.compareTo("")==0) throw new Exception("Libelle invalide");
		this.libelle = _libelle;
	}
	public String getLibelle() {
		return libelle;
	}
	public void setNumpiece(String _numpiece) throws Exception{
		if (_numpiece.compareTo("")==0) throw new Exception("Numero piece invalide");
		this.numpiece = _numpiece;
	}
	public String getNumpiece() {
		return numpiece;
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
	
	public void setNumero(int _numero){
		this.numero = _numero;
	}
	public int getNumero(){
		return this.numero;
	}
	
	public void setIdobjet(String idobjet) {
		this.idobjet = idobjet;
	}
	public String getIdobjet() {
		return idobjet;
	}
}