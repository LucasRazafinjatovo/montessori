// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   ParametrePenaliteUtil.java

package penalite;

import bean.GenUtil;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

// Referenced classes of package penalite:
//            ParametrePenalite

public class ParametrePenaliteUtil extends GenUtil
{

    public ParametrePenaliteUtil()
    {
        super("parametrePenalite");
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
                ParametrePenalite temp = null;
                Vector vect = new Vector();
                while(rs.next())
                {
                    temp = new ParametrePenalite(rs.getString(1), rs.getDouble(2), rs.getDouble(3), rs.getInt(4), rs.getInt(5), rs.getInt(6), rs.getInt(7), rs.getInt(8), rs.getInt(9), rs.getInt(10), rs.getInt(11), rs.getInt(12), rs.getInt(13), rs.getInt(14), rs.getInt(15), rs.getDate(16));
                    vect.add(i, temp);
                    i++;
                }
                ParametrePenalite retour[] = new ParametrePenalite[i];
                for(; k < i; k++)
                    retour[k] = (ParametrePenalite)vect.elementAt(k);

                ParametrePenalite aparametrepenalite[] = retour;
                return aparametrepenalite;
            }
            catch(Exception s)
            {
                System.out.println("ParametrePenalite ".concat(String.valueOf(String.valueOf(s.getMessage()))));
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
                System.out.println("Erreur Fermeture SQL ParametrePenalite ".concat(String.valueOf(String.valueOf(e.getMessage()))));
            }
        }
    }
}
