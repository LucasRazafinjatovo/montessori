// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   EtatCaisseUtil.java

package finance;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

// Referenced classes of package finance:
//            EtatCaisse

public class EtatCaisseUtil
{

    public EtatCaisseUtil()
    {
    }

    public EtatCaisse[] findEtatCaisse(String daty1, String daty2, String caisse)
    {
        return null;
    }

    public static EtatCaisse[] result(ResultSet rs)
    {
        int k = 0;
        int i = 0;
        Vector vect = new Vector();
        EtatCaisse aetatcaisse1[];
        try
        {
            while(rs.next())
            {
                EtatCaisse temp = new EtatCaisse(rs.getString(1), rs.getDouble(2), rs.getString(3), rs.getString(4));
                vect.add(i, temp);
                i++;
            }
            EtatCaisse retour[] = new EtatCaisse[i];
            vect.copyInto(retour);
            return retour;
        }
        catch(SQLException ex)
        {
          return null;
        }
        finally
        {
          try {
            rs.close();
          }
          catch (SQLException ex) {
          }
        }
    }
}
