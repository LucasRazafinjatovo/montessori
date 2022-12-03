/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package etudiant;

import bean.CGenUtil;
import bean.ClassMAPTable;
import java.sql.Connection;

/**
 *
 * @author LUCAS
 */
public class FactureFille extends ClassMAPTable{
    String id;
    String designation;
    double montant;
    String idfacturemere;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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

    public String getIdfacturemere() {
        return idfacturemere;
    }

    public void setIdfacturemere(String idfacturemere) {
        this.idfacturemere = idfacturemere;
    }

    public FactureFille() {
        this.setNomTable("facturefille");
    }

    @Override
    public String getTuppleID() {
       return id; //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public String getAttributIDName() {
       return "id"; //To change body of generated methods, choose Tools | Templates.
    }
    public void construirePK(Connection c) throws Exception{
        super.setNomTable("facturefille");
        this.preparePk("FACF","getSeqFactureFille");
        this.setId(makePK(c));
      }
    public EtudiantEnCours[] gEtudiant(Connection c) throws Exception
    {
      EtudiantEnCours[] etudiantEnCours = (EtudiantEnCours[]) CGenUtil.rechercher(new EtudiantEnCours(), null, null, c,"and id=''");
      return etudiantEnCours;
    }
 
}
