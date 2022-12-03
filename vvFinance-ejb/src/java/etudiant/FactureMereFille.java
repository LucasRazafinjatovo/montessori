package etudiant;

import bean.ClassEtat;

public class FactureMereFille extends ClassEtat{
    String idfacturemere;
    String idetudiant;
    int moisint;
    String mois;
    int annee;
    String idfacturefille;
    String designation;
    double montant;
    String idecole;
    String ecole;

    public FactureMereFille() {
        this.setNomTable("facturemerefille");
    }

    public String getIdfacturemere() {
        return idfacturemere;
    }

    public void setIdfacturemere(String idfacturemere) {
        this.idfacturemere = idfacturemere;
    }

    public String getIdetudiant() {
        return idetudiant;
    }

    public void setIdetudiant(String idetudiant) {
        this.idetudiant = idetudiant;
    }
    public String getEcole() {
        return ecole;
    }

    public void setEcole(String ecole) {
        this.ecole = ecole;
    }
    public String getIdecole() {
        return idecole;
    }

    public void setIdecole(String idecole) {
        this.idecole = idecole;
    }

    public int getMoisint() {
        return moisint;
    }

    public void setMoisint(int moisint) {
        this.moisint = moisint;
    }
    public String getMois() {
        return mois;
    }

    public void setMois(String mois) {
        this.mois = mois;
    }

    public int getAnnee() {
        return annee;
    }

    public void setAnnee(int annee) {
        this.annee = annee;
    }

    public String getIdfacturefille() {
        return idfacturefille;
    }

    public void setIdfacturefille(String idfacturefille) {
        this.idfacturefille = idfacturefille;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    @Override
    public String getTuppleID() {
        return idfacturemere; //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public String getAttributIDName() {
        return "idfacturemere";//To change body of generated methods, choose Tools | Templates.
    }
}
