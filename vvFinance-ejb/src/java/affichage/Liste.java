package affichage;

import bean.CGenUtil;
import java.sql.Connection;
import bean.ClassMAPTable;
import historique.*;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class Liste extends Champ {

  private String colAffiche;
  private MapUtilisateur u;
  private String colValeur;
  private bean.ClassMAPTable[] base;
  private bean.ClassMAPTable singleton;
  private Object[] valeurBrute;
  private String[] colValeurBrute;
  //private String defaultSelected;
  private boolean selectedMultiple = false;
  private String apresW="";
  public Liste()
  {
  }
  public Liste(String nom)
  {
    super(nom);
  }
  public Liste(bean.ClassMAPTable[] f) {
    setBase(f);
  }
  public Liste(String nom,Object[] f,String defaut) {
    super(nom);
    setValeurBrute(f);
    setDefaultSelected(defaut);
  }
  public Liste(String nom,ClassMAPTable f) {
    super(nom);
    setSingleton(f);
  }
  public Liste(String nom,Object[] f) {
    super(nom);
    setValeurBrute(f);
  }
  public Liste(String nom,bean.ClassMAPTable f,String colAff) {
    super(nom);
    setSingleton(f);
    setColAffiche(colAff);
  }
  public Liste(String nom,bean.ClassMAPTable f,String colAff,String colV) throws Exception{
    super(nom);
    setSingleton(f);
    setColAffiche(colAff);
    setColValeur(colV);
  }
  public Liste(String nom,Object[] f,String[] valeur) {
    super(nom);
    setValeurBrute(f);
    setColValeurBrute(valeur);
  }
  public void makeListeMois()
  {
    String affiche[]={"janvier","fevrier","mars","avril","mai","juin","juillet","aout","septembre","octobre","novembre","decembre"};
    String valeur[]={"1","2","3","4","5","6","7","8","9","10","11","12"};
    setValeurBrute(affiche);
    setColValeurBrute(valeur);
  }
  public Liste(String nom,bean.ClassMAPTable[] f,String colAff,String colV) {
    super(nom);
    setBase(f);
    setColAffiche(colAff);
    setColValeur(colV);
  }
  public Liste(String nom,bean.ClassMAPTable f,String colAff,String colV,Connection c) throws Exception{
    super(nom);
    setSingleton(f);
    setColAffiche(colAff);
    setColValeur(colV);
    findData(c);
  }

  public Liste(String nom,bean.ClassMAPTable f,String colAff,String colV,boolean selM) throws Exception{
    super(nom);
    setSingleton(f);
    setColAffiche(colAff);
    setColValeur(colV);
    setSelectedMultiple(selM);
 }
  public void findData(Connection c) throws Exception
  {
    if(getValeurBrute()==null||getValeurBrute().length==0)
    {
      String aW=" order by "+getColAffiche()+ " ASC";
      //System.out.println("la comande = "+getApresW()+aW);
      bean.ClassMAPTable[] ret=(bean.ClassMAPTable[])(CGenUtil.rechercher(getSingleton(),null,null,c,getApresW()+aW));
      setBase(ret);
    }
  }
  //public Liste(
  public String makeHtmlValeur(String temp) throws Exception
  {
    for(int i=0;i<getValeurBrute().length;i++)
    {
      String champValeur="";
      if(getColValeurBrute()==null)
        champValeur=valeurBrute[i].toString();
      else
        champValeur=getColValeurBrute()[i];
      String champAffiche=getValeurBrute()[i].toString();
      String selected="";
      if(champValeur.compareToIgnoreCase(getValeur())==0) selected="selected";
      else if((getValeur()==null||getValeur().compareToIgnoreCase("")==0)&&(getDefaultSelected()!=null&&getDefaultSelected().compareToIgnoreCase("")!=0))
      {
        if(champValeur.compareToIgnoreCase(getDefaultSelected())==0) selected="selected";
      }
      temp+="<option value='"+champValeur+"' "+selected+">"+champAffiche+"</option>";
    }
        return temp;
  }

  public void makeHtml()throws Exception
  {
    String temp="";
    String valiny="";
    if(selectedMultiple){valiny="multiple";}
    temp="<select name="+getNom()+" class="+getCss()+" id="+getNom()+" "+valiny+">";
    if(this.getBase()==null||this.getBase().length==0)
    {
      if( valeurBrute!=null && valeurBrute.length>0)
        temp=makeHtmlValeur(temp);
    }
    else
    {
      temp+="<option value="+ConstanteAffichage.asterisque+">Tous</option>";
      for(int i=0;i<this.getBase().length;i++){
        String champValeur=String.valueOf(CGenUtil.getValeurFieldByMethod((getBase()[i]),getColValeur()));
        String champAffiche=String.valueOf(CGenUtil.getValeurFieldByMethod((getBase()[i]),getColAffiche()));
        String selected="";

        if((getValeur()==null || getValeur().compareToIgnoreCase("")==0)&&getDefaultSelected()!=null){
          if(champValeur.compareToIgnoreCase(getDefaultSelected())==0)selected="selected";
        }else if(champValeur.compareToIgnoreCase(getValeur())==0){
          selected="selected";
        }
        temp+="<option value='"+champValeur+"' "+selected+">"+champAffiche+"</option>";
      }
    }
    temp+="</select>";
    setHtml(temp);
 }

  public void makeHtmlInsert() throws Exception
  {
      String temp="";
      temp="<select name="+getNom()+" class="+getCss()+" id="+getNom()+" "+getAutre()+" >";
      if(this.getBase()==null||this.getBase().length==0)
      {
        if( valeurBrute!=null && valeurBrute.length>0)
        temp=makeHtmlValeur(temp);
      }
      else
      {
        for(int i=0;i<this.getBase().length;i++)
        {
          String champValeur=String.valueOf(CGenUtil.getValeurFieldByMethod((getBase()[i]),getColValeur()));
          String champAffiche=String.valueOf(CGenUtil.getValeurFieldByMethod((getBase()[i]),getColAffiche()));
          String selected="";
          //System.out.println(" AVANT TOUT NIDITRA  "+getValeur()+" champValeir = "+champValeur);
          if((getValeur()==null || getValeur().compareToIgnoreCase("")==0)&&getDefaultSelected()!=null)
          {
            if(champValeur.compareToIgnoreCase(getDefaultSelected())==0)selected="selected";
          }
          else if(champValeur.compareToIgnoreCase(getValeur())==0)
          {
            selected="selected";
          }
          temp+="<option value='"+champValeur+"' "+selected+">"+champAffiche+"</option>";
        }
      }
      temp+="</select>";
      setHtmlInsert(temp);
  }
  public bean.ClassMAPTable[] getBase() {
    return base;
  }
  public void setBase(bean.ClassMAPTable[] base) {
    this.base = base;
  }
  public void setColAffiche(String colAffiche) {
    this.colAffiche = colAffiche;
  }
  public String getColAffiche() throws Exception{
    if(colAffiche==null)
    {
      if(getSingleton()!=null)
      {
        return getSingleton().getFieldList()[1].getName();
      }
      return getColValeur();
    }
    return colAffiche;
  }
  public void setColValeur(String colValeur) {
    this.colValeur = colValeur;
  }
  public String getColValeur() {
    if(colValeur==null)
    {
      if(getBase().length>0)
      {
        return getBase()[0].getAttributIDName();
      }
    }
    return colValeur;
  }
  public void setSingleton(bean.ClassMAPTable singleton) {
    this.singleton = singleton;
  }
  public bean.ClassMAPTable getSingleton() {
    return singleton;
  }
  public void setValeurBrute(Object[] valeurBrute) {
    this.valeurBrute = valeurBrute;
  }
  public Object[] getValeurBrute() {
    return valeurBrute;
  }
  public void setColValeurBrute(String[] colValeurBrute) {
    this.colValeurBrute = colValeurBrute;
  }
  public String[] getColValeurBrute() {
    return colValeurBrute;
  }
  public void setDefaultSelected(String defaultSelected) {
    setDefaut(defaultSelected);
    //this.defaultSelected = ;
  }
  public String getDefaultSelected() {
    return getDefaut();
  }
  public void setApresW(String apresW) {
    this.apresW = apresW;
  }
  public String getApresW() {
    return apresW;
  }

  public void ajouterValeur(String[] valeur, String[] affiche) {
        setColValeurBrute(valeur);
        setValeurBrute(affiche);
    }
  public void setSelectedMultiple(boolean selectedMultiple) {
    this.selectedMultiple = selectedMultiple;
 }

 public boolean isSelectedMultiple() {
   return selectedMultiple;
 }
}
