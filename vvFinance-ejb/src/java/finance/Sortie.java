// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   Sortie.java

package finance;

import bean.*;
import java.io.PrintStream;
import java.sql.Date;
import utilitaire.Utilitaire;

// Referenced classes of package finance:
//            CaisseUtil, Caisse

public class Sortie extends ClassMAPTable
{

    public Sortie(String num)
    {
        super.setNomTable("sortie");
        idSortie = num;
    }

    public Sortie()
    {
    }
public Sortie(String daty,String designation,String montant,String idDevise,String idMode,String idCaisse,String remarque,String agence,String projet,String numpiece)
{
    setDaty(Utilitaire.string_date("dd/MM/yyyy",daty));
    setDesignation(designation);
    setMontant(Utilitaire.stringToDouble(montant));
    setIdDevise(idDevise);
    setIdModePaiement(idMode);
    setIdCaisse(idCaisse);
    setRemarque(remarque);
    setAgence(agence);
    setIdProjet(projet);
    setNUMPIECE(numpiece);
    setNomTable("sortie");
    setIndicePk("DEP");
    setNomProcedureSequence("getSeqSortie");
    setIdSortie(makePK());
}
    public Sortie(String num, Date datee, String desi, double mont, String ben, String typ,
            String dev, String mode, String cais, String eta, String rem, int parution, String agence, String prj, String part, String fact, String idLigne)
    {
        super.setNomTable("sortie");
        setIdSortie(num);
        setDaty(datee);
        setDesignation(desi);
        setIdDevise(dev);
        setMontant(mont);
        setBeneficiaire(ben);
        setIdTypeSortie(typ);
        setIdModePaiement(mode);
        setIdCaisse(cais);
        setIdEtat(eta);
        setRemarque(rem);
        setParution(parution);
        setAgence(agence);
        setIdProjet(prj);
        setNUMPIECE(part);
        setIdFacture(fact);
        setIdLigne(idLigne);
    }

    public Sortie(Date datee, String desi, double mont, String ben, String typ, String dev,
            String mode, String cais, String eta, String rem, String prj, String part, String fact, String idLigne)
    {
        super.setNomTable("sortie");
        setIndicePk("DEP");
        setNomProcedureSequence("getSeqSortie");
        setIdSortie(makePK());
        setDaty(datee);
        setDesignation(desi);
        setIdDevise(dev);
        setMontant(mont);
        setBeneficiaire(ben);
        setIdTypeSortie(typ);
        setIdModePaiement(mode);
        setIdCaisse(cais);
        setIdEtat(eta);
        setRemarque(rem);
        setIdProjet(prj);
        setNUMPIECE(part);
        setIdFacture(fact);
        setIdLigne(idLigne);
    }

    public Sortie(String datee, String desi, String mont, String ben, String typ, String dev, String mode,
            String cais, String eta, String rem, String parution, String agence, String prj, String part, String fact, String idLigne)
    {
        try
        {
            super.setNomTable("sortie");
            setIndicePk("DEP");
            setNomProcedureSequence("getSeqSortie");
            setIdSortie(makePK());
            if(String.valueOf(datee).compareTo("") == 0 || datee == null)
                setDaty(Utilitaire.dateDuJourSql());
            else
                setDaty(Utilitaire.string_date("dd/MM/yyyy", datee));
            if(String.valueOf(parution).compareTo("") == 0)
                setParution(0);
            else
                setParution(Utilitaire.stringToInt(parution));
            if(String.valueOf(agence).compareTo("") == 0)
                setAgence("-");
            else
                setAgence(agence);
            if(desi.compareTo("") == 0 || desi == null)
                setDesignation("-");
            else
                setDesignation(desi);
            if(dev.compareTo("") == 0 || dev == null)
                setIdDevise("-");
            else
                setIdDevise(dev);
            if(String.valueOf(mont).compareTo("") == 0)
                setMontant(0.0D);
            else
                setMontant(Utilitaire.stringToDouble(mont));
            if(ben.compareTo("") == 0 || ben == null)
                setBeneficiaire("-");
            else
                setBeneficiaire(ben);
            if(typ.compareTo("") == 0 || typ == null)
                setIdTypeSortie("-");
            else
                setIdTypeSortie(typ);
            if(mode.compareTo("") == 0 || mode == null)
                setIdModePaiement("-");
            else
                setIdModePaiement(mode);
            if(cais.compareTo("") == 0 || cais == null)
                setIdCaisse("-");
            else
                setIdCaisse(cais);
            if(eta.compareTo("") == 0 || eta == null)
                setIdEtat("eta2");
            else
                setIdEtat(eta);
            if(rem.compareTo("") == 0 || rem == null)
                setRemarque("-");
            else
                setRemarque(rem);
            if(idLigne.compareTo("") == 0 || idLigne == null)
                setIdLigne("-");
            else
            	setIdLigne(idLigne);
            setIdProjet(prj);
            setNUMPIECE(part);
            setIdFacture(fact);
        }
        catch(Exception ex)
        {
            System.out.println("tsmety".concat(String.valueOf(String.valueOf(ex.getMessage()))));
        }
    }

