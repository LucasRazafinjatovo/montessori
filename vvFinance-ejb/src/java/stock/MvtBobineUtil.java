// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   MvtBobineUtil.java

package stock;

import bean.GenUtil;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

// Referenced classes of package finance:
//            MvtBobine

public class MvtBobineUtil extends GenUtil
{

    public MvtBobineUtil()
    {
        super("MvtBobine","stock.MvtBobine");
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
                MvtBobine temp = null;
                Vector vect = new Vector();
                while(rs.next())
                {
                    temp = new MvtBobine(rs.getString(1), rs.getDate(2), rs.getString(3), rs.getString(4), rs.getDouble(5), rs.getDouble(6), rs.getString(7), rs.getString(8), rs.getString(9),rs.getString(10), rs.getDouble(11) );
                    vect.add(i, temp);
                    i++;
                }
                MvtBobine retour[] = new MvtBobine[i];
                for(; k < i; k++)
                    retour[k] = (MvtBobine)vect.elementAt(k);

                MvtBobine acaisse[] = retour;
                return acaisse;
            }
            catch(Exception s)
            {
                System.out.println("MvtBobine ".concat(String.valueOf(String.valueOf(s.getMessage()))));
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
                System.out.println("Erreur Fermeture SQL MvtBobine ".concat(String.valueOf(String.valueOf(e.getMessage()))));
            }
        }
    }
}
