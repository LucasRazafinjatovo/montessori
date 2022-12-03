// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   AdminCharge.java

package finance;


// Referenced classes of package finance:
//            Sortie

public class AdminCharge
{

    public AdminCharge()
    {
    }

    public static double getSommeSortie(Sortie a[], int indiceInf, int indiceSup)
    {
        double retour = 0.0D;
        for(int i = indiceInf; i < indiceSup + 1; i++)
            if(i < a.length)
                retour += a[i].getMontant();
            else
                return retour;

        return retour;
    }

    public static double getSommeSortie(Sortie a[])
    {
        double retour = 0.0D;
        for(int i = 0; i < a.length; i++)
            retour += a[i].getMontant();

        return retour;
    }

    public static double getMoyenneSortie(Sortie a[])
    {
        double retour = 0.0D;
        for(int i = 0; i < a.length; i++)
            retour += a[i].getMontant();

        return retour / (double)a.length;
    }

    public static double getSommeSortieByType(Sortie a[], String type)
    {
        double retour = 0.0D;
        for(int i = 0; i < a.length; i++)
            if(a[i].getIdTypeSortie().compareToIgnoreCase(type) == 0)
                retour += a[i].getMontant();

        return retour;
    }

    public static double getSommeSortieByBen(Sortie a[], String ben)
    {
        double retour = 0.0D;
        for(int i = 0; i < a.length; i++)
            if(a[i].getBeneficiaire().compareToIgnoreCase(ben) == 0)
                retour += a[i].getMontant();

        return retour;
    }

    public static double getSommeSortieByDevise(Sortie a[], String devise)
    {
        double retour = 0.0D;
        for(int i = 0; i < a.length; i++)
            if(a[i].getIdDevise().compareToIgnoreCase(devise) == 0)
                retour += a[i].getMontant();

        return retour;
    }

    public static int getNombreSortieByDevise(Sortie a[], String devise)
    {
        int retour = 0;
        for(int i = 0; i < a.length; i++)
            if(a[i].getIdDevise().compareToIgnoreCase(devise) == 0)
                retour++;

        return retour;
    }
}
