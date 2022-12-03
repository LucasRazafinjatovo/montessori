// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   FactureLocalHome.java

package facture;

import javax.ejb.CreateException;
import javax.ejb.EJBLocalHome;

// Referenced classes of package facture:
//            FactureEjbLocal

public interface FactureLocalHome
    extends EJBLocalHome
{

    public abstract FactureEjbLocal create()
        throws CreateException;
}
