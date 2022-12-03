// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   FactureMereUtil.java

package facture;

import bean.GenUtil;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

// Referenced classes of package facture:
//            FactMere

public class FactureMereUtil extends GenUtil
{

    public FactureMereUtil()
    {
        super.setNomTable("FactureMere");
    }

    public Object[] resultatLimit(int numBloc, ResultSet rs)
    {
        throw new UnsupportedOperationException("Method resultatLimit() not yet implemented.");
    }

    public Object[] resultatGen(ResultSet rs)
    {
        try
        {
            Object obj;
            try
            {
                int i = 0;
                int k = 0;
                FactMere temp = null;
                Vector vect = new Vector();
                while(rs.next())
                {
                    temp = new FactMere(rs.getString(1), rs.getDate(2), rs.getDate(3), rs.getDate(4), rs.getString(5), rs.getString(6), rs.getInt(7), rs.getString(8), rs.getString(9), rs.getInt(10), rs.getDouble(11), rs.getString(12), rs.getDate(13), rs.getDouble(14), rs.getString(15), rs.getString(16), rs.getString(17), rs.getString(18), rs.getString(19));
                    vect.add(i, temp);
                    i++;
                }
                FactMere retour[] = new FactMere[i];
                vect.copyInto(retour);
                FactMere afactmere[] = retour;
                return afactmere;
            }
            catch(Exception s)
            {
                s.printStackTrace();
                System.out.println("Recherche dans FactMere ".concat(String.valueOf(String.valueOf(s.getMessage()))));
                obj = null;
                return null;
            }
            //return obj;
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
                System.out.println("Erreur Fermeture SQL HistoriqueOrdUtil ".concat(String.valueOf(String.valueOf(e.getMessage()))));
            }
        }
    }
}
