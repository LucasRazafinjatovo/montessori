/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ventegazety;

import bean.ClassMAPTable;
import java.sql.Date;

/**
 *
 * @author Alain
 */
public class ControleInvendu extends ClassMAPTable {

    private String id;
    private String vendeur;
    private String typevendeur;
    private Date dateprise;
    private String province;

    public ControleInvendu() {
        this.setNomTable("InvenduControleSaisie");
    }
    
    public String getAttributIDName() {
        return "id";
    }

    public String getTuppleID() {
        return id;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getVendeur() {
        return vendeur;
    }

    public void setVendeur(String vendeur) {
        this.vendeur = vendeur;
    }

    public String getTypevendeur() {
        return typevendeur;
    }

    public void setTypevendeur(String typevendeur) {
        this.typevendeur = typevendeur;
    }

    public Date getDateprise() {
        return dateprise;
    }

    public void setDateprise(Date dateprise) {
        this.dateprise = dateprise;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }
    
}
