// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   SCatServiceUtil.java

package facture;

import bean.GenUtil;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

// Referenced classes of package facture:
//            SCatService

public class SCatServiceUtil extends GenUtil
{

    public SCatServiceUtil()
    {
        super("ScatService");
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
                SCatService temp = null;
                Vector vect = new Vector();
                while(rs.next())
                {
                    temp = new SCatService(rs.getString(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getString(5));
                    vect.add(i, temp);
                    i++;
                }
                SCatService retour[] = new SCatService[i];
                for(; k < i; k++)
                    retour[k] = (SCatService)vect.elementAt(k);

                SCatService ascatservice[] = retour;
                return ascatservice;
            }
            catch(Exception s)
            {
                System.out.println("Recherche SCatService ".concat(String.valueOf(String.valueOf(s.getMessage()))));
                return null;
            }
            /*Object obj = null;
            return obj;*/
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
                System.out.println("Erreur Fermeture SQL SCatService ".concat(String.valueOf(String.valueOf(e.getMessage()))));
            }
        }
    }
}
