/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package etudiant;

import bean.ClassMAPTable;
import finance.MvtCaisse;

import java.sql.Connection;
import java.sql.Date;

/**
 *
 * @author LUCAS
 */
public class Depense extends ClassMAPTable{
    String id;
    Date daty;
    String idtypedepense;
    String designation;
    double montant;
    String beneficiaire;
    String idcaisse;
    String idecole;

    public Depense() {
        this.setNomTable("depense");
    }
    public void construirePK(Connection c) throws Exception{
       super.setNomTable("Depense");
       this.preparePk("DEP","getSeqDepense");
       this.setId(makePK(c));
  }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdecole() {
        return idecole;
    }

    public void setIdecole(String idecole) {
        this.idecole = idecole;
    }
 
    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public String getIdtypedepense() {
        return idtypedepense;
    }

    public void setIdtypedepense(String idtypedepense) {
        this.idtypedepense = idtypedepense;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public String getBeneficiaire() {
        return beneficiaire;
    }

    public void setBeneficiaire(String beneficiaire) {
        this.beneficiaire = beneficiaire;
    }

    @Override
    public String getTuppleID() {
       return id; //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public String getAttributIDName() {
        return "id"; //To change body of generated methods, choose Tools | Templates.
    }
    public String getIdcaisse() {
        return idcaisse;
    }

    public void setIdcaisse(String idcaisse) {
        this.idcaisse = idcaisse;
    }
    @Override
    public void controler(Connection c) throws Exception 
    {           
            MvtCaisse mvtCaisse=new MvtCaisse();
            mvtCaisse.setDesignation(this.getDesignation());
            mvtCaisse.setDaty(this.getDaty());
            mvtCaisse.setDebit(this.getMontant());
            mvtCaisse.setCredit(0);
            mvtCaisse.setIdCaisse(this.getIdcaisse());
            mvtCaisse.setIdecole(idecole);
            mvtCaisse.construirePK(c);
            mvtCaisse.insertToTable(c);
        
    }
}
