package facturefournisseur;

import javax.ejb.*;
import java.util.*;
import java.rmi.*;

public interface GestionFactureFournisseurHome extends javax.ejb.EJBHome {
  public GestionFactureFournisseur create() throws CreateException, RemoteException;
}