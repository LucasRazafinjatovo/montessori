// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   LettrageMvtUtil.java

package stock;

import bean.GenUtil;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

// Referenced classes of package finance:
//            LettrageMvt

public class LettrageMvtUtil extends GenUtil
{

    public LettrageMvtUtil()
    {
        super("LettrageMvt","stock.LettrageMvt");
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
                LettrageMvt temp = null;
                Vector vect = new Vector();
                while(rs.next())
                {
                    temp = new LettrageMvt(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4));
                    vect.add(i, temp);
                    i++;
                }
                LettrageMvt retour[] = new LettrageMvt[i];
                for(; k < i; k++)
                    retour[k] = (LettrageMvt)vect.elementAt(k);

                LettrageMvt acaisse[] = retour;
                return acaisse;
            }
            catch(Exception s)
            {
                System.out.println("LettrageMvt ".concat(String.valueOf(String.valueOf(s.getMessage()))));
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
                System.out.println("Erreur Fermeture SQL LettrageMvt ".concat(String.valueOf(String.valueOf(e.getMessage()))));
            }
        }
    }
}
