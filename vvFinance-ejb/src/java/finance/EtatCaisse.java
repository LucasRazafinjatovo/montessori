// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   EtatCaisse.java

package finance;

import bean.TypeObjet;
import bean.TypeObjetUtil;

public class EtatCaisse implements java.io.Serializable
{

    public EtatCaisse(String typ, double mont, String dev, String caiss)
    {
        type = typ;
        montant = mont;
        devise = dev;
        caisse = caiss;
    }
    public String getType()
    {
        return type;
    }

    public void setType(String type)
    {
        this.type = type;
    }

    public void setMontant(double montant)
    {
        this.montant = montant;
    }

    public double getMontant()
    {
        return montant;
    }

    public void setDevise(String devise)
    {
        this.devise = devise;
    }

    public String getDevise()
    {
        return devise;
    }

    public void setCaisse(String caisse)
    {
        this.caisse = caisse;
    }

    public String getCaisse()
    {
        return caisse;
    }

    public TypeObjet getTypeObjet()
    {
        try
        {
            if(type.startsWith("TE"))
            {
                TypeObjet typeobjet = (new TypeObjetUtil()).findTypeObjet("TypeEntree", type, "%")[0];
                return typeobjet;
            }
            if(type.startsWith("TS"))
            {
                TypeObjet typeobjet1 = (new TypeObjetUtil()).findTypeObjet("TypeSortie", type, "%")[0];
                return typeobjet1;
            }
        }
        catch(Exception exception) { }
        return null;
    }

    public String type;
    public double montant;
    public String devise;
    public String caisse;
}
