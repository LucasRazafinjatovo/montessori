// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   RecuperePenaliteLocale.java

package penalite;

import javax.naming.*;

// Referenced classes of package penalite:
//            PenaliteLocalHome

public class RecuperePenaliteLocale
{

    public RecuperePenaliteLocale()
    {
    }

    public static PenaliteLocalHome recupHome()
    {
        PenaliteLocalHome penalitelocalhome;
        try
        {
            Context ctx = new InitialContext();
            Object objRef = ctx.lookup("PenaliteVVLocal");
            PenaliteLocalHome pcLHome = (PenaliteLocalHome)objRef;
            PenaliteLocalHome penalitelocalhome1 = pcLHome;
            return penalitelocalhome1;
        }
        catch(NamingException ex)
        {
            penalitelocalhome = null;
        }
        return penalitelocalhome;
    }
}
