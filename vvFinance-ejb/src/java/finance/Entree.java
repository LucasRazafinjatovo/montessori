// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   Entree.java

package finance;

import bean.*;
import java.sql.Date;
import utilitaire.Utilitaire;

// Referenced classes of package finance:
//            CaisseUtil, Caisse

public class Entree extends ClassMAPTable
{
    public String idEntree;
    public Date daty;
    public String designation;
    public double montant;
    public String client;
    public String idTypeEntree;
    public String numpiece;
    public String idDevise;
    public String idModePaiement;
    public String idCaisse;
    public String idEtat;
    public String remarque;
    public int parution;
    public String agence;
    public String source;
    public String idProjet;
    public String idPartenaire;
    public String idLigne;
    
	public Entree()
    {
		
    }
    
    
    
	public String getWord(){
			return "entree word";
	}
	
    public Entree(String num, Date datee, String desi, double mont, String sour, String typ,
            String n_pie, String dev, String mode, String cais, String eta, String rem, String prj, String part, String idLigne)
    {
        super.setNomTable("Entree");
        setIdEntree(num);
        setDaty(datee);
        setDesignation(desi);
        setIdDevise(dev);
        setMontant(mont);
        setClient(sour);
        setIdTypeEntree(typ);
        setNumpiece(n_pie);
        setIdModePaiement(mode);
        setRemarque(rem);
        setIdCaisse(cais);
        setIdEtat(eta);
        setIdProjet(prj);
        setIdPartenaire(part);
        setIdLigne(idLigne);

    }

    public Entree(String num, Date datee, String desi, double mont, String sour, String typ,
            String n_pie, String dev, String mode, String cais, String eta, String rem, int parution,
            String agence, String source, String prj, String part, String idLigne)
    {
        super.setNomTable("Entree");
        setIdEntree(num);
        setDaty(datee);
        setDesignation(desi);
        setIdDevise(dev);
        setMontant(mont);
        setClient(sour);
        setIdTypeEntree(typ);
        setNumpiece(n_pie);
        setIdModePaiement(mode);
        setRemarque(rem);
        setIdCaisse(cais);
        setIdEtat(eta);
        setParution(parution);
        setAgence(agence);
        setSource(source);
        setIdProjet(prj);
        setIdPartenaire(part);
        setIdLigne(idLigne);
    }

    public Entree(String num, Date datee, String desi, double mont, String sour, String typ,
            String n_pie, String dev, String mode, String cais, String eta, String rem, int parution,
            String agence, String prj, String part, String idLigne)
    {
        super.setNomTable("Entree");
        setIdEntree(num);
        setDaty(datee);
        setDesignation(desi);
        setIdDevise(dev);
        setMontant(mont);
        setClient(sour);
        setIdTypeEntree(typ);
        setNumpiece(n_pie);
        setIdModePaiement(mode);
        setRemarque(rem);
        setIdCaisse(cais);
        setIdEtat(eta);
        setParution(parution);
        setAgence(agence);
        setIdProjet(prj);
        setIdPartenaire(part);
        setIdLigne(idLigne);
    }
    public Entree(Date datee, String desi, double mont, String sour, String typ, String n_pie,
            String dev, String mode, String cais, String eta, String rem, String prj, String part, String idLigne)
    {
        super.setNomTable("Entree");
        setIndicePk("EN");
        setNomProcedureSequence("getSeqEntree");
        setIdEntree(makePK());
        setDaty(datee);
        setDesignation(desi);
        setMontant(mont);
        setClient(sour);
        setIdDevise(dev);
        setIdTypeEntree(typ);
        setNumpiece(n_pie);
        setIdModePaiement(mode);
        setRemarque(rem);
        setIdCaisse(cais);
        setIdEtat(eta);
        setIdProjet(prj);
        setIdPartenaire(part);
        setIdLigne(idLigne);
    }

