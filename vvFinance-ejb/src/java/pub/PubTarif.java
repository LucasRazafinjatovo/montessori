/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pub;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;

/**
 *
 * @author ITU
 */
public class PubTarif extends ClassMAPTable{
    private String id;
    private String idtype;
    private String durees;
    private String id_plage_horaire;
    private int duree;
    private double montant;
    private Date date_effective;

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public Date getDate_effective() {
        return date_effective;
    }

    public void setDate_effective(Date date_effective) {
        this.date_effective = date_effective;
    }
    
    
    @Override
    public String getTuppleID() {
        return this.getId(); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public String getAttributIDName() {
        return "id"; //To change body of generated methods, choose Tools | Templates.
    }
    public PubTarif()
    {
        this.setNomTable("pub_tarif");
    }
    public PubTarif(String id,String idtype,String durees,String idplage_horaire,int duree)
    {
        this.setId(id);
        this.setIdtype(idtype);
        this.setDurees(durees);
        this.setId_plage_horaire(idplage_horaire);
        this.setDurees(durees);
        this.setNomTable("pub_tarif");
    }
    public PubTarif(String idtype,String durees,String idplage_horaire,int duree)
    {
        this.setIdtype(idtype);
        this.setDurees(durees);
        this.setId_plage_horaire(idplage_horaire);
        this.setDurees(durees);
        this.setNomTable("pub_tarif");
    }
    public void construirePK(Connection c) throws Exception {
        this.preparePk("PTR", "GETSEQPUBTARIF");
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
     * @return the idtype
     */
    public String getIdtype() {
        return idtype;
    }

    /**
     * @param idtype the idtype to set
     */
    public void setIdtype(String idtype) {
        this.idtype = idtype;
    }

    /**
     * @return the durees
     */
    public String getDurees() {
        return durees;
    }

    /**
     * @param durees the durees to set
     */
    public void setDurees(String durees) {
        this.durees = durees;
    }

    /**
     * @return the id_plage_horaire
     */
    public String getId_plage_horaire() {
        return id_plage_horaire;
    }

    /**
     * @param id_plage_horaire the id_plage_horaire to set
     */
    public void setId_plage_horaire(String id_plage_horaire) {
        this.id_plage_horaire = id_plage_horaire;
    }

    /**
     * @return the duree
     */
    public int getDuree() {
        return duree;
    }

    /**
     * @param duree the duree to set
     */
    public void setDuree(int duree) {
        this.duree = duree;
    }
    
}
