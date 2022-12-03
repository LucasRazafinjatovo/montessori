// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   RecupLocalDed.java

package ded;

import javax.naming.*;

// Referenced classes of package facture:
//            FactureEjbLocalHome

public class RecupLocalDed
{

    public RecupLocalDed()
    {
    }

    public static DedEjbLocalHome recupDedHome()
    {
        DedEjbLocalHome dedejblocalhome;
        try
        {
            Context ctx = new InitialContext();
            Object objRef = ctx.lookup("gestionDedEjbLocal");
            DedEjbLocalHome pcLHome = (DedEjbLocalHome)objRef;
            DedEjbLocalHome dedejblocalhome1 = pcLHome;
            return dedejblocalhome1;
        }
        catch(NamingException ex)
        {
            dedejblocalhome = null;
        }
        return dedejblocalhome;
    }
}
