package ded;

import javax.ejb.*;
import java.util.*;
import java.rmi.*;

public interface DedEjbHome extends javax.ejb.EJBHome {
  public DedEjb create() throws CreateException, RemoteException;
}