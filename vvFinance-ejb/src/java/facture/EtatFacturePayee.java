/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;
import bean.ClassMAPTable;
import java.sql.Date;
/**
 *
 * @author Andy
 */
public class EtatFacturePayee extends ClassMAPTable{
    private String id,nif,nom,numstat,adresse,libelle,numfact;
    private double montantht,tva,montantttc,montant_paye;
    private Date daty;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNif() {
        return nif;
    }

    public void setNif(String nif) {
        this.nif = nif;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getNumstat() {
        return numstat;
    }

    public void setNumstat(String numstat) {
        this.numstat = numstat;
    }

    public String getAdresse() {
        return adresse;
    }

    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }

    public String getLibelle() {
        return libelle;
    }

    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }

    public String getNumfact() {
        return numfact;
    }

    public void setNumfact(String numfact) {
        this.numfact = numfact;
    }

    public double getMontantht() {
        return montantht;
    }

    public void setMontantht(double montantht) {
        this.montantht = montantht;
    }

    public double getTva() {
        return tva;
    }

    public void setTva(double tva) {
        this.tva = tva;
    }

    public double getMontantttc() {
        return montantttc;
    }

    public void setMontantttc(double montantttc) {
        this.montantttc = montantttc;
    }

    public double getMontant_paye() {
        return montant_paye;
    }

    public void setMontant_paye(double montant_paye) {
        this.montant_paye = montant_paye;
    }

    @Override
    public String getTuppleID() {
        return String.valueOf(id);
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public EtatFacturePayee() {
        this.setNomTable("ETAT_FACTURE_PAYEE");
    }

    public EtatFacturePayee(String id, String nif, String nom, String numstat, String adresse, String libelle, String numfact, double montantht, double tva, double montantttc, double montant_paye, Date daty) {
        this.id = id;
        this.nif = nif;
        this.nom = nom;
        this.numstat = numstat;
        this.adresse = adresse;
        this.libelle = libelle;
        this.numfact = numfact;
        this.montantht = montantht;
        this.tva = tva;
        this.montantttc = montantttc;
        this.montant_paye = montant_paye;
        this.daty = daty;
        this.setNomTable("ETAT_FACTURE_PAYEE");
    }        
    
}
