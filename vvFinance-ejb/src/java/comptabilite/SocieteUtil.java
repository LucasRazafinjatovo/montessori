package comptabilite;

import bean.GenUtil;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;


public class SocieteUtil extends GenUtil
{

    public SocieteUtil()
    {
        super("societe");
    }

    public Societe findById(int id)
    {
        return (Societe)rechercher(1, String.valueOf(id))[0];
    }

    public Object[] resultatLimit(int numBloc, ResultSet rs)
    {
        throw new UnsupportedOperationException("Method resultatLimit() not yet implemented.");
    }

    public Object[] resultatGen(ResultSet rs)
    {
        try
        {
            try
            {
                int i = 0;
                int k = 0;
                Societe temp = null;
                Vector vect = new Vector();
                while(rs.next())
                {
                    temp = new Societe(rs.getString(1), rs.getString(2), rs.getString(3),
					rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7),
					rs.getString(8), rs.getString(9), rs.getString(10), rs.getString(11),
					rs.getString(12));
                    vect.add(i, temp);
                    i++;
                }
                Societe retour[] = new Societe[i];
                for(; k < i; k++)
                    retour[k] = (Societe)vect.elementAt(k);

                Societe aclient[] = retour;
                return aclient;
            }
            catch(Exception s)
            {
                System.out.println("Recherche Societe ".concat(String.valueOf(String.valueOf(s.getMessage()))));
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
                System.out.println("Erreur Fermeture SQL Historique ".concat(String.valueOf(String.valueOf(e.getMessage()))));
            }
        }
    }
}
