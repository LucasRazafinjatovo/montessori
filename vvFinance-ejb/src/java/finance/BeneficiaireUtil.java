// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   BeneficiaireUtil.java

package finance;

import bean.GenUtil;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

// Referenced classes of package finance:
//            Beneficiaire

public class BeneficiaireUtil extends GenUtil
{

    public BeneficiaireUtil()
    {
        super("beneficiaire");
    }

    public Beneficiaire getById(int id)
    {
        return (Beneficiaire)rechercher(1, String.valueOf(id))[0];
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
                Beneficiaire temp = null;
                Vector vect = new Vector();
                while(rs.next())
                {
                    temp = new Beneficiaire(rs.getString(1), rs.getString(2));
                    vect.add(i, temp);
                    i++;
                }
                Beneficiaire retour[] = new Beneficiaire[i];
                for(; k < i; k++)
                    retour[k] = (Beneficiaire)vect.elementAt(k);

                Beneficiaire abeneficiaire[] = retour;
                return abeneficiaire;
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
                System.out.println("Erreur Fermeture SQL HistoriqueOrdUtil ".concat(String.valueOf(String.valueOf(e.getMessage()))));
            }
        }
    }
}
