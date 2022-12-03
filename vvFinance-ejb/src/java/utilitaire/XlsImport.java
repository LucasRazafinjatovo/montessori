package utilitaire;

import bean.Champ;
import bean.CGenUtil;
import bean.ClassEtat;
import bean.ClassMAPTable;
import bean.ListeColonneTable;
import java.io.File;
import java.io.InputStream;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.Date;
import java.util.ArrayList;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import user.UserEJBBean;

public class XlsImport {

    private static Workbook workbook;
    private static Sheet sheet;

    public static void importerAvecId(String fileUrl, ClassMAPTable o) throws Exception {
        Connection conn = null;
        try {
            conn = new UtilDB().GetConn();
            workbook = WorkbookFactory.create(new File(fileUrl));
            sheet = workbook.getSheetAt(0);
            int indice = 1; // miala ny indice 0 satria titre
            Row row = sheet.getRow(indice);
            while (row != null) {
                int cellNumber = row.getPhysicalNumberOfCells();
                Champ[] listeChamps = ListeColonneTable.getFromListe(o, null);
                if (cellNumber != listeChamps.length - 1) {
                    throw new Exception("erreur");
                }
                for (int co = 0; co < cellNumber; co++) {
                    Cell c = row.getCell(co);
                    if (listeChamps[co + 1].getTypeJava().equals("java.lang.String")) {
                        String valeur = "";
                        try {
                            valeur = c.getStringCellValue();
                        } catch (Exception ex) {
                            try {
                                valeur = String.valueOf((int) c.getNumericCellValue());
                            } catch (Exception e) {
                                valeur = Utilitaire.format(c.getDateCellValue());
                            }
                        }
                        CGenUtil.setValChamp(o, listeChamps[co + 1].getNomClasse(), valeur);
                    } else if (listeChamps[co + 1].getTypeJava().equals("int")) {
                        CGenUtil.setValChamp(o, listeChamps[co + 1].getNomClasse(), new Integer((int) c.getNumericCellValue()));
                    } else if (listeChamps[co + 1].getTypeJava().equals("double")) {
                        CGenUtil.setValChamp(o, listeChamps[co + 1].getNomClasse(), new Double(c.getNumericCellValue()));
                    } else if (listeChamps[co + 1].getTypeJava().equals("java.sql.Date")) {
                        CGenUtil.setValChamp(o, listeChamps[co + 1].getNomClasse(), new Date(c.getDateCellValue().getTime()));
                    }
                }
                o.construirePK(conn);
                o.insertToTable();
                indice++;
                row = sheet.getRow(indice);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception("Erreur lors de l'import du fichier Excel");
        } finally {
            if (conn != null) {
                conn.close();
            }
        }
    }

    public static void importerTous(String fileUrl, ClassMAPTable o) throws Exception {
        try {
            workbook = WorkbookFactory.create(new File(fileUrl));
            sheet = workbook.getSheetAt(0);
            int indice = 1; // miala ny indice 0 satria titre
            Row row = sheet.getRow(indice);
            while (row != null) {
                int cellNumber = row.getPhysicalNumberOfCells();
                Champ[] listeChamps = ListeColonneTable.getFromListe(o, null);
                if (cellNumber != listeChamps.length) {
                    throw new Exception("erreur");
                }
                for (int co = 0; co < cellNumber; co++) {
                    Cell c = row.getCell(co);
                    if (listeChamps[co].getTypeJava().equals("java.lang.String")) {
                        String valeur = "";
                        try {
                            valeur = c.getStringCellValue();
                        } catch (Exception ex) {
                            try {
                                valeur = String.valueOf((int) c.getNumericCellValue());
                            } catch (Exception e) {
                                valeur = Utilitaire.format(c.getDateCellValue());
                            }
                        }
                        CGenUtil.setValChamp(o, listeChamps[co].getNomClasse(), valeur);
                    } else if (listeChamps[co].getTypeJava().equals("int")) {
                        CGenUtil.setValChamp(o, listeChamps[co].getNomClasse(), new Integer((int) c.getNumericCellValue()));
                    } else if (listeChamps[co].getTypeJava().equals("double")) {
                        CGenUtil.setValChamp(o, listeChamps[co].getNomClasse(), new Double(c.getNumericCellValue()));
                    } else if (listeChamps[co].getTypeJava().equals("java.sql.Date")) {
                        CGenUtil.setValChamp(o, listeChamps[co].getNomClasse(), new Date(c.getDateCellValue().getTime()));
                    }
                }
                o.insertToTable();
                indice++;
                row = sheet.getRow(indice);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception("Erreur lors de l'import du fichier Excel");
        }
    }

    public static void importerAvecId(String fileUrl, ClassMAPTable o, String sheetAt) throws Exception {
        try {
            Connection conn = new UtilDB().GetConn();
            workbook = WorkbookFactory.create(new File(fileUrl));
            sheet = workbook.getSheet(sheetAt);
            int indice = 1; // miala ny indice 0 satria titre
            Row row = sheet.getRow(indice);
            while (row != null) {
                int cellNumber = row.getPhysicalNumberOfCells();
                Champ[] listeChamps = ListeColonneTable.getFromListe(o, null);
                if (cellNumber != listeChamps.length - 1) {
                    throw new Exception("erreur");
                }
                for (int co = 0; co < cellNumber; co++) {
                    Cell c = row.getCell(co);
                    if (listeChamps[co + 1].getTypeJava().equals("java.lang.String")) {
                        String valeur = "";
                        try {
                            valeur = c.getStringCellValue();
                        } catch (Exception ex) {
                            try {
                                valeur = String.valueOf((int) c.getNumericCellValue());
                            } catch (Exception e) {
                                valeur = Utilitaire.format(c.getDateCellValue());
                            }
                        }
                        CGenUtil.setValChamp(o, listeChamps[co + 1].getNomClasse(), valeur);
                    } else if (listeChamps[co + 1].getTypeJava().equals("int")) {
                        CGenUtil.setValChamp(o, listeChamps[co + 1].getNomClasse(), new Integer((int) c.getNumericCellValue()));
                    } else if (listeChamps[co + 1].getTypeJava().equals("double")) {
                        CGenUtil.setValChamp(o, listeChamps[co + 1].getNomClasse(), new Double(c.getNumericCellValue()));
                    } else if (listeChamps[co + 1].getTypeJava().equals("java.sql.Date")) {
                        CGenUtil.setValChamp(o, listeChamps[co + 1].getNomClasse(), new Date(c.getDateCellValue().getTime()));
                    }
                }
                o.construirePK(conn);
                o.insertToTable();
                indice++;
                row = sheet.getRow(indice);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception("Erreur lors de l'import du fichier Excel");
        }
    }

    public static void importerTous(String fileUrl, ClassMAPTable o, String sheetAt) throws Exception {
        try {
            workbook = WorkbookFactory.create(new File(fileUrl));
            sheet = workbook.getSheet(sheetAt);
            int indice = 1; // miala ny indice 0 satria titre
            Row row = sheet.getRow(indice);
            while (row != null) {
                int cellNumber = row.getPhysicalNumberOfCells();
                Champ[] listeChamps = ListeColonneTable.getFromListe(o, null);
                if (cellNumber != listeChamps.length) {
                    throw new Exception("erreur");
                }
                for (int co = 0; co < cellNumber; co++) {
                    Cell c = row.getCell(co);
                    if (listeChamps[co].getTypeJava().equals("java.lang.String")) {
                        String valeur = "";
                        try {
                            valeur = c.getStringCellValue();
                        } catch (Exception ex) {
                            try {
                                valeur = String.valueOf((int) c.getNumericCellValue());
                            } catch (Exception e) {
                                valeur = Utilitaire.format(c.getDateCellValue());
                            }
                        }
                        CGenUtil.setValChamp(o, listeChamps[co].getNomClasse(), valeur);
                    } else if (listeChamps[co].getTypeJava().equals("int")) {
                        CGenUtil.setValChamp(o, listeChamps[co].getNomClasse(), new Integer((int) c.getNumericCellValue()));
                    } else if (listeChamps[co].getTypeJava().equals("double")) {
                        CGenUtil.setValChamp(o, listeChamps[co].getNomClasse(), new Double(c.getNumericCellValue()));
                    } else if (listeChamps[co].getTypeJava().equals("java.sql.Date")) {
                        CGenUtil.setValChamp(o, listeChamps[co].getNomClasse(), new Date(c.getDateCellValue().getTime()));
                    }
                }
                o.insertToTable();
                indice++;
                row = sheet.getRow(indice);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception("Erreur lors de l'import du fichier Excel");
        }
    }

    public static ClassMAPTable[] toObject(String fileUrl, ClassMAPTable o) throws Exception {
        ClassMAPTable[] rst = null;
        ArrayList<Object> ob = new ArrayList<>();
        Class c = Class.forName(o.getClassName());
        Method method;
        Field[] champs = c.getDeclaredFields();

        workbook = WorkbookFactory.create(new File(fileUrl));
        sheet = workbook.getSheetAt(0);
        int indice = 1; // miala ny indice 0 satria titre
        Row row = sheet.getRow(indice);
        rst = new ClassMAPTable[sheet.getPhysicalNumberOfRows() - 1];
        int ind = 0;
        while (row != null) {
            Object obj = c.newInstance();
            int cellNumber = row.getPhysicalNumberOfCells();
            Object value = null;
            if (cellNumber != champs.length) {
                throw new Exception("erreur import, colonnes non synchronisés");
            }
            for (int co = 0; co < champs.length; co++) {
                method = obj.getClass().getMethod("set" + Utilitaire.convertDebutMajuscule(champs[co].getName()), champs[co].getType());
                if (champs[co].getType().getName().contains("String")) {
                    try {
                        method.invoke(obj, row.getCell(co).getStringCellValue());
                    } catch (Exception e) {
                        try {
                            method.invoke(obj, String.valueOf((int) row.getCell(co).getNumericCellValue()));
                        } catch (Exception exp) {
                            method.invoke(obj, String.valueOf(row.getCell(co).getDateCellValue()));
                        }
                    }
                } else if (champs[co].getType().getName().contains("nteger")) {
                    method.invoke(obj, row.getCell(co).getNumericCellValue());
                } else if (champs[co].getType().getName().contains("double")) {
                    method.invoke(obj, row.getCell(co).getNumericCellValue());
                } else if (champs[co].getType().getName().contains("Date")) {
                    method.invoke(obj, new java.sql.Date(row.getCell(co).getDateCellValue().getTime()));
                }
            }
            ob.add(obj);
            ind++;
            indice++;
            row = sheet.getRow(indice);
        }
        rst = (ClassMAPTable[]) ob.toArray();
        return rst;
    }

    public static Object[] toObject(InputStream is, ClassMAPTable o) throws Exception {
        ClassMAPTable[] rst = null;
        ArrayList<Object> ob = new ArrayList<>();
        Class c = Class.forName(o.getClassName());
        Method method;
        Field[] champs = c.getDeclaredFields();
        workbook = WorkbookFactory.create(is);
        sheet = workbook.getSheetAt(0);
        int indice = 0; // miala ny indice 0 satria titre
        Row row = sheet.getRow(indice);
        rst = new ClassMAPTable[sheet.getPhysicalNumberOfRows() - 1];
        int ind = 0;
        while (row != null) {
            Object obj = c.newInstance();
            int cellNumber = row.getPhysicalNumberOfCells();
            Object value = null;
            System.out.println("CELL : " + cellNumber + " et CHAMPS : " + champs.length);
            if (cellNumber != champs.length) {
                if (ind == 0) {
                    throw new Exception("erreur import, colonnes non synchronisés");
                } else {
                    ind++;
                    indice++;
                    row = sheet.getRow(indice);
                    continue;
                }
            }
            for (int co = 0; co < champs.length; co++) {
                method = obj.getClass().getMethod("set" + Utilitaire.convertDebutMajuscule(champs[co].getName()), champs[co].getType());
                if (champs[co].getType().getName().contains("String")) {
                    try {
                        method.invoke(obj, row.getCell(co).getStringCellValue());
                    } catch (Exception e) {
                        try {
                            method.invoke(obj, String.valueOf((int) row.getCell(co).getNumericCellValue()));
                        } catch (Exception exp) {
                            method.invoke(obj, String.valueOf(row.getCell(co).getDateCellValue()));
                        }
                    }
                } else if (champs[co].getType().getName().contains("nteger")) {
                    method.invoke(obj, row.getCell(co).getNumericCellValue());
                } else if (champs[co].getType().getName().contains("double")) {
                    method.invoke(obj, row.getCell(co).getNumericCellValue());
                } else if (champs[co].getType().getName().contains("Date")) {
                    method.invoke(obj, new java.sql.Date(row.getCell(co).getDateCellValue().getTime()));
                }
            }
            ob.add(obj);
            ind++;
            indice++;
            row = sheet.getRow(indice);
        }
        return ob.toArray();

    }

    public static Object[] toObject(InputStream is, ClassMAPTable o, int ligneDebut) throws Exception {
        ClassMAPTable[] rst = null;
        ArrayList<Object> ob = new ArrayList<>();
        Class c = Class.forName(o.getClassName());
        Method method;
        Field[] champs = c.getDeclaredFields();

        workbook = WorkbookFactory.create(is);
        sheet = workbook.getSheetAt(0);
        int indice = 0; // miala ny indice 0 satria titre
        Row row = sheet.getRow(indice);
        rst = new ClassMAPTable[sheet.getPhysicalNumberOfRows() - 1];
        int ind = 0;
        while (row != null) {
            Object obj = c.newInstance();
            int cellNumber = row.getPhysicalNumberOfCells();
            Object value = null;
            if (cellNumber != champs.length) {
                throw new Exception("erreur import, colonnes non synchronisés");
            }
            for (int co = 0; co < champs.length; co++) {
                method = obj.getClass().getMethod("set" + Utilitaire.convertDebutMajuscule(champs[co].getName()), champs[co].getType());
                if (champs[co].getType().getName().contains("String")) {
                    try {
                        method.invoke(obj, row.getCell(co).getStringCellValue());
                    } catch (Exception e) {
                        try {
                            method.invoke(obj, String.valueOf((int) row.getCell(co).getNumericCellValue()));
                        } catch (Exception exp) {
                            method.invoke(obj, String.valueOf(row.getCell(co).getDateCellValue()));
                        }
                    }
                } else if (champs[co].getType().getName().contains("nteger")) {
                    method.invoke(obj, row.getCell(co).getNumericCellValue());
                } else if (champs[co].getType().getName().contains("double")) {
                    method.invoke(obj, row.getCell(co).getNumericCellValue());
                } else if (champs[co].getType().getName().contains("Date")) {
                    method.invoke(obj, new java.sql.Date(row.getCell(co).getDateCellValue().getTime()));
                }
            }
            ob.add(obj);
            ind++;
            indice++;
            row = sheet.getRow(indice);
        }
        return ob.toArray();
    }

    public static ClassEtat[] importClassEtatUser(InputStream is, ClassEtat o) throws Exception {
        ClassEtat[] rst = null;
        UserEJBBean u = new UserEJBBean();
        String user = u.getUser().getTuppleID();
        int etat = 1;
        ArrayList<ClassEtat> ob = new ArrayList<>();
        Class c = Class.forName(o.getClassName());
        Method method;
        Field[] champs = c.getDeclaredFields();
        workbook = WorkbookFactory.create(is);
        sheet = workbook.getSheetAt(0);
        int indice = 0; // miala ny indice 0 satria titre
        Row row = sheet.getRow(indice);
        rst = new ClassEtat[sheet.getPhysicalNumberOfRows() - 1];
        int ind = 0;
        while (row != null) {
            Object obj = c.newInstance();
            int cellNumber = row.getPhysicalNumberOfCells();
            Object value = null;
            if ((cellNumber != champs.length) || (cellNumber + 2 != champs.length)) { //  + 2 satria raha tsy misy iduser sy etat ilay excel
                throw new Exception("erreur import, colonnes non synchronisés");
            }
            for (int co = 0; co < champs.length; co++) {
                if (champs[co].getName().compareToIgnoreCase("etat") == 0 || champs[co].getName().compareToIgnoreCase("iduser") == 0) {
                    continue;
                }
                method = obj.getClass().getMethod("set" + Utilitaire.convertDebutMajuscule(champs[co].getName()), champs[co].getType());
                if (champs[co].getType().getName().contains("String")) {
                    try {
                        method.invoke(obj, row.getCell(co).getStringCellValue());
                    } catch (Exception e) {
                        try {
                            method.invoke(obj, String.valueOf((int) row.getCell(co).getNumericCellValue()));
                        } catch (Exception exp) {
                            method.invoke(obj, String.valueOf(row.getCell(co).getDateCellValue()));
                        }
                    }
                } else if (champs[co].getType().getName().contains("Integer")) {
                    method.invoke(obj, row.getCell(co).getNumericCellValue());
                } else if (champs[co].getType().getName().contains("Double")) {
                    method.invoke(obj, row.getCell(co).getNumericCellValue());
                } else if (champs[co].getType().getName().contains("Date")) {
                    method.invoke(obj, new java.sql.Date(row.getCell(co).getDateCellValue().getTime()));
                }
            }
            ClassEtat cEtat = (ClassEtat) obj;
            cEtat.setEtat(etat);
            cEtat.setIduser(user);
            ob.add(cEtat);
            ind++;
            indice++;
            row = sheet.getRow(indice);
        }
        return rst;
    }
    
    public static Object[] genToObject(InputStream is, ClassMAPTable o) throws Exception {
//        ClassMAPTable[] rst = null;
        ArrayList<Object> ob = new ArrayList<>();
        Class c = Class.forName(o.getClassName());
        Method method;
        Field[] champs = c.getDeclaredFields();
        workbook = WorkbookFactory.create(is);
        sheet = workbook.getSheetAt(0);
        int indice = 1; // miala ny indice 0 satria titre
        Row row = sheet.getRow(indice);
//        rst = new ClassMAPTable[sheet.getPhysicalNumberOfRows() - 1];
        int ind = 0;
        while (row != null) {
            Object obj = c.newInstance();
            int cellNumber = row.getPhysicalNumberOfCells();
            Object value = null;
            //System.out.println("CELL : " + cellNumber + " et CHAMPS : " + champs.length+" indice : "+ind );
            if (cellNumber != champs.length) {
                if (ind == 0) {
                    throw new Exception("erreur import, colonnes non synchronisés");
                } else {
                    ind++;
                    indice++;
                   
                    row = sheet.getRow(indice);
                    continue;
                }
            }
            for (int co = 0; co < champs.length; co++) {
                method = obj.getClass().getMethod("set" + Utilitaire.convertDebutMajuscule(champs[co].getName()), champs[co].getType());
                if (champs[co].getType().getSimpleName().contains("String")) {
                    method.invoke(obj, row.getCell(co).getStringCellValue());
                } else if (champs[co].getType().getSimpleName().compareToIgnoreCase("int") == 0) {
                    method.invoke(obj, (int)row.getCell(co).getNumericCellValue());
                } else if (champs[co].getType().getSimpleName().contains("double")) {
                    method.invoke(obj, (double)row.getCell(co).getNumericCellValue());
                } else if (champs[co].getType().getSimpleName().contains("Date")) {
                    method.invoke(obj, new java.sql.Date(row.getCell(co).getDateCellValue().getTime()));
                }
            }
            ob.add(obj);
            ind++;
            indice++;
            row = sheet.getRow(indice);
        }
        System.out.println("indice = "+indice);
        return ob.toArray();
    }
}
