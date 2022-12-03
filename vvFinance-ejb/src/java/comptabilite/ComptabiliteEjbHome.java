package comptabilite;

import java.rmi.RemoteException;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import java.util.*;


public interface ComptabiliteEjbHome  extends EJBHome {
  public ComptabiliteEjb create() throws CreateException, RemoteException;
}
