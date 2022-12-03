// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   RecupLocalStock.java

package stock;

import javax.naming.*;
import stock.StockEjbLocalHome;

// Referenced classes of package finance:
//            FinanceLocalHome

public class RecupLocalStock
{

    public RecupLocalStock()
    {
    }

    public static StockEjbLocalHome recupHome()
    {
        StockEjbLocalHome financelocalhome;
        try
        {
            Context ctx = new InitialContext();
            Object objRef = ctx.lookup("stockLocal");
            StockEjbLocalHome pcLHome = (StockEjbLocalHome)objRef;
            StockEjbLocalHome financelocalhome1 = pcLHome;
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
