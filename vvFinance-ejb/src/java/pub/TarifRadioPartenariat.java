/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pub;

import bean.ClassMAPTable;
import java.sql.Connection;

/**
 *
 * @author Alain
 */
public class TarifRadioPartenariat extends ClassMAPTable{
    
    private String id, confpresse, libelle, duree, plage;
    private double montant;
    private int nbspot, nbemission, tophoraire, siconcert;

    public String getLibelle() {
        return libelle;
    }

    public String getPlage() {
        return plage;
    }

    public void setPlage(String plage) {
        this.plage = plage;
    }

    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }

    public String getDuree() {
        return duree;
    }

    public void setDuree(String duree) {
        this.duree = duree;
    }

    public TarifRadioPartenariat() {
        this.setNomTable("tarif_pack_radio");
    }
    
    public void construirePK(Connection c) throws Exception {
        this.preparePk("TPR", "GETSEQ_TARIF_PACK");
        this.setId(makePK(c));
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

    public String getConfpresse() {
        return confpresse;
    }

    public void setConfpresse(String confpresse) {
        this.confpresse = confpresse;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public int getNbspot() {
        return nbspot;
    }

    public void setNbspot(int nbspot) {
        this.nbspot = nbspot;
    }

    public int getNbemission() {
        return nbemission;
    }

    public void setNbemission(int nbemission) {
        this.nbemission = nbemission;
    }

    public int getTophoraire() {
        return tophoraire;
    }

    public void setTophoraire(int tophoraire) {
        this.tophoraire = tophoraire;
    }

    public int getSiconcert() {
        return siconcert;
    }

    public void setSiconcert(int siconcert) {
        this.siconcert = siconcert;
    }
    
}
