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
 * @author Safidimahefa
 */
public class PubRadioFille extends ClassMAPTable {
    private String id, mere, nomcampagne, nature, duree, pubtype, heure;
    private Date datedebut, datefin;
    private int etat, quantite;
    
    public PubRadioFille(){
        this.setNomTable("PUB_TOP_RADIO_FILLE");
    }

    public void construirePK(Connection c) throws Exception {
        this.preparePk("PUBF", "GETSEQPUBTOPRADIOFILLE");
        this.setId(makePK(c));
    }    
    @Override
    public String getTuppleID() {
        return getId();
    }

    @Override
    public String getAttributIDName() {
        return "id";
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
     * @return the mere
     */
    public String getMere() {
        return mere;
    }

    /**
     * @param mere the mere to set
     */
    public void setMere(String mere) {
        this.mere = mere;
    }
    /**
     * @return the nature
     */
    public String getNature() {
        return nature;
    }

    /**
     * @param nature the nature to set
     */
    public void setNature(String nature) {
        this.nature = nature;
    }

    /**
     * @return the duree
     */
    public String getDuree() {
        return duree;
    }

    /**
     * @param duree the duree to set
     */
    public void setDuree(String duree) {
        this.duree = duree;
    }

    /**
     * @return the pubtype
     */
    public String getPubtype() {
        return pubtype;
    }

    /**
     * @param pubtype the pubtype to set
     */
    public void setPubtype(String pubtype) {
        this.pubtype = pubtype;
    }

    /**
     * @return the heure
     */
    public String getHeure() {
        return heure;
    }

    /**
     * @param heure the heure to set
     */
    public void setHeure(String heure) throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (heure == null) {
                throw new Exception("error : heure obligatoire.");
            }
        }
        this.heure = heure;
    }

    /**
     * @return the datedebut
     */
    public Date getDatedebut() {
        return datedebut;
    }

    /**
     * @param datedebut the datedebut to set
     */
    public void setDatedebut(Date datedebut) {
        this.datedebut = datedebut;
    }

    /**
     * @return the datefin
     */
    public Date getDatefin() {
        return datefin;
    }

    /**
     * @param datefin the datefin to set
     */
    public void setDatefin(Date datefin) {
        this.datefin = datefin;
    }

    /**
     * @return the etat
     */
    public int getEtat() {
        return etat;
    }

    /**
     * @param etat the etat to set
     */
    public void setEtat(int etat) {
        this.etat = etat;
    }

    /**
     * @return the quantite
     */
    public int getQuantite() {
        return quantite;
    }

    /**
     * @param quantite the quantite to set
     */
    public void setQuantite(int quantite) {
        this.quantite = quantite;
    }

    /**
     * @return the nomcampagne
     */
    public String getNomcampagne() {
        return nomcampagne;
    }

    /**
     * @param nomcampagne the nomcampagne to set
     */
    public void setNomcampagne(String nomcampagne) {
        this.nomcampagne = nomcampagne;
    }
    
}
