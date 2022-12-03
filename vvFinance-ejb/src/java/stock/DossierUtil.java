// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   DossierUtil.java

package stock;

import bean.GenUtil;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

// Referenced classes of package finance:
//            Dossier

public class DossierUtil extends GenUtil
{

    public DossierUtil()
    {
        super("Dossier","stock.Dossier");
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
                Dossier temp = null;
                Vector vect = new Vector();
                while(rs.next())
                {
                    temp = new Dossier(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getDate(6), rs.getString(7), rs.getDouble(8), rs.getDouble(9), rs.getString(10));
                    vect.add(i, temp);
                    i++;
                }
                Dossier retour[] = new Dossier[i];
                for(; k < i; k++)
                    retour[k] = (Dossier)vect.elementAt(k);

                Dossier acaisse[] = retour;
                return acaisse;
            }
            catch(Exception s)
            {
                System.out.println("Dossier ".concat(String.valueOf(String.valueOf(s.getMessage()))));
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
                System.out.println("Erreur Fermeture SQL Dossier ".concat(String.valueOf(String.valueOf(e.getMessage()))));
            }
        }
    }
}