    public Sortie(String desi, double mont, String ben, String typ, String dev, String mode,
            String cais, String eta, String prj, String part, String fact, String idLigne)
    {
        super.setNomTable("sortie");
        daty = Utilitaire.dateDuJourSql();
        designation = desi;
        montant = mont;
        beneficiaire = ben;
        idTypeSortie = typ;
        idDevise = dev;
        idModePaiement = mode;
        idCaisse = cais;
        idEtat = eta;
        setIndicePk("SO");
        setNomProcedureSequence("getSeqSortie");
        setIdSortie(makePK());
        setIdProjet(prj);
        setNUMPIECE(part);
        setIdFacture(fact);
        setIdLigne(idLigne);
    }

    public String getTuppleID()
    {
        return String.valueOf(idSortie);
    }

    public String getAttributIDName()
    {
        return "idSortie";
    }

    public String getIdSortie()
    {
        return idSortie;
    }

    public void setIdSortie(String idSortie)
    {
        this.idSortie = idSortie;
    }

    public void setDaty(Date daty)
    {
        if(String.valueOf(daty).compareTo("") == 0 || daty == null)
            this.daty = Utilitaire.dateDuJourSql();
        else
            this.daty = daty;
    }
    public String getDesignation()
    {
        return designation;
    }

    public Date getDaty()
    {
        return daty;
    }

    public void setDesignation(String designation)
    {
        if(designation.compareTo("") == 0 || designation == null)
            this.designation = "-";
        else
            this.designation = designation;
    }


    public void setMontant(double montant)
    {
        if(String.valueOf(montant).compareTo("") == 0)
            this.montant = 0.0D;
        if(getIdDevise().compareToIgnoreCase("fmg") == 0)
        {
            this.montant = montant / (double)5;
            setIdDevise("Ar");
        } else
        {
            this.montant = montant;
        }
    }

    public double getMontant()
    {
        return montant;
    }

    public void setBeneficiaire(String beneficiaire)
    {
        this.beneficiaire = beneficiaire;
    }

    public String getBeneficiaire()
    {
        return beneficiaire;
    }

    public void setIdTypeSortie(String idTypeSortie)
    {
        this.idTypeSortie = idTypeSortie;
    }

    public String getIdTypeSortie()
    {
        return idTypeSortie;
    }

    public void setIdDevise(String idDevise)
    {
        this.idDevise = idDevise;
    }

    public String getIdDevise()
    {
        return idDevise;
    }

    public void setIdModePaiement(String idModePaiement)
    {
        this.idModePaiement = idModePaiement;
    }

    public String getIdModePaiement()
    {
        return idModePaiement;
    }

    public void setIdEtat(String idEtat)
    {
        this.idEtat = idEtat;
    }

    public String getIdEtat()
    {
        return idEtat;
    }

    public void setIdCaisse(String idCaisse)
    {
        this.idCaisse = idCaisse;
    }

    public String getIdCaisse()
    {
        return idCaisse;
    }

    public void setRemarque(String remarque)
    {
        if(remarque.compareTo("") == 0 || remarque == null)
            this.remarque = "-";
        else
            this.remarque = remarque;
    }

    public String getRemarque()
    {
        return remarque;
    }

    public TypeObjet findTypeSortie()
    {
        TypeObjetUtil tou = new TypeObjetUtil();
        tou.setNomTable("TypeSortie");
        return (TypeObjet)tou.rechercher(1, getIdTypeSortie())[0];
    }

    public TypeObjet findDevise()
    {
        TypeObjetUtil tou = new TypeObjetUtil();
        tou.setNomTable("devise");
        return (TypeObjet)tou.rechercher(1, getIdDevise())[0];
    }

    public Caisse findCaisse()
    {
        CaisseUtil cu = new CaisseUtil();
        return (Caisse)cu.rechercher(1, getIdCaisse())[0];
    }

    public TypeObjet findModePayement()
    {
        TypeObjetUtil tou = new TypeObjetUtil();
        tou.setNomTable("modePaiement");
        return (TypeObjet)tou.rechercher(1, getIdModePaiement())[0];
    }

    public TypeObjet findEtat()
    {
        TypeObjetUtil tou = new TypeObjetUtil();
        tou.setNomTable("etat");
        return (TypeObjet)tou.rechercher(1, getIdEtat())[0];
    }

    public void setParution(int parution)
    {
        this.parution = parution;
    }

    public int getParution()
    {
        return parution;
    }

    public void setAgence(String agence)
    {
        this.agence = agence;
    }

    public String getAgence()
    {
        return agence;
    }
    public String getIdProjet()
    {
        return idProjet;
    }

    public void setIdProjet(String idProjet)
    {
        this.idProjet = idProjet;
    }
    public String getNUMPIECE()
    {
        return NUMPIECE;
    }

    public void setNUMPIECE(String NUMPIECE)
    {
        this.NUMPIECE = NUMPIECE;
    }
    public String getIdFacture()
    {
        return idFacture;
    }

    public void setIdFacture(String idFacture)
    {
        this.idFacture = idFacture;
    }

    public String getIdLigne() {
		if(idLigne == null) return "-";
    	return idLigne;
	}

	public void setIdLigne(String idLigne) {
		this.idLigne = idLigne;
	}


    public String idSortie;
    public Date daty;
    public String designation;
    public double montant;
    public String beneficiaire;
    public String idTypeSortie;
    public String idDevise;
    public String idModePaiement;
    public String idCaisse;
    public String idEtat;
    public String remarque;
    public int parution;
    public String agence;
    public String idProjet;
    public String NUMPIECE;
    public String idFacture;
    public String idLigne;

}
