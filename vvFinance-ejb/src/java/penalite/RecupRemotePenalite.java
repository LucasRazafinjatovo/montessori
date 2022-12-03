// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   RecupRemotePenalite.java

package penalite;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.rmi.PortableRemoteObject;

// Referenced classes of package penalite:
//            PenaliteHome, PenaliteEjb

public class RecupRemotePenalite
{

    public RecupRemotePenalite()
    {
        penaliteHome = null;
        try
        {
            Context ctx = new InitialContext();
            Object ref = ctx.lookup("PenaliteVV");
            penaliteHome = (PenaliteHome)PortableRemoteObject.narrow(ref, penalite.PenaliteHome.class);
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
    }

    public void testRemoteCallsWithDefaultArguments(PenaliteEjb penaliteEjb)
    {
        if(penaliteEjb == null)
            return;
        try
        {
            penaliteEjb.create(null, null);
            penaliteEjb.update(null, null);
            penaliteEjb.delete(null, null);
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
    }

    public PenaliteHome getHome()
    {
        return penaliteHome;
    }

    public static void main(String args[])
    {
        RecupRemotePenalite client = new RecupRemotePenalite();
    }

    private PenaliteHome penaliteHome;
}
