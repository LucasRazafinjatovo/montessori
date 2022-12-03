package finance;

import utilitaire.UtilDB;
import java.sql.*;
import java.util.Vector;
import bean.GenUtil;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class EtatCaisseResteUtil extends GenUtil {

  public EtatCaisseResteUtil() {
    super("resteParJour","finance.EtatCaisseReste");
  }
  public Object[] resultatGen (ResultSet rs)
  {
          try
          {
                  int i = 0, k = 0;
                  EtatCaisseReste temp = null;
                  Vector vect = new Vector();
                  while(rs.next())
                  {
                      temp = new EtatCaisseReste (rs.getDate(1),rs.getString(2),rs.getString(3),rs.getString(4),rs.getDouble(5),rs.getDouble(6),rs.getDouble(7),rs.getDouble(8),rs.getDouble(9));
                          vect.add(i,temp);
                          i++;
                  }

                  EtatCaisseReste []retour = new EtatCaisseReste[i];
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
  public Object[] resultatLimit(int numBloc, ResultSet rs) {
    /**@todo Implement this bean.GenUtil abstract method*/
    throw new java.lang.UnsupportedOperationException("Method resultatLimit() not yet implemented.");
  }
}