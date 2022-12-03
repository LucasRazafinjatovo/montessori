// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   AdminAvoir.java

package facture;


// Referenced classes of package facture:
//            Avoir

public class AdminAvoir
{

    public AdminAvoir()
    {
    }

    public static double getSommeMontantAvoir(Avoir a[])
    {
        double somme = 0.0D;
        for(int i = 0; i < a.length; i++)
            somme += a[i].getMontant();

        return somme;
    }
}
