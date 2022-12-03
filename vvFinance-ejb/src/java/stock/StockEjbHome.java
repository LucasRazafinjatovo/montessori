package stock;

import javax.ejb.*;
import java.util.*;
import java.rmi.*;

public interface StockEjbHome extends javax.ejb.EJBHome {
  public StockEjb create() throws CreateException, RemoteException;
}