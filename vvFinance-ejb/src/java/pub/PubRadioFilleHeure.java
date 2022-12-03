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
 * @author Alain
 */
public class PubRadioFilleHeure extends ClassMAPTable{
 
    private String id;
    private String idpub;
    private String heure;

    public PubRadioFilleHeure() {
        this.setNomTable("pub_fille_heure");
    }

    public void construirePK(Connection c) throws Exception {
        this.preparePk("PUBF", "GETSEQPUBFILLEHEURE");
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
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdpub() {
        return idpub;
    }

    public void setIdpub(String idpub) {
        this.idpub = idpub;
    }

    public String getHeure() {
        return heure;
    }

    public void setHeure(String heure) {
        this.heure = heure;
    }
    
    
}
