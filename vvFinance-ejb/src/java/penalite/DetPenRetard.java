// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   DetPenRetard.java

package penalite;

import bean.ClassMAPTable;
import java.sql.Date;
import utilitaire.Utilitaire;

public class DetPenRetard extends ClassMAPTable
{

    public DetPenRetard(String i, String idPenalit, Date datyIn, Date datySu, double rest, int nbJourRetar, 
            String numPiec, double montat)
    {
        super.setNomTable("DetPenRetard");
        setId(i);
        setIdPenalite(idPenalit);
        setDatyInf(datyIn);
        setDatySup(datySu);
        setReste(rest);
        setNbJourRetard(nbJourRetar);
        setNumPiece(numPiec);
        setMontant(montat);
    }

    public DetPenRetard(String idPenalit, Date datyIn, Date datySu, double rest, int nbJourRetar, String numPiec, 
            double montat)
    {
        super.setNomTable("DetPenRetard");
        setIndicePk("DPR");
        setNomProcedureSequence("getSeqDetPenRetard");
        setId(makePK());
        setIdPenalite(idPenalit);
        setDatyInf(datyIn);
        setDatySup(datySu);
        setReste(rest);
        setNbJourRetard(nbJourRetar);
        setNumPiece(numPiec);
        setMontant(montat);
    }

    public DetPenRetard(String i, String idPenalit, String datyIn, String datySu, String rest, String nbJourRetar, String numPiec, 
            String montat)
    {
        super.setNomTable("DetPenRetard");
        setId(i);
        if(idPenalit.compareTo("") == 0 || idPenalit == null)
            setIdPenalite("-");
        else
            setIdPenalite(idPenalit);
        if(String.valueOf(datyIn).compareTo("") == 0 || datyIn == null)
            setDatyInf(Utilitaire.dateDuJourSql());
        else
            setDatyInf(Utilitaire.string_date("dd/MM/yyyy", datyIn));
        if(String.valueOf(datySu).compareTo("") == 0 || datySu == null)
            setDatySup(Utilitaire.dateDuJourSql());
        else
            setDatySup(Utilitaire.string_date("dd/MM/yyyy", datySu));
        if(String.valueOf(rest).compareTo("") == 0)
            setReste(0.0D);
        else
            setReste(Utilitaire.stringToDouble(rest));
        if(String.valueOf(nbJourRetar).compareTo("") == 0)
            setNbJourRetard(0);
        else
            setNbJourRetard(Utilitaire.stringToInt(nbJourRetar));
        if(numPiec.compareTo("") == 0 || numPiec == null)
            setNumPiece("-");
        else
            setNumPiece(numPiec);
        if(String.valueOf(montat).compareTo("") == 0)
            setMontant(0.0D);
        else
            setMontant(Utilitaire.stringToDouble(montat));
    }

    public DetPenRetard(String idPenalit, String datyIn, String datySu, String rest, String nbJourRetar, String numPiec, String montat)
    {
        super.setNomTable("DetPenRetard");
        setIndicePk("DPR");
        setNomProcedureSequence("getSeqDetPenRetard");
        setId(makePK());
        if(idPenalit.compareTo("") == 0 || idPenalit == null)
            setIdPenalite("-");
        else
            setIdPenalite(idPenalit);
        if(String.valueOf(datyIn).compareTo("") == 0 || datyIn == null)
            setDatyInf(Utilitaire.dateDuJourSql());
        else
            setDatyInf(Utilitaire.string_date("dd/MM/yyyy", datyIn));
        if(String.valueOf(datySu).compareTo("") == 0 || datySu == null)
            setDatySup(Utilitaire.dateDuJourSql());
        else
            setDatySup(Utilitaire.string_date("dd/MM/yyyy", datySu));
        if(String.valueOf(rest).compareTo("") == 0)
            setReste(0.0D);
        else
            setReste(Utilitaire.stringToDouble(rest));
        if(String.valueOf(nbJourRetar).compareTo("") == 0)
            setNbJourRetard(0);
        else
            setNbJourRetard(Utilitaire.stringToInt(nbJourRetar));
        if(numPiec.compareTo("") == 0 || numPiec == null)
            setNumPiece("-");
        else
            setNumPiece(numPiec);
        if(String.valueOf(montat).compareTo("") == 0)
            setMontant(0.0D);
        else
            setMontant(Utilitaire.stringToDouble(montat));
    }

    public String getAttributIDName()
    {
        return "id";
    }

    public String getTuppleID()
    {
        return getId();
    }

    public void setId(String id)
    {
        this.id = id;
    }

    public String getId()
    {
        return id;
    }

    public void setIdPenalite(String idPenalite)
    {
        this.idPenalite = idPenalite;
    }

    public String getIdPenalite()
    {
        return idPenalite;
    }

    public void setDatyInf(Date datyInf)
    {
        this.datyInf = datyInf;
    }

    public Date getDatyInf()
    {
        return datyInf;
    }

    public void setDatySup(Date datySup)
    {
        this.datySup = datySup;
    }

    public Date getDatySup()
    {
        return datySup;
    }

    public void setReste(double reste)
    {
        this.reste = reste;
    }

    public double getReste()
    {
        return reste;
    }

    public void setNbJourRetard(int nbJourRetard)
    {
        this.nbJourRetard = nbJourRetard;
    }

    public int getNbJourRetard()
    {
        return nbJourRetard;
    }

    public void setNumPiece(String numPiece)
    {
        this.numPiece = numPiece;
    }

    public String getNumPiece()
    {
        return numPiece;
    }

    public void setMontant(double montant)
    {
        this.montant = montant;
    }

    public double getMontant()
    {
        return montant;
    }

    public String id;
    public String idPenalite;
    public Date datyInf;
    public Date datySup;
    public double reste;
    public int nbJourRetard;
    public String numPiece;
    public double montant;
}
