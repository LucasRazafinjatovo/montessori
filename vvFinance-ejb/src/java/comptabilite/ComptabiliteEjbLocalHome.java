package comptabilite;

import javax.ejb.CreateException;
import javax.ejb.EJBLocalHome;
import java.util.*;


public interface ComptabiliteEjbLocalHome  extends EJBLocalHome {
  public ComptabiliteEjbLocal create() throws CreateException;
}
