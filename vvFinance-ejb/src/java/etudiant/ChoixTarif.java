/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package etudiant;

import bean.ClassMAPTable;

/**
 *
 * @author LUCAS
 */
public class ChoixTarif extends ClassMAPTable{
    String id;
    String designation;

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public ChoixTarif(String id, String designation) {
        this.id = id;
        this.designation = designation;
    }

    public ChoixTarif() {
        this.setNomTable("choixtarif");
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }
}
