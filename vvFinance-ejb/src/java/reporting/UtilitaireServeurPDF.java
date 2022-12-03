/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package reporting;

import bean.CGenUtil;
import java.io.FileNotFoundException;
import java.sql.Connection;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utilitaire.UtilDB;

/**
 *
 * @author anthonyandrianaivoravelona
 */

public class UtilitaireServeurPDF {
    public static boolean testIfExist(String nom_objet, String idobjet, int etat) throws Exception{
        ServeurPDF spdf = new ServeurPDF();
        ServeurPDF[] spdfs = (ServeurPDF[]) CGenUtil.rechercher(spdf, null, null, null, " AND NOM_OBJET ='"+nom_objet+"' AND IDOBJET = '"+idobjet+"' and etat="+etat+"");
        if(spdfs.length>0) return true;
        return false;
    }
    public static boolean testIfExist(String nom_objet, String idobjet) throws Exception{
        ServeurPDF spdf = new ServeurPDF();
        ServeurPDF[] spdfs = (ServeurPDF[]) CGenUtil.rechercher(spdf, null, null, null, " AND NOM_OBJET ='"+nom_objet+"' AND IDOBJET = '"+idobjet+"'");
        if(spdfs.length>0) return true;
        return false;
    }
    public static void updateWhenNotAnneeEnCours(String nom_objet, int etat) throws Exception{
        Connection c = new UtilDB().GetConn();
        try{
            ServeurPDF spdf = new ServeurPDF();
            ServeurPDF[] spdfs = (ServeurPDF[]) CGenUtil.rechercher(spdf, null, null, null, " AND NOM_OBJET ='"+nom_objet+"'");
            if(spdfs.length>0) return;
            spdfs[0].setEtat(etat);
            spdfs[0].setNom_objet("");
            spdfs[0].setRemarque("0");
            spdfs[0].upDateToTable();
            c.commit();
        }
        catch(Exception e){
            throw e;
        }
        finally{
            if(c!=null) c.close();
        }
    }
    public static boolean checkEtatServeur(String fileName, ReportingCdn.Fonctionnalite fonctionnalite, ReportingUtils.ReportType typeFile, String id, int etat) throws FileNotFoundException, Exception{
        if(ReportingCdn.checkExistingFile(fonctionnalite, fileName+"-"+id+ReportingCdn.getExtension(typeFile))) if(etat==getEtatServeur(fileName, id)) return true;
        return false;
    }
    public static int getEtatServeur(String nom_objet, String idobjet) throws Exception{
        ServeurPDF spdf = new ServeurPDF();
        ServeurPDF[] spdfs = (ServeurPDF[]) CGenUtil.rechercher(spdf, null, null, null, " AND NOM_OBJET ='"+nom_objet+"' AND IDOBJET = '"+idobjet+"'");
        if(spdfs.length>0) spdf = spdfs[0];
        return spdf.getEtat();
    }
    public static void deleteFromServeur(String idobjet) throws Exception{
        ServeurPDF spdf = new ServeurPDF();
        spdf.setIdobjet(idobjet);
        spdf.deleteToTable();
    }
    private static void updateEtatServeur(String nom_objet, String idobjet, int etat) throws Exception{
        ServeurPDF spdf = new ServeurPDF();
        ServeurPDF[] spdfs = (ServeurPDF[]) CGenUtil.rechercher(spdf, null, null, null, " AND NOM_OBJET ='"+nom_objet+"' AND IDOBJET = '"+idobjet+"'");
        if(spdfs.length>0) spdf = spdfs[0];
        spdf.setEtat(etat);
        spdf.upDateToTable();
    }
    private static void updateEtatServeurWithRemarque(String nom_objet, String idobjet, int etat, String remarque) throws Exception{
        ServeurPDF spdf = new ServeurPDF();
        ServeurPDF[] spdfs = (ServeurPDF[]) CGenUtil.rechercher(spdf, null, null, null, " AND NOM_OBJET ='"+nom_objet+"' AND IDOBJET = '"+idobjet+"'");
        if(spdfs.length>0) spdf = spdfs[0];
        spdf.setEtat(etat);
        spdf.setRemarque(remarque);
        spdf.upDateToTable();
    }
    
    public static int getNumerosequentiel(String nom_objet, String idObjet) throws Exception{
        Connection c = null;
        try{
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            int toReturn =  getNumerosequentiel(c, nom_objet, idObjet);
            c.commit();
            return toReturn;
        }
        catch(Exception e){
            throw e;
        }
        finally{
            if(c!=null) c.close();
        }
    }
    
