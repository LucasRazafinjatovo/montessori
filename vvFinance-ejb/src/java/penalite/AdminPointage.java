// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   AdminPointage.java

package penalite;


// Referenced classes of package penalite:
//            SynthesePointage

public class AdminPointage
{

    public AdminPointage()
    {
    }

    public static double getNombreConteneur(SynthesePointage sp[])
    {
        double retour = 0.0D;
        for(int i = 0; i < sp.length; i++)
            retour += sp[i].getNombre();

        return retour;
    }

    public static double getNombreDuree(SynthesePointage sp[])
    {
        double retour = 0.0D;
        for(int i = 0; i < sp.length; i++)
            retour += sp[i].getDuree();

        return retour;
    }
}
