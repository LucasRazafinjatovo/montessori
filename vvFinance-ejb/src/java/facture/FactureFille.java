// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   FactureFille.java
package facture;

import bean.ClassMAPTable;
import utilitaire.Utilitaire;

public class FactureFille extends ClassMAPTable {

    public FactureFille(String factFille, String factM, String refOb, String des, double qte, String unit,
            double pu, int red) {
        setIdFactureFille(factFille);
        setIdFactureMere(factM);
        setDesignation(des);
        setIdUnite(unit);
        setReduction(red);
        setQuantite(qte);
        setPrixUnitaire(pu);
        setRefObj(refOb);
        setNomTable("factureFille");
    }

    public FactureFille() {
        this.setNomTable("factureFille");
    }

    public FactureFille(String factM, String refOb, String des, double qte, String unit, double pu, int red) {
        setIdFactureMere(factM);
        setDesignation(des);
        setIdUnite(unit);
        setReduction(red);
        setQuantite(qte);
        setPrixUnitaire(pu);
        setRefObj(refOb);
        setIndicePk("FF");
        setNomProcedureSequence("getSeqFactureFille");
        setIdFactureFille(makePK());
        setNomTable("factureFille");
    }

    public FactureFille(String refOb, String des, double qte, String unit, double pu, int red) {
        setDesignation(des);
        setIdUnite(unit);
        setReduction(red);
        setQuantite(qte);
        setPrixUnitaire(pu);
        setRefObj(refOb);
        setIndicePk("FF");
        setNomTable("factureFille");
    }

    public FactureFille(String factM, String refOb, String des, String qte, String unit, String pu, String red) {
        if (factM.compareTo("") == 0 || factM == null) {
            setIdFactureMere("-");
        } else {
            setIdFactureMere(factM);
        }
        if (des.compareTo("") == 0 || des == null) {
            setDesignation("-");
        } else {
            setDesignation(des);
        }
        if (unit.compareTo("") == 0 || unit == null) {
            setIdUnite("unite");
        } else {
            setIdUnite(unit);
        }
        if (String.valueOf(red).compareTo("") == 0) {
            setReduction(0);
        } else {
            setReduction(Utilitaire.doubleToInt(red));
        }
        if (String.valueOf(qte).compareTo("") == 0) {
            setQuantite(0.0D);
        } else {
            setQuantite(Utilitaire.stringToDouble(qte));
        }
        if (String.valueOf(pu).compareTo("") == 0) {
            setPrixUnitaire(0.0D);
        } else {
            setPrixUnitaire(Utilitaire.stringToDouble(pu));
        }
        if (refOb.compareTo("") == 0 || refOb == null) {
            setRefObj("-");
        } else {
            setRefObj(refOb);
        }
        setIndicePk("FF");
        setNomProcedureSequence("getSeqFactureFille");
        setIdFactureFille(makePK());
        setNomTable("factureFille");
    }

    public FactureFille(String factM, String refOb, String des, String qte, String unit, String pu, String red, String etat) {
        if (factM.compareTo("") == 0 || factM == null) {
            setIdFactureMere("-");
        } else {
            setIdFactureMere(factM);
        }
        if (des.compareTo("") == 0 || des == null) {
            setDesignation("-");
        } else {
            setDesignation(des);
        }
        if (unit.compareTo("") == 0 || unit == null) {
            setIdUnite("unite");
        } else {
            setIdUnite(unit);
        }
        if (String.valueOf(red).compareTo("") == 0) {
            setReduction(0);
        } else {
            setReduction(Utilitaire.stringToInt(red));
        }
        if (String.valueOf(qte).compareTo("") == 0) {
            setQuantite(0.0D);
        } else {
            setQuantite(Utilitaire.stringToDouble(qte));
        }
        if (String.valueOf(pu).compareTo("") == 0) {
            setPrixUnitaire(0.0D);
        } else {
            setPrixUnitaire(Utilitaire.stringToDouble(pu));
        }
        if (refOb.compareTo("") == 0 || refOb == null) {
            setRefObj("-");
        } else {
            setRefObj(refOb);
        }
        setIndicePk("FFP");
        setNomProcedureSequence("getSeqFactureFilleProforma");
        setIdFactureFille(makePK());
        setNomTable("factureFilleProforma");
    }

    public String getTuppleID() {
        return String.valueOf(idFactureFille);
    }

    public String getAttributIDName() {
        return "idFactureFille";
    }

    public void setIdFactureFille(String idFactureFille) {
        this.idFactureFille = idFactureFille;
    }

    public String getIdFactureFille() {
        return idFactureFille;
    }

    public void setIdFactureMere(String idFactureMere) {
        this.idFactureMere = idFactureMere;
    }

    public String getIdFactureMere() {
        return idFactureMere;
    }

    public void setDesignation(String designation) {
        if (designation.compareTo("") == 0 || designation == null) {
            this.designation = "-";
        } else {
            this.designation = designation;
        }
    }

    public String getDesignation() {
        return designation;
    }

    public void setQuantite(double quantite) {
        if (String.valueOf(quantite).compareTo("") == 0) {
            this.quantite = 0.0D;
        } else {
            this.quantite = quantite;
        }
    }

    public double getQuantite() {
        return quantite;
    }

    public void setIdUnite(String idUnite) {
        this.idUnite = idUnite;
    }

    public String getIdUnite() {
        return idUnite;
    }

    public void setPrixUnitaire(double prixUnitaire) {
        if (String.valueOf(prixUnitaire).compareTo("") == 0) {
            this.prixUnitaire = 0.0D;
        } else {
            this.prixUnitaire = prixUnitaire;
        }
    }

    public double getPrixUnitaire() {
        return prixUnitaire;
    }

    public void setReduction(int reduction) {
        if (String.valueOf(reduction).compareTo("") == 0) {
            this.reduction = 0;
        } else {
            this.reduction = reduction;
        }
    }

    public int getReduction() {
        return reduction;
    }

    public void setRefObj(String refObj) {
        if (refObj.compareTo("") == 0 || refObj == null) {
            this.refObj = "-";
        } else {
            this.refObj = refObj;
        }
    }

    public String getRefObj() {
        return refObj;
    }

    public double getMontant() {
        return Utilitaire.arrondir(getQuantite() * getPrixUnitaire() - (getQuantite() * getPrixUnitaire() * (double) getReduction()) / (double) 100, 2);
    }

    public String idFactureFille;
    public String idFactureMere;
    public String designation;
    public String idUnite;
    public int reduction;
    public String refObj;
    public double prixUnitaire;
    public double quantite;
}
