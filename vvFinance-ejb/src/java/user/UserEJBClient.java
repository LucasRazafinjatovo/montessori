// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   UserEJBClient.java

package user;

import java.util.Properties;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;

// Referenced classes of package user:
//            UserEJBHome, UserEJB

public class UserEJBClient
{

    public UserEJBClient()
    {
        userEJBHome = null;
        try
        {
            Context ctx = new InitialContext();
            Object objRef = ctx.lookup("UserEJBLocal");
            userEJBHome = (UserEJBLocalHome)objRef;

        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
    }

    public void testRemoteCallsWithDefaultArguments(UserEJB userEJB)
    {
        if(userEJB == null)
            return;
        try
        {
            userEJB.getUser();
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
    }

    public static UserEJB getInterface()
        throws Exception
    {
        try {
            Context c = new InitialContext();
            return (UserEJB) c.lookup("java:module/UserEJBBean!user.UserEJB");
        } catch (NamingException ne) {
//            Logger.getLogger(getClass().getName()).log(Level.SEVERE, "exception caught", ne);
            throw new RuntimeException(ne);
        }
    }

    public UserEJBLocalHome getHome()
    {
        return userEJBHome;
    }

    private UserEJBLocalHome userEJBHome;
    
    
}
