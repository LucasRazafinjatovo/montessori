// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   SyntheseEVPUtil.java

package facture;

import bean.GenUtil;
import java.io.PrintStream;
import java.sql.*;
import java.util.Vector;

// Referenced classes of package facture:
//            SyntheseEVP

public class SyntheseEVPUtil extends GenUtil
{

    public SyntheseEVPUtil()
    {
        super.setNomTable("syntheseEVP");
    }

    public SyntheseEVPUtil(Connection c)
    {
        super.setNomTable("syntheseEVP", c);
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
                SyntheseEVP temp = null;
                Vector vect = new Vector();
                while(rs.next())
                {
                    temp = new SyntheseEVP(rs.getDate(1), rs.getInt(2), rs.getInt(3));
                    vect.add(i, temp);
                    i++;
                }
                SyntheseEVP retour[] = new SyntheseEVP[i];
                for(; k < i; k++)
                    retour[k] = (SyntheseEVP)vect.elementAt(k);

                SyntheseEVP asyntheseevp[] = retour;
                return asyntheseevp;
            }
            catch(Exception s)
            {
                System.out.println("Recherche SyntheseEVP ".concat(String.valueOf(String.valueOf(s.getMessage()))));
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
                System.out.println("Erreur Fermeture SQL SyntheseEVP ".concat(String.valueOf(String.valueOf(e.getMessage()))));
            }
        }
    }
}
