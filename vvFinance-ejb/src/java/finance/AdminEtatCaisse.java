// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   AdminEtatCaisse.java

package finance;


// Referenced classes of package finance:
//            EtatCaisse

public class AdminEtatCaisse
{

    public AdminEtatCaisse()
    {
    }

    public static double getSommeEtat(EtatCaisse a[])
    {
        double retour = 0.0D;
        for(int i = 0; i < a.length; i++)
            retour += a[i].getMontant();

        return retour;
    }

    public static double getSommeEtatReel(EtatCaisse a[])
    {
        double retour = 0.0D;
        for(int i = 0; i < a.length; i++)
            if(a[i].getType().compareToIgnoreCase("report") != 0)
                retour += a[i].getMontant();

        return retour;
    }

    public static double getSommeEtatByDevise(EtatCaisse a[], String devise)
    {
        double retour = 0.0D;
        for(int i = 0; i < a.length; i++)
            if(a[i].getDevise().compareToIgnoreCase(devise) == 0)
                retour += a[i].getMontant();

        return retour;
    }

    public static double getSommeEtatReelByDevise(EtatCaisse a[], String devise)
    {
        double retour = 0.0D;
        for(int i = 0; i < a.length; i++)
            if(a[i].getDevise().compareToIgnoreCase(devise) == 0 && a[i].getType().compareToIgnoreCase("report") != 0)
                retour += a[i].getMontant();

        return retour;
    }
}
