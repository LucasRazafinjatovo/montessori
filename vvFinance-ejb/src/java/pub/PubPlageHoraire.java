/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pub;

import bean.ClassMAPTable;
import java.sql.Connection;

/**
 *
 * @author ITU
 */
public class PubPlageHoraire extends ClassMAPTable{
    private String id;
    private String designation;
    private String numero;
    private String heure_debut;
    private String heure_fin;
    @Override
    public String getTuppleID() {
        return this.getId(); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public String getAttributIDName() {
        return "id"; //To change body of generated methods, choose Tools | Templates.
    }
    public PubPlageHoraire()
    {
        setNomTable("pub_plage_horaire");
    }
    public PubPlageHoraire(String id,String designation,String numero,String heure_debut,String heure_fin)
    {
        setId(id);
        setDesignation(designation);
        setNumero(numero);
        setHeure_debut(heure_debut);
        setHeure_fin(heure_fin);
        setNomTable("pub_plage_horaire");
    }
    public PubPlageHoraire(String designation,String numero,String heure_debut,String heure_fin)
    {
        setDesignation(designation);
        setNumero(numero);
        setHeure_debut(heure_debut);
        setHeure_fin(heure_fin);
        setNomTable("pub_plage_horaire");
    }
    public void construirePK(Connection c) throws Exception {
        this.preparePk("PPH", "GETSEQPUBPLAGEHORAIRE");
        this.setId(makePK(c));
    }
    /**
     * @return the id
     */
    public String getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(String id) {
        this.id = id;
    }

    /**
     * @return the designation
     */
    public String getDesignation() {
        return designation;
    }

    /**
     * @param designation the designation to set
     */
    public void setDesignation(String designation) {
        this.designation = designation;
    }

    /**
     * @return the numero
     */
    public String getNumero() {
        return numero;
    }

    /**
     * @param numero the numero to set
     */
    public void setNumero(String numero) {
        this.numero = numero;
    }

    /**
     * @return the heure_debut
     */
    public String getHeure_debut() {
        return heure_debut;
    }

    /**
     * @param heure_debut the heure_debut to set
     */
    public void setHeure_debut(String heure_debut) {
        this.heure_debut = heure_debut;
    }

    /**
     * @return the heure_fin
     */
    public String getHeure_fin() {
        return heure_fin;
    }

    /**
     * @param heure_fin the heure_fin to set
     */
    public void setHeure_fin(String heure_fin) {
        this.heure_fin = heure_fin;
    }
    
}
