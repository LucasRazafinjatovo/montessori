/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package etudiant;

import bean.ClassEtat;
import bean.ClassMAPTable;
import java.sql.Date;

/**
 *
 * @author pro
 */
public class AnalysePaiement extends ClassEtat{

    private String idetudiant;
    private String nom;
    private String prenom;
    private int echeance;
    private String mois;
    private int annee;
    private String ecole;
    private double fooddu;
    private double foodpaye;
    private double ecolagedu;
    private double ecolagepaye;
    private double transportdu;
    private double transportpaye;
    private double inscriptiondu;
    private double inscriptionpaye;
    private double autredu;
    private double autrepaye;
    private double montantdu;
    private double montantpaye;
    private double reste;
    private int moisint;

    public int getMoisint() {
        return moisint;
    }

    public void setMoisint(int moisint) {
        this.moisint = moisint;
    }

    public String getIdetudiant() {
        return idetudiant;
    }

    public void setIdetudiant(String idetudiant) {
        this.idetudiant = idetudiant;
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

    public int getEcheance() {
        return echeance;
    }

    public void setEcheance(int echeance) {
        this.echeance = echeance;
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

    public String getEcole() {
        return ecole;
    }

    public void setEcole(String ecole) {
        this.ecole = ecole;
    }

    public double getFooddu() {
        return fooddu;
    }

    public void setFooddu(double fooddu) {
        this.fooddu = fooddu;
    }

    public double getFoodpaye() {
        return foodpaye;
    }

    public void setFoodpaye(double foodpaye) {
        this.foodpaye = foodpaye;
    }

    public double getEcolagedu() {
        return ecolagedu;
    }

    public void setEcolagedu(double ecolagedu) {
        this.ecolagedu = ecolagedu;
    }

    public double getEcolagepaye() {
        return ecolagepaye;
    }

    public void setEcolagepaye(double ecolagepaye) {
        this.ecolagepaye = ecolagepaye;
    }

    public double getTransportdu() {
        return transportdu;
    }

    public void setTransportdu(double transportdu) {
        this.transportdu = transportdu;
    }

    public double getTransportpaye() {
        return transportpaye;
    }

    public void setTransportpaye(double transportpaye) {
        this.transportpaye = transportpaye;
    }

    public double getInscriptiondu() {
        return inscriptiondu;
    }

    public void setInscriptiondu(double inscriptiondu) {
        this.inscriptiondu = inscriptiondu;
    }

    public double getInscriptionpaye() {
        return inscriptionpaye;
    }

    public void setInscriptionpaye(double inscriptionpaye) {
        this.inscriptionpaye = inscriptionpaye;
    }

    public double getAutredu() {
        return autredu;
    }

    public void setAutredu(double autredu) {
        this.autredu = autredu;
    }

    public double getAutrepaye() {
        return autrepaye;
    }

    public void setAutrepaye(double autrepaye) {
        this.autrepaye = autrepaye;
    }

    public double getMontantdu() {
        return montantdu;
    }

    public void setMontantdu(double montantdu) {
        this.montantdu = montantdu;
    }

    public double getMontantpaye() {
        return montantpaye;
    }

    public void setMontantpaye(double montantpaye) {
        this.montantpaye = montantpaye;
    }

    public double getReste() {
        return reste;
    }

    public void setReste(double reste) {
        this.reste = reste;
    }
    
    
   
    public AnalysePaiement() {
        super.setNomTable("etat_paiement_moisint");
    }

    
    @Override
    public String getTuppleID() {
        return idetudiant;
    }

    @Override
    public String getAttributIDName() {
        return "idetudiant";
    }
    
}
