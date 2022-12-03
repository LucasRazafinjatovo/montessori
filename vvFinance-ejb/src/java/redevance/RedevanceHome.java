// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   RedevanceHome.java

package redevance;

import java.rmi.RemoteException;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;

// Referenced classes of package redevance:
//            RedevanceEjb

public interface RedevanceHome
    extends EJBHome
{

    public abstract RedevanceEjb create()
        throws RemoteException, CreateException;
}
