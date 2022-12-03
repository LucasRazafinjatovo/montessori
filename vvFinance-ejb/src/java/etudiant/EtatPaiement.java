/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package etudiant;

import bean.ClassEtat;

/**
 *
 * @author LUCAS
 */
public class EtatPaiement extends ClassEtat{
    String id;
    String idetudiant;
    String designation;
    int moisint;
    String mois;
    int annee;
    String idecole;
    String ecole;
    double montantapayer;
    double montantdejapayer;
    double resteapayer;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
      public String getIdetudiant() {
        return idetudiant;
    }

    public void setIdetudiant(String idetudiant) {
        this.idetudiant = idetudiant;
    }
    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
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
    public String getMois() {
        return mois;
    }
    public void setMois(String mois) {
        this.mois = mois;
    }
    public int getMoisint() {
        return moisint;
    }

    public void setMoisint(int moisint) {
        this.moisint = moisint;
    }

    public int getAnnee() {
        return annee;
    }

    public void setAnnee(int annee) {
        this.annee = annee;
    }

    public double getMontantapayer() {
        return montantapayer;
    }

    public void setMontantapayer(double montantapayer) {
        this.montantapayer = montantapayer;
    }

    public double getMontantdejapayer() {
        return montantdejapayer;
    }

    public void setMontantdejapayer(double montantdejapayer) {
        this.montantdejapayer = montantdejapayer;
    }

    public double getResteapayer() {
        return resteapayer;
    }

    public void setResteapayer(double resteapayer) {
        this.resteapayer = resteapayer;
    }
  


    public EtatPaiement() {
        super.setNomTable("etat_analyse_paiement");
    }

    @Override
    public String getTuppleID() {
        return id; //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public String getAttributIDName() {
         return "id"; //To change body of generated methods, choose Tools | Templates.
    }
}
