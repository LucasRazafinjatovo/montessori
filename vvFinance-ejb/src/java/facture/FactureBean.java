// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   FactureBean.java

package facture;

import bean.ClassEjb;
import javax.ejb.*;

public class FactureBean extends ClassEjb
    implements SessionBean
{

    public FactureBean()
    {
    }

    public void ejbCreate()
        throws CreateException
    {
    }

    public void ejbRemove()
    {
    }

    public void ejbActivate()
    {
    }

    public void ejbPassivate()
    {
    }

    public void setSessionContext(SessionContext sessionContext)
    {
        this.sessionContext = sessionContext;
    }

    SessionContext sessionContext;
}
