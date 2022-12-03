/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package commercial;

import bean.ClassMAPTable;

/**
 *
 * @author Alain
 */
public class EtatNumcompte extends ClassMAPTable{
    
    private String idnumcompte, categorie, etat;

    public EtatNumcompte() {
        super.setNomTable("etatnumcompte");
    }
    
    public String getAttributIDName() {
        return "idnumcompte";
    }

    public String getTuppleID() {
        return idnumcompte;
    }

    public String getIdnumcompte() {
        return idnumcompte;
    }

    public void setIdnumcompte(String idnumcompte) {
        this.idnumcompte = idnumcompte;
    }

    public String getCategorie() {
        return categorie;
    }

    public void setCategorie(String categorie) {
        this.categorie = categorie;
    }

    public String getEtat() {
        return etat;
    }

    public void setEtat(String etat) {
        this.etat = etat;
    }
    
    
}
