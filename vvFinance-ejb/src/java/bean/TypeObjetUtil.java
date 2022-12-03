// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   TypeObjetUtil.java
package bean;

import java.io.PrintStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

// Referenced classes of package bean:
//            GenUtil, TypeObjet
public class TypeObjetUtil extends GenUtil {

    public TypeObjetUtil() {
    }

    public TypeObjet[] findTypeObjet(String nomTable, String id, String typ)
            throws Exception {
        try {
            TypeObjetUtil to = new TypeObjetUtil();
            to.setNomTable(nomTable);
            int a[] = {
                1, 2
            };
            String val[] = new String[a.length];
            val[0] = id;
            val[1] = typ;
            TypeObjet atypeobjet[] = (TypeObjet[]) to.rechercher(a, val);
            return atypeobjet;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        }
    }

    public TypeObjet[] findTypeObjet(String nomTable, String id, String typ, Connection c)
            throws Exception {
        try {
            TypeObjetUtil to = new TypeObjetUtil();
            to.setNomTable(nomTable);
            int a[] = {
                1, 2
            };
            String val[] = new String[a.length];
            val[0] = id;
            val[1] = typ;
            TypeObjet atypeobjet[] = (TypeObjet[]) to.rechercher(a, val, c);
            return atypeobjet;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        }
    }
    
    public Object[] resultatLimit(int numBloc, ResultSet rs) {
        throw new UnsupportedOperationException("Method resultatLimit() not yet implemented.");
    }

    public Object[] resultatGen(ResultSet rs) {
        try {
            try {
                int i = 0;
                int k = 0;
                TypeObjet temp = null;
                Vector vect = new Vector();
                while (rs.next()) {
                    temp = new TypeObjet(rs.getString(1), rs.getString(2), rs.getString(3));
                    vect.add(i, temp);
                    i++;
                }
                TypeObjet retour[] = new TypeObjet[i];
                for (; k < i; k++) {
                    retour[k] = (TypeObjet) vect.elementAt(k);
                }

                TypeObjet atypeobjet[] = retour;
                return atypeobjet;
            } catch (Exception s) {
                System.out.println("Resultat ".concat(String.valueOf(String.valueOf(s.getMessage()))));
                return null;
            }
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (SQLException e) {
                System.out.println("Erreur Fermeture SQL Type Objet ".concat(String.valueOf(String.valueOf(e.getMessage()))));
            }
        }
    }
}