    public static int getNumerosequentiel(Connection c, String nom_objet, String idObjet) throws Exception{
        ServeurPDF spdf = new ServeurPDF();
        ServeurPDF[] spdfs = (ServeurPDF[]) CGenUtil.rechercher(spdf, null, null, null, " AND NOM_OBJET ='"+nom_objet+"' ORDER BY id DESC");
        if(spdfs.length>0 && spdfs[0].getIdobjet().equals(idObjet)){
            spdfs[0].updateToTable(c);
            return Integer.valueOf(spdfs[0].getRemarque());
        }
        spdf.construirePK(c);
        spdf.setNom_objet(nom_objet);
        spdf.setIdobjet(idObjet);
        if(spdfs.length>0){
            spdf.setRemarque(String.valueOf(Integer.valueOf(spdfs[0].getRemarque())+1));
            spdf.insertToTable(c);
            return Integer.valueOf(spdfs[0].getRemarque())+1;
        }
        else{
            spdf.setRemarque(String.valueOf(1));
            spdf.insertToTable(c);
            return 1;
        }
        
    }

    
    public static void updateServeurPDF(String nom_objet, String idObjet) throws Exception{
        Connection c = null;
        try{
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            ServeurPDF spdf = new ServeurPDF();
            ServeurPDF[] spdfs = (ServeurPDF[]) CGenUtil.rechercher(spdf, null, null, c, " AND nom_objet = '"+nom_objet+"' and idobjet='"+idObjet+"'");
            if(spdfs.length==0) throw new Exception("Exception lors de la generation du numero sequentiel");
            spdf = spdfs[0];
            spdf.setRemarque(String.valueOf(Integer.valueOf(spdf.getRemarque())+1));
            spdf.updateToTable(c);
            c.commit();
        }
        catch(Exception e){
            e.printStackTrace();
            throw e;
        }
        finally{
            if(c!=null) c.close();
        }
    }
    
    public static void insertHistoPDF(String nom_objet, String idObjet, int etat) throws Exception{
        Connection c = null;
        try{
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            if(testIfExist(nom_objet, idObjet, etat)){
                updateEtatServeur(nom_objet, idObjet, etat);
                c.commit();
                return;
            }
            ServeurPDF spdf = new ServeurPDF();
            spdf.construirePK(c);
            spdf.setNom_objet(nom_objet);
            spdf.setIdobjet(idObjet);
            spdf.setEtat(etat);
            spdf.insertToTable(c);
            c.commit();
        }
        catch(Exception e){
            e.printStackTrace();
            throw e;
        }
        finally{
            if(c!=null) c.close();
        }
    }
    
    public static void insertHistoPDFWithRemarque(String nom_objet, String idObjet, int etat, String remarque) throws Exception{
        Connection c = null;
        try{
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            if(testIfExist(nom_objet, idObjet, etat)){
                updateEtatServeurWithRemarque(nom_objet, idObjet, etat, remarque);
                c.commit();
                return;
            }
            ServeurPDF spdf = new ServeurPDF();
            spdf.construirePK(c);
            spdf.setNom_objet(nom_objet);
            spdf.setIdobjet(idObjet);
            spdf.setEtat(etat);
            spdf.setRemarque(remarque);
            spdf.insertToTable(c);
            c.commit();
        }
        catch(Exception e){
            e.printStackTrace();
            throw e;
        }
        finally{
            if(c!=null) c.close();
        }
    }
    
    public static void updateNumeroNotificationAt(String nom_objet, String idObjet) throws Exception{
        Connection c = null;
        try{
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            ServeurPDF spdf = new ServeurPDF();
            ServeurPDF[] spdfs = (ServeurPDF[]) CGenUtil.rechercher(spdf, null, null, null, " AND NOM_OBJET ='"+nom_objet+"'");
            if(spdfs.length>0) spdf = spdfs[0];
            spdf.setIdobjet(idObjet);
            spdf.setRemarque(String.valueOf(Integer.valueOf(spdf.getRemarque())+1));
            spdf.upDateToTable();
            c.commit();
        }
        catch(Exception e){
            e.printStackTrace();
            throw e;
        }
        finally{
            if(c!=null) c.close();
        }
    }
    public static boolean testNullEtVide(String value){
        if(value==null || value.equalsIgnoreCase("") || value.equalsIgnoreCase("null")) return false;
        return true;
    }
    public static String makeCritereStringWithTestNull(String attribut, String value, String critere){
        if(!testNullEtVide(value)) return "";
        return " AND "+attribut.toUpperCase()+critere+"'"+value+"'";
    }
    public static String champNullZero(String valeur){
        if(!testNullEtVide(valeur)) return "0";
        return valeur;
    }
    
    public static String remplirParZero(int nombre, int isany){
        String nombreString = String.valueOf(nombre);
        for(int i=nombreString.length();i<isany;i++){
            nombreString = "0" + nombreString;
        }
        return nombreString;
    }
}
