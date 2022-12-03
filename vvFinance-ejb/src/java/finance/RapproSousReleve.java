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
public class RapproSousReleve extends ClassMAPTable{
    private String id;
    private String idrapprolettre;
    private String idreleve;
    public RapproSousReleve()
    {
        this.setNomTable("rappro_sous_releve");
    }
    public RapproSousReleve(String id,String idrapprolettre,String idreleve)
    {
        this.setId(id);
        this.setIdrapprolettre(idrapprolettre);
        this.setIdreleve(idreleve);
        this.setNomTable("rappro_sous_releve");
    }
    public RapproSousReleve(String idrapprolettre,String idreleve)
    {
        this.setIdrapprolettre(idrapprolettre);
        this.setIdreleve(idreleve);
        this.setNomTable("rappro_sous_releve");
    }
    public void construirePK(Connection c) throws Exception {
        this.preparePk("RSR", "GETSEQrapprosousreleve");
        this.setId(makePK(c));
    }

    public String getTuppleID() {
        return getId();
    }
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
     * @return the idreleve
     */
    public String getIdreleve() {
        return idreleve;
    }

    /**
     * @param idreleve the idreleve to set
     */
    public void setIdreleve(String idreleve) {
        this.idreleve = idreleve;
    }

}
