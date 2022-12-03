/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package finance;

import bean.ClassMAPTable;
import java.sql.Connection;

/**
 *
 * @author user
 */
public class RapproSousMvtCaisse extends ClassMAPTable{
    private String id;
    private String idrapprolettre;
    private String idmvtcaisse;


    public void construirePK(Connection c) throws Exception {
        this.preparePk("RSE", "GETSEQrapprosousmvtcaisse");
        this.setId(makePK(c));
    }

    public String getTuppleID() {
        return getId();
    }


    public String getAttributIDName() {
        return "id";
    }
    public RapproSousMvtCaisse()
    {
        this.setNomTable("rappro_sous_mvtcaisse");
    }
    public RapproSousMvtCaisse(String id,String idrapprolettre,String idsousecriture)
    {
        this.setId(id);
        this.setIdrapprolettre(idrapprolettre);
        this.setIdmvtcaisse(idsousecriture);
        this.setNomTable("rappro_sous_mvtcaisse");
    }
    public RapproSousMvtCaisse(String idrapprolettre,String idsousecriture)
    {
        this.setIdrapprolettre(idrapprolettre);
        this.setIdmvtcaisse(idsousecriture);
        this.setNomTable("rappro_sous_mvtcaisse");
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
     * @return the idraprolettre
     */
    public String getIdrapprolettre() {
        return idrapprolettre;
    }

    /**
     * @param idraprolettre the idraprolettre to set
     */
    public void setIdrapprolettre(String idrapprolettre) {
        this.idrapprolettre = idrapprolettre;
    }

    /**
     * @return the idsousecriture
     */
    public String getIdmvtcaisse() {
        return idmvtcaisse;
    }

    /**
     * @param idmvtcaisse the idsousecriture to set
     */
    public void setIdmvtcaisse(String idmvtcaisse) {
        this.idmvtcaisse = idmvtcaisse;
    }

}
