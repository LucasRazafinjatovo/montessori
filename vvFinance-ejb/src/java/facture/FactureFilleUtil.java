// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   FactureFilleUtil.java

package facture;

import bean.GenUtil;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

// Referenced classes of package facture:
//            FactureFille

public class FactureFilleUtil extends GenUtil
{

    public FactureFilleUtil()
    {
        super("FactureFille");
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
                FactureFille temp = null;
                Vector vect = new Vector();
                while(rs.next())
                {
                    temp = new FactureFille(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getDouble(5), rs.getString(6), rs.getDouble(7), rs.getInt(8));
                    vect.add(i, temp);
                    i++;
                }
                FactureFille retour[] = new FactureFille[i];
                for(; k < i; k++)
                    retour[k] = (FactureFille)vect.elementAt(k);

                FactureFille afacturefille[] = retour;
                return afacturefille;
            }
            catch(Exception s)
            {
              System.out.println("Recherche FactureFille ".concat(String.valueOf(String.valueOf(s.getMessage()))));
              return null;
            }
            /*Object obj = null;
            return obj;*/
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
                System.out.println("Erreur Fermeture SQL FactureFille ".concat(String.valueOf(String.valueOf(e.getMessage()))));
            }
        }
    }
}
