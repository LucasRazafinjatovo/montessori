// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   DetPenRetardUtil.java

package penalite;

import bean.GenUtil;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

// Referenced classes of package penalite:
//            DetPenRetard

public class DetPenRetardUtil extends GenUtil
{

    public DetPenRetardUtil()
    {
        super.setNomTable("DetPenRetard");
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
                DetPenRetard temp = null;
                Vector vect = new Vector();
                while(rs.next())
                {
                    temp = new DetPenRetard(rs.getString(1), rs.getString(2), rs.getDate(3), rs.getDate(4), rs.getDouble(5), rs.getInt(6), rs.getString(7), rs.getDouble(8));
                    vect.add(i, temp);
                    i++;
                }
                DetPenRetard retour[] = new DetPenRetard[i];
                for(; k < i; k++)
                    retour[k] = (DetPenRetard)vect.elementAt(k);

                DetPenRetard adetpenretard[] = retour;
                return adetpenretard;
            }
            catch(Exception s)
            {
                System.out.println("DetPenRetard ".concat(String.valueOf(String.valueOf(s.getMessage()))));
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
                System.out.println("Erreur Fermeture SQL DetPenRetard ".concat(String.valueOf(String.valueOf(e.getMessage()))));
            }
        }
    }
}
