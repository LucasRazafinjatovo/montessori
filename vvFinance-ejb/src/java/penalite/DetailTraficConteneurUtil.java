// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   DetailTraficConteneurUtil.java

package penalite;

import bean.GenUtil;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

// Referenced classes of package penalite:
//            DetailTraficConteneur

public class DetailTraficConteneurUtil extends GenUtil
{

    public DetailTraficConteneurUtil()
    {
        super.setNomTable("detailtraficConteneur");
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
                DetailTraficConteneur temp = null;
                Vector vect = new Vector();
                while(rs.next())
                {
                    temp = new DetailTraficConteneur(rs.getString(1), rs.getDate(2), rs.getDate(3));
                    vect.add(i, temp);
                    i++;
                }
                DetailTraficConteneur retour[] = new DetailTraficConteneur[i];
                for(; k < i; k++)
                    retour[k] = (DetailTraficConteneur)vect.elementAt(k);

                DetailTraficConteneur adetailtraficconteneur[] = retour;
                return adetailtraficconteneur;
            }
            catch(Exception s)
            {
                System.out.println("DetailTraficConteneur ".concat(String.valueOf(String.valueOf(s.getMessage()))));
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
                System.out.println("Erreur Fermeture SQL DetailTraficConteneur ".concat(String.valueOf(String.valueOf(e.getMessage()))));
            }
        }
    }
}
