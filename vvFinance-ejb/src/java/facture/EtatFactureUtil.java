// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   EtatFactureUtil.java

package facture;

import bean.GenUtil;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

// Referenced classes of package facture:
//            EtatFacture

public class EtatFactureUtil extends GenUtil
{

    public EtatFactureUtil()
    {
        setNomTable("etatFacture");
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
                EtatFacture temp = null;
                Vector vect = new Vector();
                while(rs.next())
                {
                    temp = new EtatFacture(rs.getString(1), rs.getDate(2), rs.getString(3), rs.getDouble(4), rs.getString(5), rs.getDouble(6), rs.getDouble(7), rs.getDouble(8), rs.getDouble(9), rs.getDouble(10), rs.getString(11), rs.getString(12), rs.getDouble(13), rs.getString(14), rs.getString(15), rs.getString(16));
                    vect.add(i, temp);
                    i++;
                }
                EtatFacture retour[] = new EtatFacture[i];
                for(; k < i; k++)
                    retour[k] = (EtatFacture)vect.elementAt(k);

                EtatFacture aetatfacture[] = retour;
                return aetatfacture;
            }
            catch(Exception s)
            {
                System.out.println("Resultat ".concat(String.valueOf(String.valueOf(s.getMessage()))));
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
                System.out.println("Erreur Fermeture SQL EtatFactureUtil ".concat(String.valueOf(String.valueOf(e.getMessage()))));
            }
        }
    }
}