    public Entree(String datee, String desi, String mont, String sour, String typ, String n_pie, String dev,
            String mode, String cais, String eta, String rem, String prj, String part, String idLigne)
    {
        super.setNomTable("Entree");
        setIndicePk("EN");
        setNomProcedureSequence("getSeqEntree");
        setIdEntree(makePK());
        if(String.valueOf(datee).compareTo("") == 0 || datee == null)
            setDaty(Utilitaire.dateDuJourSql());
        else
            setDaty(Utilitaire.string_date("dd/MM/yyyy", datee));
        if(desi == null)
            setDesignation("-");
        else
            setDesignation(desi);
        if(String.valueOf(mont).compareTo("") == 0)
            setMontant(0.0D);
        else
            setMontant((new Double(mont)).doubleValue());
        if(sour.compareTo("") == 0 || sour == null)
            setClient("-");
        else
            setClient(sour);
        if(dev.compareTo("") == 0 || dev == null)
            setIdDevise("-");
        else
            setIdDevise(dev);
        if(typ.compareTo("") == 0 || typ == null)
            setIdTypeEntree("-");
        else
            setIdTypeEntree(typ);
        if(n_pie.compareTo("") == 0 || n_pie == null)
            setNumpiece("-");
        else
            setNumpiece(n_pie);
        if(mode.compareTo("") == 0 || mode == null)
            setIdModePaiement("-");
        else
            setIdModePaiement(mode);
        if(rem.compareTo("") == 0 || rem == null)
            setRemarque("-");
        else
            setRemarque(rem);
        if(cais.compareTo("") == 0 || cais == null)
            setIdCaisse("-");
        else
            setIdCaisse(cais);
        if(eta.compareTo("") == 0 || eta == null)
            setIdEtat("-");
        else
            setIdEtat(eta);
        if(idLigne.compareTo("") == 0 || eta == null)
            setIdLigne("-");
        else
            setIdEtat(eta);
        setIdProjet(prj);
        setIdPartenaire(part);
    }

    public Entree(String datee, String desi, String mont, String sour, String typ, String n_pie, String dev,
            String mode, String cais, String eta, String rem, String parution, String agence, String prj, String part, String idLigne)
    {//IO
        super.setNomTable("Entree");
        setIndicePk("EN");
        setNomProcedureSequence("getSeqEntree");
        setIdEntree(makePK());
        if(String.valueOf(datee).compareTo("") == 0 || datee == null)
            setDaty(Utilitaire.dateDuJourSql());
        else
            setDaty(Utilitaire.string_date("dd/MM/yyyy", datee));
        if(desi == null)
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
            setMontant((new Double(mont)).doubleValue());
        if(String.valueOf(parution).compareTo("") == 0)
            setParution(0);
        else
            setParution(Utilitaire.stringToInt(parution));
        if(String.valueOf(agence).compareTo("") == 0)
            setAgence("-");
        else
            setAgence(agence);
        if(sour.compareTo("") == 0 || sour == null)
            setClient("-");
        else
            setClient(sour);
        if(typ.compareTo("") == 0 || typ == null)
            setIdTypeEntree("-");
        else
            setIdTypeEntree(typ);
        if(n_pie.compareTo("") == 0 || n_pie == null)
            setNumpiece("-");
        else
            setNumpiece(n_pie);
        if(mode.compareTo("") == 0 || mode == null)
            setIdModePaiement("-");
        else
            setIdModePaiement(mode);
        if(rem.compareTo("") == 0 || rem == null)
            setRemarque("-");
        else
            setRemarque(rem);
        if(cais.compareTo("") == 0 || cais == null)
            setIdCaisse("-");
        else
            setIdCaisse(cais);
        if(eta.compareTo("") == 0 || eta == null)
            setIdEtat("-");
        else
            setIdEtat(eta);
        if(idLigne.compareTo("") == 0 || idLigne == null)
            setIdLigne("-");
        else
            setIdLigne(idLigne);
        setIdProjet(prj);
        setIdPartenaire(part);
    }
    public Entree(String datee, String desi, String mont, String sour, String typ, String n_pie, String dev,
            String mode, String cais, String eta, String rem, String parution, String agence, String source, String prj, String part, String idLigne)
    {//IO NO IZY
        super.setNomTable("Entree");
        setIndicePk("EN");
        setNomProcedureSequence("getSeqEntree");
        setIdEntree(makePK());
        if(String.valueOf(datee).compareTo("") == 0 || datee == null)
            setDaty(Utilitaire.dateDuJourSql());
        else
            setDaty(Utilitaire.string_date("dd/MM/yyyy", datee));
        if(desi == null)
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
            setMontant((new Double(mont)).doubleValue());
        if(String.valueOf(parution).compareTo("") == 0)
            setParution(0);
        else
            setParution(Utilitaire.stringToInt(parution));
        if(String.valueOf(agence).compareTo("") == 0)
            setAgence("-");
        else
            setAgence(agence);
        if(sour.compareTo("") == 0 || sour == null)
            setClient("-");
        else
            setClient(sour);
        if(typ.compareTo("") == 0 || typ == null)
            setIdTypeEntree("-");
        else
            setIdTypeEntree(typ);
        if(n_pie.compareTo("") == 0 || n_pie == null)
            setNumpiece("-");
        else
            setNumpiece(n_pie);
        if(mode.compareTo("") == 0 || mode == null)
            setIdModePaiement("-");
        else
            setIdModePaiement(mode);
        if(rem.compareTo("") == 0 || rem == null)
            setRemarque("-");
        else
            setRemarque(rem);
        if(cais.compareTo("") == 0 || cais == null)
            setIdCaisse("-");
        else
            setIdCaisse(cais);
        if(eta.compareTo("") == 0 || eta == null)
            setIdEtat("-");
        else
            setIdEtat(eta);
        if(idLigne.compareTo("") == 0 || idLigne == null)
            setIdLigne("-");
        else
            setIdLigne(idLigne);
        setSource(source);
        setIdProjet(prj);
        setIdPartenaire(part);
    }

