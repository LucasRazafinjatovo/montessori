/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package etudiant;

import bean.ClassEtat;
import java.sql.Connection;

/**
 *
 * @author pro
 */
public class Edition extends ClassEtat{
    private String id;
    private int mois;
    private int annee;
    private String idetudiant;
    private double ecolagedu;
    private double ecolagepaye;
    private double fooddu;
    private double foodpaye;
    private double transportdu;
    private double transportpaye;
    private double inscriptiondu;
    private double inscriptionpaye;
    private double autredu;
    private double autrepaye;
    private String remarque;

    public Edition() {
        super.setNomTable("edition");
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }
    
    
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public int getMois() {
        return mois;
    }

    public void setMois(int mois) {
        this.mois = mois;
    }

    public int getAnnee() {
        return annee;
    }

    public void setAnnee(int annee) {
        this.annee = annee;
    }

    public String getIdetudiant() {
        return idetudiant;
    }

    public void setIdetudiant(String idetudiant) {
        this.idetudiant = idetudiant;
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

    public void construirePK(Connection c) throws Exception{
        super.setNomTable("edition");
        this.preparePk("EDT","getSeqedition");
        this.setId(makePK(c));
    }

    
    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    
}
