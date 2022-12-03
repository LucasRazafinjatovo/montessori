/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ded;

import bean.ClassMAPTable;

/**
 *
 * @author ITU
 */
public class OpAAnnuler extends ClassMAPTable{

    private String id;
    private double montant;
    private double montant_paye;
    private double reste;
    
    public OpAAnnuler()
    {
        this.setNomTable("OP_A_ANNULER");
    }
    @Override
    public String getTuppleID() {
        return this.getId(); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public String getAttributIDName() {
        return "id"; //To change body of generated methods, choose Tools | Templates.
    }

    /**
     * @return the id
     */
    public String getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(String id) {
        this.id = id;
    }


    /**
     * @return the montant
     */
    public double getMontant() {
        return montant;
    }

    /**
     * @param montant the montant to set
     */
    public void setMontant(double montant) {
        this.montant = montant;
    }

    /**
     * @return the montant_paye
     */
    public double getMontant_paye() {
        return montant_paye;
    }

    /**
     * @param montant_paye the montant_paye to set
     */
    public void setMontant_paye(double montant_paye) {
        this.montant_paye = montant_paye;
    }

    /**
     * @return the reste
     */
    public double getReste() {
        return reste;
    }

    /**
     * @param reste the reste to set
     */
    public void setReste(double reste) {
        this.reste = reste;
    }

}
