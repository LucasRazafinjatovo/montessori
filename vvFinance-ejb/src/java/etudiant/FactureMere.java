/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package etudiant;

import bean.CGenUtil;
import bean.ClassMAPTable;
import historique.MapUtilisateur;
import utilitaire.UtilDB;

import java.sql.Connection;

/**
 *
 * @author LUCAS
 */
public class FactureMere extends ClassMAPTable{
    String id;
    int mois;
    int annee;
    String idetudiant;

    public FactureMere() {
        this.setNomTable("facturemere");
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public int getMois() {
        return mois;
    }

    public void setMois(int mois) {
        this.mois = mois;
    }

    public int getAnnee() {
        return annee;
    }

    public void setAnnee(int annee) {
        this.annee = annee;
    }

    public String getIdetudiant() {
        return idetudiant;
    }

    public void setIdetudiant(String idetudiant) {
        this.idetudiant = idetudiant;
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
        super.setNomTable("facturemere");
        this.preparePk("FACM","getSeqFactureMere");
        this.setId(makePK(c));
      }
    
    public boolean isExist(Connection c) throws Exception
    {   
        int indice = 0;
    try {
        if (c == null) {
            c = new UtilDB().GetConn();
            indice = 1;
            c.setAutoCommit(false);
        }
        FactureMere[] facture = (FactureMere[]) CGenUtil.rechercher(new FactureMere(), null, null, c, "and idetudiant='"+this.getIdetudiant()+"' and annee='"+this.getAnnee()+"' and mois='"+this.getMois()+"'");
        if(facture.length > 0){
          return true;
        } 
      
    } catch (Exception e) {
        e.printStackTrace();
        throw e;
    } finally {
        if (indice == 1 && c != null) {
            c.close();
        }
    } 
    return false;
    }
    public FactureMere getFacture(Connection c) throws Exception
    {
        FactureMere[] facture = (FactureMere[]) CGenUtil.rechercher(new FactureMere(), null, null, c, "and idetudiant='"+this.getIdetudiant()+"' and annee='"+this.getAnnee()+"' and mois='"+this.getMois()+"'");
        return facture[0];
    }
    public EtudiantEnCours getEtudiant(Connection c) throws Exception
    {
        EtudiantEnCours[] etudiantEnCours = (EtudiantEnCours[]) CGenUtil.rechercher(new EtudiantEnCours(), null, null, c, "and idetudiant='"+this.getIdetudiant()+"'");
        return etudiantEnCours[0];
    }
   
    public void genererEcolage(String u) throws Exception
    {
        Connection c = null;
        try
        {
            c = new UtilDB().GetConn();
            if(!this.isExist(c))
            {
                this.construirePK(c);
                this.insertToTableWithHisto(u, c);
              
            }
            if(this.isExist(c))
            {

                FactureFille facturefille=new FactureFille();
                facturefille.setDesignation(this.getEtudiant(c).getDesignation()+"(ecolage)");
                facturefille.setMontant(this.getEtudiant(c).getMontant());
                facturefille.setIdfacturemere(this.getFacture(c).getId());
                facturefille.construirePK(c);
                facturefille.insertToTableWithHisto(u, c);
            }
    
           
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
            
    }
    
}
