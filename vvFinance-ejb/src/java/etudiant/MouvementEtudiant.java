/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package etudiant;

import bean.ClassEtat;
import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;

/**
 *
 * @author pro
 */
public class MouvementEtudiant extends ClassMAPTable{

    private String id;
    private String  etudiant;
    private Date daty;
    private String motif;
    private String type;

    public MouvementEtudiant() {
        super.setNomTable("mouvementEtudiant");
    }
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getEtudiant() {
        return etudiant;
    }

    public void setEtudiant(String etudiant) {
        this.etudiant = etudiant;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public String getMotif() {
        return motif;
    }

    public void setMotif(String motif) {
        this.motif = motif;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
            
    public void construirePK(Connection c) throws Exception{
        super.setNomTable("mouvementEtudiant");
        this.preparePk("MVT","GETSEQ_MouvementEtudiant");
        this.setId(makePK(c));
    }
    
    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    
}
