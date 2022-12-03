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
import utilitaire.Utilitaire;

import java.sql.Connection;

/**
 *
 * @author LUCAS
 */
public class InscriptionEtudiant extends ClassMAPTable{
    String id;
    int moisDebut;
    String idEtudiant;
    String idNiveau;
    String idAnneeScolaire;
    String idEcole;
    String idTarif;
   

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdEtudiant() {
        return idEtudiant;
    }

    public void setIdEtudiant(String idEtudiant) {
        this.idEtudiant = idEtudiant;
    }

    public String getIdNiveau() {
        return idNiveau;
    }

    public void setIdNiveau(String idNiveau) {
        this.idNiveau = idNiveau;
    }

    public String getIdAnneeScolaire() {
        return idAnneeScolaire;
    }

    public void setIdAnneeScolaire(String idAnneeScolaire) {
        this.idAnneeScolaire = idAnneeScolaire;
    }
    public int getMoisDebut() {
        return moisDebut;
    }

    public void setMoisDebut(int moisDebut) {
        this.moisDebut = moisDebut;
    }
    public String getIdTarif() {
        return idTarif;
    }

    public void setIdTarif(String idtarif)  throws Exception{
       
        this.idTarif = idtarif;
    }
    public String getIdEcole() {
        return idEcole;
    }

    public void setIdEcole(String idEcole) {
        this.idEcole = idEcole;
    }
    public InscriptionEtudiant() {
        super.setNomTable("inscriptionetudiant");
    }
    public String getTuppleID(){
    return idEtudiant;
  }
  public String getAttributIDName(){
    return "id";
  }
  public void construirePK(Connection c) throws Exception{
    super.setNomTable("inscriptionetudiant");
    this.preparePk("IEU","getSeqInscriptionEtudiant");
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
        InscriptionEtudiant[] tEtudiant = (InscriptionEtudiant[]) CGenUtil.rechercher(new InscriptionEtudiant(), null, null, c, " and idAnneescolaire='"+this.getIdAnneeScolaire()+"' and idEtudiant='"+this.getIdEtudiant()+"' and idNiveau='"+this.getIdNiveau()+"' and idecole='"+this.getIdEcole()+"'");
        if(tEtudiant.length > 0){
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
    public Tarif getTarif(Connection c) throws Exception
    {
    
        Tarif[] tarifr = (Tarif[]) CGenUtil.rechercher(new Tarif(), null, null, c, " and designation='"+this.idTarif+"' and idEcole='"+this.idEcole+"'");
        return tarifr[0];
    }
    public int getAnnee(Connection c) throws Exception
    {
        int reponse=0;
        String[] temp=this.getAnneeScolaire(c).split("-");
        reponse=Integer.parseInt(temp[1]);
        return reponse;
    }
    public String getAnneeScolaire(Connection c) throws Exception
    {
        AnneeScolaire[] anneeScolaire = (AnneeScolaire[]) CGenUtil.rechercher(new AnneeScolaire(), null, null, c, "and id = '"+this.idAnneeScolaire+"'");
        return anneeScolaire[0].getNom();
    }
    @Override
    public void controler(Connection c) throws Exception
    {
        if(this.isExist(c)==true)
        {
           throw new Exception("Erreur! Etudiant deja inscrit");
        } 
        else
        {  
              
                String idTarif=this.getTarif(c).getId();
                this.setIdTarif(idTarif);   
                // FactureMere factureMere=new FactureMere();
                // factureMere.setMois(this.getMoisDebut());
                // factureMere.setAnnee(this.getAnnee(c));
                // factureMere.setIdetudiant(this.getIdEtudiant());
                // System.out.println("------------facture Mere--------------");
                // System.out.println("facturemere mois : "+factureMere.getMois());
                // System.out.println("facturemere annee : "+factureMere.getAnnee());
                // System.out.println("facturemere idetudiant : "+factureMere.getIdetudiant());
                // factureMere.construirePK(c);
                // factureMere.insertToTable(c);
                // System.out.println("facturemere mere : "+factureMere.getId());
                // FactureFille fraisInscription=new FactureFille();
                // this.setIdTarif("Once off Registration fee");
                // fraisInscription.setDesignation(this.getTarif(c).getDesignation()+"(inscription)");
                // fraisInscription.setMontant(this.getTarif(c).getMontant());
                // fraisInscription.setIdfacturemere(factureMere.getId());
                // System.out.println("------------facturefille--------------");
                // System.out.println("designation :"+fraisInscription.getDesignation());
                // System.out.println("montant : "+fraisInscription.getMontant());
                // System.out.println("fm : "+fraisInscription.getIdfacturemere());
                // // fraisInscription.construirePK(c);
                // // fraisInscription.insertToTable(c);
                // // FactureFille stationnery=new FactureFille();
                // // this.setIdTarif("Stationary and toiletries");
                // // stationnery.setDesignation(this.getTarif(c).getDesignation()+"(Station)");
                // // stationnery.setMontant(this.getTarif(c).getMontant());
                // // stationnery.setIdfacturemere(factureMere.getId());
                // // stationnery.construirePK(c);
                // // stationnery.insertToTable(c);
        }                  
                          
    }
 
}
