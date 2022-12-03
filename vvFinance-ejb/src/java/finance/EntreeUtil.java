// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   EntreeUtil.java

package finance;

import bean.GenUtil;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

// Referenced classes of package finance:
//            Entree

public class EntreeUtil extends GenUtil
{

    public EntreeUtil()
    {
        super("Entree","finance.Entree");
    }

    public Entree findById(int id)
    {
        return (Entree)rechercher(1, String.valueOf(id))[0];
    }

    public Entree[] findByDate(String date1, String date2)
    {
        return (Entree[])rechercher(2, date1, date2);
    }

    public Object[] resultatLimit(int numBloc, ResultSet rs)
    {
        throw new UnsupportedOperationException("Method resultatLimit() not yet implemented.");
    }
    public Object[] resultatGen(Vector v)
    {
      Entree retour[]=new Entree[v.size()];
      for (int i=0;i<v.size();i++)
      {
        Vector temp=(Vector)v.get(i);
        retour[i]=new Entree((String)temp.get(1), utilitaire.Utilitaire.string_date("dd/MM/yyyy",(String)temp.get(2)), (String)temp.get(3), utilitaire.Utilitaire.stringToDouble((String)temp.get(4)), (String)temp.get(5), (String)temp.get(6),(String)temp.get(7), (String)temp.get(8), (String)temp.get(9), (String)temp.get(10), (String)temp.get(11),(String)temp.get(12),utilitaire.Utilitaire.stringToInt ((String)temp.get(13)),(String)temp.get(14), (String)temp.get(15),(String)temp.get(16),(String)temp.get(17),(String)temp.get(18));
      }
      return retour;
    }
    public Object[] resultatGen(ResultSet rs)
    {
        try
        {
            try
            {
                int i = 0;
                int k = 0;
                Entree temp = null;
                Vector vect = new Vector();
                while(rs.next())
                {
                    temp = new Entree(rs.getString(1), rs.getDate(2), rs.getString(3), rs.getDouble(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(12), rs.getInt(13), rs.getString(14), rs.getString(15),rs.getString(16),rs.getString(17), rs.getString(18));
                    vect.add(i, temp);
                    i++;
                }
                Entree retour[] = new Entree[i];
                vect.copyInto(retour);
                return retour;
            }
            catch(Exception s)
            {
                System.out.println("Entree ".concat(String.valueOf(String.valueOf(s.getMessage()))));
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
                System.out.println("Erreur Fermeture SQL Entree ".concat(String.valueOf(String.valueOf(e.getMessage()))));
            }
        }
    }
}
