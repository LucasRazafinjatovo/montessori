package user;

import javax.ejb.CreateException;
import java.util.*;

public interface UserEJBLocalHome extends javax.ejb.EJBLocalHome {
  public UserEJB create() throws CreateException;
}