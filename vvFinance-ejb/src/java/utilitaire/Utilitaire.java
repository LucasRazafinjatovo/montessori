// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   Utilitaire.java
package utilitaire;

import bean.CGenUtil;
import bean.ClassMAPTable;
import etudiant.Ecole;
import etudiant.EtatDeCaisse;

import java.io.PrintStream;
import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.DateFormatSymbols;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.Locale;
import java.util.Random;
import java.util.TimeZone;
import java.util.Vector;
import ventegazety.*;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;

// Referenced classes of package utilitaire:
//            Parametre, UtilDB, Log
public class Utilitaire extends Parametre {

    public Utilitaire() {
    }

    public static Date[] getIntervalleDateNonFerie(Date max, Date min) throws Exception {
        int nb = Utilitaire.diffJourDaty(max, min) - 2;
        System.out.println("isa = " + nb);
        Date[] listeDate = null;
        if (nb > 0) {
            Date[] liste = new Date[nb];
            for (int i = 0; i < nb; i++) {
                liste[i] = new Date(min.getYear(), min.getMonth(), min.getDate() + i + 1);
            }
            pointage.PointJourferie[] ljf = (pointage.PointJourferie[]) bean.CGenUtil.rechercher(new pointage.PointJourferie(), null, null, " AND DATY >= '" + Utilitaire.formatterDaty(min) + "' AND DATY <= '" + Utilitaire.formatterDaty(max) + "' ");
            Vector v = new Vector();

            if (ljf.length > 0) {
                for (int i = 0; i < liste.length; i++) {
                    int tmp = 0;
                    for (int j = 0; j < ljf.length; j++) {
                        if (ljf[j].getDaty().compareTo(liste[i]) == 0 || Utilitaire.dayOfDate(liste[i]) == 1) {
                            tmp += 1;
                        }
                    }
                    if (tmp <= 0) {
                        Date dt = liste[i];
                        v.add(dt);
                    }
                }
                listeDate = new Date[v.size()];
                v.copyInto(listeDate);
            } else {
                for (int i = 0; i < liste.length; i++) {
                    if (Utilitaire.dayOfDate(liste[i]) != 1) {
                        Date notWE = liste[i];
                        v.add(notWE);
                    }
                    listeDate = new Date[v.size()];
                    v.copyInto(listeDate);
                }
            }
            return listeDate;

        } else {

            return null;
        }
    }

    public static int dayOfDate(Date daty) {

        Calendar cal = Calendar.getInstance();
        cal.setTime(daty);
        int day = cal.get(Calendar.DAY_OF_WEEK);

//        switch (day) {
//            case 1:
//                return "Dimanche";
//            case 2:
//                return "Lundi";
//            case 3:
//                return "Mardi";
//            case 4:
//                return "Mercredi";
//            case 5:
//                return "Jeudi";
//            case 6:
//                return "Vendredi";
//            case 7:
//                return "Samedi";
//        }
        return day;
    }

    public static String[] formerTableauGroupe(String[] val) throws Exception {
        String retour[] = null;
        Vector r = new Vector();
        for (int i = 0; i < val.length; i++) {
            if (val[i] != null && val[i].compareToIgnoreCase("") != 0 && val[i].compareToIgnoreCase("-") != 0) {
                r.add(val[i]);
            }
        }
        if (r.size() > 0) {
            retour = new String[r.size()];
            r.copyInto(retour);
        }
        return retour;
    }

    public static String[] formerTableauGroupe(String val1, String val2) throws Exception {
        String retour[] = null;
        if ((val1 == null || val1.compareToIgnoreCase("") == 0 || val1.compareToIgnoreCase("-") == 0) && (val2 != null && val2.compareToIgnoreCase("") != 0)) {
            retour = new String[1];
            retour[0] = val2;
            return retour;
        } else if ((val2 == null || val2.compareToIgnoreCase("") == 0) && (val1 != null && val1.compareToIgnoreCase("") != 0)) {
            retour = new String[1];
            retour[0] = val1;
            return retour;
        } else if ((val2 == null || val2.compareToIgnoreCase("") == 0) && (val1 == null || val1.compareToIgnoreCase("") == 0)) {
            return null;
        } else {
            retour = new String[2];
            retour[0] = val1;
            retour[1] = val2;
            return retour;
        }
    }

    public static String convertDatyFormtoRealDatyFormat(String daty) {
        String[] tableau = new String[3];
        tableau = split(daty, "-");
        //System.out.println("tableau"+tableau[0]+" "+tableau[1]+" "+tableau[2]);
        String result = tableau[2] + "/" + tableau[1] + "/" + tableau[0];
        return result;
    }

    public static String[] ajouterTableauString(String[] s1, String[] s2) {
        String retour[] = new String[s1.length + s2.length];
        int i = 0;
        for (i = 0; i < s1.length; i++) {
            retour[i] = s1[i];
        }
        for (int j = 0; j < s2.length; j++) {
            retour[i + j] = s2[j];
        }
        return retour;
    }

    public static String[] ajouterTableauString(String[] s1, String[] s2, String[] s3) {
        String retour[] = new String[s1.length + s2.length + s3.length];
        int i = 0;
        for (i = 0; i < s1.length; i++) {
            retour[i] = s1[i];
        }
        int j = 0;
        for (j = 0; j < s2.length; j++) {
            retour[i + j] = s2[j];
        }
        for (int k = 0; k < s3.length; k++) {
            retour[i + j + k] = s3[k];
        }
        return retour;
    }

    public static String replaceChar(String s) {
        //s = s.replace(''', '''');
        s = s.replace('*', '%');
        s = s.replace(',', '%');
        return s;
    }

    public static String getDebutAnnee(String annee) {
        return "01/01/" + annee;
    }

    public static String[] split(String mot, String sep) {
        java.util.StringTokenizer tokenizer = new java.util.StringTokenizer(mot, sep);
        Vector v = new Vector();
        while (tokenizer.hasMoreTokens()) {
            v.add(tokenizer.nextToken());
        }
        String retour[] = new String[v.size()];
        v.copyInto(retour);
        return retour;
    }

    public static String getFinAnnee(String annee) {
        return "31/12/" + annee;
    }

    public static String[] getDebutFinAnnee() {
        Parametre.getParametre();
        String[] retour = new String[2];
        retour[0] = getDebutAnnee(String.valueOf(getAneeEnCours()));
        retour[1] = getFinAnnee(String.valueOf(getAneeEnCours()));
        return retour;
    }

