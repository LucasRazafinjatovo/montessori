// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   SynthesePointageUtil.java

package penalite;

import bean.GenUtil;
import java.io.PrintStream;
import java.sql.*;
import java.util.Vector;

// Referenced classes of package penalite:
//            SynthesePointage

public class SynthesePointageUtil extends GenUtil
{

    public SynthesePointageUtil()
    {
        setNomTable("SynthPointage");
    }

    public SynthesePointageUtil(Connection c)
    {
        setNomTable("SynthPointage", c);
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
                SynthesePointage temp = null;
                Vector vect = new Vector();
                while(rs.next())
                {
                    temp = new SynthesePointage(rs.getDate(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getFloat(5));
                    vect.add(i, temp);
                    i++;
                }
                SynthesePointage retour[] = new SynthesePointage[i];
                for(; k < i; k++)
                    retour[k] = (SynthesePointage)vect.elementAt(k);

                SynthesePointage asynthesepointage[] = retour;
                return asynthesepointage;
            }
            catch(Exception s)
            {
                System.out.println("Recherche SynthesePointage ".concat(String.valueOf(String.valueOf(s.getMessage()))));
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
                System.out.println("Erreur Fermeture SQL SynthesePointage ".concat(String.valueOf(String.valueOf(e.getMessage()))));
            }
        }
    }
}
