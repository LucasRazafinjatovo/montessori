/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package etudiant;

import bean.CGenUtil;
import bean.ClassMAPTable;
import finance.MvtCaisse;
import utilitaire.Utilitaire;

import java.sql.Connection;
import java.sql.Date;

/**
 *
 * @author LUCAS
 */
public class Paiement extends ClassMAPTable{
    String id;
    double montant;
    String idfacture;
    String idmodepaiement;
    Date datepaiement;
    String idcaisse;

    public Paiement() {
        this.setNomTable("paiement");
    }
    public void construirePK(Connection c) throws Exception{
    super.setNomTable("paiement");
    this.preparePk("PAI","getSeqPaiement");
    this.setId(makePK(c));
  }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public String getIdfacture() {
        return idfacture;
    }

    public void setIdfacture(String idfacture) {
        this.idfacture = idfacture;
    }

    public String getIdmodepaiement() {
        return idmodepaiement;
    }

    public void setIdmodepaiement(String idmodepaiement) {
        this.idmodepaiement = idmodepaiement;
    }
    public String getIdcaisse() {
        return idcaisse;
    }

    public void setIdcaisse(String idcaisse) {
        this.idcaisse = idcaisse;
    }

    public Date getDatepaiement() {
        return datepaiement;
    }

    public void setDatepaiement(Date datepaiement) {
        this.datepaiement = datepaiement;
    }

    @Override
    public String getTuppleID() {
       return idfacture; //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public String getAttributIDName() {
        return "id"; //To change body of generated methods, choose Tools | Templates.
    }
    public double getMontantAPayer() throws Exception
    {
        int somme=0;
        somme=Utilitaire.getSommeColonneMultiCritere("facturefille","montant","id ='"+this.idfacture+"'");
        double reponse =(double) somme;
        return reponse;
    }
    public double getMontantDejaPayer() throws Exception
    {
        int somme=0;
        somme=Utilitaire.getSommeColonneMultiCritere("paiement","montant","idfacture ='"+this.idfacture+"'");
        double reponse =(double) somme;
        return reponse;
    }
    public FactureFille getFacture(Connection c) throws Exception
    {
        FactureFille[] facture = (FactureFille[]) CGenUtil.rechercher(new FactureFille(), null, null, c, "and id='"+this.getIdfacture()+"'");
        return facture[0];
    }
    public FactureMereFille getFactureMereFille(Connection c) throws Exception
    {
        FactureMereFille[] facture = (FactureMereFille[]) CGenUtil.rechercher(new FactureMereFille(), null, null, c, "and idfacturefille='"+this.getIdfacture()+"'");
        return facture[0];
    }
    
    @Override
    public void controler(Connection c) throws Exception {

        double montantApayer=this.getMontantAPayer();
        double dejapayer=this.getMontantDejaPayer();
        double montant=dejapayer+this.montant;
        if(montant>montantApayer)
        {
            throw new Exception("Erreur! le montant est superieur à le montant à payer "+montant);
        }
        else
        {
            String idecole=this.getFactureMereFille(c).getIdecole();
            MvtCaisse mvtCaisse=new MvtCaisse();
            mvtCaisse.setDesignation("Paiement "+this.getFacture(c).getDesignation());
            mvtCaisse.setDaty(this.datepaiement);
            mvtCaisse.setDebit(0);
            mvtCaisse.setCredit(this.getMontant());
            mvtCaisse.setIdmodepaiement(this.getIdmodepaiement());
            mvtCaisse.setIdCaisse(this.idcaisse);
            mvtCaisse.setIdecole(idecole);
            mvtCaisse.construirePK(c);
            mvtCaisse.insertToTable(c);
        }
       
    }

    
    
}
