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
 * @author Alain
 */
public class PubRadioPartenariat extends ClassMAPTable {

    private String id;
    private Date daty;
    private String client, observation, reference, responsable;
    private int remise;
    private int nombre_spot;
    private Date datedebut, datefin;
    private String idtarif, nomcampagne, nature, duree, pubtype, heure;
    private int etat;

    public PubRadioPartenariat() {
        this.setNomTable("pub_radio_partenariat");
    }

    public void construirePK(Connection c) throws Exception {
        this.preparePk("PRP", "GETSEQ_PUBRADIO_PACK");
        this.setId(makePK(c));
    }

    @Override
    public String getTuppleID() {
        return this.getId(); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public String getAttributIDName() {
        return "id"; //To change body of generated methods, choose Tools | Templates.
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public String getClient() {
        return client;
    }

    public void setClient(String client) {
        this.client = client;
    }

    public String getObservation() {
        return observation;
    }

    public void setObservation(String observation) {
        this.observation = observation;
    }

    public String getReference() {
        return reference;
    }

    public void setReference(String reference) {
        this.reference = reference;
    }

    public String getResponsable() {
        return responsable;
    }

    public void setResponsable(String responsable) {
        this.responsable = responsable;
    }

    public int getRemise() {
        return remise;
    }

    public void setRemise(int remise) {
        this.remise = remise;
    }

    public Date getDatedebut() {
        return datedebut;
    }

    public void setDatedebut(Date datedebut) {
        this.datedebut = datedebut;
    }

    public Date getDatefin() {
        return datefin;
    }

    public void setDatefin(Date datefin) {
        this.datefin = datefin;
    }

    public String getIdtarif() {
        return idtarif;
    }

    public void setIdtarif(String idtarif) throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (idtarif == null) {
                throw new Exception("error : idtarif obligatoire.");
            }
        }
        this.idtarif = idtarif;
    }

    public String getNomcampagne() {
        return nomcampagne;
    }

    public void setNomcampagne(String nomcampagne) {
        this.nomcampagne = nomcampagne;
    }

    public String getNature() {
        return nature;
    }

    public void setNature(String nature) {
        this.nature = nature;
    }

    public String getDuree() {
        return duree;
    }

    public void setDuree(String duree) {
        this.duree = duree;
    }

    public String getPubtype() {
        return pubtype;
    }

    public void setPubtype(String pubtype) {
        this.pubtype = pubtype;
    }

    public String getHeure() {
        return heure;
    }

    public void setHeure(String heure) {
        this.heure = heure;
    }

    public int getEtat() {
        return etat;
    }

    public void setEtat(int etat) {
        this.etat = etat;
    }

    /**
     * @return the nombre_spot
     */
    public int getNombre_spot() {
        return nombre_spot;
    }

    /**
     * @param nombre_spot the nombre_spot to set
     */
    public void setNombre_spot(int nombre_spot) {
        this.nombre_spot = nombre_spot;
    }

}
