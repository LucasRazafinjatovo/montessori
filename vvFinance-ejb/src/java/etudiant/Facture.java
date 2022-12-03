package etudiant;

import java.sql.Connection;

import bean.CGenUtil;
import bean.ClassMAPTable;
import utilitaire.UtilDB;

public class Facture extends ClassMAPTable
{
    String id;
    String designation;
    double montant;
    int mois;
    int annee;
    String idEtudiant;

    public Facture() {
        this.setNomTable("facture");
    }

    public Facture(String id, String designation, double montant, int mois, int annee, String idEtudiant) {
        this.id = id;
        this.designation = designation;
        this.montant = montant;
        this.mois = mois;
        this.annee = annee;
        this.idEtudiant = idEtudiant;
    }
    public void construirePK(Connection c) throws Exception{
        super.setNomTable("facture");
        this.preparePk("FAC","getSeqFacture");
        this.setId(makePK(c));
      }

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

    public String getIdEtudiant() {
        return idEtudiant;
    }

    public void setIdEtudiant(String idEtudiant) {
        this.idEtudiant = idEtudiant;
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    
    
}