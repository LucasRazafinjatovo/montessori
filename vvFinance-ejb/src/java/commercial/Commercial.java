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
public class Commercial extends ClassMAPTable {

    private String id, val, desce, ref, type;

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Commercial() {
        this.setNomTable("commercial_responsable");
    }
    
    

    public String getAttributIDName() {
        return "id";
    }

    public String getTuppleID() {
        return id;
    }

    public void construirePK(Connection c) throws Exception {
        super.setNomTable("commercial_responsable");
        this.preparePk("ag", "getSeqNewCommercial");
        this.setId(makePK(c));
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getVal() {
        return val;
    }

    public void setVal(String val) {
        this.val = val;
    }

    public String getDesce() {
        return desce;
    }

    public void setDesce(String desce) {
        this.desce = desce;
    }

    public String getRef() {
        return ref;
    }

    public void setRef(String ref) {
        this.ref = ref;
    }

}
