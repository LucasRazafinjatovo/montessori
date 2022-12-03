// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   ParametreFactureUtil.java

package facture;

import bean.GenUtil;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

// Referenced classes of package facture:
//            ParametreFacture

public class ParametreFactureUtil extends GenUtil
{

    public ParametreFactureUtil()
    {
        super.setNomTable("ParametreFacture");
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
                ParametreFacture temp = null;
                Vector vect = new Vector();
                while(rs.next())
                {
                    temp = new ParametreFacture(rs.getString(1), rs.getInt(2), rs.getDouble(3), rs.getInt(4), rs.getDate(5));
                    vect.add(i, temp);
                    i++;
                }
                ParametreFacture retour[] = new ParametreFacture[i];
                for(; k < i; k++)
                    retour[k] = (ParametreFacture)vect.elementAt(k);

                ParametreFacture aparametrefacture[] = retour;
                return aparametrefacture;
            }
            catch(Exception s)
            {
                System.out.println("Recherche ParametreFacture ".concat(String.valueOf(String.valueOf(s.getMessage()))));
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
                System.out.println("Erreur Fermeture SQL Historique ".concat(String.valueOf(String.valueOf(e.getMessage()))));
            }
        }
    }
}
