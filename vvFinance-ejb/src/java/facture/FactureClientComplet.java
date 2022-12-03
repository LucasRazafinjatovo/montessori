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
 * @author Tian
 */
public class FactureClientComplet extends ClassMAPTable{
    private String idfacturefournisseur;
    private Date daty;
    private String idfournisseur;
    private double idtva;
    private double montantttc;
    private String remarque;
    private Date dateemission;
    private String designation;
    private String iddevise;
    private String numfact;
    private String resp;
    private Date datyecheance;

    public FactureClientComplet() {
        this.setNomTable("FACTURECLIENT");
    }

    public FactureClientComplet(String idfacturefournisseur, Date daty, String idfournisseur, double idtva, double montantttc, String remarque, Date dateemission, String designation, String iddevise, String numfact, String resp, Date dateecheance) {
        this.setNomTable("FACTURECLIENT");
        this.idfacturefournisseur = idfacturefournisseur;
        this.daty = daty;
        this.idfournisseur = idfournisseur;
        this.idtva = idtva;
        this.montantttc = montantttc;
        this.remarque = remarque;
        this.dateemission = dateemission;
        this.designation = designation;
        this.iddevise = iddevise;
        this.numfact = numfact;
        this.resp = resp;
        this.datyecheance = dateecheance;
    }

    public FactureClientComplet(Date daty, String idfournisseur, double idtva, double montantttc, String remarque, Date dateemission, String designation, String iddevise, String numfact, String resp, Date dateecheance) {
        this.setNomTable("FACTURECLIENT");
        this.daty = daty;
        this.idfournisseur = idfournisseur;
        this.idtva = idtva;
        this.montantttc = montantttc;
        this.remarque = remarque;
        this.dateemission = dateemission;
        this.designation = designation;
        this.iddevise = iddevise;
        this.numfact = numfact;
        this.resp = resp;
        this.datyecheance = dateecheance;
    }
    
    
    
    public String getIdfacturefournisseur() {
        return idfacturefournisseur;
    }

    public void setIdfacturefournisseur(String idfacturefournisseur) {
        this.idfacturefournisseur = idfacturefournisseur;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public String getIdfournisseur() {
        return idfournisseur;
    }

    public void setIdfournisseur(String idfournisseur) {
        this.idfournisseur = idfournisseur;
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

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public Date getDateemission() {
        return dateemission;
    }

    public void setDateemission(Date dateemission) {
        this.dateemission = dateemission;
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

    public String getNumfact() {
        return numfact;
    }

    public void setNumfact(String numfact) {
        this.numfact = numfact;
    }

    public String getResp() {
        return resp;
    }

    public void setResp(String resp) {
        this.resp = resp;
    }

    public Date getDatyecheance() {
        return datyecheance;
    }

    public void setDateecheance(Date dateecheance) {
        this.datyecheance = dateecheance;
    }
    
    

    @Override
    public String getTuppleID() {
       return idfacturefournisseur;
    }

    @Override
    public String getAttributIDName() {
        return "idfacturefournisseur";
    }
    
}
