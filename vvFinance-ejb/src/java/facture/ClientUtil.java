// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   ClientUtil.java

package facture;

import bean.GenUtil;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

// Referenced classes of package facture:
//            Client

public class ClientUtil extends GenUtil
{

    public ClientUtil()
    {
        super("client");
    }

    public Client findById(int id)
    {
        return (Client)rechercher(1, String.valueOf(id))[0];
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
                Client temp = null;
                Vector vect = new Vector();
                while(rs.next())
                {
                    temp = new Client(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9), rs.getString(10), rs.getString(11));
                    vect.add(i, temp);
                    i++;
                }
                Client retour[] = new Client[i];
                for(; k < i; k++)
                    retour[k] = (Client)vect.elementAt(k);

                Client aclient[] = retour;
                return aclient;
            }
            catch(Exception s)
            {
                System.out.println("Recherche Client ".concat(String.valueOf(String.valueOf(s.getMessage()))));
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
