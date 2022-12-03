package comptabilite;

import bean.GenUtil;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;


public class ExerciceUtil extends GenUtil
{

    public ExerciceUtil()
    {
        super("exercice");
    }

    public Exercice findById(int id)
    {
        return (Exercice)rechercher(1, String.valueOf(id))[0];
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
                Exercice temp = null;
                Vector vect = new Vector();
                while(rs.next())
                {
                    temp = new Exercice(rs.getString(1), rs.getDate(2), rs.getDate(3),
					rs.getInt(4), rs.getString(5));
                    vect.add(i, temp);
                    i++;
                }
                Exercice retour[] = new Exercice[i];
                for(; k < i; k++)
                    retour[k] = (Exercice)vect.elementAt(k);

                Exercice aclient[] = retour;
                return aclient;
            }
            catch(Exception s)
            {
                System.out.println("Recherche Exercice ".concat(String.valueOf(String.valueOf(s.getMessage()))));
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
