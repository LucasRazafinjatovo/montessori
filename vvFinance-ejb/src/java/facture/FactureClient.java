package facture;

import bean.ClassMAPTable;
import bean.GenUtil;
import java.io.PrintStream;
import java.sql.Date;
import utilitaire.Utilitaire;

/**
 * <p>
 * Title: Gestion des recettes </p>
 * <p>
 * Description: </p>
 * <p>
 * Copyright: Copyright (c) 2005</p>
 * <p>
 * Company: </p>
 *
 * @author unascribed
 * @version 1.0
 */
public class FactureClient extends ClassMAPTable {

    private String idfacturefournisseur;
    private String idfournisseur;
    private String numfact;
    private Date daty;

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public FactureClient() {
        super.setNomTable("factureclient");
    }

    public String getTuppleID() {
        return String.valueOf(idfacturefournisseur);
    }

    public String getAttributIDName() {
        return "idfacturefournisseur";
    }

    public void setIdfacturefournisseur(String idfacturefournisseur) {
        this.idfacturefournisseur = idfacturefournisseur;
    }

    public String getIdfacturefournisseur() {
        return idfacturefournisseur;
    }

    public void setIdfournisseur(String idfournisseur) {
        this.idfournisseur = idfournisseur;
    }

    public String getIdfournisseur() {
        return idfournisseur;
    }

    public void setNumfact(String numfact) {
        this.numfact = numfact;
    }

    public String getNumfact() {
        return numfact;
    }
}
