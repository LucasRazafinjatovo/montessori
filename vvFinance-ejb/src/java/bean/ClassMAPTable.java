// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   ClassMAPTable.java
package bean;

import java.io.PrintStream;
import java.io.Serializable;
import java.lang.reflect.Field;
import java.sql.*;
import java.util.Vector;
import utilitaire.*;
import java.lang.reflect.*;
import historique.MapHistorique;

public abstract class ClassMAPTable
        implements Serializable {
	public static final boolean isMirroring =true;
    public static final String histoSync ="HISTORIQUE_SYNC";
    public ClassMAPTable() {
        INDICE_PK = "EX";
        nomProcedureSequence = "GetSeqExecutions";
        longuerClePrimaire = 6;
        setNombreChamp();
    }

    public String makePK(Connection c) throws Exception {
        int maxSeq = Utilitaire.getMaxSeq(nomProcedureSequence, c);
        String nombre = Utilitaire.completerInt(longuerClePrimaire, maxSeq);
        return String.valueOf(INDICE_PK) + String.valueOf(nombre);
    }

    public void construirePK(Connection c) throws Exception {
    }

    public void controler(Connection c) throws Exception {

    }

    public void controlerUpdate(Connection c) throws Exception {

    }

    public String makePK() {
        int maxSeq = Utilitaire.getMaxSeq(nomProcedureSequence);
        String nombre = Utilitaire.completerInt(longuerClePrimaire, maxSeq);
        return String.valueOf(INDICE_PK) + String.valueOf(nombre);
    }

    public String makePK(String indicePK, String fonct) throws Exception {
        this.preparePk(indicePK, fonct);
        return makePK();
    }

    public String makePKCFin(String daty) {
        int maxSeq = getMaxColonneFactFin(daty) + 1;
        String nombre = Utilitaire.completerInt(longuerClePrimaire, maxSeq);
        return String.valueOf(INDICE_PK) + String.valueOf(nombre);
    }

    public String makePKCFinEntite(String daty, String entite) {
        int maxSeq = getMaxColonneFactFinEntite(daty, entite) + 1;
        String nombre = Utilitaire.completerInt(longuerClePrimaire, maxSeq);
        return String.valueOf(INDICE_PK) + String.valueOf(nombre);
    }

    public String makePKCFinEntite(String daty, String entite, Connection c) {
        int maxSeq = getMaxColonneFactFinEntite(daty, entite, c) + 1;
        String nombre = Utilitaire.completerInt(longuerClePrimaire, maxSeq);
        return String.valueOf(INDICE_PK) + String.valueOf(nombre);
    }
    
    public String makePKCFinEntiteProforma(String daty, String entite) {
        int maxSeq = getMaxColonneFactFinEntiteProforma(daty, entite) + 1;
        String nombre = Utilitaire.completerInt(longuerClePrimaire, maxSeq);
        return String.valueOf(INDICE_PK) + String.valueOf(nombre);
    }

    public void setIndicePk(String indice) {
        INDICE_PK = indice;
    }

    public void setNomProcedureSequence(String seq) {
        nomProcedureSequence = seq;
    }

    public void setLonguerClePrimaire(int longueur) {
        if (longueur > 0) {
            longuerClePrimaire = longueur;
        }
    }

    public String getNomTable() {
        if (nomTable == null) {
            if (this.nomTableSelect == null) {
                return this.getClassName();
            }
            return nomTableSelect;
        }
        return nomTable;
    }

    public void setNomTable(String table) {
        nomTable = table;
    }

    public abstract String getTuppleID();

    public abstract String getAttributIDName();

    public String getClassName() {
        return getClass().getName();
    }

    public Field[] getFieldList() throws ClassMAPTableException {
        try {
            Class cls = getClass();
            Field retour[] = new Field[nombreChamp];
            Field fieldlist[] = cls.getDeclaredFields();
            for (int i = 0; i < nombreChamp; i++) {
                retour[i] = fieldlist[i];
            }
            return retour;
        } catch (Exception e) {
            throw new ClassMAPTableException(e.getMessage());
        }
    }

    public void setNombreChamp() {
        Class cls = getClass();
        Field fieldlist[] = cls.getDeclaredFields();
        nombreChamp = fieldlist.length;
    }

    public void setNombreChamp(int nouveau) {
        nombreChamp = nouveau;
    }

    public void setFieldList() {
        try {
            cls = getClass();
            Field fieldlist[] = cls.getDeclaredFields();
            for (int i = 0; i < fieldlist.length; i++) {
                champ.add(i, fieldlist[i]);
            }

            nombreChamp = fieldlist.length;
        } catch (Exception e) {
            System.out.println("SETFIELDLIST ERREUR".concat(String.valueOf(String.valueOf(e.getMessage()))));
        }
    }

    public void setFieldList(Field a) {
        try {
            champ.add(nombreChamp, a);
            nombreChamp++;
        } catch (Exception e) {
            System.out.println("SETFIELDLIST ERREUR".concat(String.valueOf(String.valueOf(e.getMessage()))));
        }
    }

    protected int getTypeMAPField(Field fld) {
        String nomClasse = fld.getType().getName();
        if (nomClasse.equals("boolean")) {
            return 0;
        }
        if (nomClasse.equals("byte")) {
            return 1;
        }
        if (nomClasse.equals("short")) {
            return 2;
        }
        if (nomClasse.equals("int")) {
            return 3;
        }
        if (nomClasse.equals("long")) {
            return 4;
        }
        if (nomClasse.equals("float")) {
            return 5;
        }
        if (nomClasse.equals("Real")) {
            return 5;
        }
        if (nomClasse.equals("double")) {
            return 6;
        }
        if (nomClasse.equals("java.lang.String")) {
            return 10;
        }
        if (nomClasse.equals("java.sql.Date")) {
            return 21;
        }
        if (nomClasse.equals("java.sql.Time")) {
            return 22;
        }
        if (nomClasse.equals("java.sql.Blob")) {
            return 31;
        }
        if (nomClasse.equals("java.sql.Clob")) {
            return 32;
        }
        return !nomClasse.equals("java.lang.Integer") ? -1 : 33;
    }

    public int deleteToTableWithHisto(String refUser, Connection con) throws Exception {
        MapHistorique histo = new MapHistorique(this.getNomTable(), "delete", refUser, this.getTuppleID());
        this.deleteToTable(con);
        histo.insertToTable(con);
        return 0;
    }

    public int deleteToTableWithHisto(String refUser) throws Exception {
        Connection con = null;
        try {
            con = new UtilDB().GetConn();
            con.setAutoCommit(false);
            deleteToTableWithHisto(refUser, con);
            con.commit();
            return 1;
        } catch (Exception ex) {
            con.rollback();
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        } finally {
            if (con != null) {
                con.close();
            }
        }

    }

    public int deleteToTable(Connection cDb) throws Exception {
        PreparedStatement stmt,insertHistoSync = null;
        String sqlQry;
        int retoure;
        String tableName = getNomTable();
        stmt = null;
        Field fld = null;
        sqlQry = "DELETE FROM " + tableName;
        retoure = 0;
        try {
            //Field fieldlist[] = getFieldList();
            sqlQry = sqlQry + " WHERE " + getAttributIDName() + " = '"+getTuppleID()+"'";
            stmt = cDb.prepareStatement(sqlQry);
			if(isMirroring){
                if(tableName.compareTo(histoSync)!=0 && tableName.compareToIgnoreCase("HISTORIQUE")!=0){
                    String query = "INSERT INTO "+histoSync+" (ID,ACTION,TABLECONCERNE,REQUETE,ETAT) VALUES (getSeqHistoriqueSync,?,?,?,1)";
                    insertHistoSync = cDb.prepareCall(query);
                    insertHistoSync.setString(1, "DELETE");
                    insertHistoSync.setString(2, tableName);
                    insertHistoSync.setString(3, sqlQry);
                    insertHistoSync.executeUpdate();
                }                
            }
            //stmt.setString(1, getTuppleID());
            //System.out.println("SQLQUERY:"+sqlQry);
            int retour = stmt.executeUpdate();
            cDb.commit();
            if (retour == 0) {
                throw new Exception("Erreur suppression dans la table");
            }
            retoure = 1;
        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (cDb != null) {
                    cDb.rollback();
                }
                throw new Exception("ERREUR deleteToTable " + e.getMessage());
            } catch (Exception ee) {
                throw new Exception("ERREUR SQL AVEC CONN " + ee.getMessage());
            }
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                //if(cDb!=null) cDb.close();

            } catch (Exception se) {
                Log.setLog(getClassName() + " - probl�me de fermeture d'1 Statement ");
            }
            return retoure;
        }
    }

    public int deleteToTable() {
        UtilDB util = new UtilDB();
        Connection c = null;
        try {
            try {
                c = util.GetConn();
                c.setAutoCommit(false);
                int i = deleteToTable(c);
                return i;
            } catch (Exception e) {
                if (c != null) {
                    try {
                        c.rollback();
                    } catch (SQLException e1) {
                        e1.printStackTrace();
                    }
                }
                System.out.println("ERREUR DELETE_TABLE ".concat(String.valueOf(String.valueOf(e.getMessage()))));
            }
            int j = 0;
            return j;
        } finally {
            try {
                if (c != null) {
                    c.close();
                }
                util.close_connection();
            } catch (Exception exception1) {
            }
        }
    }

    public int deleteToTable(ClassMAPTable histo)
            throws ErreurDAO {
        UtilDB util = new UtilDB();
        Connection c = null;
        try {
            c = util.GetConn();
            util.commitOFF();
            histo.insertToTable(c);
            int i = deleteToTable(c);
            c.commit();
            int j = 1;
            return j;
        } catch (Exception e) {
            try {
                c.rollback();
                throw new ErreurDAO(String.valueOf(String.valueOf((new StringBuffer("ERREUR deleteToTable ")).append(e.getMessage()).append(" ").append(e.getMessage()))));
            } catch (Exception ee) {
                throw new ErreurDAO(String.valueOf(String.valueOf((new StringBuffer("ERREUR SQL ")).append(e.getMessage()).append(" ").append(ee.getMessage()))));
            }
        } finally {
            try {
                if (c != null) {
                    c.close();
                }
                util.close_connection();
            } catch (Exception exception1) {
            }
        }
    }

    public int deleteToTable(ClassMAPTable histo, Connection c)
            throws ErreurDAO {
        try {
            histo.insertToTable(c);
            int i = deleteToTable(c);
            int j = 1;
            return j;
        } catch (Exception e) {
            try {
                throw new ErreurDAO(e.getMessage());
            } catch (Exception ee) {
                throw new ErreurDAO(e.getMessage());
            }
        }
    }
    
    public int updateToTable(Connection cDb)
            throws Exception {
        String tableName = getNomTable();
        PreparedStatement stmt = null, insertHistoSync=null;
        Field fld = null;
        String sqlQry = String.valueOf(String.valueOf((new StringBuffer("UPDATE ")).append(tableName).append(" SET ")));
        try {
            Field fieldlist[] = ListeColonneTable.getChampBase(this, cDb);
            //Field fieldlist[] = getFieldList();
            for (int i = 0; i < fieldlist.length; i++) {
                fld = fieldlist[i];
                sqlQry = String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(sqlQry)))).append(fld.getName()).append(" = ? ")));
                if (i + 1 < fieldlist.length) {
                    sqlQry = String.valueOf(String.valueOf(sqlQry)).concat(", ");
                }
            }

            sqlQry = String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(sqlQry)))).append(" WHERE ").append(getAttributIDName()).append(" = ? ")));

            stmt = cDb.prepareStatement(sqlQry);
			String enTete = "UPDATE "+tableName+" SET ";
            for (int i = 0; i < fieldlist.length; i++) {
                fld = fieldlist[i];
                // System.out.println("================= "+getTypeMAPField(fld)+" "+this.getValField(fld));
				String valStr="";
                switch (getTypeMAPField(fld)) {
                    case 0: // '\0'
                        stmt.setBoolean(i + 1, ((Boolean) this.getValField(fld)).booleanValue());
						valStr="'"+((Boolean) this.getValField(fld)).booleanValue()+"'";
                        break;

                    case 1: // '\001'
                        stmt.setByte(i + 1, ((Byte) this.getValField(fld)).byteValue());
						valStr="'"+((Byte) this.getValField(fld)).byteValue()+"'";
                        break;

                    case 2: // '\002'
                        stmt.setShort(i + 1, ((Short) this.getValField(fld)).shortValue());
						valStr="'"+((Byte) this.getValField(fld)).byteValue()+"'";
                        break;

                    case 3: // '\003'
                        Integer it = (Integer) this.getValField(fld);
                        stmt.setInt(i + 1, it.intValue());
						valStr="'"+it.intValue()+"'";
                        break;

                    case 4: // '\004'
                        Long lo = (Long) this.getValField(fld);
                        stmt.setLong(i + 1, lo.longValue());
						valStr="'"+lo.longValue()+"'";
                        break;

                    case 5: // '\005'
                        stmt.setFloat(i + 1, ((Float) this.getValField(fld)).floatValue());
						valStr="'"+((Float) this.getValField(fld)).floatValue()+"'";
                        break;

                    case 6: // '\006'
                        stmt.setDouble(i + 1, ((Double) this.getValField(fld)).doubleValue());
						valStr="'"+((Double) this.getValField(fld)).doubleValue()+"'";
                        break;

                    case 10: // '\n'
                        stmt.setString(i + 1, (String) this.getValField(fld));
						valStr="'"+ (String) this.getValField(fld)+"'";
                        break;

                    case 21: // '\025'
                        stmt.setDate(i + 1, (Date) this.getValField(fld));
						if((Date) this.getValField(fld) != null) valStr  = "'"+Utilitaire.formatterDatySql((Date) this.getValField(fld))+"'";
						else valStr = "'null'";
                        break;

                    case 33: // '!'
                        stmt.setInt(i + 1, ((Integer) this.getValField(fld)).intValue());
						valStr="'"+ ((Integer) this.getValField(fld)).intValue()+"'";
                        break;
                }
				valStr = (valStr.compareToIgnoreCase("'null'")==0)?null:valStr;
                if (i + 1 < fieldlist.length) {
                   enTete+= fld.getName()+"="+valStr+", ";
                }else{
                   enTete+= fld.getName()+"="+valStr+" ";
                }
            }
			enTete+=" WHERE "+getAttributIDName()+" =  '"+ getTuppleID()+"' ";
            stmt.setString(fieldlist.length + 1, getTuppleID());
            System.out.println("SQL command : \n" + sqlQry);
            int retour = stmt.executeUpdate();
            if (retour == 0) {
                throw new Exception("Erreur modification dans la table");
            }
           if(isMirroring){
               if(tableName.compareTo(histoSync)!=0 && tableName.compareToIgnoreCase("HISTORIQUE")!=0){
                    String query = "INSERT INTO "+histoSync+" (ID,ACTION,TABLECONCERNE,REQUETE,ETAT) VALUES (getSeqHistoriqueSync,?,?,?,1)";
                    insertHistoSync = cDb.prepareCall(query);
                    insertHistoSync.setString(1, "UPDATE");
                    insertHistoSync.setString(2, tableName);
                    insertHistoSync.setString(3, enTete);
                    insertHistoSync.executeUpdate();
                }                
            }
            int j = 1;
            //cDb.commit();
            return j;
        } catch (Exception e) {
            e.printStackTrace();
           /* if (cDb != null) {
                cDb.rollback();
            }*/
            throw new Exception("Erreur update dans la table \n" + e.getMessage());
        } finally {
            try {
				if(insertHistoSync!=null)
                    insertHistoSync.close();
                if (stmt != null) {
                    stmt.close();
                }
            } catch (SQLException se) {
                Log.setLog(String.valueOf(String.valueOf(getClassName())).concat(" - probl�me de fermeture d'1 Statement "));
            }
        }
    }

    public int upDateToTable() {
        UtilDB util = new UtilDB();
        Connection c = null;
        try {
            try {
                c = util.GetConn();
                c.setAutoCommit(false);
                int i = updateToTable(c);
                c.commit();
                return i;
            } catch (Exception e) {
                if (c != null) {
                    try {
                        c.rollback();
                    } catch (SQLException e1) {
                        e1.printStackTrace();
                    }
                }
                System.out.println(String.valueOf(String.valueOf((new StringBuffer("ERREUR UPDATE_TABLE ")).append(getNomTable()).append(" ").append(e.getMessage()))));
            }
            int j = 0;
            return j;
        } finally {
            try {
                if (c != null) {
                    c.close();
                }
                util.close_connection();
            } catch (Exception exception1) {
            }
        }
    }

    public int updateToTableWithHisto(String refUser, Connection c) throws Exception {

        try {
            MapHistorique histo = new MapHistorique(this.getNomTable(), "update", refUser, this.getTuppleID());
            return this.updateToTableWithHisto(histo, c);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("ERREUR UPDATE 2" + e.getMessage());
        }

    }

    public int updateToTableWithHisto(String refUser) throws Exception {

        UtilDB util = new UtilDB();
        Connection c = null;
        try {
            c = util.GetConn();
            c.setAutoCommit(false);
            int i = updateToTableWithHisto(refUser, c);
            c.commit();
            return i;
        } catch (Exception e) {
            if (c != null) {
                try {
                    c.rollback();
                } catch (SQLException e1) {
                    e1.printStackTrace();
                }
            }
            throw new Exception("ERREUR Update 1 ".concat(String.valueOf(String.valueOf(e.getMessage()))));
        } finally {
            try {
                if (c != null) {
                    c.close();
                }
            } catch (Exception exception1) {
            }
        }

    }

    public int insertToTableWithHisto(String refUser) throws Exception {
        try {
            MapHistorique histo = new MapHistorique(this.getNomTable(), "insert", refUser, this.getTuppleID());
            return insertToTable(histo);
        } catch (Exception e) {
            throw new Exception("ERREUR INSERT_TABLEtttttttttttttttttt ".concat(String.valueOf(String.valueOf(e.getMessage()))));
        }

    }

    public int insertToTableWithHisto(String refUser, java.sql.Connection c) throws ErreurDAO {

        try {
            MapHistorique histo = new MapHistorique(this.getNomTable(), "insert", refUser, this.getTuppleID(), c);
            return insertToTable(histo, c);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ErreurDAO("ERREUR INSERT_TABLEtttttttttttttttttt " + e.getMessage());
        }

    }

    public int updateToTableWithHisto(ClassMAPTable histo, Connection c)
            throws Exception {
        UtilDB util = new UtilDB();
        try {
            histo.insertToTable(c);
            return (updateToTable(c));
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("ERREUR UPDATE_TABLE 3 " + e.getMessage());
        }
    }

    public int updateToTableWithHisto(ClassMAPTable histo)
            throws ErreurDAO {
        UtilDB util = new UtilDB();
        Connection c = null;
        try {
            c = util.GetConn();
            c.setAutoCommit(false);
            histo.insertToTable(c);
            int i = updateToTable(c);
            c.commit();
            int j = 1;
            return j;
        } catch (Exception e) {
            if (c != null) {
                try {
                    c.rollback();
                } catch (SQLException e1) {
                    e1.printStackTrace();
                }
            }
            throw new ErreurDAO(String.valueOf(String.valueOf((new StringBuffer("ERREUR UPDATE_TABLE ")).append(getNomTable()).append(" ").append(e.getMessage()))));
        } finally {
            try {
                if (c != null) {
                    c.close();
                }
                util.close_connection();
            } catch (Exception exception1) {
            }
        }
    }

    public int insertToTable(ClassMAPTable histo, Connection c) throws Exception {

        try {
            int i = insertToTable(c);
            return (histo.insertToTable(c));
        } catch (Exception e) {
            throw new Exception("ERREUR INSERT_TABLEtttttttttttttttttt ".concat(String.valueOf(String.valueOf(e.getMessage()))));
        }
    }

    public int insertToTable(ClassMAPTable histo)
            throws Exception {
        UtilDB util = new UtilDB();
        Connection c = null;
        try {
            c = util.GetConn();
            c.setAutoCommit(false);
            int i = insertToTable(histo, c);
            c.commit();
            return i;
        } catch (Exception e) {
            if (c != null) {
                try {
                    c.rollback();
                } catch (SQLException e1) {
                    e1.printStackTrace();
                    throw new Exception(e.getMessage());
                }
            }
            throw new Exception("ERREUR INSERT_TABLEtttttttttttttttttt ".concat(String.valueOf(String.valueOf(e.getMessage()))));
        } finally {
            try {
                if (c != null) {
                    c.close();
                }
                util.close_connection();
            } catch (Exception exception1) {
            }
        }
    }

    public int insertToTable() {
        UtilDB util = new UtilDB();
        Connection c = null;
        int retour = 0;
        try {
            try {
                c = util.GetConn();
                c.setAutoCommit(false);
                retour = insertToTable(c);
                c.commit();
                int i = retour;
                return i;
            } catch (Exception e) {
                if (c != null) {
                    try {
                        c.rollback();
                    } catch (SQLException e1) {
                        e1.printStackTrace();
                    }
                }
                System.out.println("ERREUR INSERT_TABLE ".concat(String.valueOf(String.valueOf(e.getMessage()))));
            }
            int j = 0;
            return j;
        } finally {
            try {
                if (c != null) {
                    c.close();
                }
                util.close_connection();
            } catch (Exception e) {
                System.out.println("ERREUR FERMETURE CONNECTION INSERT_TABLE ".concat(String.valueOf(String.valueOf(e.getMessage()))));
            }
        }
    }

    public int insertToTable(Connection cDb)
            throws Exception {
        String tableName = getNomTable();
        PreparedStatement stmt = null,insertHistoSync=null;
        Field fld = null;
        String sqlQry = "INSERT INTO " + tableName + " ( ";
        String sqlTmp = " ) VALUES ( ";
        //System.out.println("Querry = "+sqlQry);
        try {
            //Field fieldlist[] = getFieldList();
            Field[] fieldlist = ListeColonneTable.getChampBase(this, cDb);
            for (int i = 0; i < fieldlist.length; i++) {
                fld = fieldlist[i];
                sqlQry = sqlQry + fld.getName() + " ";
                sqlTmp = sqlTmp + "? ";
                if (i + 1 < fieldlist.length) {
                    //System.out.println("s"+i+" = "+sqlQry);
                    sqlQry = sqlQry + ", ";
                    sqlTmp = sqlTmp + ", ";
                }
            }
            //System.out.println("sf = "+sqlQry);
			String enTete = sqlQry+") values ( ";
            sqlQry = sqlQry + sqlTmp + " ) ";
            stmt = cDb.prepareStatement(sqlQry);
			int indicePrepared = 0;
            for (int i = 0; i < fieldlist.length; i++) {
                fld = fieldlist[i];
				String valStr = "";
                switch (getTypeMAPField(fld)) {
                    case 0: // '\0'
                        stmt.setBoolean(i + 1, ((Boolean) this.getValField(fld)).booleanValue());
						valStr  = "'"+((Boolean) this.getValField(fld)).booleanValue()+"'";
                        break;

                    case 1: // '\001'
                        stmt.setByte(i + 1, ((Byte) this.getValField(fld)).byteValue());
						valStr  = "'"+((Byte) this.getValField(fld)).byteValue()+"'";
                        break;

                    case 2: // '\002'
                        stmt.setShort(i + 1, ((Short) this.getValField(fld)).shortValue());
						valStr  = "'"+((Short) this.getValField(fld)).shortValue()+"'";
                        break;

                    case 3: // '\003'
                        Integer it = (Integer) this.getValField(fld);
                        stmt.setInt(i + 1, it.intValue());
						valStr  = "'"+it.intValue()+"'";
                        break;

                    case 4: // '\004'
                        Long lo = (Long) this.getValField(fld);
                        stmt.setLong(i + 1, lo.longValue());
						valStr  = "'"+lo.longValue()+"'";
                        break;

                    case 5: // '\005'
                        stmt.setFloat(i + 1, ((Float) this.getValField(fld)).floatValue());
						valStr  = "'"+ ((Float) this.getValField(fld)).floatValue()+"'";
                        break;

                    case 6: // '\006'
                        stmt.setDouble(i + 1, ((Double) this.getValField(fld)).doubleValue());
						valStr  = "'"+((Double) this.getValField(fld)).doubleValue()+"'";
                        break;

                    case 10: // '\n'
                        String val = (String) this.getValField(fld);
                        if(val!=null && val.compareTo("")!=0){
                            val = val.replace("'", "''");
                        }
                        stmt.setString(i + 1, (String) this.getValField(fld));
                        valStr  = "'"+val+"'";
                        break;

                    case 21: // '\025'
                        stmt.setDate(i + 1, (Date) this.getValField(fld));
						if((Date) this.getValField(fld) != null) valStr  = "'"+Utilitaire.formatterDatySql((Date) this.getValField(fld))+"'";
						else valStr = "'null'";
                        break;

                    case 33: // '!'
                        stmt.setInt(i + 1, ((Integer) this.getValField(fld)).intValue());
						valStr  = "'"+((Integer) this.getValField(fld)).intValue()+"'";
                        break;
                }
				valStr = (valStr.compareToIgnoreCase("'null'")==0)?null:valStr;
                if (i + 1 < fieldlist.length) {
                   enTete+= valStr+",";
                }else{
                    enTete+=valStr;
                }
            }
            int retour = stmt.executeUpdate();
            if (retour == 0) {
                throw new Exception("Erreur insertion dans la table ");
            }
			enTete += ")";
			if(isMirroring){
                if(tableName.compareTo(histoSync)!=0 && tableName.compareToIgnoreCase("HISTORIQUE")!=0){
                    String query = "INSERT INTO "+histoSync+" (ID,ACTION,TABLECONCERNE,REQUETE,ETAT) VALUES (getSeqHistoriqueSync,?,?,?,1)";
                    insertHistoSync = cDb.prepareCall(query);
                    insertHistoSync.setString(1, "INSERT");
                    insertHistoSync.setString(2, tableName);
                    insertHistoSync.setString(3, enTete);
                    insertHistoSync.executeUpdate();
                }                
            }
            int j = 1;
            return j;
        } catch (Exception e) {
            try {
                cDb.rollback();
                //System.out.println("erreur table "+this.getNomTable()+" messahe "+e.getMessage());
                e.printStackTrace();
                //System.out.println("erreur table "+e.getMessage());
                throw new ErreurDAO(String.valueOf(String.valueOf((new StringBuffer("Erreur insertiooooooooooooooooooon dans la table ")).append(getNomTable()).append(" ").append(e.getMessage()).append(" ref= ").append(getTuppleID()))));
            } catch (Exception ex) {
                return 0;
            }
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
            } catch (SQLException se) {
                Log.setLog(String.valueOf(String.valueOf(getClassName())).concat(" - probl�me de fermeture d'1 Statement "));
            }
        }
    }

    public void getInfoFromCursor(ResultSet rs)
            throws ClassMAPTableException {
        try {
            Field fieldlist[] = getFieldList();
            int typeClass = 0;
            for (int i = 0; i < fieldlist.length; i++) {
                Field fld = fieldlist[i];
                typeClass = getTypeMAPField(fld);
                switch (getTypeMAPField(fld)) {
                    case 0: // '\0'
                        fld.setBoolean(this, rs.getBoolean(fld.getName()));
                        Log.setLog(String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(getClassName())))).append(" - Valeur boolean : ").append(fld.getBoolean(this)))));
                        break;

                    case 1: // '\001'
                        fld.setByte(this, rs.getByte(fld.getName()));
                        Log.setLog(String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(getClassName())))).append(" - Valeur byte : ").append(fld.getByte(this)))));
                        break;

                    case 2: // '\002'
                        fld.setShort(this, rs.getShort(fld.getName()));
                        Log.setLog(String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(getClassName())))).append(" - Valeur Short : ").append(fld.getShort(this)))));
                        break;

                    case 3: // '\003'
                        fld.setInt(this, rs.getInt(fld.getName()));
                        Log.setLog(String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(getClassName())))).append(" - Valeur int : ").append(fld.getInt(this)))));
                        break;

                    case 4: // '\004'
                        fld.setLong(this, rs.getLong(fld.getName()));
                        Log.setLog(String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(getClassName())))).append(" - Valeur long : ").append(fld.getLong(this)))));
                        break;

                    case 5: // '\005'
                        fld.setFloat(this, rs.getFloat(fld.getName()));
                        Log.setLog(String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(getClassName())))).append(" - Valeur Float : ").append(fld.getFloat(this)))));
                        break;

                    case 6: // '\006'
                        fld.setDouble(this, rs.getDouble(fld.getName()));
                        Log.setLog(String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(getClassName())))).append(" - Valeur double : ").append(fld.getDouble(this)))));
                        break;

                    case 10: // '\n'
                        Log.setLog(String.valueOf(String.valueOf(getClassName())).concat(" - TYPE STRING "));
                        fld.set(this, rs.getString(fld.getName()));
                        Log.setLog(String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(getClassName())))).append(" - Valeur String : ").append((String) fld.get(this)))));
                        break;
                }
            }

        } catch (Exception e) {
            throw new ClassMAPTableException(e.getMessage());
        }
    }

    public static int getMaxColonneFactFin(String daty) {
        UtilDB util = new UtilDB();
        Connection c = null;
        PreparedStatement cs = null;
        ResultSet rs = null;
        try {
            try {
                String an = Utilitaire.getAnnee(daty);
                c = null;
                c = util.GetConn();
                cs = c.prepareStatement(String.valueOf(String.valueOf((new StringBuffer("select * from  seqFact where daty<='31/12/")).append(an).append("' and daty>='01/01/").append(an).append("'"))));
                rs = cs.executeQuery();
                int i = 0;
                if (rs.next()) {
                    i++;
                }
                //System.out.println("sasa ".concat(String.valueOf(String.valueOf(i))));
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
                if (rs != null) {
                    rs.close();
                }
                if (cs != null) {
                    cs.close();
                }
                if (c != null) {
                    c.close();
                }
                util.close_connection();
            } catch (SQLException e) {
                System.out.println("Erreur Fermeture SQL RechercheType ".concat(String.valueOf(String.valueOf(e.getMessage()))));
            }
        }
    }

    public static int getMaxColonneFactFinEntite(String daty, String entite) {
        UtilDB util = new UtilDB();
        Connection c = null;
        PreparedStatement cs = null;
        ResultSet rs = null;
        try {
            try {
                String an = Utilitaire.getAnnee(daty);
                c = null;
                c = util.GetConn();
                cs = c.prepareStatement(String.valueOf(String.valueOf((new StringBuffer("select * from  seqFact where entite='" + entite + "' and daty<='31/12/")).append(an).append("' and daty>='01/01/").append(an).append("'"))));
                rs = cs.executeQuery();
                int i = 0;
                if (rs.next()) {
                    i++;
                }
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
                if (rs != null) {
                    rs.close();
                }
                if (cs != null) {
                    cs.close();
                }
                if (c != null) {
                    c.close();
                }
                util.close_connection();
            } catch (SQLException e) {
                System.out.println("Erreur Fermeture SQL RechercheType ".concat(String.valueOf(String.valueOf(e.getMessage()))));
            }
        }
    }

    public static int getMaxColonneFactFinEntite(String daty, String entite, Connection c) {
        
        PreparedStatement cs = null;
        ResultSet rs = null;
        try {
            try {
                String an = Utilitaire.getAnnee(daty);
                
                cs = c.prepareStatement(String.valueOf(String.valueOf((new StringBuffer("select * from  seqFact where entite='" + entite + "' and daty<='31/12/")).append(an).append("' and daty>='01/01/").append(an).append("'"))));
                rs = cs.executeQuery();
                int i = 0;
                if (rs.next()) {
                    i++;
                }
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
                if (rs != null) {
                    rs.close();
                }
                if (cs != null) {
                    cs.close();
                }
            } catch (SQLException e) {
                System.out.println("Erreur Fermeture SQL RechercheType ".concat(String.valueOf(String.valueOf(e.getMessage()))));
            }
        }
    }
    
    public static int getMaxColonneFactFinEntiteProforma(String daty, String entite) {
        UtilDB util = new UtilDB();
        Connection c = null;
        PreparedStatement cs = null;
        ResultSet rs = null;
        try {
            try {
                String an = Utilitaire.getAnnee(daty);
                c = null;
                c = util.GetConn();
                cs = c.prepareStatement(String.valueOf(String.valueOf((new StringBuffer("select * from  seqFactProforma where entite='" + entite + "' and daty<='31/12/")).append(an).append("' and daty>='01/01/").append(an).append("'"))));
                rs = cs.executeQuery();
                int i = 0;
                if (rs.next()) {
                    i++;
                }
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
                if (rs != null) {
                    rs.close();
                }
                if (cs != null) {
                    cs.close();
                }
                if (c != null) {
                    c.close();
                }
                util.close_connection();
            } catch (SQLException e) {
                System.out.println("Erreur Fermeture SQL RechercheType ".concat(String.valueOf(String.valueOf(e.getMessage()))));
            }
        }
    }
    
    public static int getMaxColonneFactFinEntiteProforma(String daty, String entite, Connection c) {
        
        PreparedStatement cs = null;
        ResultSet rs = null;
        try {
            try {
                String an = Utilitaire.getAnnee(daty);
                
                cs = c.prepareStatement(String.valueOf(String.valueOf((new StringBuffer("select * from  seqFactProforma where entite='" + entite + "' and daty<='31/12/")).append(an).append("' and daty>='01/01/").append(an).append("'"))));
                rs = cs.executeQuery();
                int i = 0;
                if (rs.next()) {
                    i++;
                }
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
                if (rs != null) {
                    rs.close();
                }
                if (cs != null) {
                    cs.close();
                }
                
            } catch (SQLException e) {
                System.out.println("Erreur Fermeture SQL RechercheType ".concat(String.valueOf(String.valueOf(e.getMessage()))));
            }
        }
    }

    public int getNombreChamp() {
        return nombreChamp;
    }

    public void preparePk(String indicePK, String fonct) throws Exception {
        setIndicePk(indicePK);
        setNomProcedureSequence(fonct);
    }

    public void genererPKInterne() throws Exception {
        String nomMethode = "set" + Utilitaire.convertDebutMajuscule(this.getAttributIDName());
        String[] args = {makePK()};
        Class[] paramT = {new String().getClass()};
        this.getClass().getMethod(nomMethode, paramT).invoke(this, args);
    }

    public void setValChamp(String nomChamp, Object valeur) throws Exception {
        Field f = getFieldByName(nomChamp);
        String nomMethode = "set" + Utilitaire.convertDebutMajuscule(nomChamp);
        Object[] args = {valeur};
        Class[] paramT = {f.getType()};
        this.getClass().getMethod(nomMethode, paramT).invoke(this, args);
    }

    public Field getFieldByName(String name) throws Exception {
        Field[] t = getFieldList();
        for (int i = 0; i < t.length; i++) {
            if (t[i].getName().compareTo(name) == 0) {
                return t[i];
            }
        }
        return null;
    }

    public Object getValField(Field f) //ato ny olana
    {
        try {
            String nomMethode = "get" + Utilitaire.convertDebutMajuscule(f.getName());
            Object o = this.getClass().getMethod(nomMethode, null).invoke(this, null);
            //System.out.println("UUUU"+this.getClass().getMethod(nomMethode,null));
            return o;
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }

    }

    public Object getValeur(int numColonne) {
        try {
            Object o = this.getValField(getFieldList()[numColonne]);
            return o;
        } catch (Exception ex) {
            return null;
        }
    }

    public void setNomTableSelect(String nomTableSelect) {
        this.nomTableSelect = nomTableSelect;
    }

    public String getNomTableSelect() {
        if (nomTableSelect == null || nomTableSelect == "") {
            return this.getNomTable();
        }
        return nomTableSelect;
    }

    public String getNomProcedureSequence() {
        return nomProcedureSequence;
    }

    public int getLonguerClePrimaire() {
        return longuerClePrimaire;
    }

    public String getINDICE_PK() {
        return INDICE_PK;
    }

    public void setINDICE_PK(String INDICE_PK) {
        this.INDICE_PK = INDICE_PK;
    }

    public void setMode(String mode) {
        this.mode = mode;
    }

    public String getMode() {
        return mode;
    }

    static final int TYPE_CLASS_MAP_BOOLEAN = 0;
    static final int TYPE_CLASS_MAP_BYTE = 1;
    static final int TYPE_CLASS_MAP_SHORT = 2;
    static final int TYPE_CLASS_MAP_INT = 3;
    static final int TYPE_CLASS_MAP_LONG = 4;
    static final int TYPE_CLASS_MAP_FLOAT = 5;
    static final int TYPE_CLASS_MAP_DOUBLE = 6;
    static final int TYPE_CLASS_MAP_STRING = 10;
    static final int TYPE_CLASS_MAP_WBYTE = 11;
    static final int TYPE_CLASS_MAP_WSHORT = 12;
    static final int TYPE_CLASS_MAP_WINT = 13;
    static final int TYPE_CLASS_MAP_WLONG = 14;
    static final int TYPE_CLASS_MAP_WFLOAT = 15;
    static final int TYPE_CLASS_MAP_WDOUBLE = 16;
    static final int TYPE_CLASS_MAP_DATE = 21;
    static final int TYPE_CLASS_MAP_TIME = 22;
    static final int TYPE_CLASS_MAP_BLOB = 31;
    static final int TYPE_CLASS_MAP_CLOB = 32;
    static final int TYPE_CLASS_MAP_INTEGER = 33;
    String nomTable;
    Vector champ;
    int nombreChamp;
    Class cls;
    String INDICE_PK;
    String nomProcedureSequence;
    int longuerClePrimaire;
    private String nomTableSelect;
    private String mode = "normal";

}
