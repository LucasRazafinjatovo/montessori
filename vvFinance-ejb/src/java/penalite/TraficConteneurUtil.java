// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   TraficConteneurUtil.java

package penalite;

import bean.GenUtil;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

// Referenced classes of package penalite:
//            TraficConteneur

public class TraficConteneurUtil extends GenUtil
{

    public TraficConteneurUtil()
    {
        super.setNomTable("TraficConteneur");
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
                TraficConteneur temp = null;
                Vector vect = new Vector();
                while(rs.next())
                {
                    temp = new TraficConteneur(rs.getString(1), rs.getDate(2), rs.getDate(3), rs.getDate(4), rs.getDouble(5), rs.getString(6), rs.getString(7));
                    vect.add(i, temp);
                    i++;
                }
                TraficConteneur retour[] = new TraficConteneur[i];
                for(; k < i; k++)
                    retour[k] = (TraficConteneur)vect.elementAt(k);

                TraficConteneur atraficconteneur[] = retour;
                return atraficconteneur;
            }
            catch(Exception s)
            {
                System.out.println("TraficConteneur ".concat(String.valueOf(String.valueOf(s.getMessage()))));
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
                System.out.println("Erreur Fermeture SQL TraficConteneur ".concat(String.valueOf(String.valueOf(e.getMessage()))));
            }
        }
    }
}
