package pcg;

import javax.ejb.*;
import java.util.*;
import java.rmi.*;

public interface GestionPlanComptableHome extends javax.ejb.EJBHome {
  public GestionPlanComptable create() throws CreateException, RemoteException;
}