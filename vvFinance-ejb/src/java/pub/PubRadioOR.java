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
public class PubRadioOR extends ClassMAPTable{
 
    private String id, idpub, idfacture, montant, remarque, etat;
    
    public PubRadioOR() {
        this.setNomTable("pub_radio_or");
    }

    public void construirePK(Connection c) throws Exception {
        this.preparePk("PRO", "GETSEQ_PUBRADIO_OR");
        this.setId(makePK(c));
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

    public String getIdfacture() {
        return idfacture;
    }

    public void setIdfacture(String idfacture) {
        this.idfacture = idfacture;
    }

    public String getMontant() {
        return montant;
    }

    public void setMontant(String montant) {
        this.montant = montant;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public String getEtat() {
        return etat;
    }

    public void setEtat(String etat) {
        this.etat = etat;
    }
    
    @Override
    public String getTuppleID() {
        return this.getId(); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public String getAttributIDName() {
        return "id"; //To change body of generated methods, choose Tools | Templates.
    }
}
