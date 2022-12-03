package lc;

import java.rmi.RemoteException;

import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import java.util.*;

public interface LCEjbHome extends EJBHome{
  public LCEjb create() throws CreateException, RemoteException;
}
