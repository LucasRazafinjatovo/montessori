// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   RecupLocalLC.java

package lc;

import javax.naming.*;

// Referenced classes of package finance:
//            FinanceLocalHome

public class RecupLocalLC
{

    public RecupLocalLC()
    {
    }

    public static LCEjbLocalHome recupHome()
    {
    	LCEjbLocalHome lclocalhome;
        try
        {
            Context ctx = new InitialContext();
            Object objRef = ctx.lookup("LCEjbLocal");
            LCEjbLocalHome pcLHome = (LCEjbLocalHome)objRef;
            LCEjbLocalHome financelocalhome1 = pcLHome;
            return financelocalhome1;
        }
        catch(NamingException ex)
        {
        	lclocalhome = null;
            ex.printStackTrace();
        }
        return lclocalhome;
    }
}
