package lc;

import bean.ClassMAPTable;
import java.sql.Connection;
public class LigneCredit extends ClassMAPTable {

	public String idLigne;
	public String designation;
	public double creditInitial;
	public double creditModifier;
	public double montantEng;
	public double montantVis;//Montant payé facture
	public double montantFac;
	public String idTypeLigne;
	public String numCompte;
	public String idEntite;
	public String idDirection;
	public String mois;
	public int annee;
	public String parution;

	public LigneCredit(){
		this.setNomTable("LIGNECREDIT");
	}
/*ito*/
	public LigneCredit(String idLigne, String designation, double creditInitial, double creditModifier, double montantEng, double montantVis, double montantFac, String idTypeLigne, String numCompte, String idEntite, String idDirection, String mois, int annee, String rmq) {
		this.idLigne = idLigne;
		this.designation = designation;
		this.creditInitial = creditInitial;
		this.creditModifier = creditModifier;
		this.montantEng = montantEng;
		this.montantVis = montantVis;
		this.montantFac = montantFac;
		this.idTypeLigne = idTypeLigne;
		this.numCompte = numCompte;
		this.idEntite = idEntite;
		this.idDirection = idDirection;
		this.mois = mois;
		this.annee = annee;
		this.setParution(rmq);
                this.setIndicePk("LC");
		this.setNomProcedureSequence("GETSEQLIGNECREDIT");
		this.setNomTable("LIGNECREDIT");
	}

        public void LigneCreditRecette(String designation, double creditInitial, double creditModifier, double montantEng, double montantVis, double montantFac, String idTypeLigne, String numCompte, String idEntite, String idDirection, String mois, int annee, String rmq){
          this.setNomTable("LIGNECREDITRecette");
                this.designation = designation;
                //System.out.println("CREDIT "+creditInitial);
                //if(creditInitial==0) throw new Exception("Entrer le montant exacte de credit");
                this.creditInitial = creditInitial;
                this.creditModifier = creditModifier;
                this.montantEng = montantEng;
                this.montantVis = montantVis;
                this.montantFac = montantFac;
                this.idTypeLigne = idTypeLigne;
                this.numCompte = numCompte;
                this.idEntite = idEntite;
                this.idDirection = idDirection;
                this.mois = mois;
                this.annee = annee;
                this.setParution(rmq);
                this.setIndicePk("LCR");
                this.setNomProcedureSequence("getSeqLCRecette");

                this.setIdLigne(makePK());
	}
	public void LigneCreditRecette(String designation, double creditInitial, String idTypeLigne, String numCompte, String idEntite, String idDirection, String mois, int annee){
          this.setNomTable("LIGNECREDITRecette");
                this.designation = designation;
                this.creditInitial = creditInitial;
                this.idTypeLigne = idTypeLigne;
                this.numCompte = numCompte;
                this.idEntite = idEntite;
                this.idDirection = idDirection;
                this.mois = mois;
                this.annee = annee;
	}
	public LigneCredit(String designation, double creditInitial, String idTypeLigne, String numCompte, String idEntite, String idDirection, String mois, int annee) {
		this.designation = designation;
		this.creditInitial = creditInitial;
		this.idTypeLigne = idTypeLigne;
		this.numCompte = numCompte;
		this.idEntite = idEntite;
		this.idDirection = idDirection;
		this.mois = mois;
		this.annee = annee;
		this.setNomTable("LIGNECREDIT");
	}
	public LigneCredit(String designation, double creditInitial, double creditModifier, double montantEng, double montantVis, double montantFac, String idTypeLigne, String numCompte, String idEntite, String idDirection, String mois, int annee, String rmq) {
		this.designation = designation;
		this.creditInitial = creditInitial;
		this.creditModifier = creditModifier;
		this.montantEng = montantEng;
		this.montantVis = montantVis;
		this.montantFac = montantFac;
		this.idTypeLigne = idTypeLigne;
		this.numCompte = numCompte;
		this.idEntite = idEntite;
		this.idDirection = idDirection;
		this.mois = mois;
		this.annee = annee;
		this.setParution(rmq);

		this.setNomTable("LIGNECREDIT");
		this.setIndicePk("LC");
		this.setNomProcedureSequence("GETSEQLIGNECREDIT");
		this.setIdLigne(makePK());
	}
        public void construirePK(Connection c) throws Exception{
            super.setNomTable("LIGNECREDIT");
            this.preparePk("LC","GETSEQLIGNECREDIT");
            this.setIdLigne(makePK(c));
  }
	public String getAttributIDName() {
		return "idLigne";
	}

	public String getTuppleID() {
		return idLigne;
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

	public String getDesignation() {
		return designation;
	}

	public void setDesignation(String designation) {
		this.designation = designation;
	}

	public String getIdDirection() {
		return idDirection;
	}

	public void setIdDirection(String idDirection) {
		this.idDirection = idDirection;
	}

	public String getIdEntite() {
		return idEntite;
	}

	public void setIdEntite(String idEntite) {
		this.idEntite = idEntite;
	}

	public String getIdLigne() {
		return idLigne;
	}

	public void setIdLigne(String idLigne) {
		this.idLigne = idLigne;
	}

	public String getIdTypeLigne() {
		return idTypeLigne;
	}

	public void setIdTypeLigne(String idTypeLigne) {
		this.idTypeLigne = idTypeLigne;
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

	public String getParution() {
    return parution;
	}

	public void setParution(String parution) {
    this.parution = parution;
	}
        public double getDisponibleVis() {
                return this.getCreditModifier()-this.getMontantVis();
        }
        public double getDisponibleFact() {
                return this.getCreditModifier()-this.getMontantFac();
        }


	public LigneCredit cloneLC(){
		LigneCredit ligne = new LigneCredit();
		ligne.setNomTable(this.getNomTable());
		ligne.setDesignation(this.getDesignation());
		ligne.setCreditInitial(this.getCreditInitial());
		ligne.setCreditModifier(0);
		ligne.setMontantEng(0);
		ligne.setMontantVis(0);
		ligne.setMontantFac(0);
		ligne.setIdTypeLigne(this.getIdTypeLigne());
		ligne.setNumCompte(this.getNumCompte());
		ligne.setIdEntite(this.getIdEntite());
		ligne.setIdDirection(this.getIdDirection());
		ligne.setParution(this.getParution());
		return ligne;
	}
}
