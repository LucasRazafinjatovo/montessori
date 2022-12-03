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
public class PubRadioMere extends ClassMAPTable{
    private String id;
    private Date daty;
    private String client, observation, reference, responsable;
    private int remise;
    private int etat;

    public int getRemise() {
        return remise;
    }

    public void setRemise(int remise) {
        this.remise = remise;
    }
            
    
    public PubRadioMere(){
        this.setNomTable("PUB_TOP_RADIO_MERE");
    }

    public void construirePK(Connection c) throws Exception {
        this.preparePk("PUB", "GETSEQPUBTOPRADIOMERE");
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
     * @return the daty
     */
    public Date getDaty() {
        return daty;
    }

    /**
     * @param daty the daty to set
     */
    public void setDaty(Date daty) {
        this.daty = daty;
    }

    /**
     * @return the client
     */
    public String getClient() {
        return client;
    }

    /**
     * @param client the client to set
     */
    public void setClient(String client) throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (client == null) {
                throw new Exception("error : client obligatoire.");
            }
        }
        this.client = client;
    }

    /**
     * @return the observation
     */
    public String getObservation() {
        return observation;
    }

    /**
     * @param observation the observation to set
     */
    public void setObservation(String observation) {
        this.observation = observation;
    }

    /**
     * @return the reference
     */
    public String getReference() {
        return reference;
    }

    /**
     * @param reference the reference to set
     */
    public void setReference(String reference) {
        this.reference = reference;
    }

    /**
     * @return the responsable
     */
    public String getResponsable() {
        return responsable;
    }

    /**
     * @param responsable the responsable to set
     */
    public void setResponsable(String responsable) throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (responsable == null) {
                throw new Exception("error : responsable obligatoire.");
            }
        }
        this.responsable = responsable;
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
    
}
