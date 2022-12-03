package user;

import java.rmi.RemoteException;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import java.util.*;



public interface UserEJBHome     extends EJBHome {
  public UserEJBRemote create() throws CreateException, RemoteException;
}
