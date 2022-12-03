// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   ChiffreAffTAcUtil.java

package penalite;

import bean.GenUtil;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

// Referenced classes of package penalite:
//            ChiffreAffTac

public class ChiffreAffTAcUtil extends GenUtil
{

    public ChiffreAffTAcUtil()
    {
        super.setNomTable("chiffreAffaireTac");
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
                ChiffreAffTac temp = null;
                Vector vect = new Vector();
                while(rs.next())
                {
                    temp = new ChiffreAffTac(rs.getString(1), rs.getInt(2), rs.getInt(3), rs.getDouble(4));
                    vect.add(i, temp);
                    i++;
                }
                ChiffreAffTac retour[] = new ChiffreAffTac[i];
                for(; k < i; k++)
                    retour[k] = (ChiffreAffTac)vect.elementAt(k);

                ChiffreAffTac achiffreafftac[] = retour;
                return achiffreafftac;
            }
            catch(Exception s)
            {
                System.out.println("ChiffreAffTac ".concat(String.valueOf(String.valueOf(s.getMessage()))));
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
                System.out.println("Erreur Fermeture SQL ChiffreAffTac ".concat(String.valueOf(String.valueOf(e.getMessage()))));
            }
        }
    }
}
