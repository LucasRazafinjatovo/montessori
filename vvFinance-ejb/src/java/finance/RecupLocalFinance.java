// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   RecupLocalFinance.java

package finance;

import javax.naming.*;

// Referenced classes of package finance:
//            FinanceLocalHome

public class RecupLocalFinance
{

    public RecupLocalFinance()
    {
    }

    public static FinanceLocalHome recupHome()
    {
        FinanceLocalHome financelocalhome;
        try
        {
            Context ctx = new InitialContext();
            Object objRef = ctx.lookup("FinanceVVLocal");
            FinanceLocalHome pcLHome = (FinanceLocalHome)objRef;
            FinanceLocalHome financelocalhome1 = pcLHome;
            return financelocalhome1;
        }
        catch(NamingException ex)
        {
            financelocalhome = null;
            ex.printStackTrace();
        }
        return financelocalhome;
    }
}
