// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   PointCtnUtil.java

package penalite;

import bean.GenUtil;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

// Referenced classes of package penalite:
//            PointCtn

public class PointCtnUtil extends GenUtil
{

    public PointCtnUtil()
    {
        super.setNomTable("PointCtnVue");
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
                PointCtn temp = null;
                Vector vect = new Vector();
                while(rs.next())
                {
                    temp = new PointCtn(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getDate(5), rs.getDate(6), rs.getInt(7), rs.getDate(8));
                    vect.add(i, temp);
                    i++;
                }
                PointCtn retour[] = new PointCtn[i];
                for(; k < i; k++)
                    retour[k] = (PointCtn)vect.elementAt(k);

                PointCtn apointctn[] = retour;
                return apointctn;
            }
            catch(Exception s)
            {
                System.out.println("PointCtn ".concat(String.valueOf(String.valueOf(s.getMessage()))));
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
                System.out.println("Erreur Fermeture SQL PointCtn ".concat(String.valueOf(String.valueOf(e.getMessage()))));
            }
        }
    }
}
