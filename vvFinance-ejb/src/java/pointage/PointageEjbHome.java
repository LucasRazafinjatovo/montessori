package pointage;

import javax.ejb.*;
import java.util.*;
import java.rmi.*;

public interface PointageEjbHome extends javax.ejb.EJBHome {
  public PointageEjb create() throws CreateException, RemoteException;
}