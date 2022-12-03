package bean;

import java.sql.*;
import java.util.Vector;
import utilitaire.Utilitaire;
import java.lang.reflect.Field;
import utilitaire.UtilDB;
import historique.MapHistorique;
import utilitaire.Parametre;
import java.lang.reflect.*;

/**
 * <p>
 * Title: Gestion des recettes </p>
 * <p>
 * Description: </p>
 * <p>
 * Copyright: Copyright (c) 2005</p>
 * <p>
 * Company: </p>
 *
 * @author unascribed
 * @version 1.0
 */
public class CGenUtil {

    public CGenUtil() {
    }

    public static String getListeChampPage(ClassMAPTable e, Connection c) throws Exception {
        String retour = "";
        Champ[] liste = ListeColonneTable.getFromListe(e, c);
        if (liste.length == 0) {
            throw new Exception("Table non existante");
        }
        retour = liste[0].getNomColonne();
        for (int i = 1; i < liste.length; i++) {
            retour = retour + "," + liste[i].getNomColonne();
        }
        return retour;
    }

    public static String getListeChampGroupeSomme(String[] groupe, String[] somme) throws Exception {
        if (groupe == null || groupe.length == 0) {
            return "*";
        }
        String retour = groupe[0];
        for (int i = 1; i < groupe.length; i++) {
            if (groupe[i] != null && groupe[i].compareToIgnoreCase("") != 0 && groupe[i].compareToIgnoreCase("-") != 0) {
                retour = retour + "," + groupe[i];
            }
        }
        if (somme == null) {
            return retour;
        }
        for (int j = 0; j < somme.length; j++) {
            if (somme[j] != null && somme[j].compareToIgnoreCase("") != 0 && somme[j].compareToIgnoreCase("-") != 0) {
                retour = retour + ", sum(" + somme[j] + ") as " + somme[j];
            }
        }
        return retour;
    }

    public static String getListeChampGroupeSommeMoyenne(String[] groupe, String[] somme, String[] moyenne) throws Exception {
        //System.out.println(" nandalo getListeChampGroupeSommeMoyenne moyenne.length ======== " + moyenne.length);
        if (groupe == null || groupe.length == 0) {
            return "*";
        }
        String retour = groupe[0];
        for (int i = 1; i < groupe.length; i++) {
            if (groupe[i] != null && groupe[i].compareToIgnoreCase("") != 0 && groupe[i].compareToIgnoreCase("-") != 0) {
                retour = retour + "," + groupe[i];
            }
        }
        if (somme == null) {
            return retour;
        }
        for (int j = 0; j < somme.length; j++) {
            if (somme[j] != null && somme[j].compareToIgnoreCase("") != 0 && somme[j].compareToIgnoreCase("-") != 0) {
                retour = retour + ", sum(" + somme[j] + ") as " + somme[j];
            }
        }
        if (moyenne == null) {
            return retour;
        }
        for (int j = 0; j < moyenne.length; j++) {
            if (moyenne[j] != null && moyenne[j].compareToIgnoreCase("") != 0 && moyenne[j].compareToIgnoreCase("-") != 0) {
                retour = retour + ", avg(" + moyenne[j] + ") as " + moyenne[j];
            }
        }
        return retour;
    }

    public static String getListeChampGroupeSimple(String[] groupe, String[] somme) throws Exception {
        if (groupe == null) {
            return "*";
        }
        String retour = groupe[0];
        for (int i = 1; i < groupe.length; i++) {
            if (groupe[i] != null && groupe[i].compareToIgnoreCase("") != 0 && groupe[i].compareToIgnoreCase("-") != 0) {
                retour = retour + "," + groupe[i];
            }
        }
        if (somme == null) {
            return retour;
        }
        for (int j = 0; j < somme.length; j++) {
            if (somme[j] != null && somme[j].compareToIgnoreCase("") != 0 && somme[j].compareToIgnoreCase("-") != 0) {
                retour = retour + ", " + somme[j];
            }
        }
        return retour;
    }

    public static String getListeChampGroupeSimple(String[] groupe, String[] somme, String[] moyenne) throws Exception {
        if (groupe == null) {
            return "*";
        }
        String retour = groupe[0];
        for (int i = 1; i < groupe.length; i++) {
            if (groupe[i] != null && groupe[i].compareToIgnoreCase("") != 0 && groupe[i].compareToIgnoreCase("-") != 0) {
                retour = retour + "," + groupe[i];
            }
        }
        if (somme == null) {
            return retour;
        }
        for (int j = 0; j < somme.length; j++) {
            if (somme[j] != null && somme[j].compareToIgnoreCase("") != 0 && somme[j].compareToIgnoreCase("-") != 0) {
                retour = retour + ", " + somme[j];
            }
        }
        if (moyenne == null) {
            return retour;
        }
        for (int j = 0; j < moyenne.length; j++) {
            if (moyenne[j] != null && moyenne[j].compareToIgnoreCase("") != 0 && moyenne[j].compareToIgnoreCase("-") != 0) {
                retour = retour + ", " + moyenne[j];
            }
        }
        return retour;
    }

