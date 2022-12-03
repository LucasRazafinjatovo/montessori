// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   PoidsFeuilleUtil.java

package stock;

import bean.GenUtil;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

// Referenced classes of package finance:
//            PoidsFeuille

public class PoidsFeuilleUtil extends GenUtil
{

    public PoidsFeuilleUtil()
    {
        super("PoidsFeuille","stock.PoidsFeuille");
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
                PoidsFeuille temp = null;
                Vector vect = new Vector();
                while(rs.next())
                {
                    temp = new PoidsFeuille(rs.getString(1));
                    vect.add(i, temp);
                    i++;
                }
                PoidsFeuille retour[] = new PoidsFeuille[i];
                for(; k < i; k++)
                    retour[k] = (PoidsFeuille)vect.elementAt(k);

                PoidsFeuille acaisse[] = retour;
                return acaisse;
            }
            catch(Exception s)
            {
                System.out.println("PoidsFeuille ".concat(String.valueOf(String.valueOf(s.getMessage()))));
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
                System.out.println("Erreur Fermeture SQL PoidsFeuille ".concat(String.valueOf(String.valueOf(e.getMessage()))));
            }
        }
    }
}
