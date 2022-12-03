package stock;

import javax.ejb.*;
import java.util.*;

public interface StockEjbLocalHome extends javax.ejb.EJBLocalHome {
  public StockEjbLocal create() throws CreateException;
}