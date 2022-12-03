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
 * @author Alain
 */
public class FactureClientFiche extends ClassMAPTable{
    
    private String idfacturefournisseur;
    private String idfournisseur;
    private String numfact, remarque, designation, iddevise, resp;
    private Date daty, dateemission, datyecheance;
    private double idtva, montantttc;
    
    public FactureClientFiche() {
        super.setNomTable("factureclient");
    }
    
    public String getTuppleID() {
        return idfacturefournisseur;
    }

    public String getAttributIDName() {
        return "idfacturefournisseur";
    }

    public String getIdfacturefournisseur() {
        return idfacturefournisseur;
    }

    public void setIdfacturefournisseur(String idfacturefournisseur) {
        this.idfacturefournisseur = idfacturefournisseur;
    }

    public String getIdfournisseur() {
        return idfournisseur;
    }

    public void setIdfournisseur(String idfournisseur) {
        this.idfournisseur = idfournisseur;
    }

    public String getNumfact() {
        return numfact;
    }

    public void setNumfact(String numfact) {
        this.numfact = numfact;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public String getIddevise() {
        return iddevise;
    }

    public void setIddevise(String iddevise) {
        this.iddevise = iddevise;
    }

    public String getResp() {
        return resp;
    }

    public void setResp(String resp) {
        this.resp = resp;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public Date getDateemission() {
        return dateemission;
    }

    public void setDateemission(Date dateemission) {
        this.dateemission = dateemission;
    }

    public Date getDatyecheance() {
        return datyecheance;
    }

    public void setDatyecheance(Date datyecheance) {
        this.datyecheance = datyecheance;
    }

    public double getIdtva() {
        return idtva;
    }

    public void setIdtva(double idtva) {
        this.idtva = idtva;
    }

    public double getMontantttc() {
        return montantttc;
    }

    public void setMontantttc(double montantttc) {
        this.montantttc = montantttc;
    }
    
    
    
}
