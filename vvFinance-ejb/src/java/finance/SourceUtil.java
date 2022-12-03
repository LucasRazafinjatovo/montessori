package finance;
import java.util.Vector;
import bean.*;
import java.sql.*;


/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class SourceUtil extends GenUtil {

  public SourceUtil() {
    super("Source");
  }
  public Object[] resultatLimit(int numBloc, ResultSet rs) {
    /**@todo Implement this bean.GenUtil abstract method*/
    throw new java.lang.UnsupportedOperationException("Method resultatLimit() not yet implemented.");
  }
  public Object[] resultatGen (ResultSet rs)
  {
          try
          {
                  int i = 0, k = 0;
                  Source temp = null;
                  Vector vect = new Vector();
                  while(rs.next())
                  {
                      temp = new Source (rs.getString(1),rs.getString(2));
                          vect.add(i,temp);
                          i++;
                  }

                  Source []retour = new Source[i];
                  vect.copyInto(retour);
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
              System.out.println("Erreur Fermeture SQL HistoriqueOrdUtil "+ e.getMessage());
            }
          }
  }
}