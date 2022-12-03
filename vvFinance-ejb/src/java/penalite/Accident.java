// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   Accident.java

package penalite;

import bean.ClassMAPTable;
import java.sql.Date;
import utilitaire.Utilitaire;

public class Accident extends ClassMAPTable
{

    public Accident(String i, Date datyS, Date datyAc, String des, String nomEmp, String re)
    {
        super.setNomTable("accident");
        setIdAccident(i);
        setDatySaisie(datyS);
        setDatyAccident(datyAc);
        setDescription(des);
        setNomEmploye(nomEmp);
        setRem(re);
    }

    public Accident(Date datyS, Date datyAc, String des, String nomEmp, String re)
    {
        super.setNomTable("accident");
        setIndicePk("ACC");
        setNomProcedureSequence("getSeqAccident");
        setIdAccident(makePK());
        setDatySaisie(datyS);
        setDatyAccident(datyAc);
        setDescription(des);
        setNomEmploye(nomEmp);
        setRem(re);
    }

    public Accident(String datyS, String datyAc, String des, String nomEmp, String re)
    {
        super.setNomTable("accident");
        setIndicePk("ACC");
        setNomProcedureSequence("getSeqAccident");
        setIdAccident(makePK());
        if(String.valueOf(datyS).compareTo("") == 0 || datyS == null)
            setDatySaisie(Utilitaire.dateDuJourSql());
        else
            setDatySaisie(Utilitaire.string_date("dd/MM/yyyy", datyS));
        if(String.valueOf(datyAc).compareTo("") == 0 || datyAc == null)
            setDatyAccident(Utilitaire.dateDuJourSql());
        else
            setDatyAccident(Utilitaire.string_date("dd/MM/yyyy", datyAc));
        if(des.compareTo("") == 0 || des == null)
            setDescription("-");
        else
            setDescription(des);
        if(nomEmp.compareTo("") == 0 || nomEmp == null)
            setNomEmploye("-");
        else
            setNomEmploye(nomEmp);
        if(re.compareTo("") == 0 || re == null)
            setRem("-");
        else
            setRem(re);
    }

    public String getAttributIDName()
    {
        return "idAccident";
    }

    public String getTuppleID()
    {
        return String.valueOf(idAccident);
    }

    public void setIdAccident(String idAccident)
    {
        this.idAccident = idAccident;
    }

    public String getIdAccident()
    {
        return idAccident;
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

    public void setDatyAccident(Date datyAccident)
    {
        if(String.valueOf(datyAccident).compareTo("") == 0 || datyAccident == null)
            this.datyAccident = Utilitaire.dateDuJourSql();
        else
            this.datyAccident = datyAccident;
    }

    public Date getDatyAccident()
    {
        return datyAccident;
    }

    public void setNomEmploye(String nomEmploye)
    {
        if(nomEmploye.compareTo("") == 0 || nomEmploye == null)
            this.nomEmploye = "-";
        else
            this.nomEmploye = nomEmploye;
    }

    public String getNomEmploye()
    {
        return nomEmploye;
    }

    public void setDescription(String desc)
    {
        if(desc.compareTo("") == 0 || desc == null)
            description = "-";
        else
            description = desc;
    }

    public String getDescription()
    {
        return description;
    }

    public void setRem(String rem)
    {
        if(rem.compareTo("") == 0 || rem == null)
            this.rem = "-";
        else
            this.rem = rem;
    }

    public String getRem()
    {
        return rem;
    }

    public String idAccident;
    public Date datySaisie;
    public Date datyAccident;
    public String nomEmploye;
    public String description;
    public String rem;
}
