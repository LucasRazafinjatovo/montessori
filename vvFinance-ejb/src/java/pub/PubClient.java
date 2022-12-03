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
public class PubClient extends ClassMAPTable{
    private String id;
    private String client;
    private String nom_compagne;
    @Override
    public String getTuppleID() {
        return this.getId(); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public String getAttributIDName() {
        return "id"; //To change body of generated methods, choose Tools | Templates.
    }
    public PubClient()
    {
        this.setNomTable("pub_client");
    }
    public PubClient(String id,String client,String nom_compagne)
    {
        this.setId(id);
        this.setClient(client);
        this.setNom_compagne(nom_compagne);
        this.setNomTable("pub_client");
    }
    public PubClient(String client,String nom_compagne)
    {
        this.setClient(client);
        this.setNom_compagne(nom_compagne);
        this.setNomTable("pub_client");
    }
    public void construirePK(Connection c) throws Exception {
        this.preparePk("PBC", "GETSEQPUBCLIENT");
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
     * @return the client
     */
    public String getClient() {
        return client;
    }

    /**
     * @param client the client to set
     */
    public void setClient(String client) {
        this.client = client;
    }

    /**
     * @return the nom_compagne
     */
    public String getNom_compagne() {
        return nom_compagne;
    }

    /**
     * @param nom_compagne the nom_compagne to set
     */
    public void setNom_compagne(String nom_compagne) {
        this.nom_compagne = nom_compagne;
    }
    
}
