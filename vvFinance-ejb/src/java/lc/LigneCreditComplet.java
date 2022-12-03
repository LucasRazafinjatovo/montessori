package lc;

import bean.ClassMAPTable;

public class LigneCreditComplet extends ClassMAPTable {

	public String idLigne;

	public String designation;

	public double creditInitial;

	public double creditModifier;

	public double montantEng;

	public double montantVis;

	public double montantFac;

	public String mois;

	public int annee;

	public String typeLC;

	public String numCompte;

	public String descCompte;

	public String libelledir;

	public String abbrevdir;

	public int idDirecteur;

	public String entite;

	public String idDirection;

	public String parution;
  public double reste;

	public LigneCreditComplet(){
		this.setNomTable("LigneCreditComplet");
	}

	public LigneCreditComplet(String idLigne, String designation,
			double creditInitial, double creditModifier, double montantEng,
			double montantVis, double montantFac, String mois, int annee,
			String typeLC, String numCompte, String descCompte,
			String libelledir, String abbrevdir, int idDirecteur, String entite,
			String idDirection, String rmq) {
		this.idLigne = idLigne;
		this.designation = designation;
		this.creditInitial = creditInitial;
		this.creditModifier = creditModifier;
		this.montantEng = montantEng;
		this.montantVis = montantVis;
		this.montantFac = montantFac;
		this.mois = mois;
		this.annee = annee;
		this.typeLC = typeLC;
		this.numCompte = numCompte;
		this.descCompte = descCompte;
		this.libelledir = libelledir;
		this.abbrevdir = abbrevdir;
		this.idDirecteur = idDirecteur;
		this.entite = entite;
		this.parution = rmq;

		this.setNomTable("LIGNECREDITCOMPLET");
	}

	public String getAbbrevdir() {
		return abbrevdir;
	}

	public void setAbbrevdir(String abbrevdir) {
		this.abbrevdir = abbrevdir;
	}

	public int getAnnee() {
		return annee;
	}

	public void setAnnee(int annee) {
		this.annee = annee;
	}

	public double getCreditInitial() {
		return creditInitial;
	}

	public void setCreditInitial(double creditInitial) {
		this.creditInitial = creditInitial;
	}

	public double getCreditModifier() {
		return creditModifier;
	}

	public void setCreditModifier(double creditModifier) {
		this.creditModifier = creditModifier;
	}

	public String getDescCompte() {
		return descCompte;
	}

	public void setDescCompte(String descCompte) {
		this.descCompte = descCompte;
	}

	public String getDesignation() {
		return designation;
	}

	public void setDesignation(String designation) {
		this.designation = designation;
	}

	public String getEntite() {
		return entite;
	}

	public void setEntite(String entite) {
		this.entite = entite;
	}

	public int getIdDirecteur() {
		return idDirecteur;
	}

	public void setIdDirecteur(int idDirecteur) {
		this.idDirecteur = idDirecteur;
	}

	public String getIdLigne() {
		return idLigne;
	}

	public void setIdLigne(String idLigne) {
		this.idLigne = idLigne;
	}

	public String getLibelledir() {
		return libelledir;
	}

	public void setLibelledir(String libelledir) {
		this.libelledir = libelledir;
	}

	public String getMois() {
		return mois;
	}

	public void setMois(String mois) {
		this.mois = mois;
	}

	public double getMontantEng() {
		return montantEng;
	}

	public void setMontantEng(double montantEng) {
		this.montantEng = montantEng;
	}

	public double getMontantFac() {
		return montantFac;
	}

	public void setMontantFac(double montantFac) {
		this.montantFac = montantFac;
	}

	public double getMontantVis() {
		return montantVis;
	}

	public void setMontantVis(double montantVis) {
		this.montantVis = montantVis;
	}

	public String getNumCompte() {
		return numCompte;
	}

	public void setNumCompte(String numCompte) {
		this.numCompte = numCompte;
	}

	public String getTypeLC() {
		return typeLC;
	}

	public void setTypeLC(String typeLC) {
		this.typeLC = typeLC;
	}

	public String getAttributIDName() {
		return "idLigne";
	}

	public String getTuppleID() {
		return idLigne;
	}

	public String getIdDirection() {
		return idDirection;
	}

	public void setIdDirection(String idDirection) {
		this.idDirection = idDirection;
	}

	public String getParution() {
    return parution;
	}

	public void setParution(String parution) {
    this.parution = parution;
	}
  public void setReste(double reste) {
    this.reste = reste;
  }
  public double getReste() {
    return reste;
  }

}
