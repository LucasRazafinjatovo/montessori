// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   AdminTrafic.java

package penalite;


// Referenced classes of package penalite:
//            TraficConteneur

public class AdminTrafic
{

    public AdminTrafic()
    {
    }

    public static double calculSommeFacture(TraficConteneur a[])
    {
        double somme = 0.0D;
        for(int i = 0; i < a.length; i++)
            somme += a[i].getNombre();

        return somme;
    }

    public static double calculSommeFactureIndice(TraficConteneur a[], int debut, int fin)
    {
        double somme = 0.0D;
        for(int i = debut; i < fin; i++)
            somme += a[i].getNombre();

        return somme;
    }
}
