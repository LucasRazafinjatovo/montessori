// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   PenaliteUtil.java

package penalite;

import bean.GenUtil;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

// Referenced classes of package penalite:
//            Penalite

public class PenaliteUtil extends GenUtil
{

    public PenaliteUtil()
    {
        super.setNomTable("Penalite");
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
                Penalite temp = null;
                Vector vect = new Vector();
                while(rs.next())
                {
                    temp = new Penalite(rs.getString(1), rs.getDate(2), rs.getDate(3), rs.getString(4), rs.getDouble(5), rs.getString(6), rs.getString(7), (float)rs.getDouble(8), (float)rs.getDouble(9), (float)rs.getDouble(10));
                    vect.add(i, temp);
                    i++;
                }
                Penalite retour[] = new Penalite[i];
                for(; k < i; k++)
                    retour[k] = (Penalite)vect.elementAt(k);

                Penalite apenalite[] = retour;
                return apenalite;
            }
            catch(Exception s)
            {
                System.out.println("Penalite ".concat(String.valueOf(String.valueOf(s.getMessage()))));
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
                System.out.println("Erreur Fermeture SQL Penalite ".concat(String.valueOf(String.valueOf(e.getMessage()))));
            }
        }
    }
}
