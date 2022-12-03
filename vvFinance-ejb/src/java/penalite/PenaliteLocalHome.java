// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   PenaliteLocalHome.java

package penalite;

import javax.ejb.CreateException;
import javax.ejb.EJBLocalHome;
import java.util.*;

// Referenced classes of package penalite:
//            PenaliteEjbLocal

public interface PenaliteLocalHome
    extends EJBLocalHome
{
  public PenaliteEjbLocal create() throws CreateException;

}
