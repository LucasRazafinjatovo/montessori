/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pub;

import bean.ClassMAPTable;
import java.sql.Date;

/**
 *
 * @author Alain
 */
public class PubRadioPaiement extends ClassMAPTable{
    
    private String id;
    private Date daty;
    private String client, observation, reference, responsable;
    private String nomcampagne, nature, duree, pubtype, heure;
    private double montant, paie, reste;
    
    public PubRadioPaiement() {
        this.setNomTable("pub_radio_paiement");
    }
    
    @Override
    public String getTuppleID() {
        return this.getId(); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public String getAttributIDName() {
        return "id"; //To change body of generated methods, choose Tools | Templates.
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public String getClient() {
        return client;
    }

    public void setClient(String client) {
        this.client = client;
    }

    public String getObservation() {
        return observation;
    }

    public void setObservation(String observation) {
        this.observation = observation;
    }

    public String getReference() {
        return reference;
    }

    public void setReference(String reference) {
        this.reference = reference;
    }

    public String getResponsable() {
        return responsable;
    }

    public void setResponsable(String responsable) {
        this.responsable = responsable;
    }

    public String getNomcampagne() {
        return nomcampagne;
    }

    public void setNomcampagne(String nomcampagne) {
        this.nomcampagne = nomcampagne;
    }

    public String getNature() {
        return nature;
    }

    public void setNature(String nature) {
        this.nature = nature;
    }

    public String getDuree() {
        return duree;
    }

    public void setDuree(String duree) {
        this.duree = duree;
    }

    public String getPubtype() {
        return pubtype;
    }

    public void setPubtype(String pubtype) {
        this.pubtype = pubtype;
    }

    public String getHeure() {
        return heure;
    }

    public void setHeure(String heure) {
        this.heure = heure;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public double getPaie() {
        return paie;
    }

    public void setPaie(double paie) {
        this.paie = paie;
    }

    public double getReste() {
        return reste;
    }

    public void setReste(double reste) {
        this.reste = reste;
    }
}
