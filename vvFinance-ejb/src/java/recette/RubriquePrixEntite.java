/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package recette;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;

/**
 *
 * @author Amboara
 */
public class RubriquePrixEntite extends ClassMAPTable{
    private String id;
    private String libelle;
    private double montant;
    private String entite;
    private Date daty;

    public RubriquePrixEntite() {
        this.setNomTable("RubriquePrixEntite");
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getLibelle() {
        return libelle;
    }

    public void setLibelle(String libelle) throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0 || getMode().compareToIgnoreCase("insert") == 0) {
            if (libelle.equals("")) {
                throw new Exception("Libelle obligatoire.");
            }
        }
        this.libelle = libelle;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0 || getMode().compareToIgnoreCase("insert") == 0) {
            if (montant <= 0) {
                throw new Exception("Montant obligatoire.");
            }
        }
        this.montant = montant;
    }

    public String getEntite() {
        return entite;
    }

    public void setEntite(String entite) {
        this.entite = entite;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public void construirePK(Connection c) throws Exception{
        this.preparePk("RPE","getSeqRubriquePrixEntite");
        this.setId(makePK(c));
    }
    
    @Override
    public String getTuppleID() {
        return this.getId();
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    
    

}
