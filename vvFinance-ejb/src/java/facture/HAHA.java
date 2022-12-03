// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   HAHA.java

package facture;

import bean.ClassMAPTable;

public class HAHA extends ClassMAPTable
{

    public HAHA(double n1, double n2)
    {
        super.setNomTable("HAHA");
        nombre1 = n1 * n2;
        nombre2 = n1 * n2;
    }

    public String getAttributIDName()
    {
        return "nombre1";
    }

    public String getTuppleID()
    {
        return String.valueOf(nombre1);
    }

    public void setNombre1(double nombre1)
    {
        this.nombre1 = nombre1;
    }

    public double getNombre1()
    {
        return nombre1;
    }

    public void setNombre2(double nombre2)
    {
        this.nombre2 = nombre2;
    }

    public double getNombre2()
    {
        return nombre2;
    }

    public double nombre1;
    public double nombre2;
}
