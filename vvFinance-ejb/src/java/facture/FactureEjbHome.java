package facture;

import java.rmi.RemoteException;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import java.util.*;


public interface FactureEjbHome  extends EJBHome {
  public FactureEjb create() throws CreateException, RemoteException;
}
