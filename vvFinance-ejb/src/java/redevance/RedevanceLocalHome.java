// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   RedevanceLocalHome.java

package redevance;

import javax.ejb.CreateException;
import javax.ejb.EJBLocalHome;

// Referenced classes of package redevance:
//            RedevanceEjbLocal

public interface RedevanceLocalHome
    extends EJBLocalHome
{

    public abstract RedevanceEjbLocal create()
        throws CreateException;
}
