// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   RecupLocalHome.java

package user;

import javax.naming.*;

// Referenced classes of package user:
//            UserEJBHome

public class RecupLocalHome
{

    public RecupLocalHome()
    {
    }

    public static UserEJBHome recupUserHome()
    {
        UserEJBHome userejbhome;
        try
        {
            Context ctx = new InitialContext();
            Object objRef = ctx.lookup("UserEJBVV");
            UserEJBHome pcLHome = (UserEJBHome)objRef;
            UserEJBHome userejbhome1 = pcLHome;
            return userejbhome1;
        }
        catch(NamingException ex)
        {
            userejbhome = null;
        }
        return userejbhome;
    }
}