    public String getTuppleID()
    {
        return String.valueOf(idEntree);
    }

    public String getAttributIDName()
    {
        return "idEntree";
    }

    public String getIdEntree()
    {
        return idEntree;
    }

    public void setIdEntree(String idEntree)
    {
        this.idEntree = idEntree;
    }

    public void setDaty(Date daty)
    {
        if(String.valueOf(daty).compareTo("") == 0 || daty == null)
            this.daty = Utilitaire.dateDuJourSql();
        else
            this.daty = daty;
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

    public String getDesignation()
    {
        return designation;
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

    public void setClient(String client)
    {
        if(client.compareTo("") == 0 || client == null)
            this.client = "-";
        else
            this.client = client;
    }

    public String getClient()
    {
        return client;
    }

    public void setIdTypeEntree(String idTypeEntree)
    {
        this.idTypeEntree = idTypeEntree;
    }

    public String getIdTypeEntree()
    {
        return idTypeEntree;
    }

    public void setNumpiece(String numpiece)
    {
        if(numpiece.compareTo("") == 0 || numpiece == null)
            this.numpiece = "-";
        else
            this.numpiece = numpiece;
    }

    public String getNumpiece()
    {
        return numpiece;
    }

    public void setIdModePaiement(String idModePaiement)
    {
        this.idModePaiement = idModePaiement;
    }

    public String getIdModePaiement()
    {
        return idModePaiement;
    }

    public void setIdCaisse(String idCaisse)
    {
        this.idCaisse = idCaisse;
    }

    public String getIdCaisse()
    {
        return idCaisse;
    }

    public void setIdEtat(String idEtat)
    {
        this.idEtat = idEtat;
    }

    public String getIdEtat()
    {
        return idEtat;
    }

    public void setIdDevise(String idDevise)
    {
        this.idDevise = idDevise;
    }

    public String getIdDevise()
    {
        return idDevise;
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

    public TypeObjet findTypeEntre()
    {
        TypeObjetUtil tou = new TypeObjetUtil();
        tou.setNomTable("TypeEntree");
        return (TypeObjet)tou.rechercher(1, getIdTypeEntree())[0];
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
        if(agence.compareTo("") == 0)
            this.agence = "-";
        else
            this.agence = agence;
    }

    public String getAgence()
    {
        return agence;
    }

    public void setSource(String source)
    {
        if(source.compareTo("") == 0 || source == null)
            this.source = "BE011";
        else
            this.source = source;
    }

    public String getSource()
    {
        return source;
    }
    public String getIdProjet()
    {
        return idProjet;
    }

    public void setIdProjet(String idProjet)
    {
        this.idProjet = idProjet;
    }
    public String getIdPartenaire()
    {
        return idPartenaire;
    }

    public void setIdPartenaire(String idPartenaire)
    {
        this.idPartenaire = idPartenaire;
    }
    
    public String getIdLigne() {
		if(idLigne == null) return "-";
    	return idLigne;
	}
	public void setIdLigne(String idLigne) {
		this.idLigne = idLigne;
	}
	

	
}
