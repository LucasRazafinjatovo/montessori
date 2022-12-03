package pointage;

import bean.*;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;



public class PointageUtil extends GenUtil
{

    public PointageUtil()
    {
        super("Pointage");
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
                Pointage temp = null;
                Vector vect = new Vector();
                while(rs.next())
                {
                    temp = new Pointage(rs.getString(1), rs.getString(2), rs.getDate(3),rs.getString(4),rs.getString(5),rs.getString(6),rs.getString(7),rs.getString(8),rs.getString(9));
                    vect.add(i, temp);
                    i++;
                }
                Pointage retour[] = new Pointage[i];
                for(; k < i; k++)
                    retour[k] = (Pointage)vect.elementAt(k);

                Pointage pointageTab[] = retour;
                return pointageTab;
            }
            catch(Exception s)
            {
                System.out.println("PointageUtil ".concat(String.valueOf(String.valueOf(s.getMessage()))));
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
                System.out.println("Erreur Fermeture SQL PointageUtil ".concat(String.valueOf(String.valueOf(e.getMessage()))));
            }
        }
    }
}
