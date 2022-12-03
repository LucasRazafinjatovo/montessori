// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   RecupLocalHome.java

package facture;

import javax.naming.*;

// Referenced classes of package facture:
//            FactureEjbLocalHome

public class RecupLocalHome
{

    public RecupLocalHome()
    {
    }

    public static FactureEjbLocalHome recupFactureHome()
    {
        FactureEjbLocalHome factureejblocalhome;
        try
        {
            Context ctx = new InitialContext();
            Object objRef = ctx.lookup("FactureVVEjbLocal");
            FactureEjbLocalHome pcLHome = (FactureEjbLocalHome)objRef;
            FactureEjbLocalHome factureejblocalhome1 = pcLHome;
            return factureejblocalhome1;
        }
        catch(NamingException ex)
        {
            factureejblocalhome = null;
        }
        return factureejblocalhome;
    }
}
