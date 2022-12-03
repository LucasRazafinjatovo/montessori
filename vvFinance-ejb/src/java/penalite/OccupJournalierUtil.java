// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   OccupJournalierUtil.java

package penalite;

import bean.GenUtil;
import java.io.PrintStream;
import java.sql.*;
import java.util.Vector;

// Referenced classes of package penalite:
//            OccupJournalier

public class OccupJournalierUtil extends GenUtil
{

    public OccupJournalierUtil()
    {
        super.setNomTable("OccupJournalier");
    }

    public OccupJournalierUtil(Connection c)
    {
        super.setNomTable("OccupJournalier", c);
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
                OccupJournalier temp = null;
                Vector vect = new Vector();
                while(rs.next())
                {
                    temp = new OccupJournalier(rs.getString(1), rs.getDate(2), rs.getDouble(3));
                    vect.add(i, temp);
                    i++;
                }
                OccupJournalier retour[] = new OccupJournalier[i];
                for(; k < i; k++)
                    retour[k] = (OccupJournalier)vect.elementAt(k);

                OccupJournalier aoccupjournalier[] = retour;
                return aoccupjournalier;
            }
            catch(Exception s)
            {
                System.out.println("OccupJournalier ".concat(String.valueOf(String.valueOf(s.getMessage()))));
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
                System.out.println("Erreur Fermeture SQL OccupJournalier ".concat(String.valueOf(String.valueOf(e.getMessage()))));
            }
        }
    }
}
