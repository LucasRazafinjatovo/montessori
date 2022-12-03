package affichage;

import java.sql.Connection;
import java.lang.reflect.Field;
import bean.CGenUtil;
import bean.ClassMAPTable;
import javax.servlet.http.HttpServletRequest;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class PageInsert extends Page {
  public PageInsert()
  {

  }
  public PageInsert(ClassMAPTable o,HttpServletRequest req,user.UserEJB u) throws Exception{
    setBase(o);
    setReq(req);
    setUtilisateur(u);
    makeFormulaire();
  }
  public PageInsert(ClassMAPTable o,HttpServletRequest req) throws Exception{
    setBase(o);
    setReq(req);
  }
  public void makeFormulaire() throws Exception
  {
    formu=new Formulaire();
    affichage.Champ[] t=null;
    //Field[]f=getBase().getFieldList();
    bean.Champ[] f=bean.ListeColonneTable.getFromListe(getBase(),null);
    //t=new Champ[getBase().getNombreChamp()-1];
    t=new Champ[f.length-1];
    int nbElement=0;
    for(int i=0;i<t.length+1;i++)
    {
      if(f[i].getNomColonne().compareToIgnoreCase(getBase().getAttributIDName())!=0)
      {
        t[nbElement]=new Champ(f[i].getNomColonne());
        t[nbElement].setLibelle(f[i].getNomColonne());
        t[nbElement].setValeur("");
        nbElement++;
    }
    }
    formu.setListeChamp(t);
  }
  public void preparerDataFormu() throws Exception
  {
    Connection c=null;
    try {
      c=new utilitaire.UtilDB().GetConn();
      formu.getAllData(c);
    }
    catch (Exception ex) {
      throw (ex);
    }
    finally
    {
      if(c!=null)c.close();
    }
  }
  public void makeHtml()
  {

  }
  public ClassMAPTable getObjectAvecValeur() throws Exception
  {
    //Field[]tempChamp=getBase().getFieldList();
    try{
    Field[]tempChamp=bean.ListeColonneTable.getFieldListeHeritage(getBase());
    for(int i=0;i<tempChamp.length;i++)
    {
      Field f=tempChamp[i];
      String valeur=getParamSansNull(f.getName());
      getBase().setMode("insert");
      if(f.getType().getName().compareToIgnoreCase("java.lang.String")==0)
        bean.CGenUtil.setValChamp(getBase(),f,valeur);
      if(f.getType().getName().compareToIgnoreCase("java.sql.Date")==0)
      {
        //System.out.println("La date en sortie = "+utilitaire.Utilitaire.string_date("dd/MM/yyyy",valeur));
        bean.CGenUtil.setValChamp(getBase(),f,utilitaire.Utilitaire.string_date("dd/MM/yyyy",valeur));
      }
      if(f.getType().getName().compareToIgnoreCase("double")==0)
      {
        bean.CGenUtil.setValChamp(getBase(),f,new Double(utilitaire.Utilitaire.stringToDouble(valeur)));
      }
      if(f.getType().getName().compareToIgnoreCase("int")==0)
      {
        if(valeur!=null && valeur.compareToIgnoreCase("")!=0)
          bean.CGenUtil.setValChamp(getBase(),f,new Integer(valeur));
      }
      if(f.getType().getName().compareToIgnoreCase("float")==0)
      {
        bean.CGenUtil.setValChamp(getBase(),f,new Float(utilitaire.Utilitaire.stringToFloat(valeur)));
      }
    }
    return getBase();
    }
    catch(NumberFormatException n)
    {
      throw new Exception("format de nombre invalide");
    }
    catch(Exception e)
    {
      //System.out.println("ERREUUURRR = "+e.getMessage());
      throw e;
    }
  }
}