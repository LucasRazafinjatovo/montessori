// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   EcritureUtil.java

package facture;

import bean.GenUtil;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

// Referenced classes of package facture:
//            Ecriture

public class EcritureUtil extends GenUtil
{

    public EcritureUtil()
    {
        super.setNomTable("EcritureCompte");
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
                Ecriture temp = null;
                Vector vect = new Vector();
                while(rs.next())
                {
                    temp = new Ecriture(rs.getDate(2), rs.getString(3), rs.getString(4), rs.getDouble(5), rs.getDouble(6), rs.getString(7), rs.getString(1));
                    vect.add(i, temp);
                    i++;
                }
                Ecriture retour[] = new Ecriture[i];
                for(; k < i; k++)
                    retour[k] = (Ecriture)vect.elementAt(k);

                Ecriture aecriture[] = retour;
                return aecriture;
            }
            catch(Exception s)
            {
                System.out.println("Resultat Ecriture".concat(String.valueOf(String.valueOf(s.getMessage()))));
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
                System.out.println("Erreur Fermeture SQL Ecriture ".concat(String.valueOf(String.valueOf(e.getMessage()))));
            }
        }
    }
}
