// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   EscaleUtil.java

package penalite;

import bean.GenUtil;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

// Referenced classes of package penalite:
//            Escale

public class EscaleUtil extends GenUtil
{

    public EscaleUtil()
    {
        super.setNomTable("EscaleVue");
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
                Escale temp = null;
                Vector vect = new Vector();
                while(rs.next())
                {
                    temp = new Escale(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getDate(5), rs.getDate(6), rs.getDate(7), rs.getDate(8), rs.getString(9));
                    vect.add(i, temp);
                    i++;
                }
                Escale retour[] = new Escale[i];
                for(; k < i; k++)
                    retour[k] = (Escale)vect.elementAt(k);

                Escale aescale[] = retour;
                return aescale;
            }
            catch(Exception s)
            {
                System.out.println("Escale ".concat(String.valueOf(String.valueOf(s.getMessage()))));
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
                System.out.println("Erreur Fermeture SQL Escale ".concat(String.valueOf(String.valueOf(e.getMessage()))));
            }
        }
    }
}
