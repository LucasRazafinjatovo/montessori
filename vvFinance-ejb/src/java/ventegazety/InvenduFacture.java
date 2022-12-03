package ventegazety;

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
import bean.*;
import java.sql.Connection;

public class InvenduFacture extends ClassMAPTable {

    private String id;
    private String id1;
    private String id2;
    private int nbreinvendu;
    private String remarque;
    private int etat;

    public InvenduFacture() {
        super.setNomTable("InvenduFacture");
    }

    public InvenduFacture(String idinv, String idfact, String rem, int nbre, int eta) throws Exception {
        super.setNomTable("InvenduFacture");
        this.preparePk("IVF", "getSeqInvenduFacture");
        this.setId(makePK());
        this.setId1(idinv);
        this.setId2(idfact);
        this.setRemarque(rem);
        this.setNbreinvendu(nbre);
        this.setEtat(eta);
    }

    public InvenduFacture(String idinv, String idfact, String rem, int nbre, int eta, Connection c) throws Exception {
        super.setNomTable("InvenduFacture");
        this.preparePk("IVF", "getSeqInvenduFacture");
        this.setId(makePK(c));
        this.setId1(idinv);
        this.setId2(idfact);
        this.setRemarque(rem);
        this.setNbreinvendu(nbre);
        this.setEtat(eta);
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

    public void setId1(String id1) {
        this.id1 = id1;
    }

    public String getId1() {
        return id1;
    }

    public void setId2(String id2) {
        this.id2 = id2;
    }

    public String getId2() {
        return id2;
    }

    public void setNbreinvendu(int nbreinvendu) {
        this.nbreinvendu = nbreinvendu;
    }

    public int getNbreinvendu() {
        return nbreinvendu;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setEtat(int etat) {
        this.etat = etat;
    }

    public int getEtat() {
        return etat;
    }
}
