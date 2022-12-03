// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   VolConteneur.java

package penalite;

import bean.ClassMAPTable;
import java.sql.Date;
import utilitaire.Utilitaire;

public class VolConteneur extends ClassMAPTable
{

    public VolConteneur(String i, Date datyS, Date datyV, String numCont, String des, String idDos, String nomProp, 
            double mont)
    {
        super.setNomTable("VolConteneur");
        setIdVol(i);
        setDatyVol(datyV);
        setDatySaisie(datyS);
        setNumeroConteneur(numCont);
        setDesignation(des);
        setIdDossier(idDos);
        setNomProprietaire(nomProp);
        setMontant(mont);
    }

    public VolConteneur(Date datyS, Date datyV, String numCont, String des, String idDos, String nomProp, double mont)
    {
        super.setNomTable("VolConteneur");
        setIndicePk("VC");
        setNomProcedureSequence("getSeqVolConteneur");
        setIdVol(makePK());
        setDatyVol(datyV);
        setDatySaisie(datyS);
        setNumeroConteneur(numCont);
        setDesignation(des);
        setIdDossier(idDos);
        setNomProprietaire(nomProp);
        setMontant(mont);
    }

    public VolConteneur(String datyS, String datyV, String numCont, String des, String idDos, String nomProp, String mont)
    {
        super.setNomTable("VolConteneur");
        setIndicePk("VC");
        setNomProcedureSequence("getSeqVolConteneur");
        setIdVol(makePK());
        if(String.valueOf(datyV).compareTo("") == 0 || datyV == null)
            setDatyVol(Utilitaire.dateDuJourSql());
        else
            setDatyVol(Utilitaire.string_date("dd/MM/yyyy", datyV));
        if(String.valueOf(datyS).compareTo("") == 0 || datyS == null)
            setDatySaisie(Utilitaire.dateDuJourSql());
        else
            setDatySaisie(Utilitaire.string_date("dd/MM/yyyy", datyS));
        if(numCont.compareTo("") == 0 || numCont == null)
            setNumeroConteneur("-");
        else
            setNumeroConteneur(numCont);
        if(des.compareTo("") == 0 || des == null)
            setDesignation("-");
        else
            setDesignation(des);
        if(idDos.compareTo("") == 0 || idDos == null)
            setIdDossier("-");
        else
            setIdDossier(idDos);
        if(nomProp.compareTo("") == 0 || nomProp == null)
            setNomProprietaire("-");
        else
            setNomProprietaire(nomProp);
        if(String.valueOf(mont).compareTo("") == 0)
            setMontant(0.0D);
        else
            setMontant(Utilitaire.stringToDouble(mont));
    }

    public String getAttributIDName()
    {
        return "idVol";
    }

    public String getTuppleID()
    {
        return String.valueOf(idVol);
    }

    public void setIdVol(String idVol)
    {
        this.idVol = idVol;
    }

    public String getIdVol()
    {
        return idVol;
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

    public void setNumeroConteneur(String numeroConteneur)
    {
        if(String.valueOf(numeroConteneur).compareTo("") == 0)
            this.numeroConteneur = "-";
        else
            this.numeroConteneur = numeroConteneur;
    }

    public String getNumeroConteneur()
    {
        return numeroConteneur;
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

    public void setIdDossier(String idDossier)
    {
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

    public void setDatyVol(Date datyVol)
    {
        if(String.valueOf(datyVol).compareTo("") == 0 || datyVol == null)
            this.datyVol = Utilitaire.dateDuJourSql();
        else
            this.datyVol = datyVol;
    }

    public Date getDatyVol()
    {
        return datyVol;
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

    public String idVol;
    public Date datyVol;
    public Date datySaisie;
    public String numeroConteneur;
    public String designation;
    public String idDossier;
    public String nomProprietaire;
    public double montant;
}
