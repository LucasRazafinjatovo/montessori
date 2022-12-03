package utilitaire;

/**
 * <p>Title: Gestion des recettes : Société du Port à gestion Autonome de Toamasina</p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */
import bean.ObjetCroise;
import finance.Entree;
import java.lang.reflect.Method;
import user.UserEJBClient;
import user.UserEJB;
import finance.RecupLocalFinance;
import finance.FinanceLocalHome;
import finance.Sortie;
public class TestKely {

  public TestKely() {
  }
  public static void main(String[] args) {
    try {
      /*Entree e=new Entree();
      String d="10 000";
      double f=utilitaire.Utilitaire.stringToDouble(d);
      //Field[] f=e.getClass().getFields();
      System.out.println("ty le double "+f);
      Sortie s=new Sortie();
      System.out.println(s.getNombreChamp());
      System.out.println(e.getNombreChamp());*/
      /*UserEJBClient uc=new UserEJBClient();
      UserEJB u=null;
      u=uc.getInterface();
      u.testLogin("dev","ved123");*/
      /*String date1="01/07/2012";
      String date2="21/07/2012";
      java.sql.Date dateSql1=Utilitaire.string_date("dd/MM/yyyy",date1);
      java.sql.Date dateSql2=Utilitaire.string_date("dd/MM/yyyy",date2);
      System.out.println("nandalo teto "+Utilitaire.diffJourDaty(dateSql2,dateSql1));
      java.sql.Date[]listeDate=Utilitaire.convertIntervaleToListDate(dateSql1,dateSql2);
      System.out.println("longueur "+listeDate.length);
      for(int i=0;i<listeDate.length;i++){
        System.out.println("Date "+i+" "+listeDate[i]);
      }*/
      try{
              //Lancer excel en indiquant l'URL
              //Runtime run = Runtime.getRuntime();
              //Commande shell Windows (présence du fichier c:/cablageFT.xls
              //String cmd = "excel.exe c:/cablageFT.xls";
              String cmd = "C:\\Program Files (x86)\\Microsoft Office\\Office15\\EXCEL.EXE C:\\Alain\\test.xlsx";
              Runtime.getRuntime().exec(cmd);
              System.out.println("success ");
              //Desktop lanceur = Desktop.getDesktop();
      //File fichier = new File("excel.exe c:/cablageFT.xls");
      } catch(Exception e) {
              e.printStackTrace();
      }
    }
    catch (Exception ex) {
      ex.printStackTrace();
      System.out.println("erreur " +ex.getMessage());
    }
  }
}