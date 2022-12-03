// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   DommageConteneur.java

package penalite;

import bean.ClassMAPTable;
import java.sql.Date;
import utilitaire.Utilitaire;

public class DommageConteneur extends ClassMAPTable
{

    public DommageConteneur(String i, Date datyS, Date datyDom, String des, double montant, String idDossier, 
            String nomProprietaire)
    {
        super.setNomTable("dommageconteneur");
        setIdDommage(i);
        setDatySaisie(datyS);
        setDatyDommage(datyDom);
        setDesignation(des);
        setMontant(montant);
        setNomProprietaire(nomProprietaire);
        setIdDossier(idDossier);
    }

    public DommageConteneur(Date datyS, Date datyDom, String des, double montant, String idDossier, String nomProprietaire)
    {
        super.setNomTable("dommageconteneur");
        setIndicePk("DC");
        setNomProcedureSequence("getSeqDommageConteneur");
        setIdDommage(makePK());
        setDatySaisie(datyS);
        setDatyDommage(datyDom);
        setDesignation(des);
        setMontant(montant);
        setNomProprietaire(nomProprietaire);
        setIdDossier(idDossier);
    }

    public DommageConteneur(String datyS, String datyDom, String des, String montant, String idDossier, String nomProprietaire)
    {
        super.setNomTable("dommageconteneur");
        setIndicePk("DC");
        setNomProcedureSequence("getSeqDommageConteneur");
        setIdDommage(makePK());
        if(String.valueOf(datyS).compareTo("") == 0 || datyS == null)
            setDatySaisie(Utilitaire.dateDuJourSql());
        else
            setDatySaisie(Utilitaire.string_date("dd/MM/yyyy", datyS));
        if(String.valueOf(datyDom).compareTo("") == 0 || datyDom == null)
            setDatyDommage(Utilitaire.dateDuJourSql());
        else
            setDatyDommage(Utilitaire.string_date("dd/MM/yyyy", datyDom));
        if(des.compareTo("") == 0 || des == null)
            setDesignation("-");
        else
            setDesignation(des);
        if(String.valueOf(montant).compareTo("") == 0)
            setMontant(0.0D);
        else
            setMontant(Utilitaire.stringToDouble(montant));
        if(nomProprietaire.compareTo("") == 0 || nomProprietaire == null)
            setNomProprietaire("-");
        else
            setNomProprietaire(nomProprietaire);
        if(idDossier.compareTo("") == 0 || idDossier == null)
            setIdDossier("-");
        else
            setIdDossier(idDossier);
    }

    public String getAttributIDName()
    {
        return "idDommage";
    }

    public String getTuppleID()
    {
        return String.valueOf(idDommage);
    }

    public void setIdDommage(String idDommage)
    {
        this.idDommage = idDommage;
    }

    public String getIdDommage()
    {
        return idDommage;
    }

    public void setDatySaisie(Date datySaisie)
    {
        if(String.valueOf(datySaisie).compareTo("") == 0 || datySaisie == null)
            this.datySaisie = Utilitaire.dateDuJourSql();
        else
            this.datySaisie = datySaisie;
    }

    public Date getDatySaisie()
    {
        return datySaisie;
    }

    public void setDatyDommage(Date datyDommage)
    {
        if(String.valueOf(datyDommage).compareTo("") == 0 || datyDommage == null)
            this.datyDommage = Utilitaire.dateDuJourSql();
        else
            this.datyDommage = datyDommage;
    }

    public Date getDatyDommage()
    {
        return datyDommage;
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
        else
            this.montant = montant;
    }

    public double getMontant()
    {
        return montant;
    }

    public void setIdDossier(String idDossier)
    {
        if(idDossier.compareTo("") == 0 || idDossier == null)
            this.idDossier = "-";
        else
            this.idDossier = idDossier;
    }

    public String getIdDossier()
    {
        return idDossier;
    }

    public void setNomProprietaire(String nomProprietaire)
    {
        if(nomProprietaire.compareTo("") == 0 || nomProprietaire == null)
            this.nomProprietaire = "-";
        else
            this.nomProprietaire = nomProprietaire;
    }

    public String getNomProprietaire()
    {
        return nomProprietaire;
    }

    public String idDommage;
    public String designation;
    public double montant;
    public String nomProprietaire;
    public String idDossier;
    public Date datyDommage;
    public Date datySaisie;
}
