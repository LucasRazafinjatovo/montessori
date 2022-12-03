/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pub;

import bean.ClassMAPTable;
import java.sql.Date;

/**
 *
 * @author ITU
 */
public class PubClientLibelle extends ClassMAPTable{
    private String id;
    private String client;
    private String nom_compagne;
    private String nom_pub;
    private String ref;
    private String idtype;
    private String idplage;
    private String remarques;
    private Date date_debut_diff;
    private Date date_fin_diff;
    private int duree;
    private int qte;
    @Override
    public String getTuppleID() {
        return this.getId(); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public String getAttributIDName() {
        return "id"; //To change body of generated methods, choose Tools | Templates.
    }
    public PubClientLibelle()
    {
        this.setNomTable("pub_client_libelle");
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
     * @return the client
     */
    public String getClient() {
        return client;
    }

    /**
     * @param client the client to set
     */
    public void setClient(String client) {
        this.client = client;
    }

    /**
     * @return the nom_compagne
     */
    public String getNom_compagne() {
        return nom_compagne;
    }

    /**
     * @param nom_compagne the nom_compagne to set
     */
    public void setNom_compagne(String nom_compagne) {
        this.nom_compagne = nom_compagne;
    }

    /**
     * @return the nom_pub
     */
    public String getNom_pub() {
        return nom_pub;
    }

    /**
     * @param nom_pub the nom_pub to set
     */
    public void setNom_pub(String nom_pub) {
        this.nom_pub = nom_pub;
    }

    /**
     * @return the ref
     */
    public String getRef() {
        return ref;
    }

    /**
     * @param ref the ref to set
     */
    public void setRef(String ref) {
        this.ref = ref;
    }

    /**
     * @return the idtype
     */
    public String getIdtype() {
        return idtype;
    }

    /**
     * @param idtype the idtype to set
     */
    public void setIdtype(String idtype) {
        this.idtype = idtype;
    }

    /**
     * @return the idplage
     */
    public String getIdplage() {
        return idplage;
    }

    /**
     * @param idplage the idplage to set
     */
    public void setIdplage(String idplage) {
        this.idplage = idplage;
    }

    /**
     * @return the remarques
     */
    public String getRemarques() {
        return remarques;
    }

    /**
     * @param remarques the remarques to set
     */
    public void setRemarques(String remarques) {
        this.remarques = remarques;
    }

    /**
     * @return the date_debut_diff
     */
    public Date getDate_debut_diff() {
        return date_debut_diff;
    }

    /**
     * @param date_debut_diff the date_debut_diff to set
     */
    public void setDate_debut_diff(Date date_debut_diff) {
        this.date_debut_diff = date_debut_diff;
    }

    /**
     * @return the date_fin_diff
     */
    public Date getDate_fin_diff() {
        return date_fin_diff;
    }

    /**
     * @param date_fin_diff the date_fin_diff to set
     */
    public void setDate_fin_diff(Date date_fin_diff) {
        this.date_fin_diff = date_fin_diff;
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

    /**
     * @return the qte
     */
    public int getQte() {
        return qte;
    }

    /**
     * @param qte the qte to set
     */
    public void setQte(int qte) {
        this.qte = qte;
    }
    
}