    public static ResultatEtSomme rechercherGroupe(ClassMAPTable e, String[] groupe, String[] sommeGroupe, String[] colInt, String[] valInt, String apresWhere, String[] nomColSomme, String ordre, Connection c) throws Exception {
        ResultSet dr = null;
        Statement st = null;
        boolean ouvertInterne = false;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                ouvertInterne = true;
            }
            String selectInterne = "select " + getListeChampGroupeSomme(groupe, sommeGroupe) + " from " + e.getNomTableSelect() + " where " + makeWhere(e) + makeWhereIntervalle(colInt, valInt) + " " + apresWhere + " group by " + getListeChampGroupeSomme(groupe, null) + " " + ordre;
            String comande = "select * from (select " + getListeChampGroupeSimple(groupe, sommeGroupe) + ",rowNum as r from (" + selectInterne + "))";
            //System.out.print(" ==== ++++++ ===== 1212 " + comande);
            st = c.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            //if(e.getNomTableSelect().compareToIgnoreCase("ANALYSEPREVISIONEFFECTIFGROUPE")==0)
            //System.out.println("comande==>"+comande);
            dr = st.executeQuery(comande);
            Object[] resultat = transformeDataReader(dr, e, c);
            double[] somme = calculSommeNombreGroupe(selectInterne, nomColSomme, c);
            ResultatEtSomme rs = new ResultatEtSomme(resultat, somme);
            //rs.setResultatCaste(resultat);
            return rs;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception("Erreur durant la recherche groupee " + ex.getMessage());
        } finally {
            if (ouvertInterne == true && c != null) {
                c.close();
            }
            if (dr != null) {
                dr.close();
            }
            if (st != null) {
                st.close();
            }
        }
    }

    public static double[] calculSommeNombreGroupe(String selectInterne, String[] nomColSomme, Connection c) throws Exception {
        ResultSet dr = null;
        try {
            String param = null;
            if (nomColSomme == null) {
                param = "SELECT COUNT(*) FROM (" + selectInterne + ")";
            } else {
                param = "SELECT " + getColonneSomme(nomColSomme) + ",COUNT(*) FROM (" + selectInterne + ")";
            }
            Statement st = c.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            dr = st.executeQuery(param);
            double[] retour = null;
            if (nomColSomme == null) {
                retour = new double[1];
            } else {
                retour = new double[nomColSomme.length + 1];
            }
            dr.next();
            int i = 0;
            for (i = 0; i < retour.length - 1; i++) {
                retour[i] = dr.getDouble(i + 1);// getDouble(i + 1);
            }
            retour[i] = dr.getDouble(i + 1);//pour avoir le nombre de ligne
            return retour;
        } catch (Exception s) {
            s.printStackTrace();
            throw new Exception(s.getMessage());
        } finally {
            if (dr != null) {
                dr.close();
            }
        }
    }

    public static double[] calculSommeNombreMultiple(ClassMAPTable e, String apresWhere, String[] numChampDaty, String[] daty, String[] nomColSomme, Connection c) throws Exception {
        ResultSet dr = null;
        Statement st = null;
        try {
            String param = null;
            if (nomColSomme == null) {
                param = "SELECT COUNT(*) FROM " + e.getNomTableSelect() + " WHERE " + makeWhereOr(e) + " " + makeWhereIntervalle(numChampDaty, daty) + " " + apresWhere;
            } else {
                param = "SELECT " + getColonneSomme(nomColSomme) + ",COUNT(*) FROM " + e.getNomTableSelect() + " WHERE " + makeWhereOr(e) + " " + makeWhereIntervalle(numChampDaty, daty) + " " + apresWhere;
            }
            st = c.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            dr = st.executeQuery(param);
            double[] retour = null;
            if (nomColSomme == null) {
                retour = new double[1];
            } else {
                retour = new double[nomColSomme.length + 1];
            }
            dr.next();
            int i = 0;
            for (i = 0; i < retour.length - 1; i++) {
                retour[i] = dr.getDouble(i + 1);// getDouble(i + 1);
            }
            retour[i] = dr.getDouble(i + 1);//pour avoir le nombre de ligne
            return retour;
        } catch (Exception s) {
            s.printStackTrace();
            throw new Exception(s.getMessage());
        } finally {
            if (st != null) {
                st.close();
            }
            if (dr != null) {
                dr.close();
            }
        }
    }

    public static double[] calculSommeNombre(ClassMAPTable e, String apresWhere, String[] numChampDaty, String[] daty, String[] nomColSomme, Connection c) throws Exception {
        ResultSet dr = null;
        Statement st = null;
        try {
            String param = null;
            if (nomColSomme == null) {
                param = "SELECT COUNT(*) FROM " + e.getNomTableSelect() + " WHERE " + makeWhere(e) + " " + makeWhereIntervalle(numChampDaty, daty) + " " + apresWhere;
            } else {
                param = "SELECT " + getColonneSomme(nomColSomme) + ",COUNT(*) FROM " + e.getNomTableSelect() + " WHERE " + makeWhere(e) + " " + makeWhereIntervalle(numChampDaty, daty) + " " + apresWhere;
            }
            st = c.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            dr = st.executeQuery(param);
            double[] retour = null;
            if (nomColSomme == null) {
                retour = new double[1];
            } else {
                retour = new double[nomColSomme.length + 1];
            }
            dr.next();
            int i = 0;
            for (i = 0; i < retour.length - 1; i++) {
                retour[i] = dr.getDouble(i + 1);// getDouble(i + 1);
            }
            retour[i] = dr.getDouble(i + 1);//pour avoir le nombre de ligne
            return retour;
        } catch (Exception s) {
            s.printStackTrace();
            throw new Exception(s.getMessage());
        } finally {
            if (st != null) {
                st.close();
            }
            if (dr != null) {
                dr.close();
            }
        }
    }

    public static String getColonneSomme(String[] listeCol) {
        if ((listeCol == null) || (listeCol.length == 0)) {
            return "0";
        }
        String retour = "sum(" + listeCol[0] + ")";
        for (int i = 1; i < listeCol.length; i++) {
            retour = retour + ",sum(" + listeCol[i] + ")";
        }
        return retour;
    }

    /*public static String getValChamp(ClassMAPTable e, Champ liste)
  {
    Object g = e.GetType().GetProperty(Utilitaire.majDebut(liste.getNom().ToLower())).GetValue(e, null);
    if (liste.getType() == "DATE")
    {
      DateTime f = (DateTime)(g);
      if (f == DateTime.MinValue)
      {
        //f = DateTime.Now;
        return "";
      }
      return f.ToShortDateString();
    }
    if (liste.getNom() == "REFE")
    {
      String re = (String)g;
      if((re==null)||(re==""))
      {
        return e.Code;
      }
    }
    if (g == null)
      return null;
    return g.ToString().Replace("'","''");
  }*/
    public static String makePK(ClassMAPTable e, Connection c) {
        int maxSeq = Utilitaire.getMaxSeq(e.getNomProcedureSequence());
        String nombre = Utilitaire.completerInt(e.getLonguerClePrimaire(), maxSeq);
        return e.getINDICE_PK() + nombre;
    }

    public static ClassMAPTable saveWithPKSeq(ClassMAPTable e, Connection c) throws Exception {
        makePK(e, c);
        return save(e, c);
    }

    public static ClassMAPTable save(ClassMAPTable e) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            return save(e, c);
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public static ClassMAPTable save(ClassMAPTable e, Connection c) throws Exception {
        try {
            Statement cmd = null;
            Champ[] listeC = ListeColonneTable.getFromListe(e, c);
            //makePkRang(e, dt);
            String comande = "insert into " + e.getNomTable() + " values (";
            comande = comande + "'" + getValeurFieldByMethod(e, listeC[0].getNomColonne()) + "'";
            for (int i = 1; i < listeC.length; i++) {
                comande = comande + ",";
                if (getValeurFieldByMethod(e, listeC[i].getNomColonne()) == null) {
                    comande = comande + " null ";
                } else {
                    comande = comande + "'" + getValeurFieldByMethod(e, listeC[i].getNomColonne()) + "'";
                }
            }
            comande = comande + ")";
            cmd = c.createStatement();

            cmd.executeUpdate(comande);
            return e;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        }
    }

    public static Object[] rechercher(ClassMAPTable e, String[] colInt, String[] valInt, String apresWhere) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            return rechercher(e, colInt, valInt, c, apresWhere);
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public static Object[] rechercherSommeIntegrale(ClassMAPTable e, String[] colInt, String[] valInt, String apresWhere, String[] liste) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            return rechercherSommeIntegrale(e, colInt, valInt, c, apresWhere, liste);
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public static String miseajourDifferentTable(String nomTable, String valcritere, String cc, String colonneamodifier, String critere) throws Exception {
        Connection c = null;
        PreparedStatement pst = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            String sql = "UPDATE " + nomTable + " SET " + colonneamodifier + "=? WHERE " + critere + "=?";
            pst = c.prepareStatement(sql);
            pst.setString(1, cc);
            pst.setString(2, valcritere);
            pst.executeUpdate();
            c.commit();
        } catch (Exception ex) {
            ex.printStackTrace();
            c.rollback();
            throw ex;
        } finally {
            pst.close();
            if (c != null) {
                c.close();
            }
        }
        return null;
    }
    
    public static String miseajourDifferentTable(Connection c, String nomTable, String valcritere, String cc, String colonneamodifier, String critere) throws Exception {
        PreparedStatement pst = null;
        try {
            String sql = "UPDATE " + nomTable + " SET " + colonneamodifier + "=? WHERE " + critere + "=?";
            pst = c.prepareStatement(sql);
            pst.setString(1, cc);
            pst.setString(2, valcritere);
            pst.executeUpdate();
            //c.commit();
        } catch (Exception ex) {
            ex.printStackTrace();
            throw ex;
        } 
		finally{
			if(pst != null)
				pst.close();
		}
        return null;
    }

    public static String modifLC(String nomTable, String valcritere, String cc, String numFacture) throws Exception {
        Connection c = null;
        PreparedStatement pst = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            String sql = "UPDATE " + nomTable + " SET id2=? WHERE id2=? and id1='" + numFacture + "'";
            pst = c.prepareStatement(sql);
            pst.setString(1, cc);
            pst.setString(2, valcritere);
            pst.executeUpdate();
            c.commit();
        } catch (Exception ex) {
            ex.printStackTrace();
            c.rollback();
            throw ex;
        } finally {
            pst.close();
            if (c != null) {
                c.close();
            }
        }
        return null;
    }

    public static String modifClient(Connection c, String nomTable, String nom, String regime, String adr, String tel, String fax, String numstat, String nif, String rc, String tp, String quittance, String cc) throws Exception {
        PreparedStatement pst = null;
        try {
            
            String sql = "UPDATE " + nomTable + " SET nom=?, idregime=?, adresse=?, telephone=?,fax=?,numstat=?,nif=?,rc=?,tp=?,quittance=? WHERE idclient='" + cc + "'";
            pst = c.prepareStatement(sql);
            pst.setString(1, nom);
            pst.setString(2, regime);
            pst.setString(3, adr);
            pst.setString(4, tel);
            pst.setString(5, fax);
            pst.setString(6, numstat);
            pst.setString(7, nif);
            pst.setString(8, rc);
            pst.setString(9, tp);
            pst.setString(10, quittance);
            pst.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
            throw ex;
        } 
        return null;
    }
    
    public static String modifClient(String nomTable, String nom, String regime, String adr, String tel, String fax, String numstat, String nif, String rc, String tp, String quittance, String cc) throws Exception {
        Connection c = null;
        PreparedStatement pst = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            String sql = "UPDATE " + nomTable + " SET nom=?, idregime=?, adresse=?, telephone=?,fax=?,numstat=?,nif=?,rc=?,tp=?,quittance=? WHERE idclient='" + cc + "'";
            pst = c.prepareStatement(sql);
            pst.setString(1, nom);
            pst.setString(2, regime);
            pst.setString(3, adr);
            pst.setString(4, tel);
            pst.setString(5, fax);
            pst.setString(6, numstat);
            pst.setString(7, nif);
            pst.setString(8, rc);
            pst.setString(9, tp);
            pst.setString(10, quittance);
            pst.executeUpdate();
            c.commit();
        } catch (Exception ex) {
            ex.printStackTrace();
            c.rollback();
            throw ex;
        } finally {
            pst.close();
            if (c != null) {
                c.close();
            }
        }
        return null;
    }

    public static Object[] rechercher(ClassMAPTable e, String[] colInt, String[] valInt, Connection c, String apresWhere) throws Exception {
        ResultSet dr = null;
        Statement cmd = null;
        try {
            String comandeInterne = "select * from " + e.getNomTableSelect();
            comandeInterne = comandeInterne + " where " + makeWhere(e) + makeWhereIntervalle(colInt, valInt) + " " + apresWhere;
            System.out.println(comandeInterne);
            cmd = c.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            dr = cmd.executeQuery(comandeInterne);
            System.out.println(comandeInterne);
            return transformeDataReader(dr, e, c);
        } catch (Exception x) {
            x.printStackTrace();
            throw new Exception("Erreur durant la recherche " + x.getMessage());
        } finally {
            if (dr != null) {
                dr.close();
            }
            if (cmd != null) {
                cmd.close();
            }
        }
    }

    public static Object[] rechercherOr(ClassMAPTable e, String[] colInt, String[] valInt, String[] colOr, String[][] valOr, Connection c, String apresWhere) throws Exception {
        ResultSet dr = null;
        Statement cmd = null;
        try {
            String comandeInterne = "select * from " + e.getNomTableSelect();
            comandeInterne = comandeInterne + " where " + makeWhere(e) + makeWhereIntervalle(colInt, valInt) + " " + apresWhere;
            cmd = c.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            dr = cmd.executeQuery(comandeInterne);
            return transformeDataReader(dr, e, c);
        } catch (Exception x) {
            x.printStackTrace();
            throw new Exception("Erreur durant la recherche " + x.getMessage());
        } finally {
            if (dr != null) {
                dr.close();
            }
            if (cmd != null) {
                cmd.close();
            }
        }
    }

    public static Object[] rechercherSommeIntegrale(ClassMAPTable e, String[] colInt, String[] valInt, Connection c, String apresWhere, String[] liste) throws Exception {
        ResultSet dr = null;
        Statement cmd = null;
        try {
            String sum = "sum(" + liste[0] + ") as " + liste[0] + "";
            for (int i = 1; i < liste.length; i++) {
                sum = sum + ", sum(" + liste[i] + ") as " + liste[i] + "";
            }
            String comandeInterne = "select " + sum + " from  " + e.getNomTableSelect();
            comandeInterne = comandeInterne + " where " + makeWhere(e) + makeWhereIntervalle(colInt, valInt) + " " + apresWhere;
            cmd = c.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            dr = cmd.executeQuery(comandeInterne);
            return transformeDataReader(dr, e, c);
            //return null;
        } catch (Exception x) {
            x.printStackTrace();
            throw new Exception("Erreur durant la recherche " + x.getMessage());
        } finally {
            if (dr != null) {
                dr.close();
            }
            if (cmd != null) {
                cmd.close();
            }
        }
    }

    public static String rechercherRequete(ClassMAPTable e, String[] colInt, String[] valInt, Connection c, String apresWhere, String[] liste) throws Exception {
        String sum = "sum(" + liste[0] + ") as " + liste[0] + "";
        for (int i = 1; i < liste.length; i++) {
            sum = sum + ", sum(" + liste[i] + ") as " + liste[i] + "";
        }
        String comandeInterne = "select " + sum + " from  " + e.getNomTableSelect();
        comandeInterne = comandeInterne + " where " + makeWhere(e) + makeWhereIntervalle(colInt, valInt) + " " + apresWhere;
        return comandeInterne;
    }

    public static ResultatEtSomme rechercherPage(ClassMAPTable e, String[] colInt, String[] valInt, int numPage, String apresWhere, String[] nomColSomme, String colOrdre, String ordre) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            if ((colOrdre == null) || (colOrdre.compareToIgnoreCase("") == 0)) {
                colOrdre = e.getAttributIDName();
                ordre = "DESC";
            }
            apresWhere = apresWhere + " order by " + colOrdre + " " + ordre;

            return rechercherPage(e, colInt, valInt, numPage, apresWhere, nomColSomme, c);
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public static ResultatEtSomme rechercherPage(ClassMAPTable e, String[] colInt, String[] valInt, int numPage, String apresWhere, String[] nomColSomme) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            return rechercherPage(e, colInt, valInt, numPage, apresWhere, nomColSomme, c);
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public static Object[] copierPartiel(Object[] o, int iInf, int iSup) {
        Object[] retour = new Object[iSup - iInf + 1];
        for (int i = iInf; i < iSup || i < o.length; i++) {
            retour[i] = o[i];
        }
        return retour;
    }

    public static String[] separerOrderBy(String apresWhere) {
        String[] retour = new String[2];
        retour[0] = "";
        retour[1] = apresWhere;
        char[] cv = apresWhere.toCharArray();
        if (apresWhere == null || apresWhere.compareTo("") == 0) {
            /*retour[0]="";
      colOrdre=e.getAttributIDName();
        ordre="DESC";*/
        }
        for (int i = 0; i < cv.length; i++) {
            if (utilitaire.UtilitaireString.testMotDansUnePhrase(apresWhere, i, "order") == true) {
                retour[0] = apresWhere.substring(0, i);
                retour[1] = apresWhere.substring(i, apresWhere.length());
                return retour;
            }
        }
        return retour;
    }

    public static ResultatEtSomme rechercherPage(ClassMAPTable e, String[] colInt, String[] valInt, int numPage, String apresWhere, String[] nomColSomme, Connection c, int nbPage) throws Exception {
        ResultSet dr = null;
        Statement st = null;
        try {
            int npp = 0;
            if (nbPage <= 0) {
                npp = Parametre.getNbParPage();//(ParamDossier.getParam("%")).getNombrePage();
            } else {
                npp = nbPage;
            }
            int indiceInf = (npp * (numPage - 1)) + 1;
            int indiceSup = npp * (numPage);

            String comande = "select * from (select " + getListeChampPage(e, c) + ",rowNum as r from (select * from " + e.getNomTableSelect() + " where " + makeWhere(e) + makeWhereIntervalle(colInt, valInt) + " " + apresWhere + ")) where r between " + indiceInf + " and " + indiceSup;
            //String comande = "select * from (select " + getListeChampPage(e, c) + ",rowNum as r from " + e.getNomTableSelect() + " where " + makeWhere(e) + makeWhereIntervalle(colInt, valInt) + " " + apresWhere + ") where r between " + indiceInf + " and " + indiceSup;
            //if(e.getNomTableSelect().compareToIgnoreCase("Oppayelc")==0||e.getNomTableSelect().compareToIgnoreCase("pubcomplet")==0)
            st = c.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            //System.out.println("\n" + comande);
            dr = st.executeQuery(comande);
            Object[] resultat = transformeDataReader(dr, e, c);
            double[] somme = calculSommeNombreMultiple(e, apresWhere, colInt, valInt, nomColSomme, c);
            ResultatEtSomme rs = new ResultatEtSomme(resultat, somme);
            //rs.setResultatCaste(resultat);
            return rs;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception("Erreur durant la recherche pagine de la table " + e.getNomTableSelect() + ex.getMessage());
        } finally {
            if (dr != null) {
                dr.close();
            }
            if (st != null) {
                st.close();
            }
        }
    }

    public static ResultatEtSomme rechercherPageMultiple(ClassMAPTable e, String[] colInt, String[] valInt, int numPage, String apresWhere, String[] nomColSomme, Connection c, int nbPage) throws Exception {
        ResultSet dr = null;
        Statement st = null;
        try {
            int npp = 0;
            if (nbPage <= 0) {
                npp = Parametre.getNbParPage();//(ParamDossier.getParam("%")).getNombrePage();
            } else {
                npp = nbPage;
            }
            int indiceInf = (npp * (numPage - 1)) + 1;
            int indiceSup = npp * (numPage);

            String comande = "select * from (select " + getListeChampPage(e, c) + ",rowNum as r from (select * from " + e.getNomTableSelect() + " where " + makeWhereOr(e) + makeWhereIntervalle(colInt, valInt) + " " + apresWhere + ")) where r between " + indiceInf + " and " + indiceSup;
            //String comande = "select * from (select " + getListeChampPage(e, c) + ",rowNum as r from " + e.getNomTableSelect() + " where " + makeWhere(e) + makeWhereIntervalle(colInt, valInt) + " " + apresWhere + ") where r between " + indiceInf + " and " + indiceSup;
            //if(e.getNomTableSelect().compareToIgnoreCase("Oppayelc")==0||e.getNomTableSelect().compareToIgnoreCase("pubcomplet")==0)
            //System.out.println(" liste liste 1214 " + comande);
            st = c.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            dr = st.executeQuery(comande);
            Object[] resultat = transformeDataReader(dr, e, c);
            double[] somme = calculSommeNombreMultiple(e, apresWhere, colInt, valInt, nomColSomme, c);
            ResultatEtSomme rs = new ResultatEtSomme(resultat, somme);
            //rs.setResultatCaste(resultat);
            return rs;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception("Erreur durant la recherche pagine de la table " + e.getNomTableSelect() + ex.getMessage());
        } finally {
            if (dr != null) {
                dr.close();
            }
            if (st != null) {
                st.close();
            }
        }
    }

    public static ResultatEtSomme rechercherPage(ClassMAPTable e, String[] colInt, String[] valInt, int numPage, String apresWhere, String[] nomColSomme, Connection c) throws Exception {
        return rechercherPage(e, colInt, valInt, numPage, apresWhere, nomColSomme, c, 0);
    }

    public static ResultatEtSomme rechercherPageGroupe(ClassMAPTable e, String[] groupe, String[] sommeGroupe, String[] colInt, String[] valInt, int numPage, String apresWhere, String[] nomColSomme, String ordre, Connection c) throws Exception {
        return rechercherPageGroupe(e, groupe, sommeGroupe, colInt, valInt, numPage, apresWhere, nomColSomme, ordre, c, 0);
    }

    public static ResultatEtSomme rechercherPageGroupe(ClassMAPTable e, String[] groupe, String[] sommeGroupe, String[] moyenneGroupe, String[] colInt, String[] valInt, int numPage, String apresWhere, String[] nomColSomme, String ordre, Connection c, int nppa) throws Exception {
        ResultSet dr = null;
        Statement st = null;
        boolean ouvertInterne = false;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                ouvertInterne = true;
            }
            int npp;
            if (nppa <= 0) {
                npp = Parametre.getNbParPage();//(ParamDossier.getParam("%")).getNombrePage();
            } else {
                npp = nppa;
            }
            int indiceInf = (npp * (numPage - 1)) + 1;
            int indiceSup = npp * (numPage);

            String selectInterne = "select " + getListeChampGroupeSommeMoyenne(groupe, sommeGroupe, moyenneGroupe) + " from " + e.getNomTableSelect() + " where " + makeWhere(e) + makeWhereIntervalle(colInt, valInt) + apresWhere + " group by " + getListeChampGroupeSomme(groupe, null) + "  " + ordre;
            String comande = "select * from (select " + getListeChampGroupeSimple(groupe, sommeGroupe, moyenneGroupe) + ",rowNum as r from (" + selectInterne + ")) where r between " + indiceInf + " and " + indiceSup;
            //System.out.print(" ==== ++++++ ===== 1213 " + comande);
            st = c.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            //System.out.println(comande);
            dr = st.executeQuery(comande);
            Object[] resultat = transformeDataReader(dr, e, c);
            double[] somme = calculSommeNombreGroupe(selectInterne, nomColSomme, c);
            ResultatEtSomme rs = new ResultatEtSomme(resultat, somme);
            //rs.setResultatCaste(resultat);
            return rs;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception("Erreur durant la recherche groupee " + ex.getMessage());
        } finally {
            if (ouvertInterne == true && c != null) {
                c.close();
            }
            if (dr != null) {
                dr.close();
            }
            if (st != null) {
                st.close();
            }
        }
    }

    public static ResultatEtSomme rechercherPageGroupeM(ClassMAPTable e, String[] groupe, String[] sommeGroupe, String[] colInt, String[] valInt, int numPage, String apresWhere, String[] nomColSomme, String ordre, Connection c) throws Exception {
        ResultSet dr = null;
        Statement st = null;
        boolean ouvertInterne = false;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                ouvertInterne = true;
            }
            int npp;
            npp = 1;

            int indiceInf = (npp * (numPage - 1)) + 1;
            int indiceSup = npp * (numPage);

            String pagination = "";
            if (numPage >= 0) {
                pagination = "where r between " + indiceInf + " and " + indiceSup;
            }

            String apresWR = "";
            String orderby = "";
            char[] ch = {' '};
            String[] tabstr = Utilitaire.split(apresWhere, ch);
            int tmp = 0;
            for (int i = 0; i < tabstr.length; i++) {
                //System.out.println(" === "+tabstr[i].trim()+" ===");
                if (tabstr[i].trim().compareToIgnoreCase("order") != 0 && tmp == 0) {
                    apresWR += " " + tabstr[i].trim();
                } else {
                    tmp = 1;
                    orderby += " " + tabstr[i].trim();
                }
            }

            String selectInterne = "select " + getListeChampGroupeSimple(groupe, sommeGroupe) + " from " + e.getNomTableSelect() + " where " + makeWhereOr(e) + makeWhereIntervalle(colInt, valInt) + apresWR + " group by " + getListeChampGroupeSomme(groupe, null) + " " + orderby + "  " + ordre;
            String comande = "select * from (select " + getListeChampGroupeSimple(groupe, sommeGroupe) + ",rowNum as r from (" + selectInterne + ")) " + pagination;
            //System.out.print(" ==== ++++++ ===== 1213 " + comande);
            st = c.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            //System.out.println(comande);
            dr = st.executeQuery(comande);
            Object[] resultat = transformeDataReader(dr, e, c);
            double[] somme = calculSommeNombreGroupe(selectInterne, nomColSomme, c);
            ResultatEtSomme rs = new ResultatEtSomme(resultat, somme);
            //rs.setResultatCaste(resultat);
            return rs;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception("Erreur durant la recherche groupee " + ex.getMessage());
        } finally {
            if (ouvertInterne == true && c != null) {
                c.close();
            }
            if (dr != null) {
                dr.close();
            }
            if (st != null) {
                st.close();
            }
        }
    }

    public static ResultatEtSomme rechercherPageGroupe(ClassMAPTable e, String[] groupe, String[] sommeGroupe, String[] colInt, String[] valInt, int numPage, String apresWhere, String[] nomColSomme, String ordre, Connection c, int nppa) throws Exception {
        ResultSet dr = null;
        Statement st = null;
        boolean ouvertInterne = false;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                ouvertInterne = true;
            }
            int npp;
            if (nppa <= 0) {
                npp = Parametre.getNbParPage();//(ParamDossier.getParam("%")).getNombrePage();
            } else {
                npp = nppa;
            }
            int indiceInf = (npp * (numPage - 1)) + 1;
            int indiceSup = npp * (numPage);

            String selectInterne = "select " + getListeChampGroupeSomme(groupe, sommeGroupe) + " from " + e.getNomTableSelect() + " where " + makeWhereOr(e) + makeWhereIntervalle(colInt, valInt) + " " + apresWhere + " group by " + getListeChampGroupeSomme(groupe, null) + " " + ordre;
            String comande = "select * from (select " + getListeChampGroupeSimple(groupe, sommeGroupe) + ",rowNum as r from (" + selectInterne + ")) where r between " + indiceInf + " and " + indiceSup;
            //System.out.print(" ==== ++++++ ===== OR " + comande);
            st = c.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            dr = st.executeQuery(comande);
            Object[] resultat = transformeDataReader(dr, e, c);
            double[] somme = calculSommeNombreGroupe(selectInterne, nomColSomme, c);
            ResultatEtSomme rs = new ResultatEtSomme(resultat, somme);
            //rs.setResultatCaste(resultat);
            return rs;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception("Erreur durant la recherche groupee " + ex.getMessage());
        } finally {
            if (ouvertInterne == true && c != null) {
                c.close();
            }
            if (dr != null) {
                dr.close();
            }
            if (st != null) {
                st.close();
            }
        }
    }

    public static ResultatEtSomme rechercherPageGroupeM(ClassMAPTable e, String[] groupe, String[] sommeGroupe, String[] colInt, String[] valInt, int numPage, String apresWhere, String[] nomColSomme, String ordre, Connection c, int nppa) throws Exception {
        ResultSet dr = null;
        Statement st = null;
        boolean ouvertInterne = false;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                ouvertInterne = true;
            }
            int npp;
            if (nppa <= 0) {
                npp = Parametre.getNbParPage();//(ParamDossier.getParam("%")).getNombrePage();
            } else {
                npp = nppa;
            }
            int indiceInf = (npp * (numPage - 1)) + 1;
            int indiceSup = npp * (numPage);
            String apresWR = "";
            String orderby = "";
            char[] ch = {' '};
            String[] tabstr = Utilitaire.split(apresWhere, ch);
            int tmp = 0;
            for (int i = 0; i < tabstr.length; i++) {
                //System.out.println(" === "+tabstr[i].trim()+" ===");
                if (tabstr[i].trim().compareToIgnoreCase("order") != 0 && tmp == 0) {
                    apresWR += " " + tabstr[i].trim();
                } else {
                    tmp = 1;
                    orderby += " " + tabstr[i].trim();
                }
            }
            String selectInterne = "select " + getListeChampGroupeSomme(groupe, sommeGroupe) + " from " + e.getNomTableSelect() + " where " + makeWhereOr(e) + makeWhereIntervalle(colInt, valInt) + " " + apresWR + " group by " + getListeChampGroupeSomme(groupe, null) + " " + orderby + " " + ordre;
            String comande = "select * from (select " + getListeChampGroupeSimple(groupe, sommeGroupe) + ",rowNum as r from (" + selectInterne + ")) where r between " + indiceInf + " and " + indiceSup;
            //System.out.print(" ==== ++++++ ===== " + comande);
            st = c.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            dr = st.executeQuery(comande);
            Object[] resultat = transformeDataReader(dr, e, c);
            double[] somme = calculSommeNombreGroupe(selectInterne, nomColSomme, c);
            ResultatEtSomme rs = new ResultatEtSomme(resultat, somme);
            //rs.setResultatCaste(resultat);
            return rs;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception("Erreur durant la recherche groupee " + ex.getMessage());
        } finally {
            if (ouvertInterne == true && c != null) {
                c.close();
            }
            if (dr != null) {
                dr.close();
            }
            if (st != null) {
                st.close();
            }
        }
    }

    public static void setValChamp(ClassMAPTable e, Field nomChamp, Object valeur) throws Exception {
        String nomMethode = "set" + Utilitaire.convertDebutMajuscule(nomChamp.getName());
        Class[] paramT = {nomChamp.getType()};
        Object[] args = {valeur};
        try {
            if (valeur != null) {
                Object o = e.getClass().getMethod(nomMethode, paramT).invoke(e, args);
            }
        } catch (NoSuchMethodException ex) {
            Method[] list = e.getClass().getMethods();
            for (int i = 0; i < list.length; i++) {
                if (list[i].getName().compareToIgnoreCase(nomMethode) == 0) {
                    list[i].invoke(e, args);
                    return;
                }
            }
            throw new Exception("Methode non trouve");
        } catch (InvocationTargetException x) {
            throw new Exception(x.getTargetException().getMessage());
        }
    }

    public static String getValeurInsert(ClassMAPTable e, String nomChamp) throws Exception {
        String nomMethode = "get" + Utilitaire.convertDebutMajuscule(nomChamp);
        return e.getClass().getMethod(nomMethode, null).invoke(e, null).toString();
    }

    public static Object getValeurFieldByMethod(ClassMAPTable e, String nomChamp) throws Exception {
        String nomMethode = "get" + Utilitaire.convertDebutMajuscule(nomChamp);
        Object ret = null;
        try {
            ret = e.getClass().getMethod(nomMethode, null).invoke(e, null);
            return ret;
        } catch (NoSuchMethodException ex) {
            Method[] list = e.getClass().getMethods();
            for (int i = 0; i < list.length; i++) {
                if (list[i].getName().compareToIgnoreCase(nomMethode) == 0) {
                    ret = list[i].invoke(e, null);
                    return ret;
                }
            }
            throw new Exception("Methode non trouve " + nomChamp);
        }
    }

    public static Object getValeurFieldByMethod(ClassMAPTable e, Field g) throws Exception {
        return getValeurFieldByMethod(e, g.getName());
    }

    public static String makeWhereIntervalle(String[] numChamp, String[] val) throws Exception {
        String retour = "";
        if (numChamp == null) {
            return "";
        }

        for (int i = 0; i < numChamp.length; i++) {
            if ((val[2 * i] != "") && (val[(2 * i) + 1] == "")) {
                retour = retour + " AND " + numChamp[i] + " >= '" + val[2 * i] + "'";
            }
            if ((val[2 * i] == "") && (val[(2 * i) + 1] != "")) {
                retour = retour + " AND " + numChamp[i] + " <= '" + val[(2 * i) + 1] + "'";
            }
            if ((val[2 * i] != "") && (val[(2 * i) + 1] != "")) {
                retour = retour + " AND " + numChamp[i] + " >= '" + val[2 * i] + "'" + " AND " + numChamp[i] + " <= '" + val[(2 * i) + 1] + "'";
            }
        }
        //Console.WriteLine("make where int " + retour);
        return retour;
    }

    public static Field getField(ClassMAPTable ec, String nomChamp) throws ClassMAPTableException {
        try {

            Field fieldlist[] = ListeColonneTable.getFieldListeHeritage(ec);
            for (int i = 0; i < fieldlist.length; i++) {
                if (fieldlist[i].getName().compareToIgnoreCase(nomChamp) == 0) {
                    return fieldlist[i];
                }
            }
            return null;
        } catch (Exception e) {
            throw new ClassMAPTableException(e.getMessage());
        }
    }

    public static Field[] getFieldList(ClassMAPTable ec) throws ClassMAPTableException {
        try {
            Class cls = ec.getClass();
            Field retour[] = new Field[ec.getNombreChamp()];
            Field fieldlist[] = cls.getDeclaredFields();
            for (int i = 0; i < fieldlist.length; i++) {
                //if()
                retour[i] = fieldlist[i];
            }
            return retour;
        } catch (Exception e) {
            throw new ClassMAPTableException(e.getMessage());
        }
    }

    public static String makeWhere(ClassMAPTable e) throws Exception {
        String retour = "1<2";
        Champ[] ch = ListeColonneTable.getFromListe(e, null);
        for (int k = 0; k < ch.length; k++) {
            //if (!e.getListeAttributsIgnores().Contains(((String)g[k].Name).ToLower()))
            {
//            System.out.println("ATOOO -->"+ch[k].getNomClasse().getType().toString());
            Object valeurk = getValeurFieldByMethod(e, ch[k].getNomClasse().getName());
                boolean testDaty = ((ch[k].getNomClasse().getType().toString() == "System.DateTime")
                        || (ch[k].getNomClasse().getType().toString() == "java.sql.Date")
                        || (ch[k].getNomClasse().getType().toString() == "java.sql.Timestamp")
                        || (ch[k].getNomClasse().getType().toString() == "java.sql.Time"));
                boolean testNombre = ((ch[k].getNomClasse().getType().getName().compareToIgnoreCase("double") == 0)
                        || (ch[k].getNomClasse().getType().getName().compareToIgnoreCase("int") == 0)
                        || (ch[k].getNomClasse().getType().getName().compareToIgnoreCase("short") == 0)
                        || (ch[k].getNomClasse().getType().getName().compareToIgnoreCase("java.lang.Integer") == 0));
                boolean testBoolean = ch[k].getNomClasse().getType().toString().equals("boolean");
//                System.out.println("VALEUR : "+(ch[k].getNomClasse().getType().toString()+" > isBool : "+testBoolean));
                if (
                        (testNombre == false)
                        && (testBoolean == false)
                        && (testDaty == false)
                        && (valeurk != null)
                        && (valeurk.toString().compareToIgnoreCase("") != 0)
                        && (valeurk.toString().compareToIgnoreCase("%") != 0)
                        ) //&& (ch[k].getNomClasse().getName() != "nomTableSelect") && (ch[k].getNomClasse().getName() != "nomTableInsert") && (ch[k].getNomClasse().getName() != "apresCle"))
                {
                    retour = retour + " and upper(" + ch[k].getNomClasse().getName() + ") like upper('%" + Utilitaire.replaceChar(valeurk.toString()) + "%')";
                }
            }
        }
        return retour;
    }

    /*
  public static String makeWhereOr(ClassMAPTable e) throws Exception
  {
    String retour = "1<2";
    Champ[]ch=ListeColonneTable.getFromListe(e,null);
    for (int k = 0; k < ch.length; k++)
    {
      //if (!e.getListeAttributsIgnores().Contains(((String)g[k].Name).ToLower()))
     // {
      Object valeurk=getValeurFieldByMethod(e,ch[k].getNomClasse().getName());
      boolean testDaty = ((ch[k].getNomClasse().getType().toString() == "System.DateTime"));
      boolean testNombre=((ch[k].getNomClasse().getType().getName().compareToIgnoreCase("double")==0)||(ch[k].getNomClasse().getType().getName().compareToIgnoreCase("int")==0)||(ch[k].getNomClasse().getType().getName().compareToIgnoreCase("short")==0));
      if ((testNombre==false)&&(testDaty == false) && (valeurk != null) && (valeurk.toString().compareToIgnoreCase("")!=0) && (valeurk.toString().compareToIgnoreCase("%") != 0)) //&& (ch[k].getNomClasse().getName() != "nomTableSelect") && (ch[k].getNomClasse().getName() != "nomTableInsert") && (ch[k].getNomClasse().getName() != "apresCle"))
      {
        // retour = retour + " and " + g[k].Name + " like '" + g[k].GetValue(e, null).ToString().Replace("'", "''") + "'";
        //retour = retour + " and upper(" + ch[k].getNomClasse().getName() + ") in upper('"+ valeurk.toString() + "')";
        retour = retour + " and upper(" + ch[k].getNomClasse().getName() + ") like upper('"+ valeurk.toString() + "')";
      }

   // }


    }
    return retour;
  }*/

    public static String makeWhereOr(ClassMAPTable e) throws Exception {
        String retour = "1<2";
        Champ[] ch = ListeColonneTable.getFromListe(e, null);
        for (int k = 0; k < ch.length; k++) {
            Object valeurk = getValeurFieldByMethod(e, ch[k].getNomClasse().getName());
            boolean testDaty = ((ch[k].getNomClasse().getType().toString() == "System.DateTime"));
            boolean testNombre = ((ch[k].getNomClasse().getType().getName().compareToIgnoreCase("double") == 0) || (ch[k].getNomClasse().getType().getName().compareToIgnoreCase("int") == 0) || (ch[k].getNomClasse().getType().getName().compareToIgnoreCase("short") == 0));
            if ((testNombre == false) && (testDaty == false) && (valeurk != null) && (valeurk.toString().compareToIgnoreCase("") != 0) && (valeurk.toString().compareToIgnoreCase("%") != 0)) {
                String temp = valeurk.toString();
                String concat = "like ('";
                String after = "')";
                if (temp.lastIndexOf(",") != -1) {
                    concat = "in ('";
                    after = "')";
                }
                retour = retour + " and upper(" + ch[k].getNomClasse().getName() + ") " + concat + "" + valeurk.toString().toUpperCase() + "" + after;
            }
        }
        //System.out.println("\n"+retour+"\n");
        return retour;
    }

    public static Object[] transformeDataReader(ResultSet dr, ClassMAPTable e, Connection c, int iInf, int iSup) throws Exception {
        Vector retour = new Vector();
        String nomTable = e.getNomTableSelect();
        Champ[] listeChamp = ListeColonneTable.getFromListe(e, c);
        int ii = 0;
        while (dr.next()) {
            if (ii >= iInf && ii <= iSup) {
                Object o = Class.forName(e.getClassName()).newInstance();
                ClassMAPTable ex = (ClassMAPTable) o;
                for (int i = 0; i < listeChamp.length; i++) {
                    try {
                        int g = dr.findColumn(listeChamp[i].getNomColonne());
                    } catch (SQLException sq) {
                        continue;
                    }
                    if ((listeChamp[i].getTypeColonne().compareToIgnoreCase("NUMBER") == 0) && (listeChamp[i].getPrecision() == 0)) {
                        setValChamp(ex, listeChamp[i].getNomClasse(), new Integer(dr.getInt(listeChamp[i].getNomColonne())));
                    }
                    if (((listeChamp[i].getTypeColonne().compareToIgnoreCase("NUMBER") == 0) && (listeChamp[i].getPrecision() > 0)) || (listeChamp[i].getTypeColonne().compareToIgnoreCase("FLOAT") == 0)) {
                        setValChamp(ex, listeChamp[i].getNomClasse(), new Double(dr.getDouble(listeChamp[i].getNomColonne())));
                    }
                    if ((listeChamp[i].getTypeColonne().compareToIgnoreCase("VARCHAR2") == 0) || (listeChamp[i].getTypeColonne().compareToIgnoreCase("CHAR") == 0)) {
                        setValChamp(ex, listeChamp[i].getNomClasse(), dr.getString(listeChamp[i].getNomColonne()));
                    }
                    if (listeChamp[i].getTypeColonne().compareToIgnoreCase("DATE") == 0) {
                        setValChamp(ex, listeChamp[i].getNomClasse(), dr.getDate(listeChamp[i].getNomColonne()));
                    }
                }
                ex.setNomTable(e.getNomTableSelect());
                retour.add(ex);
            }
            ii++;
        }
        //Object[] temp = new Object[retour.size()];
        Object[] temp = (Object[]) java.lang.reflect.Array.newInstance(e.getClass().newInstance().getClass(), retour.size());
        retour.copyInto(temp);
        return temp;
    }

    public static Object[] transformeDataReader(ResultSet dr, ClassMAPTable e, Connection c) throws Exception {
        Vector retour = new Vector();
        String nomTable = e.getNomTableSelect();
        Champ[] listeChamp = ListeColonneTable.getFromListe(e, c);

        while (dr.next()) {
            Object o = Class.forName(e.getClassName()).newInstance();
            ClassMAPTable ex = (ClassMAPTable) o;
            for (int i = 0; i < listeChamp.length; i++) {
                try {
                    int g = dr.findColumn(listeChamp[i].getNomColonne());
                } catch (SQLException sq) {
                    continue;
                }

                if ((listeChamp[i].getTypeColonne().compareToIgnoreCase("NUMBER") == 0) && (listeChamp[i].getPrecision() == 0) && (listeChamp[i].getTypeJava().compareToIgnoreCase("java.lang.String") != 0)) {
                    setValChamp(ex, listeChamp[i].getNomClasse(), new Integer(dr.getInt(listeChamp[i].getNomColonne())));
                }
                if ((((listeChamp[i].getTypeColonne().compareToIgnoreCase("NUMBER") == 0) && (listeChamp[i].getPrecision() > 0)) || (listeChamp[i].getTypeColonne().compareToIgnoreCase("FLOAT") == 0)) && (listeChamp[i].getTypeJava().compareToIgnoreCase("java.lang.String") != 0)) {
                    setValChamp(ex, listeChamp[i].getNomClasse(), new Double(dr.getDouble(listeChamp[i].getNomColonne())));
                }
                if ((listeChamp[i].getTypeColonne().compareToIgnoreCase("VARCHAR2") == 0) || (listeChamp[i].getTypeColonne().compareToIgnoreCase("CHAR") == 0) || (listeChamp[i].getTypeJava().compareToIgnoreCase("java.lang.String") == 0)) {
                    setValChamp(ex, listeChamp[i].getNomClasse(), dr.getString(listeChamp[i].getNomColonne()));
                }
                if (listeChamp[i].getTypeColonne().compareToIgnoreCase("DATE") == 0) {
                    setValChamp(ex, listeChamp[i].getNomClasse(), dr.getDate(listeChamp[i].getNomColonne()));
                }
            }
            ex.setNomTable(e.getNomTableSelect());
            retour.add(ex);
        }
        //Object[] temp = new Object[retour.size()];
        Object[] temp = (Object[]) java.lang.reflect.Array.newInstance(e.getClass().newInstance().getClass(), retour.size());
        retour.copyInto(temp);
        return temp;
    }

    public static ClassMAPTable[] saveWithoutPkRangHisto(ClassMAPTable e, ClassMAPTable histo, Connection c) throws Exception {
        Connection cnx = null;
        ClassMAPTable[] retour = new ClassMAPTable[2];
        try {
            if (c == null) {
                cnx = new UtilDB().GetConn();
                cnx.setAutoCommit(false);
                c = cnx;
            }
            retour[0] = saveWithoutPkRang(e, c);
            retour[1] = saveWithoutPkRang(histo, c);
            if (cnx != null) {
                cnx.commit();
            }
            return retour;
        } catch (Exception ex) {
            if (cnx != null) {
                cnx.rollback();
            }
            throw new Exception("ERREUR INSERT_TABLE " + ex.getMessage());
        } finally {
            if (cnx != null) {
                cnx.close();
            }
        }
    }

    public static ClassMAPTable[] saveWithoutPkRangHisto(ClassMAPTable e, String refUser, Connection c) throws Exception {
        MapHistorique histo = new MapHistorique(e.getNomTable(), "insert", refUser, e.getTuppleID());
        return saveWithoutPkRangHisto(e, histo, c);
    }

    public static ClassMAPTable saveWithoutPkRang(ClassMAPTable e, Connection c) throws Exception {
        Connection cnx = null;
        try {
            if (c == null) {
                cnx = new UtilDB().GetConn();
                c = cnx;
            }
            Champ[] listeC = ListeColonneTable.getFromListe(e, c);
            String comande = "insert into " + e.getNomTable() + " values (";
            comande = comande + "'" + getValeurInsert(e, listeC[0].getNomClasse().getName()) + "'";
            for (int i = 1; i < listeC.length; i++) {
                comande = comande + ",";
                if (getValeurInsert(e, listeC[i].getNomClasse().getName()) == null) {
                    comande = comande + " null ";
                } else {
                    comande = comande + "'" + getValeurInsert(e, listeC[i].getNomClasse().getName()) + "'";
                }
            }
            comande = comande + ")";
            Statement st = c.createStatement();
            st.executeUpdate(comande);
            return e;
        } catch (Exception ex) {
            return null;
        } finally {
            if (cnx != null) {
                cnx.close();
            }
        }

    }

    public static Object[] getAllDataNoPagination(ClassMAPTable e, String[] groupe, String[] sommeGroupe, String[] colInt, String[] valInt, int numPage, String apresWhere, String[] nomColSomme, String ordre, Connection c) throws Exception {
        ResultSet dr = null;
        Statement st = null;
        boolean ouvertInterne = false;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                ouvertInterne = true;
            }

            String apresWR = "";
            String orderby = "";
            char[] ch = {' '};
            String[] tabstr = Utilitaire.split(apresWhere, ch);
            int tmp = 0;
            for (int i = 0; i < tabstr.length; i++) {
                //System.out.println(" === "+tabstr[i].trim()+" ===");
                if (tabstr[i].trim().compareToIgnoreCase("order") != 0 && tmp == 0) {
                    apresWR += " " + tabstr[i].trim();
                } else {
                    tmp = 1;
                    orderby += " " + tabstr[i].trim();
                }
            }

            String selectInterne = "select " + getListeChampGroupeSomme(groupe, sommeGroupe) + " from " + e.getNomTableSelect() + " where " + makeWhereOr(e) + makeWhereIntervalle(colInt, valInt) + " " + apresWR + " group by " + getListeChampGroupeSomme(groupe, null) + " " + orderby + " " + ordre;
            String comande = "select * from (select " + getListeChampGroupeSimple(groupe, sommeGroupe) + ",rowNum as r from (" + selectInterne + "))";
            //System.out.print(" ==== ++++++ ===== OR " + comande);
            st = c.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            dr = st.executeQuery(comande);
            Object[] resultat = transformeDataReader(dr, e, c);
            //rs.setResultatCaste(resultat);
            return resultat;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception("Erreur durant la recherche groupee " + ex.getMessage());
        } finally {
            if (ouvertInterne == true && c != null) {
                c.close();
            }
            if (dr != null) {
                dr.close();
            }
            if (st != null) {
                st.close();
            }
        }
    }

    public static Object[] rechercher(ClassMAPTable e, String requete) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            return rechercher(e, requete, c);
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public static Object[] rechercher(ClassMAPTable e, String requete, Connection c) throws Exception {
        ResultSet dr = null;
        Statement cmd = null;
        boolean ifconnnull = false;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                ifconnnull = true;
            }
            cmd = c.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            dr = cmd.executeQuery(requete);
            return transformeDataReader(dr, e, c);
        } catch (Exception x) {
            x.printStackTrace();
            throw new Exception("Erreur durant la recherche " + x.getMessage());
        } finally {
            if (dr != null) {
                dr.close();
            }
            if (cmd != null) {
                cmd.close();
            }
            if (ifconnnull && c != null) {
                c.close();
            }
        }
    }
}
