// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   VerificationUtil.java

package stock;

import bean.GenUtil;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

// Referenced classes of package finance:
//            Verification

public class VerificationUtil extends GenUtil
{

    public VerificationUtil()
    {
        super("Verification","stock.Verification");
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
                Verification temp = null;
                Vector vect = new Vector();
                while(rs.next())
                {
                    temp = new Verification(rs.getString(1), rs.getDate(2), rs.getString(3),rs.getDouble(4), rs.getString(5), rs.getString(6), rs.getString(7));
                    vect.add(i, temp);
                    i++;
                }
                Verification retour[] = new Verification[i];
                for(; k < i; k++)
                    retour[k] = (Verification)vect.elementAt(k);

                Verification acaisse[] = retour;
                return acaisse;
            }
            catch(Exception s)
            {
                System.out.println("Verification ".concat(String.valueOf(String.valueOf(s.getMessage()))));
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
                System.out.println("Erreur Fermeture SQL Verification ".concat(String.valueOf(String.valueOf(e.getMessage()))));
            }
        }
    }
}
