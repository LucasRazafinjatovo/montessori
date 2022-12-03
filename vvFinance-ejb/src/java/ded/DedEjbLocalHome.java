package ded;

import javax.ejb.*;
import java.util.*;

public interface DedEjbLocalHome extends javax.ejb.EJBLocalHome {
  public DedEjbLocal create() throws CreateException;
}