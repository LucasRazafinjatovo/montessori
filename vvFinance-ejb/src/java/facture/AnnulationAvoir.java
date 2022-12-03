// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   AnnulationAvoir.java

package facture;

import bean.ClassMAPTable;
import java.sql.Date;
import utilitaire.Utilitaire;

public class AnnulationAvoir extends ClassMAPTable
{

    public AnnulationAvoir(String idAnnulationAvoi, String idAvoi, Date dat)
    {
        super.setNomTable("AnnulationAvoir");
        setIndicePk("ANA");
        setNomProcedureSequence("getSeqAnnulationAvoir");
        setIdAnnulationAvoir(makePK());
        setIdAvoir(idAvoi);
        setDaty(dat);
    }

    public AnnulationAvoir(String idAnnulationAvoi, String idAvoi, String dat)
    {
        super.setNomTable("AnnulationAvoir");
        setNomProcedureSequence("getSeqAnnulationAvoir");
        setIdAnnulationAvoir(makePK());
        setIdAnnulationAvoir(idAnnulationAvoi);
        setIdAvoir(idAvoi);
        if(String.valueOf(dat).compareTo("") == 0 || dat == null)
            setDaty(Utilitaire.dateDuJourSql());
        else
            setDaty(Utilitaire.string_date("dd/MM/yyyy", dat));
    }

    public AnnulationAvoir(String idAvoi, String dat)
    {
        super.setNomTable("AnnulationAvoir");
        setNomProcedureSequence("getSeqAnnulationAvoir");
        setIdAnnulationAvoir(makePK());
        super.setNomTable("AnnulationAvoir");
        setIdAvoir(idAvoi);
        if(String.valueOf(dat).compareTo("") == 0 || dat == null)
            setDaty(Utilitaire.dateDuJourSql());
        else
            setDaty(Utilitaire.string_date("dd/MM/yyyy", dat));
    }

    public AnnulationAvoir(String idAvoi)
    {
        super.setNomTable("AnnulationAvoir");
        setIdAvoir(idAvoi);
        setDaty(Utilitaire.dateDuJourSql());
    }

    public String getAttributIDName()
    {
        return "idAnnulationAvoir";
    }

    public String getTuppleID()
    {
        return String.valueOf(idAnnulationAvoir);
    }

    public void setIdAnnulationAvoir(String idAnnulationAvoir)
    {
        this.idAnnulationAvoir = idAnnulationAvoir;
    }

    public String getIdAnnulationAvoir()
    {
        return idAnnulationAvoir;
    }

    public void setIdAvoir(String idAvoir)
    {
        this.idAvoir = idAvoir;
    }

    public String getIdAvoir()
    {
        return idAvoir;
    }

    public void setDaty(Date daty)
    {
        this.daty = daty;
    }

    public Date getDaty()
    {
        return daty;
    }

    public String idAnnulationAvoir;
    public String idAvoir;
    public Date daty;
}
