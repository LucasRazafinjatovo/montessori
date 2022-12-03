// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   AdminSyntheseEVP.java

package facture;


// Referenced classes of package facture:
//            SyntheseEVP

public class AdminSyntheseEVP
{

    public AdminSyntheseEVP()
    {
    }

    public static int getSommeQuarante(SyntheseEVP a[])
    {
        int somme = 0;
        for(int i = 0; i < a.length; i++)
            somme += a[i].getQuarante();

        return somme;
    }

    public static int getSommeVingt(SyntheseEVP a[])
    {
        int somme = 0;
        for(int i = 0; i < a.length; i++)
            somme += a[i].getVingt();

        return somme;
    }

    public static int getSommeEVP(SyntheseEVP a[])
    {
        int somme = 0;
        for(int i = 0; i < a.length; i++)
            somme += a[i].getEVP();

        return somme;
    }
}
