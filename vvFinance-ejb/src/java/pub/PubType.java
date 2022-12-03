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
public class PubType extends ClassMAPTable{
    private String id;
    private String designation;
    private String type;
    private String durees;
    private int duree;
    
    @Override
    public String getTuppleID() {
        return this.getId(); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public String getAttributIDName() {
        return "id"; //To change body of generated methods, choose Tools | Templates.
    }
    public PubType()
    {
        this.setNomTable("pub_type");
    }
    public PubType(String id,String designation,String type,String durees,int duree)
    {
        this.setId(id);
        this.setDesignation(designation);
        this.setType(type);
        this.setDuree(duree);
        this.setDurees(durees);
        this.setNomTable("pub_type");
    }
     public PubType(String designation,String type,String durees,int duree)
    {
        this.setDesignation(designation);
        this.setType(type);
        this.setDuree(duree);
        this.setDurees(durees);
        this.setNomTable("pub_type");
    }
     public void construirePK(Connection c) throws Exception {
        this.preparePk("PTP", "GETSEQPUBTYPE");
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
     * @return the designation
     */
    public String getDesignation() {
        return designation;
    }

    /**
     * @param designation the designation to set
     */
    public void setDesignation(String designation) {
        this.designation = designation;
    }

    /**
     * @return the type
     */
    public String getType() {
        return type;
    }

    /**
     * @param type the type to set
     */
    public void setType(String type) {
        this.type = type;
    }

    /**
     * @return the durees
     */
    public String getDurees() {
        return durees;
    }

    /**
     * @param durees the durees to set
     */
    public void setDurees(String durees) {
        this.durees = durees;
    }

    /**
     * @return the duree
     */
    public int getDuree() {
        return duree;
    }

    /**
     * @param duree the duree to set
     */
    public void setDuree(int duree) {
        this.duree = duree;
    }
    
}
