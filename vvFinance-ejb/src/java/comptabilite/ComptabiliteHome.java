package comptabilite;

import java.rmi.RemoteException;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;

public interface ComptabiliteHome
    extends EJBHome
{

    public abstract ComptabiliteEjb create()
        throws RemoteException, CreateException;
}
