package pcg;

import javax.ejb.*;
import java.util.*;

public interface GestionPlanComptableLocalHome extends javax.ejb.EJBLocalHome {
  public GestionPlanComptableLocal create() throws CreateException;
}