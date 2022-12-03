package ded;

import bean.*;
import java.sql.*;
import java.util.Vector;


/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class VisaUtil extends GenUtil {

  public VisaUtil() {
  }
  public Object[] resultatLimit(int numBloc, ResultSet rs) {
    /**@todo Implement this bean.GenUtil abstract method*/
    throw new java.lang.UnsupportedOperationException("Method resultatLimit() not yet implemented.");
  }
  public Object[] resultatGen(ResultSet rs)
  {
      try
      {
          try
          {
              int i = 0;
              int k = 0;
              Visa temp = null;
              Vector vect = new Vector();
              while(rs.next())
              {//(String id,String desi,String dt,String mtht,String taxe,String rem,String eta,String tier)
                  temp = new Visa(this.getNomTable(),rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4));
                  vect.add(i, temp);
                  i++;
              }
              Visa retour[] = new Visa[i];
              vect.copyInto(retour);
              return retour;
          }
          catch(Exception s)
          {
              System.out.println("Visa "+s.getMessage());
              return null;
          }
      }
      finally
      {
          try
          {
              if(rs != null)
                  rs.close();
          }
          catch(SQLException e)
          {
              System.out.println("Erreur Fermeture SQL Caisse ".concat(String.valueOf(String.valueOf(e.getMessage()))));
          }
      }
    }
}