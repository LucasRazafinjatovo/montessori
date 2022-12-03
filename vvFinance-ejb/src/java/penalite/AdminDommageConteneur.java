// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   AdminDommageConteneur.java

package penalite;

import java.util.Vector;

// Referenced classes of package penalite:
//            DommageConteneur

public class AdminDommageConteneur
{

    public AdminDommageConteneur()
    {
    }

    public static DommageConteneur[] getDommageSurMontant(DommageConteneur dc[], double mont)
    {
        int i = 0;
        Vector v = new Vector();
        for(; i < dc.length; i++)
            if(dc[i].getMontant() >= mont)
                v.add(i, dc[i]);

        DommageConteneur retour[] = new DommageConteneur[i];
        for(int k = 0; k < v.size(); k++)
        {
            retour[k] = (DommageConteneur)v.elementAt(k);
            k++;
        }

        return retour;
    }
}
