// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   TvaUtil.java

package facture;

import bean.GenUtil;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

// Referenced classes of package facture:
//            Tva

public class TvaUtil extends GenUtil
{

    public TvaUtil()
    {
        super.setNomTable("tva");
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
                Tva temp = null;
                Vector vect = new Vector();
                while(rs.next())
                {
                    temp = new Tva(rs.getString(1), rs.getInt(2), rs.getDate(3));
                    vect.add(i, temp);
                    i++;
                }
                Tva retour[] = new Tva[i];
                for(; k < i; k++)
                    retour[k] = (Tva)vect.elementAt(k);

                Tva atva[] = retour;
                return atva;
            }
            catch(Exception s)
            {
                System.out.println("Recherche Tva ".concat(String.valueOf(String.valueOf(s.getMessage()))));
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
                System.out.println("Erreur Fermeture SQL Tva ".concat(String.valueOf(String.valueOf(e.getMessage()))));
            }
        }
    }
}
