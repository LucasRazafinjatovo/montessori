// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   DetailBobinePoidsUtil.java

package stock;

import bean.GenUtil;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

// Referenced classes of package finance:
//            DetailBobinePoids

public class DetailBobinePoidsUtil extends GenUtil
{

    public DetailBobinePoidsUtil()
    {
        super("DetailBobinePoids","stock.DetailBobinePoids");
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
                DetailBobinePoids temp = null;
                Vector vect = new Vector();
                while(rs.next())
                {
                    temp = new DetailBobinePoids(rs.getString(1), rs.getString(2), rs.getDouble(3), rs.getString(4));
                    vect.add(i, temp);
                    i++;
                }
                DetailBobinePoids retour[] = new DetailBobinePoids[i];
                for(; k < i; k++)
                    retour[k] = (DetailBobinePoids)vect.elementAt(k);

                DetailBobinePoids acaisse[] = retour;
                return acaisse;
            }
            catch(Exception s)
            {
                System.out.println("DetailBobinePoids ".concat(String.valueOf(String.valueOf(s.getMessage()))));
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
                System.out.println("Erreur Fermeture SQL DetailBobinePoids ".concat(String.valueOf(String.valueOf(e.getMessage()))));
            }
        }
    }
}
