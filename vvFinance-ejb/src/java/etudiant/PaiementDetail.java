/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package etudiant;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;

/**
 *
 * @author Tsito
 */
public class PaiementDetail extends ClassMAPTable {

    private String id;
    private Date daty;
    private Date date_fin;
    private String etudiant;
    private Date echeance;
    private double ecolage;
    private double food;
    private double transport;
    private double inscription;
    private double autre;
    private String remarque;
    private double montant_total;
    private String caisse;
    private String modepaiement;
    private String devise;
    private String etablissement;
    private String numero_cheque;
    
    public String getNumero_cheque(){
        return this.numero_cheque;
    }
    
    public void setNumero_cheque(String numero_cheque){
        this.numero_cheque = numero_cheque;
    }

    public PaiementDetail() {

        this.setNomTable("paiment_detail");
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

    public String getEtudiant() {
        return etudiant;
    }

    public void setEtudiant(String etudiant) {
        this.etudiant = etudiant;
    }

    public Date getEcheance() {
        return echeance;
    }

    public void setEcheance(Date echeance) {
        this.echeance = echeance;
    }

    public double getEcolage() {
        return ecolage;
    }

    public void setEcolage(double ecolage) throws Exception {
        if((ecolage <0 )&&(this.getMode().compareToIgnoreCase("modif")==0))throw new Exception("Ecolage non valide");
	this.ecolage = ecolage;
    }

    public double getFood() {
        return food;
    }

    public void setFood(double food) throws Exception {
        if((food <0 )&&(this.getMode().compareToIgnoreCase("modif")==0))throw new Exception("Food non valide");
        this.food = food;
    }

    public double getTransport() {
        return transport;
    }

    public void setTransport(double transport) throws Exception {
        if((transport <0 )&&(this.getMode().compareToIgnoreCase("modif")==0))throw new Exception("Transport non valide");
        this.transport = transport;
    }

    public double getInscription() {
        return inscription;
    }

    public void setInscription(double inscription) throws Exception {
        if((inscription <0 )&&(this.getMode().compareToIgnoreCase("modif")==0))throw new Exception("Inscription non valide");
        this.inscription = inscription;
    }

    public double getAutre() {
        return autre;
    }

    public void setAutre(double autre) throws Exception {
        if((autre <0 )&&(this.getMode().compareToIgnoreCase("modif")==0))throw new Exception("Autre non valide");
        this.autre = autre;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public Date getDate_fin() {
        return date_fin;
    }

    public void setDate_fin(Date daty_fin) {
        this.date_fin = daty_fin;
    }

    public double getMontant_total() {
        return montant_total;
    }

    public void setMontant_total(double montant_total) {
        this.montant_total = montant_total;
    }

    @Override
    public String getTuppleID() {
        return this.getId();
    }

    public String getCaisse() {
        return caisse;
    }

    public void setCaisse(String caisse) {
        this.caisse = caisse;
    }

    public String getModepaiement() {
        return modepaiement;
    }

    public void setModepaiement(String modepaiement) {
        this.modepaiement = modepaiement;
    }

    public String getDevise() {
        return devise;
    }

    public void setDevise(String devise) {
        this.devise = devise;
    }

    public String getEtablissement() {
        return etablissement;
    }

    public void setEtablissement(String etablissement) {
        this.etablissement = etablissement;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("PAD", "getSeqpaiement_detail");
        this.setId(makePK(c));
    }

}
