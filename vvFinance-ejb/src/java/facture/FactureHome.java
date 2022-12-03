// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   FactureHome.java

package facture;

import java.rmi.RemoteException;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;

// Referenced classes of package facture:
//            FactureEjb

public interface FactureHome
    extends EJBHome
{

    public abstract FactureEjb create()
        throws RemoteException, CreateException;
}
