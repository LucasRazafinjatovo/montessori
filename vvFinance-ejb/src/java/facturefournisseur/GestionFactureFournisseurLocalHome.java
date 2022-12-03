package facturefournisseur;

import javax.ejb.*;
import java.util.*;

public interface GestionFactureFournisseurLocalHome extends javax.ejb.EJBLocalHome {
  public GestionFactureFournisseurLocal create() throws CreateException;
}