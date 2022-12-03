package finance;

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

public class SyntheseCompteTypeUtil extends GenUtil {

  public SyntheseCompteTypeUtil() {
    super("entreecompvalcattype","finance.SyntheseCompte");
  }
  public Object[] resultatLimit(int numBloc, ResultSet rs) {
    /**@todo Implement this bean.GenUtil abstract method*/
    throw new java.lang.UnsupportedOperationException("Method resultatLimit() not yet implemented.");
  }
  public Object[] resultatGen(ResultSet rs) {
    try
    {
            int i = 0, k = 0;
            SyntheseCompte temp = null;
            Vector vect = new Vector();
            while(rs.next())
            {
                temp = new SyntheseCompte (rs.getDate(1),rs.getDouble(2),rs.getString(3),rs.getString(4),rs.getString(5),rs.getString(6),rs.getString(7),rs.getString(8));
                    vect.add(i,temp);
                    i++;
            }

            SyntheseCompte []retour = new SyntheseCompte[i];
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
          }  }
}