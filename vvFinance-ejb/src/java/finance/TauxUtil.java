package finance;

import bean.*;
import java.sql.*;
import java.util.Vector;


/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class TauxUtil extends GenUtil {

  public TauxUtil() {
    super.setNomTable("Taux");
  }
  public Object[] resultatLimit(int numBloc, ResultSet rs) {
    /**@todo Implement this bean.GenUtil abstract method*/
    throw new java.lang.UnsupportedOperationException("Method resultatLimit() not yet implemented.");
  }
  public Taux getTaux()
  {
    return (Taux)rechercher(1,"1")[0];
  }
  public Object[] resultatGen(ResultSet rs)   {
          try
          {
                  int i = 0, k = 0;
                  Taux temp = null;
                  Vector vect = new Vector();
                  while(rs.next())
                  {
                      temp = new Taux (rs.getString(1),rs.getDouble(2),rs.getDouble(3),rs.getInt(4),rs.getDate(5));
                          vect.add(i,temp);
                          i++;
                  }

                  Taux []retour = new Taux[i];

                  while (k < i)
                  {
                          retour[k] = (Taux)(vect.elementAt(k));
                          k++;
                  }
                  return retour;
          }
          catch (Exception s)
          {
                  System.out.println("Resultat "+s.getMessage());
                  return null;
          }
          finally
          {
            try
            {
                  if (rs!=null) rs.close();
            }
            catch(SQLException e)
            {
              System.out.println("Erreur Fermeture SQL Taux "+ e.getMessage());
            }
          }
  }
}