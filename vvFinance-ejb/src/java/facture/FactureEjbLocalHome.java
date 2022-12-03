package facture;

import javax.ejb.CreateException;
import javax.ejb.EJBLocalHome;
import java.util.*;


public interface FactureEjbLocalHome  extends EJBLocalHome {
  public FactureEjbLocal create() throws CreateException;
}
