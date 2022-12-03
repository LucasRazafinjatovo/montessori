// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   AccidentUtil.java

package penalite;

import bean.GenUtil;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

// Referenced classes of package penalite:
//            Accident

public class AccidentUtil extends GenUtil
{

    public AccidentUtil()
    {
        super.setNomTable("Accident");
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
                Accident temp = null;
                Vector vect = new Vector();
                while(rs.next())
                {
                    temp = new Accident(rs.getString(1), rs.getDate(2), rs.getDate(3), rs.getString(4), rs.getString(5), rs.getString(6));
                    vect.add(i, temp);
                    i++;
                }
                Accident retour[] = new Accident[i];
                for(; k < i; k++)
                    retour[k] = (Accident)vect.elementAt(k);

                Accident aaccident[] = retour;
                return aaccident;
            }
            catch(Exception s)
            {
                System.out.println("Accident ".concat(String.valueOf(String.valueOf(s.getMessage()))));
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
                System.out.println("Erreur Fermeture SQL Accident ".concat(String.valueOf(String.valueOf(e.getMessage()))));
            }
        }
    }
}
