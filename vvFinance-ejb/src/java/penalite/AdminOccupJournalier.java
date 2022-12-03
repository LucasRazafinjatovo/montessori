// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   AdminOccupJournalier.java

package penalite;


// Referenced classes of package penalite:
//            OccupJournalier

public class AdminOccupJournalier
{

    public AdminOccupJournalier()
    {
    }

    public static double getSommeOcuppation(OccupJournalier occ[])
    {
        double retour = 0.0D;
        for(int i = 0; i < occ.length; i++)
            retour += occ[i].getOccup();

        return retour;
    }
}