    public static ClassMAPTable extraire(ClassMAPTable c[], int numCol, String val) {
        try {
            for (int i = 0; i < c.length; i++) {
                String valeur = String.valueOf(c[i].getValField(c[i].getFieldList()[numCol]));
                if (valeur.compareToIgnoreCase(val) == 0) {
                    return c[i];
                }
            }
            return null;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public static String[] remplacerNullParBlanc(String[] val, String remplacant) {
        for (int i = 0; i < val.length; i++) {
            if (val[i] == null) {
                val[i] = remplacant;
            }
        }
        return val;
    }

    public static ClassMAPTable extraire(Vector v, int numCol, String val) {
        try {
            for (int i = 0; i < v.size(); i++) {
                ClassMAPTable c = (ClassMAPTable) v.elementAt(i);
                String valeur = (String) c.getValField(c.getFieldList()[numCol]);
                if (valeur.compareToIgnoreCase(val) == 0) {
                    return c;
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public static ClassMAPTable extraireMultiple(Vector v, int numColVect, int[] numCol, String[] val) {
        try {
            for (int i = 0; i < v.size(); i++) {
                ClassMAPTable c = (ClassMAPTable) v.elementAt(i);
                int test = 1;
                String[] valeurT = (String[]) (c.getValField(c.getFieldList()[numColVect]));
                for (int j = 0; j < numCol.length; j++) {
                    String valeur = valeurT[j];
                    if (valeur.compareToIgnoreCase(val[j]) != 0) {
                        test = 0;
                        break;
                    }
                }
                if (test == 1) {
                    return c;
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public static int estIlDedans(ClassMAPTable c[], int numCol, String val) {
        try {
            for (int i = 0; i < c.length; i++) {
                String valeur = (String) c[i].getValField(c[i].getFieldList()[numCol]);
                if (valeur.compareToIgnoreCase(val) == 0) {
                    return 1;
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return 0;
    }

    public static String[] concatener(String[] t1, String[] t2) {
        int taille = t1.length + t2.length;
        String retour[] = new String[taille];
        for (int i = 0; i < t1.length; i++) {
            retour[i] = t1[i];
        }
        for (int j = t1.length; j < taille; j++) {
            retour[j] = t2[j - t1.length];
        }
        return retour;
    }

    public static Etatvente[] concatener(Etatvente[] t1, Etatvente[] t2) {
        int taille = t1.length + t2.length;
        Etatvente[] retour = new Etatvente[taille];
        for (int i = 0; i < t1.length; i++) {
            retour[i] = t1[i];
        }
        for (int j = t1.length; j < taille; j++) {
            retour[j] = t2[j - t1.length];
        }
        return retour;
    }

    public static int estIlDedans(String test, String c[]) {
        try {
            if (c == null) {
                return -1;
            }
            for (int i = 0; i < c.length; i++) {
                if (c[i].compareToIgnoreCase(test) == 0) {
                    return i;
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return -1;
    }

    public static String convertDebutMajuscule(String autre) {
        char[] c = autre.toCharArray();
        c[0] = Character.toUpperCase(c[0]);
        return new String(c);
    }

    public static String[] getvalCol(String nomTable, String col) {
        UtilDB util = new UtilDB();
        Connection c = null;
        PreparedStatement cs = null;
        ResultSet rs = null;
        String[] retour = null;
        try {
            try {
                c = util.GetConn();
                cs = c.prepareStatement("select distinct(" + col + ") from " + nomTable);
                rs = cs.executeQuery();
                Vector v = new Vector();
                while (rs.next()) {
                    v.add(rs.getString(1));
                }
                retour = new String[v.size()];
                v.copyInto(retour);
                return retour;
            } catch (SQLException e) {
                e.printStackTrace();
                return null;
            }
        } finally {
            try {
                if (c != null) {
                    c.close();
                }
                if (cs != null) {
                    cs.close();
                }
                if (rs != null) {
                    rs.close();
                }
                util.close_connection();
            } catch (SQLException e) {
                System.out.println("Erreur Fermeture SQL RechercheType ".concat(String.valueOf(String.valueOf(e.getMessage()))));
            }
        }
    }

    public static int[] getBornePage(int page, Object list[]) {
        int ret[] = new int[2];
        ret[0] = (page - 1) * Parametre.getNbParPage();
        if ((ret[0] + Parametre.getNbParPage()) - 1 < list.length) {
            ret[1] = ret[0] + Parametre.getNbParPage();
        } else {
            ret[1] = list.length;
        }
        return ret;
    }

    public static int[] getBornePage(int page, Object list[], int npp) {
        int ret[] = new int[2];
        ret[0] = (page - 1) * npp;
        if ((ret[0] + npp) - 1 < list.length) {
            ret[1] = ret[0] + npp;
        } else {
            ret[1] = list.length;
        }
        return ret;
    }

    public static int[] getBornePage(String page, Object list[]) {
        return getBornePage(stringToInt(page), list);
    }

    public static int[] getBornePage(String page, Object list[], int npp) {
        return getBornePage(stringToInt(page), list, npp);
    }

    public static int calculNbPage(double tailleObjet) {
        int ret = 0;
        Double d = new Double(tailleObjet);
        ret = d.intValue() / Parametre.getNbParPage();
        if (d.intValue() % Parametre.getNbParPage() > 0) {
            ret++;
        }
        return ret;
    }

    public static int calculNbPage(double tailleObjet, int nbParPage) {
        int ret = 0;
        int nb = Parametre.getNbParPage();
        if (nbParPage > 0) {
            nb = nbParPage;
        }
        Double d = new Double(tailleObjet);
        ret = d.intValue() / nb;
        if (d.intValue() % nb > 0) {
            ret++;
        }
        return ret;
    }/*
  public static int calculNbPage(int tailleObjet)
  {
      int ret = 0;
      ret = tailleObjet / Parametre.getNbParPage();
      if(tailleObjet % Parametre.getNbParPage() > 0)
          ret++;
      return ret;
  }*/
    public static int calculNbPage(Object list[]) {
        return calculNbPage(list.length);
    }

    public static double calculSomme(String[] val) throws Exception {
        double retour = 0;
        for (int i = 0; i < val.length; i++) {
            retour = retour + Utilitaire.stringToDouble(val[i]);
        }
        return retour;
    }

    public static String getLastDayOfDate(String daty) {
        String ret = "";
        try {
            Date dt = stringDate(daty);
            ret = getLastDayOfDate(dt);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return ret;
    }

    public static java.util.Date convertFromSQLDateToUtilDate(java.sql.Date sqlDate) {
        java.util.Date javaDate = null;
        if (sqlDate != null) {
            javaDate = new Date(sqlDate.getTime());
        }
        return javaDate;
    }

    public static String getLastDayOfDate(Date daty) {
        String ret = "";
        try {
            java.util.Date dt = convertFromSQLDateToUtilDate(daty);

            Calendar calendar = Calendar.getInstance();
            calendar.setTime(dt);

            calendar.add(Calendar.MONTH, 1);
            calendar.set(Calendar.DAY_OF_MONTH, 1);
            calendar.add(Calendar.DATE, -1);
            java.util.Date lastDayOfMonth = calendar.getTime();
            java.text.DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            // System.out.println("Date            : " + sdf.format(dt));
            //System.out.println("Last Day of Month: " + sdf.format(lastDayOfMonth));

            return sdf.format(lastDayOfMonth);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return ret;
    }

    public static double calculSomme(double[] val) throws Exception {
        double retour = 0;
        for (int i = 0; i < val.length; i++) {
            retour = retour + (val[i]);
        }
        return retour;
    }

    public static int stringToInt(String s) {
        int j;
        try {
            Integer ger = new Integer(s);
            int i = ger.intValue();
            int k = i;
            return k;
        } catch (NumberFormatException ex) {
            j = 0;
        }
        return j;
    }

    public static String remplacerNull(String valNull) {
        if ((valNull == null) || valNull.compareToIgnoreCase("null") == 0) {
            return "";
        }
        return valNull;
    }

    public static String getValPourcentage(String valeur) {
        return null;
    }

    public static String remplacerUnderscore(String mot) {
        String nouveau = new String(mot.toCharArray());
        nouveau.replace('_', '-');
        return nouveau;
    }

    public static String remplaceMot(String valeur, String mot1, String mot2) {
        StringBuffer result = new StringBuffer();
        int startIdx = 0;
        int idxOld = 0;
        while ((idxOld = valeur.indexOf(mot1, startIdx)) >= 0) {
            result.append(valeur.substring(startIdx, idxOld));
            result.append(mot2);
            startIdx = idxOld + mot1.length();
        }
        result.append(valeur.substring(startIdx));
        return result.toString();
    }

    public static int getRang(char[] liste, char c) {
        for (int i = 0; i < liste.length; i++) {
            if (Character.toLowerCase(liste[i]) == Character.toLowerCase(c)) {
                return i;
            }
        }
        return -1;
    }

    public static String coderPwd(String entree) {
        char[] listeMot = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'};
        char[] chiffre = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};
        char[] retr = new char[entree.length() + 1];
        retr[0] = listeMot[entree.length() % 5];
        char[] entr = entree.toCharArray();
        for (int i = 0; i < entr.length; i++) {
            int rL = getRang(listeMot, entr[i]);
            int rC = getRang(chiffre, entr[i]);
            if (rL > -1) {
                retr[i + 1] = listeMot[(listeMot.length - rL - i)];
            } else if (rC > -1) {
                retr[i + 1] = chiffre[(chiffre.length + rC - i)];
            } else {
                retr[i + 1] = entr[i];
            }
        }
        return new String(retr);
    }

    public static String decode(String entree) {
        char[] listeMot = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'};
        char[] chiffre = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};
        return null;
    }

    public static String remplacePourcentage(String valeur) {
        String retour = "";
        if (valeur == null) {
            return "";
        }
        char val[] = new char[valeur.length()];
        val = valeur.toCharArray();
        int taille = val.length;
        if (valeur.compareToIgnoreCase("") == 0) {
            return "";
        }
        if (valeur.compareToIgnoreCase("%") == 0 || valeur == null) {
            return "%25";
        }
        retour = remplaceMot(valeur, "%", "%25");
        retour = remplaceMot(retour, " ", "%20");
        return retour;
    }

    public static String getDebutmot(String mot) {
        String retour = "";
        char motChar[] = new char[mot.length()];
        motChar = mot.toCharArray();
        retour = retour.concat(String.valueOf(motChar[0]));
        int i = 0;
        do {
            if (i >= mot.length()) {
                break;
            }
            if (motChar[i] == ' ') {
                retour = retour.concat(String.valueOf(motChar[i + 1]));
                break;
            }
            i++;
        } while (true);
        return retour.toUpperCase();
    }

    public static String getDebutmot(String mot, int nombre) {
        if (mot == null) {
            return "";
        }

        if (nombre >= mot.length()) {
            return mot.toUpperCase();
        }

        String retour = "";
        if (nombre <= 0) {
            return retour;
        }

        char motChar[] = new char[mot.length()];
        motChar = mot.toCharArray();
        //retour = retour.concat(String.valueOf(motChar[0]));

        for (int n = 0; n < nombre; n++) {
            if (motChar[n] == ' ') {
                retour = retour;
                System.out.println("retour=============" + retour + n);
            } else {
                retour = retour.concat(String.valueOf(motChar[n]));
                System.out.println("retour=============" + retour + n);
            }
        }
        return retour.toUpperCase();
    }

    /**
     * Prend les 3 premi�res lettres d'un String si c'est compos� d'un seul mot,
     * sinon prend les premi�res lettres de chaque mot
   *
     */
    public static String getDebutMots(String mot) {
        String retour = "";
        if (mot.compareTo("-") == 0) {
            return "NON";
        }
        int multiple = 0;
        int indice = 3;
        if (mot.length() < 3) {
            indice = 2;
        }
        char[] motChar = new char[mot.length()];
        motChar = mot.toCharArray();
        //retour=retour.concat(String.valueOf(motChar[0]));
        for (int i = 0; i < mot.length(); i++) {
            if (motChar[i] == ' ') {
                multiple = 1;
                break;
            }
        }
        if (multiple == 1) {
            retour = getDebutmot(mot);
        } else {
            for (int i = 0; i < indice; i++) {
                retour = retour.concat(String.valueOf(motChar[i]));
            }
        }
        return retour.toUpperCase();
    }

    public static double getPvente(int pu, int marge) {
        return (double) pu * ((double) 1 + (double) marge / (double) 100);
    }

    public static float stringToFloat(String s) {
        float f1;
        try {
            Float ger = new Float(s);
            float f = ger.floatValue();
            return f;
        } catch (NumberFormatException ex) {
            f1 = 0.0F;
        }
        return f1;
    }

    public static String[] getBorneAnneeEnCours() {
        return null;
    }

    public static java.sql.Date[] convertIntervaleToListDate(java.sql.Date dmin, java.sql.Date dmax) {
        int nbJ = Utilitaire.diffJourDaty(dmax, dmin);
        java.sql.Date[] ret = new java.sql.Date[nbJ];
        int i = 0;
        /*  while(compareDaty(dmax,ret[i])>0)
    {
      ret[i]=ajoutJourDate(dmin,i);
      i++;
    }*/
        //  System.out.println("Taille tab "+ret.length);
        while (i < ret.length) {
            ret[i] = ajoutJourDate(dmin, i);
            i++;
        }
        return ret;
    }

    public static String[] getBorneDatyMoisAnnee(String mois, String an) {
        String retour[] = new String[2];
        GregorianCalendar eD = new GregorianCalendar();
        GregorianCalendar eD2 = new GregorianCalendar();
        retour[0] = "01/" + mois + "/" + an;
        Date daty1 = string_date("dd/MM/yyyy", retour[0]);
        eD.setTime(daty1);
        eD2.setTime(daty1);
        eD2.add(5, 26);
        do {
            eD2.add(5, 1);
        } while (eD.get(2) == eD2.get(2));
        eD2.add(5, -1);
        retour[1] = String.valueOf(String.valueOf(completerInt(2, eD2.get(5)))).concat("/");
        retour[1] = String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(retour[1])))).append(completerInt(2, eD2.get(2) + 1)).append("/")));
        retour[1] = String.valueOf(retour[1]) + String.valueOf(completerInt(4, eD2.get(1)));
        return retour;
    }

    public static int getAneeEnCours() {
        Calendar a = Calendar.getInstance();
        return a.get(1);
    }

    public static int compterCar(String lettre, char c) {
        char[] mot = lettre.toCharArray();
        int nb = 0;
        for (int i = 0; i < mot.length; i++) {
            if (mot[i] == c) {
                nb++;
            }
        }
        return nb;
    }

    public static String[] split(String lettre, char sep) {
        Vector v = new Vector();
        char[] mot = lettre.toCharArray();
        char part[] = new char[100];
        int indicePart = 0;
        for (int i = 0; i < mot.length; i++) {
            if (mot[i] == sep || (i == mot.length - 1)) {
                indicePart = 0;
                v.add(String.valueOf(part));
                part = new char[100];
            } else {
                part[indicePart] = mot[i];
                indicePart++;
            }
        }
        String[] retour = new String[v.size()];
        v.copyInto(retour);
        return retour;
    }

    public static boolean estIlDedans(char[] liste, char car) {
        for (int i = 0; i < liste.length; i++) {
            if (liste[i] == car) {
                return true;
            }
        }
        return false;
    }

    public static String[] split(String lettre, char[] sep) {
        Vector v = new Vector();
        char[] mot = lettre.toCharArray();
        char part[] = new char[100];
        int indicePart = 0;
        for (int i = 0; i < mot.length; i++) {
            if (estIlDedans(sep, mot[i])) {
                indicePart = 0;
                v.add(String.valueOf(part).trim());
                part = new char[100];
            } else {
                part[indicePart] = mot[i];
                indicePart++;
            }
            if (i == mot.length - 1) {
                v.add(String.valueOf(part).trim());
            }
        }
        String[] retour = new String[v.size()];
        v.copyInto(retour);
        return retour;
    }

    public static String getAnnee(String daty) {
        //daty.
        //GregorianCalendar eD = new GregorianCalendar();
        //eD.setTime(string_date("dd/MM/yyyy", daty));
        //return String.valueOf(eD.get(1));
        return split(daty, "/")[2];
    }

    public static int getAnnee(Date daty) {
        GregorianCalendar eD = new GregorianCalendar();
        eD.setTime(daty);
        return eD.get(1);
    }

    public static int getMois(Date daty) {
        GregorianCalendar eD = new GregorianCalendar();
        eD.setTime(daty);
        return eD.get(2) + 1;
    }

    public static String getMois(String daty) {
        //GregorianCalendar eD = new GregorianCalendar();
        //eD.setTime(string_date("dd/MM/yyyy", daty));
        //return completerInt(2, eD.get(2) + 1);
        return completerInt(2, split(daty, "/")[1]);
    }

    public static String getJour(String daty) {
        //GregorianCalendar eD = new GregorianCalendar();
        //eD.setTime(string_date("dd/MM/yyyy", daty));
        //return completerInt(2, eD.get(5));
        return completerInt(2, split(daty, "/")[0]);
    }

    public static int getMoisEnCours() {
        Calendar a = Calendar.getInstance();
        return a.get(2);
    }

    public static int compareDaty(Date supe, Date infe) {
        GregorianCalendar eD = new GregorianCalendar();
        GregorianCalendar eD2 = new GregorianCalendar();
        Date sup = string_date("dd/MM/yyyy", formatterDaty(supe));
        Date inf = string_date("dd/MM/yyyy", formatterDaty(infe));
        eD.setTime(sup);
        eD2.setTime(inf);
        if (eD.getTime().getTime() > eD2.getTime().getTime()) {
            return 1;
        }
        return eD.getTime().getTime() <= eD2.getTime().getTime() ? 0 : -1;
    }

    public static int diffJourDaty(Date dMaxe, Date dMine) {
        GregorianCalendar eD = new GregorianCalendar();
        GregorianCalendar eD2 = new GregorianCalendar();
        Date dMax = string_date("dd/MM/yyyy", formatterDaty(dMaxe));
        Date dMin = string_date("dd/MM/yyyy", formatterDaty(dMine));
        eD.setTime(dMax);
        eD2.setTime(dMin);
        double resultat = eD.getTime().getTime() - eD2.getTime().getTime();
        BigDecimal result = new BigDecimal(String.valueOf(eD.getTime().getTime() - eD2.getTime().getTime()));
        BigDecimal retour = result.divide(new BigDecimal(String.valueOf(0x5265c00)), 4);
        return 1 + retour.intValue();
    }

    public static int diffJourDaty(String dMax, String dMin) {
        return diffJourDaty(string_date("dd/MM/yyyy", dMax), string_date("dd/MM/yyyy", dMin));
    }

    public static int diffJourDatyAvecRecurrence(Date dsup, Date dinf, int rec) {
        int retour = 0;
        while (Utilitaire.compareDaty(dsup, dinf) >= 0) {
            dinf = Utilitaire.ajoutJourDate(dinf, rec);
            retour++;
        }
        return retour;
    }

    public static Date getDateDebutDuplication(Date datyinf, int jour) {
        while (1 < 2) {
            if (datyinf.getDay() == jour) {
                return datyinf;
            }
            datyinf = Utilitaire.ajoutJourDate(datyinf, 1);
        }
    }

    public static int[] stringToInt(String[] value) {
        int[] ret = new int[value.length];
        for (int i = 0; i < value.length; i++) {
            ret[i] = Utilitaire.stringToInt(value[i]);
        }
        return ret;
    }

    public static Date[] getListDateDebutDuplication(Date datyinf, int[] jours) {
        Date[] list = new Date[jours.length];
        for (int i = 0; i < jours.length; i++) {
            list[i] = Utilitaire.getDateDebutDuplication(datyinf, jours[i]);
        }
        return list;
    }

    /*
  Days of week are represented as:
  SUNDAY = 1
  MONDAY = 2
  TUESDAY = 3
  WEDNESDAY = 4
  THURSDAY = 5
  FRIDAY = 6
  SATURDAY = 7
     */
    public static double stringToDouble(String s) {
        double d1;
        try {
            Double ger = new Double(s);
            double d = ger.doubleValue();
            return d;
        } catch (NumberFormatException ex) {
            d1 = 0.0D;
        }
        return d1;
    }

    public static long stringToLong(String s) {
        try {
            Long ger = new Long(s);
            long l = ger.longValue();
            return l;
        } catch (NumberFormatException ex) {
            ex.printStackTrace();
        }
        long l1 = 0L;
        return l1;
    }

    public static String stringToTab(String[] s, String quote, String virgule) {
        String res = "";
        try {
            res = quote + s[0] + quote;
            for (int i = 1; i < s.length; i++) {
                res += virgule + quote + s[i] + quote;
            }
        } catch (NumberFormatException ex) {
            ex.printStackTrace();
        }
        return res;
    }

    public static String formaterAr(String montant) {
        return formaterAr(stringToDouble(montant));
    }

    public static String formaterAr(double montant) {
        try {
            if (montant == 0) {
                return "0";
            }
            NumberFormat nf = NumberFormat.getInstance(Locale.FRENCH);
            nf.setMinimumFractionDigits(2);
            String s = nf.format(montant);
            return s;
        } catch (Exception e) {
            e.printStackTrace();
        }
        String s1 = null;
        return s1;
    }

    public static String formaterAr(long montant) {
        return formaterAr(String.valueOf(montant));
    }

    public static String formatterDaty(String daty) {
        String retour = null;
        if ((daty == null) || (daty == "")) {
            return "";
        }
        return (daty.substring(8, 10) + "/" + (daty.substring(5, 7)) + "/" + (daty.substring(0, 4)));
    }

    public static double arrondir(double a, int apr) {
        double d;
        try {
            NumberFormat nf = NumberFormat.getInstance(Locale.GERMAN);
            nf.setMaximumFractionDigits(apr);
            Number retour = nf.parse(nf.format(a));
            double d1 = retour.doubleValue();
            return d1;
        } catch (Exception e) {
            d = 1.0D;
        }
        return d;
    }

    public static String formatterDaty(Date daty) {
        String retour = null;
        return formatterDaty(String.valueOf(daty));
    }

    public static String formatterDatySql(java.sql.Date daty) {
        String retour = null;
        return formatterDaty(String.valueOf(daty));
    }

    public static Date ajoutJourDateOuvrable(Date aDate, int nbDay) {
        try {
            Date date = string_date("dd/MM/yyyy", ajoutJourDateStringOuvrable(aDate, nbDay));
            return date;
        } catch (Exception e) {
            System.out.println("Error string_date :".concat(String.valueOf(String.valueOf(e.getMessage()))));
        }
        Date date1 = null;
        return date1;
    }

    public static String ajoutJourDateStringOuvrable(Date aDatee, int nbDay) {
        try {
            GregorianCalendar eD = new GregorianCalendar();
            Date aDate = string_date("dd/MM/yyyy", formatterDaty(aDatee));
            eD.setTime(aDate);
            int offset = 1;
            int offsetSunday = 1;
            int offsetSaturday = 2;
            if (nbDay < 0) {
                offset = -1;
                offsetSunday = -2;
                offsetSaturday = -1;
            }
            for (int i = 1; i <= Math.abs(nbDay); i++) {
                eD.add(5, offset);
                if (eD.get(7) == 7) {
                    eD.add(5, offsetSaturday);
                    continue;
                }
                if (eD.get(7) == 1) {
                    eD.add(5, offsetSunday);
                }
            }

            String retour = null;
            retour = String.valueOf(String.valueOf(completerInt(2, eD.get(5)))).concat("/");
            retour = String.valueOf(retour) + String.valueOf(completerInt(2, String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(eD.get(2) + 1)))).append("/")))));
            retour = String.valueOf(retour) + String.valueOf(completerInt(4, eD.get(1)));
            String s1 = retour;
            return s1;
        } catch (Exception e) {
            System.out.println("Error string_date :".concat(String.valueOf(String.valueOf(e.getMessage()))));
        }
        String s = null;
        return s;
    }

    public static String ajoutMoisDateString(Date aDatee, int nbMois) {
        try {
            GregorianCalendar eD = new GregorianCalendar();
            GregorianCalendar eD2 = new GregorianCalendar();
            Date aDate = string_date("dd/MM/yyyy", formatterDaty(aDatee));
            eD.setTime(aDate);
            int offset = 1;
            int offsetSunday = 1;
            int offsetSaturday = 2;
            if (nbMois < 0) {
                offset = -1;
                offsetSunday = -2;
                offsetSaturday = -1;
            }
            for (int i = 1; i <= Math.abs(nbMois); i++) {
                eD.add(2, offset);
            }

            eD2.setTime(eD.getTime());
            if (eD.get(2) == eD2.get(2) && testFinDuMois(aDate)) {
                do {
                    eD2.add(5, 1);
                } while (eD.get(2) == eD2.get(2));
                eD2.add(5, -1);
            }
            String retour = null;
            retour = String.valueOf(String.valueOf(completerInt(2, eD2.get(5)))).concat("/");
            retour = String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(retour)))).append(completerInt(2, eD2.get(2) + 1)).append("/")));
            retour = String.valueOf(retour) + String.valueOf(completerInt(4, eD2.get(1)));
            String s1 = retour;
            return s1;
        } catch (Exception e) {
            System.out.println("Error string_date :".concat(String.valueOf(String.valueOf(e.getMessage()))));
        }
        String s = null;
        return s;
    }

    public static boolean testFinDuMois(Date aDatee) {
        GregorianCalendar eD = new GregorianCalendar();
        Date aDate = string_date("dd/MM/yyyy", formatterDaty(aDatee));
        eD.setTime(aDate);
        GregorianCalendar eD2 = new GregorianCalendar();
        eD2.setTime(eD.getTime());
        eD2.add(5, 1);
        return eD.get(2) != eD2.get(2);
    }

    public static String ajoutJourDateString(Date aDatee, int nbDay) {
        try {
            GregorianCalendar eD = new GregorianCalendar();
            Date aDate = string_date("dd/MM/yyyy", formatterDaty(aDatee));
            eD.setTime(aDate);
            int offset = 1;
            int offsetSunday = 1;
            int offsetSaturday = 2;
            if (nbDay < 0) {
                offset = -1;
                offsetSunday = -2;
                offsetSaturday = -1;
            }
            for (int i = 1; i <= Math.abs(nbDay); i++) {
                eD.add(5, offset);
            }

            String retour = null;
            retour = String.valueOf(String.valueOf(completerInt(2, eD.get(5)))).concat("/");
            retour = String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(retour)))).append(completerInt(2, eD.get(2) + 1)).append("/")));
            retour = String.valueOf(retour) + String.valueOf(completerInt(4, eD.get(1)));
            String s1 = retour;
            return s1;
        } catch (Exception e) {
            System.out.println("Error ajoutJourDateString :".concat(String.valueOf(String.valueOf(e.getMessage()))));
        }
        String s = null;
        return s;
    }

    public static Date ajoutJourDate(Date aDate, int nbDay) {
        try {
            Date date = string_date("dd/MM/yyyy", ajoutJourDateString(aDate, nbDay));
            return date;
        } catch (Exception e) {
            System.out.println("Error ajoutJourDate :".concat(String.valueOf(String.valueOf(e.getMessage()))));
        }
        Date date1 = null;
        return date1;
    }

    public static Date ajoutMoisDate(Date aDate, int nbMois) {
        try {
            Date date = string_date("dd/MM/yyyy", ajoutMoisDateString(aDate, nbMois));
            return date;
        } catch (Exception e) {
            System.out.println("Error ajoutMoisDate :".concat(String.valueOf(String.valueOf(e.getMessage()))));
        }
        Date date1 = null;
        return date1;
    }

    public static Date ajoutJourDate(String daty, int jour) {
        try {
            Date date = ajoutJourDate(string_date("dd/MM/yyyy", daty), jour);
            return date;
        } catch (Exception e) {
            System.out.println("Error ajoutJourDate :".concat(String.valueOf(String.valueOf(e.getMessage()))));
        }
        Date date1 = null;
        return date1;
    }

     public static Date string_date(String patterne, String daty) {
        try {
            if (daty == null || daty.compareTo("") == 0) {
                return null;
            }
            SimpleDateFormat formatter = new SimpleDateFormat(patterne);
            formatter.applyPattern(patterne);
            formatter.setTimeZone(TimeZone.getTimeZone("EUROPE"));
            String annee = getAnnee(daty);
            int anneecours = getAneeEnCours();
            int siecl = anneecours / 100;
            if (annee.toCharArray().length == 2) {
                annee = String.valueOf(siecl) + annee;
            }
            daty = getJour(daty) + "/" + getMois(daty) + "/" + annee;
            Date hiredate = new Date(formatter.parse(daty).getTime());
            Date date1 = hiredate;
            return date1;
        } catch (Exception e) {
            System.out.println("Error string_date wawawawa :" + e.getMessage());
        }
        Date date = dateDuJourSql();
        return date;
    }

    public static java.sql.Date stringToSqlDate(String pattern, String daty) {
        java.util.Date dateUtil = stringToDate(pattern, daty);
        java.sql.Date ret = new java.sql.Date(dateUtil.getTime());
        return ret;
    }

    public static java.sql.Date stringDate(String daty) {
        java.sql.Date sqlDate = dateDuJourSql();
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            java.util.Date date = sdf.parse(daty);
            sqlDate = new Date(date.getTime());
        } catch (Exception e) {
            System.out.println("Error stringDate :".concat(String.valueOf(String.valueOf(e.getMessage()))));
        }
        return sqlDate;
    }

    public static java.util.Date stringToDate(String pattern, String daty) {
        try {
            //System.out.println("DATY UTILITAIRE ".concat(String.valueOf(String.valueOf(pattern))));
            SimpleDateFormat formatter = new SimpleDateFormat(pattern);
            java.util.Date hiredate = formatter.parse(daty);
            java.util.Date date1 = hiredate;
            return date1;
        } catch (Exception e) {
            System.out.println("Error stringTodate :".concat(String.valueOf(String.valueOf(e.getMessage()))));
        }
        java.util.Date date = null;
        return date;
    }

    public int randomizer(int max) {
        int retour;
        for (retour = 0; retour <= 0; retour = r.nextInt(max));
        return retour;
    }

    public String randomizer_daty(int annee) {
        int mois = r.nextInt(13);
        int jour = r.nextInt(31);
        String retour = String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(jour)))).append("/").append(mois).append("/").append(annee)));
        return retour;
    }

    public static int getNbTuple(String nomTable) {
        Connection c = null;
        UtilDB util = new UtilDB();
        try {
            try {
                c = util.GetConn();
                String param = "select count(*) from ".concat(String.valueOf(String.valueOf(nomTable)));
                Statement sta = c.createStatement();
                ResultSet rs = sta.executeQuery(param);
                rs.next();
                int i = rs.getInt(1);
                return i;
            } catch (SQLException e) {
                System.out.println("getNbTuple : ".concat(String.valueOf(String.valueOf(e.getMessage()))));
            }
            int j = 0;
            return j;
        } finally {
            util.close_connection();
        }
    }

    public static int getMaxColonneFactFin(String daty) {
        UtilDB util = new UtilDB();
        Connection c = null;
        PreparedStatement cs = null;
        ResultSet rs = null;
        try {
            try {
                System.out.println("sasa MIDITRA");
                String an = getAnnee(daty);
                c = null;
                c = util.GetConn();
                System.out.println("sasa ");
                cs = c.prepareStatement(String.valueOf(String.valueOf((new StringBuffer("select * from  seqFact where daty<='31/12/")).append(an).append("' and daty>='01/01/").append(an).append("'"))));
                rs = cs.executeQuery();
                System.out.println("sasa sasaa");
                int i = 0;
                if (rs.next()) {
                    i++;
                }
                System.out.println("sasa ".concat(String.valueOf(String.valueOf(i))));
                if (i == 0) {
                    int k = 0;
                    return k;
                }
                int l = (new Integer(rs.getString(1))).intValue();
                return l;
            } catch (SQLException e) {
                System.out.println("getMaxSeq : ".concat(String.valueOf(String.valueOf(e.getMessage()))));
            }
            int j = 0;
            return j;
        } finally {
            try {
                if (c != null) {
                    c.close();
                }
                if (cs != null) {
                    cs.close();
                }
                if (rs != null) {
                    rs.close();
                }
                util.close_connection();
            } catch (SQLException e) {
                System.out.println("Erreur Fermeture SQL RechercheType ".concat(String.valueOf(String.valueOf(e.getMessage()))));
            }
        }
    }

    public static int getMaxSeq(String nomProcedure, Connection c) throws Exception {
        CallableStatement cs = null;
        ResultSet rs = null;
        try {
            //System.out.println("nomProcedure = " + nomProcedure);
            cs = c.prepareCall("select " + nomProcedure + " from dual");
            rs = cs.executeQuery();
            rs.next();
            int i = rs.getInt(1);
            return i;
        } catch (Exception e) {
            throw e;
        } finally {
            if (cs != null) {
                cs.close();
            }
            if (rs != null) {
                rs.close();
            }
        }
    }

    public static int getMaxSeq(String nomProcedure) {
        UtilDB util = new UtilDB();
        Connection c = null;
        try {
            c = util.GetConn();
            return getMaxSeq(nomProcedure, c);
        } catch (Exception eu) {
            eu.printStackTrace();
        } finally {
            try {
                if (c != null) {
                    c.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return 0;
    }

    public static String getColonneSomme(String[] listeCol) {
        if ((listeCol == null) || (listeCol.length == 0)) {
            return "0";
        }
        String retour = "sum(" + listeCol[0] + ")";
        for (int i = 1; i < listeCol.length; i++) {
            retour = retour + ",sum(" + listeCol[i] + ")";
        }
        System.out.print(retour);
        return retour;
    }

    public static int getMaxNum(String nomTable, String nomColonne) throws Exception {
        Connection c = null;
        UtilDB util = new UtilDB();
        Statement sta = null;
        ResultSet rs = null;
        try {
            try {
                c = util.GetConn();
                String param = String.valueOf(String.valueOf((new StringBuffer("select max(")).append(nomColonne).append(") from ").append(nomTable)));
                sta = c.createStatement();
                rs = sta.executeQuery(param);
                rs.next();
                int i = 1 + rs.getInt(1);
                return i;
            } catch (SQLException e) {
                System.out.println("getNbTuple : ".concat(String.valueOf(String.valueOf(e.getMessage()))));
            }
            int j = 0;
            return j;
        } finally {
            if (sta != null) {
                sta.close();
            }
            if (rs != null) {
                rs.close();
            }
            util.close_connection();
        }
    }

    public static int getNombreJourMois(String mois, String an) {
        try {
            String datyInf = getBorneDatyMoisAnnee(mois, an)[0];
            String datySup = getBorneDatyMoisAnnee(mois, an)[1];
            int j = diffJourDaty(datySup, datyInf);
            return j;
        } catch (Exception e) {
            System.out.println("getNombreJourMois : ".concat(String.valueOf(String.valueOf(e.getMessage()))));
        }
        int i = 0;
        return i;
    }

    public static int getNombreJourMois(String daty) {
        try {
            String mois = getMois(daty);
            String an = getAnnee(daty);
            int j = getNombreJourMois(mois, an);
            return j;
        } catch (Exception e) {
            System.out.println("getNombreJourMois : ".concat(String.valueOf(String.valueOf(e.getMessage()))));
        }
        int i = 0;
        return i;
    }

    public static String completerInt(int longuerChaine, int nombre) {
        String zero = null;
        zero = "";
        for (int i = 0; i < longuerChaine - String.valueOf(nombre).length(); i++) {
            zero = String.valueOf(String.valueOf(zero)).concat("0");
        }

        return String.valueOf(zero) + String.valueOf(String.valueOf(nombre));
    }

    public static String completerInt(int longuerChaine, String nombre2) {
        int nombre = stringToInt(nombre2);
        return completerInt(longuerChaine, nombre);
    }

    public static String heureCourante() {
        Calendar a = Calendar.getInstance();
        String retour = null;
        retour = String.valueOf(String.valueOf(completerInt(2, a.get(11)))).concat(":");
        retour = String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(retour)))).append(completerInt(2, a.get(12))).append(":")));
        retour = String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(retour)))).append(completerInt(2, a.get(13))).append(":")));
        retour = String.valueOf(retour) + String.valueOf(completerInt(2, a.get(14) / 10));
        return retour;
    }

    public static String heureCouranteHMS() {
        Calendar a = Calendar.getInstance();
        String retour = null;
        retour = String.valueOf(String.valueOf(completerInt(2, a.get(11)))).concat(":");
        retour = String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(retour)))).append(completerInt(2, a.get(12))).append(":")));
        retour = String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(retour)))).append(completerInt(2, a.get(13)))));
        return retour;
    }

    public static String dateDuJour() {
        Calendar a = Calendar.getInstance();
        String retour = null;
        retour = String.valueOf(String.valueOf(completerInt(2, a.get(5)))).concat("/");
        retour = String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(retour)))).append(completerInt(2, a.get(2) + 1)).append("/")));
        retour = String.valueOf(retour) + String.valueOf(completerInt(4, a.get(1)));
        return retour;
    }

    public static String datetostring(java.sql.Date d) {
        String daty = null;
        SimpleDateFormat dateJava = new SimpleDateFormat("dd/MM/yyyy");
        daty = dateJava.format(d);
        return daty;
    }

    public static Date dateDuJourSql() {
        return string_date("dd/MM/yyyy", dateDuJour());
    }

    public static String annulerZero(int nombre) {
        if (nombre == 0) {
            return " ";
        } else {
            return String.valueOf(nombre);
        }
    }

    public static Vector intersecter(ClassMAPTable objet1[], ClassMAPTable objet2[]) {
        Vector retour = new Vector();
        int dim1 = objet1.length;
        int dim2 = objet2.length;
        int nbEgaux = 0;
        for (int i = 0; i < dim1; i++) {
            String cle1 = objet1[i].getTuppleID();
            for (int j = 0; j < dim2; j++) {
                String cle2 = objet2[j].getTuppleID();
                if (cle1.compareTo(cle2) == 0) {
                    retour.add(nbEgaux, objet2[j]);
                    nbEgaux++;
                }
            }

        }
        return retour;
    }

    public static Vector intersecter(Vector objet1, Vector objet2) {
        Vector retour = new Vector();
        int dim1 = objet1.size();
        int dim2 = objet2.size();
        int nbEgaux = 0;
        for (int i = 0; i < dim1; i++) {
            ClassMAPTable temp = (ClassMAPTable) objet1.elementAt(i);
            String cle1 = temp.getTuppleID();
            for (int j = 0; j < dim2; j++) {
                ClassMAPTable temp2 = (ClassMAPTable) objet2.elementAt(j);
                String cle2 = temp2.getTuppleID();
                if (cle1.compareTo(cle2) == 0) {
                    retour.add(nbEgaux, temp2);
                    nbEgaux++;
                }
            }

        }

        return retour;
    }

    public static boolean intersecterIgnoreCase(String nomChamp, String valeur, ClassMAPTable objet1[]) {
        int dim1 = objet1.length;
        int nbEgaux = 0;
        for (int i = 0; i < dim1; i++) {
            String cle1 = objet1[i].getTuppleID();
            if (ref.compareTo(cle1) == 0) {
                return true;
            }
        }

        return false;
    }

    public static boolean intersecter(String ref, ClassMAPTable objet1[]) {
        int dim1 = objet1.length;
        int nbEgaux = 0;
        for (int i = 0; i < dim1; i++) {
            String cle1 = objet1[i].getTuppleID();
            if (ref.compareTo(cle1) == 0) {
                return true;
            }
        }

        return false;
    }

    public static boolean intersecter(String ref, Vector objet1) {
        int dim1 = objet1.size();
        int nbEgaux = 0;
        if (objet1 != null) {
            for (int i = 0; i < dim1; i++) {
                ClassMAPTable temp = (ClassMAPTable) objet1.elementAt(i);
                String cle1 = temp.getTuppleID();
                if (ref.compareTo(cle1) == 0) {
                    return true;
                }
            }

        }
        return false;
    }

    public static Object[] toArray(Vector v) {
        Object retour[] = new Object[v.size()];
        for (int i = 0; i < v.size(); i++) {
            retour[i] = v.elementAt(i);
        }

        return retour;
    }

    public static String getRequest(String temp) {
        if (temp == null || temp.compareTo("") == 0) {
            return "";
        } else {
            return temp;
        }
    }

    public static String getValeurNonNull(String temp) {
        if (temp == null || temp.compareTo("") == 0) {
            return "%";
        } else {
            return temp;
        }
    }

    public static String makePK(int longPK, String indPk, String nomProcedureSequence) throws Exception {
        int maxSeq = getMaxSeq(nomProcedureSequence);
        String nombre = completerInt(longPK, maxSeq);
        return String.valueOf(indPk) + String.valueOf(nombre);
    }

    public static String[] getNomColonne(Object a) {
        String retour[] = null;
        Field f[] = a.getClass().getDeclaredFields();
        retour = new String[f.length];
        for (int i = 0; i < f.length; i++) {
            retour[i] = f[i].getName();
        }

        return retour;
    }

    public static String[] getNomColonne(Object a, String typ) {
        String retour[] = null;
        Field f[] = a.getClass().getFields();
        Vector v = new Vector();
        for (int i = 0; i < f.length; i++) {
            if (typ.compareToIgnoreCase("nombre") == 0) {
                if ((f[i].getType().getName().compareToIgnoreCase("int") == 0) || (f[i].getType().getName().compareToIgnoreCase("double") == 0) || (f[i].getType().getName().compareToIgnoreCase("float") == 0) || (f[i].getType().getName().compareToIgnoreCase("short") == 0)) {
                    v.add(f[i].getName());
                }
            }
            if (typ.compareToIgnoreCase("chaine") == 0) {
                if (f[i].getType().getName().compareToIgnoreCase("String") == 0) {
                    v.add(f[i].getName());
                }
            }
        }
        retour = new String[v.size()];
        v.copyInto(retour);
        return retour;
    }

    public static String cryptWord(String mot) {
        int niveau = (int) Math.round(Math.random() * 10);
        int sens = (int) Math.round(Math.random());
        if (niveau == 0) {
            niveau = -5;
        }
        return (cryptWord(mot, niveau, sens));
    }

    public static String cryptWord(String mot, int niveauCrypt, int croissante) {
        if (croissante == 0) {
            return cryptWord(mot, niveauCrypt, true);
        } else {
            return cryptWord(mot, niveauCrypt, false);
        }
    }

    public static String cryptWord(String mot, int niveauCrypt, boolean croissante) {
        char[] ar = mot.toCharArray();
        char[] retour = new char[ar.length];

        if (croissante) {
            for (int i = 0; i < ar.length; i++) {
                int k = Character.getNumericValue(ar[i]);
                if (k < (Character.MAX_RADIX - niveauCrypt)) {
                    retour[i] = Character.forDigit(k + niveauCrypt, Character.MAX_RADIX);
                } else {
                    retour[i] = ar[i];
                }
            }
        } else {
            for (int i = 0; i < ar.length; i++) {
                int k = Character.getNumericValue(ar[i]);
                if (k > (niveauCrypt - 1)) {
                    retour[i] = Character.forDigit(k - niveauCrypt, Character.MAX_RADIX);
                } else {
                    retour[i] = ar[i];
                }
            }
        }

        return new String(retour);
    }

    public static String unCryptWord(String mot, int niveauCrypt, boolean croissante) {
        char[] ar = mot.toCharArray();
        char[] retour = new char[ar.length];

        if (croissante) {
            for (int i = 0; i < ar.length; i++) {
                int k = Character.getNumericValue(ar[i]);
                if (k < (Character.MAX_RADIX - niveauCrypt)) {
                    retour[i] = Character.forDigit(k - niveauCrypt, Character.MAX_RADIX);
                } else {
                    retour[i] = ar[i];
                }
            }
        } else {
            for (int i = 0; i < ar.length; i++) {
                int k = Character.getNumericValue(ar[i]);
                if (k > (niveauCrypt - 1)) {
                    retour[i] = Character.forDigit(k + niveauCrypt, Character.MAX_RADIX);
                } else {
                    retour[i] = ar[i];
                }
            }
        }
        return new String(retour);
    }

    public static String nbToMois(int nombre) {
        String mois = null;
        switch (nombre) {
            case 1: // '\001'
                mois = "janvier";
                break;

            case 2: // '\002'
                mois = "f�vrier";
                break;

            case 3: // '\003'
                mois = "mars";
                break;

            case 4: // '\004'
                mois = "avril";
                break;

            case 5: // '\005'
                mois = "mai";
                break;

            case 6: // '\006'
                mois = "juin";
                break;

            case 7: // '\007'
                mois = "juillet";
                break;

            case 8: // '\b'
                mois = "ao�t";
                break;

            case 9: // '\t'
                mois = "septembre";
                break;

            case 10: // '\n'
                mois = "octobre";
                break;

            case 11: // '\013'
                mois = "novembre";
                break;

            case 12: // '\f'
                mois = "d�cembre";
                break;

            default:
                mois = null;
                break;
        }
        return mois;
    }

    static Random r = new Random();

    public static String datedujourlettre(String dat) {
        String mois = convertDebutMajuscule(nbToMois(Utilitaire.stringToInt(Utilitaire.getMois(dat))));
        String annee = getAnnee(dat);
        String daty = mois + " " + annee;
        return daty;
    }

    public static Date[] getDaty(String[] dayofweeks, Date dateInf, Date dateSup) {
        Date[] retour = null;
        DateFormatSymbols dfsFR = new DateFormatSymbols(Locale.FRENCH);
        String[] joursSemaineFR = dfsFR.getWeekdays();
        Vector listDate = new Vector();

        int diff = diffJourDaty(dateSup, dateInf);

        for (int j = 0; j < dayofweeks.length; j++) {
            Date temp = dateInf;
            for (int i = 0; i < diff; i++) {
                if (dayofweeks[j].compareToIgnoreCase(joursSemaineFR[i]) == 0);
            }
        }

        return retour;
    }

    public static String intToString(int a) {
        String s = "";
        try {
            Integer ger = new Integer(a);
            String i = ger.toString(a);
            String res = i;
            //System.out.println("i="+i);
            return res;
        } catch (NumberFormatException ex) {
            //System.out.println("niditra ve");
            s = "";
        }
        return s;
    }

    public static int doubleToInt(String s) {
        Double d = new Double(s);
        int i = d.intValue();
        return i;
    }

    public static String getTomorowDate() {
        Calendar calendar = Calendar.getInstance();
        calendar.add(calendar.DAY_OF_MONTH, 1);
        return format(calendar.getTime());
    }

    public static String getPrevDate(int nb, String date) {
        String prev = null;
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(stringToDate("dd/MM/yyyy", date));
        calendar.add(calendar.DAY_OF_MONTH, nb);
        prev = format(calendar.getTime());
        return prev;
    }

    public static String getYesterdayDate(java.util.Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.add(calendar.DAY_OF_MONTH, -1);
        return format(calendar.getTime());
    }

    public static String format(java.util.Date date) {

        SimpleDateFormat fmt = new SimpleDateFormat("dd/MM/yyyy");
        String dateFormatted = fmt.format(date);

        return dateFormatted;
    }

    public static String verifNumerique(String s) {
        /*String res=s;
       res=res.replace(',', '.');
       String[] temp=split(res,' ');
       res="";
       for(int i=0;i<temp.length;i++)
           res+=temp[i];
       try{
           Float.valueOf(res);
           return res;
       }
       catch(Exception e)
               {
                   return s;
               }*/
        return s;
    }

    public static String enleverEspaceDoubleBase(String montantBase) {
        String montant = "";
        for (int i = 0; i < montantBase.length(); ++i) {
            char c = montantBase.charAt(i);
            int j = (int) c;
            //System.out.println("ASCII value of " + c + " is " + j + ".");
            if (j != 160) {
                montant += c;
            }
        }
        return montant;
    }

    public static String getMaxId(String table) {

        String retour = "---";
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            java.sql.Statement sta = c.createStatement();
            java.sql.ResultSet res = sta.executeQuery("select max(id) from " + table);
            res.next();
            retour = res.getString(1);
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                c.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }

        return retour;
    }

    public static String formaterAr2(double montant) {
        try {
            if (montant == 0) {
                return "<center>-</center>";
            }
            return formaterAr(montant);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static String champNull(String nul) {
        if (nul == null) {
            return "";
        } else if (nul.compareToIgnoreCase("null") == 0) {
            return "";
        } else if (nul.compareToIgnoreCase("") == 0) {
            return "";
        } else {
            return nul;
        }
    }

    public static String incrementLettre(char[] lettreInit) {
        for (int i = lettreInit.length - 1; i >= 0; i--) {
            for (char j = 'A'; j <= 'Z'; j++) {
                if (lettreInit[i] == j && j == 'Z') {
                    lettreInit[i] = 'A';
                } else if (lettreInit[i] == j && j < 'Z') {
                    char tmp = j;
                    tmp = (char) (tmp + 1);
                    lettreInit[i] = tmp;
                    return new String(lettreInit);
                }
            }
        }
        return null;
    }

    public static boolean isStringNumeric(String str) {
        if (str == null || str.compareTo("") == 0) {
            return false;
        }
        DecimalFormatSymbols currentLocaleSymbols = DecimalFormatSymbols.getInstance();
        char localeMinusSign = currentLocaleSymbols.getMinusSign();

        boolean isDecimalSeparatorFound = false;
        char localeDecimalSeparator = currentLocaleSymbols.getDecimalSeparator();
//        System.out.println("VALEUR : "+str);
        for (char c : str.substring(1).toCharArray()) {
            if (!Character.isDigit(c)) {
                if (c == localeDecimalSeparator && !isDecimalSeparatorFound && c != ' ') {
                    isDecimalSeparatorFound = true;
                    continue;
                }
                return false;
            }
        }
        return true;

    }

    public static String formaterSansVirgule(double montant) {
        try {
            if (montant == 0) {
                return "0";
            }
            NumberFormat nf = NumberFormat.getInstance(Locale.FRENCH);
            //nf = new DecimalFormat("### ###,##");
            //nf.setMaximumFractionDigits(2);
            nf.setMinimumFractionDigits(0);
            String s = nf.format(montant);
            return s;
        } catch (Exception e) {
            e.printStackTrace();
        }
        String s1 = null;
        return s1;
    }
    public static String tabToString(String[] s, String quote, String virgule) {
        String res = "";
        try {
            res = quote + s[0] + quote;
            for (int i = 1; i < s.length; i++) {
                res = res + virgule + quote + s[i] + quote;
            }
        } catch (NumberFormatException ex) {
            ex.printStackTrace();
        }
        return res;
    }
    public static int getSommeColonneMultiCritere(String nomTable, String nomColonne, String whereCritereContact) throws Exception {
        Connection c = null;
        UtilDB util = new UtilDB();
        Statement sta = null;
        ResultSet rs = null;
        int sum = 0;
        try {
            c = util.GetConn();
            String param = String.valueOf(String.valueOf((new StringBuffer("select sum(")).append(nomColonne).append(") from ").append(nomTable).append(" where ").append(whereCritereContact)));
            //System.out.print("param3333:"+param);
            sta = c.createStatement();
            rs = sta.executeQuery(param);
            rs.next();
            sum = rs.getInt(1);
        } catch (SQLException e) {
            System.out.println("getNbTuple : ".concat(String.valueOf(String.valueOf(e.getMessage()))));
        } finally {
            if (sta != null) {
                sta.close();
            }
            if (rs != null) {
                rs.close();
            }
            util.close_connection();
        }
        return sum;
    }

    public static String formatSqlDate(String daty)
    {
        String[] splitDaty=daty.split("-");
        String retour=splitDaty[2]+"-"+splitDaty[1]+"-"+splitDaty[0];
        return retour;
    }
    public static Ecole[] listecole() throws Exception,SQLException {
        Connection c = null;
        UtilDB util = new UtilDB();
        c = util.GetConn();
        Ecole[] ecole = (Ecole[]) CGenUtil.rechercher(new Ecole(), null, null, c,"");
        c.close();
        return ecole;
    }
    public static EtatDeCaisse[] getEtatCaisse(String datydebut,String datyfin,String idecole) throws Exception
    {
        String sql=String.format("SELECT "+
                        "r.*, "+
                        "nvl(mvt.debit,0) debit, "+
                        "nvl(mvt.credit,0) credit, "+
                        "(nvl(r.MONTANT,0)+nvl(mvt.credit,0)-nvl(mvt.debit,0)) reste, "+
                        "maxdaty.daty datydernier, "+
                        "c.desccaisse caisse, "+
                        "e.nom ecole "+ 
                    "FROM "+ 
                        "report r, "+
                        "caisse c, "+
                        "ecole e, "+
                        "( "+
                            "select "+ 
                                "idcaisse,IDECOLE ,max(daty) AS daty "+ 
                            "from "+ 
                                "report "+
                            "WHERE "+ 
                                "daty<=to_date('%s','yyyy-mm-dd') "+
                            "GROUP BY idcaisse,IDECOLE "+
                        ") maxdaty, "+
                       "( "+
                            "SELECT "+
                                "sum(nvl(mvt.debit,0)) debit, "+
                                "sum(nvl(mvt.credit,0)) credit, "+
                                "mvt.idcaisse idcaisse, "+
                                "mvt.IDECOLE  IDECOLE "+ 
                            "FROM "+ 
                                "MVTCAISSE mvt, "+
                                "( "+
                                    "select "+ 
                                        "idcaisse,IDECOLE ,max(daty) AS daty "+ 
                                    "from "+ 
                                        "report "+
                                    "WHERE "+ 
                                        "daty<=to_date('%s','yyyy-mm-dd') "+
                                    "GROUP BY idcaisse,IDECOLE "+
                                ") maxdaty "+
                            "WHERE "+ 
                                "mvt.IDCAISSE =maxdaty.idcaisse "+
                                "AND mvt.idecole=maxdaty.idecole "+ 
                                "AND mvt.DATY>=maxdaty.daty "+
                                "AND mvt.daty<=to_date('%s','yyyy-mm-dd') "+
                            "GROUP BY "+ 
                                "mvt.idcaisse, "+
                                "mvt.idecole "+
                        ") mvt "+
                    "WHERE "+ 
                        "r.idcaisse=maxdaty.idcaisse "+ 
                        "AND r.idecole=maxdaty.idecole "+
                        "AND r.daty=maxdaty.daty "+
                        "AND r.idcaisse=mvt.idcaisse(+) "+
                        "AND r.idcaisse=c.idcaisse(+) "+
                        "AND r.idecole=e.id(+) "+
                        "AND r.idecole=mvt.IDECOLE(+) "+
                        "AND r.idecole like '%s'"
                        ,datydebut,datydebut,datyfin,idecole);
        System.out.println(sql);
        EtatDeCaisse[] caisse = (EtatDeCaisse[]) CGenUtil.rechercher(new EtatDeCaisse(),sql);
        return caisse;
    }
   
}
