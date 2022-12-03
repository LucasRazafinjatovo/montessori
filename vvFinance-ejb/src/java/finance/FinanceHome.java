// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   FinanceHome.java

package finance;

import java.rmi.RemoteException;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import java.util.*;

// Referenced classes of package finance:
//            FinanceEjb

public interface FinanceHome
    extends EJBHome{
  public FinanceEjb create() throws CreateException, RemoteException;


}
