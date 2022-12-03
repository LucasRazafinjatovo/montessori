package lc;

import javax.ejb.CreateException;
import java.util.*;

public interface LCEjbLocalHome extends javax.ejb.EJBLocalHome {
  public LCEjbLocal create() throws CreateException;
}
