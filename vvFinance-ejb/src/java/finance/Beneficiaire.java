// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   Beneficiaire.java

package finance;

import bean.ClassMAPTable;

public class Beneficiaire extends ClassMAPTable
{

    public Beneficiaire(String bene, String desce)
    {
        super.setNomTable("beneficiaire");
        ben = bene;
        this.desce = desce;
    }
    public Beneficiaire()
    {
        super.setNomTable("beneficiaire");
    }
    public String getTuppleID()
    {
        return String.valueOf(ben);
    }

    public String getAttributIDName()
    {
        return "ben";
    }

    public String getBen()
    {
        return ben;
    }

    public void setBen(String ben)
    {
        this.ben = ben;
    }

    public void setDesc(String desc)
    {
        desce = desc;
    }

    public String getDesc()
    {
        return desce;
    }

    public String ben;
    public String desce;
}
