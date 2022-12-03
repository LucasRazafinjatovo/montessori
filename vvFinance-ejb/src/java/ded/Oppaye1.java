/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ded;

import java.sql.Date;

/**
 *
 * @author Me
 */
public class Oppaye1 extends Oppaye{
    Date datedepaiement;

    public Oppaye1() {
        super.setNomTable("OPPAYELC1");
    }

    public Date getDatedepaiement() {
        return datedepaiement;
    }

    public void setDatedepaiement(Date datedepaiement) {
        this.datedepaiement = datedepaiement;
    }
    
}
