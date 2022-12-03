/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ded;

import bean.ClassMAPTable;
import java.sql.Date;

/**
 *
 * @author anthonyandrianaivoravelona
 */
public class OrdonnerPayementReste extends ClassMAPTable{
    private String id;
    private Date daty;
    private double montant, paye, reste;
    
    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public OrdonnerPayementReste() {
        super.setNomTable("ORDONNERPAYEMENTRESTE");
    }

    public OrdonnerPayementReste(String id, Date daty, double montant, double paye, double reste) {
        super.setNomTable("ORDONNERPAYEMENTRESTE");
        setId(id);
        setDaty(daty);
        setMontant(montant);
        setPaye(paye);
        setReste(reste);
    }

    public OrdonnerPayementReste(Date daty, double montant, double paye, double reste) {
        super.setNomTable("ORDONNERPAYEMENTRESTE");
        setDaty(daty);
        setMontant(montant);
        setPaye(paye);
        setReste(reste);
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

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public double getPaye() {
        return paye;
    }

    public void setPaye(double paye) {
        this.paye = paye;
    }

    public double getReste() {
        return reste;
    }

    public void setReste(double reste) {
        this.reste = reste;
    }
    
    
}
