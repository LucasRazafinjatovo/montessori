// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   RecupLocalHome.java

package pointage;

import javax.naming.*;

// Referenced classes of package facture:
//            PointageEjbLocalHome

public class RecupLocalHome
{

    public RecupLocalHome()
    {
    }

    public static PointageEjbLocalHome recupFactureHome()
    {
        PointageEjbLocalHome pointageejblocalhome;
        try
        {
            Context ctx = new InitialContext();
            Object objRef = ctx.lookup("PointageEjbLocal");
            PointageEjbLocalHome pcLHome = (PointageEjbLocalHome)objRef;
            PointageEjbLocalHome pointageejblocalhome1 = pcLHome;
            return pointageejblocalhome1;
        }
        catch(NamingException ex)
        {
            pointageejblocalhome = null;
        }
        return pointageejblocalhome;
    }
}
