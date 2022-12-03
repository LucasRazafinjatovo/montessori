package finance;

import bean.ClassMAPTable;
import java.sql.Date;
import java.sql.Connection;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class RapproLettre extends ClassMAPTable{

  private String id;
    private String lettre;
    private Date datelettrage;
        private String typelettrage;
    public RapproLettre()
    {
        this.setNomTable("RAPPRO_LETTRE");
    }
    public RapproLettre(String id,String lettre,Date daty,String typelettrage)
    {
        this.setId(id);
        this.setLettre(lettre);
        this.setDatelettrage(daty);
                this.setTypelettrage(typelettrage);
        this.setNomTable("RAPPRO_LETTRE");
    }
    public RapproLettre(String lettre,Date daty,String typelettrage)
    {
        this.setLettre(lettre);
        this.setDatelettrage(daty);
        this.setTypelettrage(typelettrage);
        this.setNomTable("RAPPRO_LETTRE");
    }
    public void construirePK(Connection c) throws Exception {
        this.preparePk("LE", "GETSEQRAPPROLETTRE");
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
     * @return the lettre
     */
    public String getLettre() {
        return lettre;
    }

    /**
     * @param lettre the lettre to set
     */
    public void setLettre(String lettre) {
        this.lettre = lettre;
    }

    /**
     * @return the daty
     */
    public Date getDatelettrage() {
        return datelettrage;
    }

    /**
     * @param daty the daty to set
     */
    public void setDatelettrage(Date daty) {
        this.datelettrage = daty;
    }
    public String getTypelettrage()
        {
                return typelettrage;
        }
        public void setTypelettrage(String typelettrage)
        {
                this.typelettrage=typelettrage;
	}
}