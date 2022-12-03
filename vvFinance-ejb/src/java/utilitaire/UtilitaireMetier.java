package utilitaire;

import bean.UnionIntraTable;
import java.sql.Connection;
import bean.UnionIntraTableUtil;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class UtilitaireMetier {

  public UtilitaireMetier() {
  }
  public static String mapperMereToFille(String nomtableMappage, String nomFonctMap, String suffixeMap, String idMere, String idFille, String rem, String montant, String refU, Connection c) throws Exception {
      return (mapperMereToFille(nomtableMappage,nomFonctMap,suffixeMap,idMere,idFille,rem,montant,refU,"0",c));
  }
  public static String mapperMereToFille(String nomtableMappage, String nomFonctMap, String suffixeMap, String idMere, String idFille, String rem, String montant, String refU,String etat, Connection c) throws Exception {
    try {
      int tab[]={2,3};
      String val[]={idMere,idFille};
      UnionIntraTableUtil uit=new UnionIntraTableUtil();
      uit.setNomTable(nomtableMappage);
      UnionIntraTable[] uu=(UnionIntraTable[])uit.rechercher(2,idMere,c);
      if((uu.length>0)&&(uu[0].estIlModifiable()==false)) throw new Exception("Vous ne pouvez plus ajouter, mappage deja valide");
      UnionIntraTable u = null;
      UnionIntraTable[] uuit=(UnionIntraTable[])uit.rechercher(tab,val,"",c);
      if(uuit.length==0) // si c est deja dedans
      {
        u = new UnionIntraTable(c,nomtableMappage,nomFonctMap,suffixeMap,idMere,idFille,rem,utilitaire.Utilitaire.stringToDouble(montant),utilitaire.Utilitaire.stringToInt(etat));
        u.insertToTableWithHisto(refU,c);
      }else{
          u = uuit[0];
      }return u.getId();
    }
    catch (Exception ex) {
      ex.printStackTrace();
      c.rollback();
      return null;
    }
  }
  public static String mapperMereToFille(String nomtableMappage, String nomFonctMap, String suffixeMap, String idMere, String idFille, String rem, String montant, String refU,String etat) throws Exception {
    Connection c=null;
    try {
      c=new utilitaire.UtilDB().GetConn();
      c.setAutoCommit(false);
      String g=mapperMereToFille(nomtableMappage,nomFonctMap,suffixeMap,idMere,idFille,rem,montant,refU,etat,c);
      c.commit();
      return g;
    }
    catch (Exception ex) {
      c.rollback();
      return null;
    }
    finally
    {
      if (c!=null) c.close();
    }
  }
    public static String mapperMereToFille(String nomtableMappage, String nomFonctMap, String suffixeMap, String idMere, String idFille, String rem, String montant, String refU) throws Exception {
      return (mapperMereToFille(nomtableMappage,nomFonctMap,suffixeMap,idMere,idFille,rem,montant,refU,"0"));
    }
}