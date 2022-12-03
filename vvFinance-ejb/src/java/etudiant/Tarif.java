package etudiant;

import bean.ClassMAPTable;

public class Tarif extends ClassMAPTable{
        String id;
        String designation;
        double montant;
        String idEcole;

    public Tarif() {
        this.setNomTable("tarif");
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

    public String getIdEcole() {
        return idEcole;
    }

    public void setIdEcole(String idEcole) {
        this.idEcole = idEcole;
    }

    public Tarif(String id, String designation, double montant, String idEcole) {
        this.id = id;
        this.designation = designation;
        this.montant = montant;
        this.idEcole = idEcole;
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
