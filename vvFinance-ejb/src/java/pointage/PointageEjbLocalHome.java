package pointage;

import javax.ejb.*;
import java.util.*;

public interface PointageEjbLocalHome extends javax.ejb.EJBLocalHome {
  public PointageEjbLocal create() throws CreateException;
}