/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package commercial;

import bean.ClassMAPTable;
import java.sql.Connection;

/**
 *
 * @author Alain
 */
public class Responsable extends ClassMAPTable{
    
    private String id, nom, code, description;

    public String getAttributIDName() {
        return "id";
    }

    public String getTuppleID() {
        return id;
    }
    
    public void construirePK(Connection c) throws Exception {
        super.setNomTable("responsable");
        this.preparePk("rsp", "getSeqResponsable");
        this.setId(makePK(c));
    }
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    
    
}
