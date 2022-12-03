// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   SortieUtil.java

package finance;

import bean.GenUtil;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

// Referenced classes of package finance:
//            Sortie

public class SortieUtil extends GenUtil
{

    public SortieUtil()
    {
        super("sortie","finance.Sortie");
    }

    public Sortie findById(int id)
    {
        return (Sortie)rechercher(1, String.valueOf(id))[0];
    }

    public Sortie[] findByDate(String date1, String date2)
    {
        return (Sortie[])rechercher(2, date1, date2);
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
                Sortie temp = null;
                Vector vect = new Vector();
                while(rs.next())
                {
                    temp = new Sortie(rs.getString(1), rs.getDate(2), rs.getString(3), rs.getDouble(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getInt(12), rs.getString(13),rs.getString(14),rs.getString(15),rs.getString(16),rs.getString(17));
                    vect.add(i, temp);
                    i++;
                }
                Sortie retour[] = new Sortie[i];
                vect.copyInto(retour);
                return retour;
            }
            catch(Exception s)
            {
                System.out.println("Resultat Sortie ".concat(String.valueOf(String.valueOf(s.getMessage()))));
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
                System.out.println("Erreur Fermeture SQL Sortie ".concat(String.valueOf(String.valueOf(e.getMessage()))));
            }
        }
    }
}
