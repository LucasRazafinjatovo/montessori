package affichage;

import bean.CGenUtil;
import bean.ListeColonneTable;
import utilitaire.Utilitaire;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class TableauRecherche {
  private String expxml;
  private String expcsv;
  private String[] libeEntete;
  private bean.ClassMAPTable[] data;
  private String cssEntete="head";
  private String cssTableau="monographe";
  private String html;
  private String titre="LISTE";
  private int[] propEntet;
  private String tailleTableau="100%";
  private String[] libelleAffiche;
  private String[][] dataDirecte;
  private String[] lien;
  private String[] colonneLien;
  private String modelePage;
  private String[] attLien=null;
  private String[] valeurLien;

  public TableauRecherche(bean.ClassMAPTable[] donne,String lib[],int[] prop) throws Exception {
    setData(donne);
    setLibeEntete(lib);
    setPropEntet(prop);
    transformerDataString();
  }
  public TableauRecherche(bean.ClassMAPTable[] donne,String[] libEnte)throws Exception {
    setData(donne);
    setLibeEntete(libEnte);
    transformerDataString();
  }
  public TableauRecherche(String[][] donne,String[] libEnte)throws Exception {
    setLibeEntete(libEnte);
    setDataDirecte(donne);
  }
  public void makeHtmlOld() throws Exception
  {
    if(getDataDirecte()==null||getDataDirecte().length==0)
      return;
    String temp="";
    temp+="<p align=center><strong><u>"+getTitre()+"</u></strong></p>";
    temp+="<table width="+getTailleTableau()+" border=0 align=center cellpadding=3 cellspacing=3 class="+getCssTableau()+">";
    temp+=  "<tr class="+getCssEntete()+">";
    int nombreLigne=0,nombreColonne=0;
    nombreLigne=getDataDirecte().length;
    nombreColonne=getDataDirecte()[0].length;
    for(int i=0;i<nombreColonne;i++)
    {
      temp+="<td width="+getPropEntet()[i]+"% align=center valign=top>"+getLibelleAffiche()[i]+"</td>";
    }
    temp+="</tr>";
    for(int i=0;i<nombreLigne; i++)
    {
      temp+="<tr onmouseover=this.style.backgroundColor='#EAEAEA' onmouseout=\"this.style.backgroundColor=''\">";
      int nombreLien=0;
      for(int j=0;j<nombreColonne;j++)
      {
        String lien="";
        String apresLien="";
        int numeroColonne=Utilitaire.estIlDedans(getLibeEntete()[j],getColonneLien());
        if(numeroColonne!=-1)
        {
          String colLien=getLibeEntete()[j];
          String valL=getDataDirecte()[i][j];
          if(getAttLien()!=null)
          {
            colLien=getAttLien()[nombreLien];
          }
          if(getValeurLien()!=null)
          {
            Object valeurC=CGenUtil.getValeurFieldByMethod(data[i],getValeurLien()[nombreLien]);
            valL=String.valueOf(valeurC);
          }
          nombreLien++;
          lien="<a href='"+getLien()[numeroColonne]+"&"+colLien +"="+valL+"'>";
          apresLien="</a>";
        }
        temp+="<td width="+getPropEntet()[j]+"% align=center>"+lien+getDataDirecte()[i][j]+apresLien+"</td>";
      }
      temp+="</tr>";
    }
    temp+="</table>";
    setHtml(temp);
  }
  public void makeHtmlCheck() throws Exception
 {
   if(getDataDirecte()==null||getDataDirecte().length==0)
     return;
   String temp="";
   temp+="<p align=center><strong><u>"+getTitre()+"</u></strong></p>";
   temp+="<table width="+getTailleTableau()+" border=0 align=center cellpadding=3 cellspacing=3 id=\"mydiv\">";
   temp+=  "<tr class="+getCssEntete()+">";
   int nombreLigne=0,nombreColonne=0;
   nombreLigne=getDataDirecte().length;
   nombreColonne=getDataDirecte()[0].length;
   for(int i=0;i<nombreColonne;i++)
   {
     temp+="<td width="+getPropEntet()[i]+"% align=center valign=top>"+getLibelleAffiche()[i]+"</td>";
   }
   temp+="<td background-color=\"#66CCFF\" align=center valign=top></td>";
   temp+="</tr>";
   for(int i=0;i<nombreLigne; i++)
   {
     temp+="<tr onmouseover=this.style.backgroundColor='#EAEAEA' onmouseout=\"this.style.backgroundColor=''\">";
     int nombreLien=0;
     for(int j=0;j<nombreColonne;j++)
     {
       String lien="";
       String apresLien="";
       int numeroColonne=Utilitaire.estIlDedans(getLibeEntete()[j],getColonneLien());
       if(numeroColonne!=-1)
       {
         String colLien=getLibeEntete()[j];
         String valL=getDataDirecte()[i][j];
         if(getAttLien()!=null)
         {
           colLien=getAttLien()[nombreLien];
         }
         if(getValeurLien()!=null)
         {
           Object valeurC=CGenUtil.getValeurFieldByMethod(data[i],getValeurLien()[nombreLien]);
           valL=String.valueOf(valeurC);
         }
         nombreLien++;
         lien="<a href='"+getLien()[numeroColonne]+"&"+colLien +"="+valL+"'>";
         apresLien="</a>";
       }
       temp+="<td width="+getPropEntet()[j]+"% align=center>"+lien+getDataDirecte()[i][j]+apresLien+"</td>";
     }
     temp+="<td width=\"wawa\" align=center><input type=\"checkbox\" value="+getDataDirecte()[i][0]+" name="+getDataDirecte()[0][0]+" onclick=\"getChoixGazety(this)\"/></td>";
     temp+="</tr>";
   }
   temp+="</table>";
   setHtml(temp);
  }
  public void transformerDataString() throws Exception
  {
    dataDirecte=new String[getData().length][getLibeEntete().length];
    for(int i=0;i<getData().length;i++)
    {
      for(int j=0;j<getLibeEntete().length;j++)
      {
        bean.Champ c=ListeColonneTable.getChamp(data[i],getLibeEntete()[j]);
        Object valeurC=CGenUtil.getValeurFieldByMethod(data[i],getLibeEntete()[j]);
        if(valeurC==null)
        {
          dataDirecte[i][j]="";
          continue;
        }
        if(c.getTypeJava().compareToIgnoreCase("double")==0)
        {
          dataDirecte[i][j]=utilitaire.Utilitaire.formaterAr(String.valueOf(valeurC));
        }
        else if (c.getTypeJava().compareToIgnoreCase("java.sql.Date")==0)
        {
          dataDirecte[i][j]=Utilitaire.formatterDaty((java.sql.Date)(valeurC));
        }
        else
        {
          dataDirecte[i][j]=String.valueOf(valeurC);
        }
      }
    }

  }
  public String getHtmlWithCheckbox()throws Exception
  {
    if(html==null||html.compareToIgnoreCase("")==0)
      this.makeHtmlWithCheckbox();
    return html;
  }
  public String getHtmlWithRadio()throws Exception
  {
    if(html==null||html.compareToIgnoreCase("")==0)
      this.makeHtmlWithRadio();
    return html;
  }
  public void makeHtmlWithCheckbox() throws Exception
 {
   if(getDataDirecte()==null||getDataDirecte().length==0)
     return;
   String temp="";
   temp+="<p align=center><strong><u>"+getTitre()+"</u></strong></p>";
   temp += "<div id=\"divchck\">";
   temp+="<table width="+getTailleTableau()+" border=0 align=center cellpadding=3 cellspacing=3 class="+getCssTableau()+">";
   temp+=  "<tr class="+getCssEntete()+">";
   int nombreLigne=0,nombreColonne=0;
   nombreLigne=getDataDirecte().length;
   nombreColonne=getDataDirecte()[0].length;
   temp+="<td align=center valign=top><input type='checkbox' id='cocheTout'/></td>";
   for(int i=0;i<nombreColonne;i++)
   {
     temp+="<td width="+getPropEntet()[i]+"% align=center valign=top>"+getLibelleAffiche()[i]+"</td>";
   }
   temp+="</tr>";
   for(int i=0;i<nombreLigne; i++)
   {
     temp+="<tr onmouseover=this.style.backgroundColor='#EAEAEA' onmouseout=\"this.style.backgroundColor=''\">";
     temp+="<td align=center><input type='checkbox' value='"+getDataDirecte()[i][0]+"' name='id' id='checkbox"+i+"'/></td>";
     int nombreLien=0;
     for(int j=0;j<nombreColonne;j++)
     {
       String lien="";
       String apresLien="";
       int numeroColonne=Utilitaire.estIlDedans(getLibeEntete()[j],getColonneLien());
       if(numeroColonne!=-1)
       {

         String colLien=getLibeEntete()[j];
         String valL=getDataDirecte()[i][j];
         if(getAttLien()!=null)
         {
           colLien=getAttLien()[nombreLien];
         }
         if(getValeurLien()!=null)
         {
           Object valeurC=CGenUtil.getValeurFieldByMethod(data[i],getValeurLien()[nombreLien]);
           valL=String.valueOf(valeurC);
         }
         nombreLien++;
         lien="<a href='"+getLien()[numeroColonne]+"&"+colLien +"="+valL+"'>";
         apresLien="</a>";
       }
       if(j==1)
         temp+="<td width="+getPropEntet()[j]+"% align=center><input type='text' readonly=true style='border:none;text-align:center;' name='idEmp"+i+"' value='"+getDataDirecte()[i][j]+"'></td>";
       else
         temp+="<td width="+getPropEntet()[j]+"% align=center>"+lien+getDataDirecte()[i][j]+apresLien+"</td>";
     }
     temp+="</tr>";
   }
   temp+="</table>";
   temp += "</div>";
   setHtml(temp);
  }
  public void makeHtmlWithRadio() throws Exception
 {
   if(getDataDirecte()==null||getDataDirecte().length==0)
     return;
   String temp="";
   temp+="<p align=center><strong><u>"+getTitre()+"</u></strong></p>";
   temp += "<div id=\"divchck\">";
   temp+="<table width="+getTailleTableau()+" border=0 align=center cellpadding=3 cellspacing=3 class="+getCssTableau()+">";
   temp+=  "<tr class="+getCssEntete()+">";
   int nombreLigne=0,nombreColonne=0;
   nombreLigne=getDataDirecte().length;
   nombreColonne=getDataDirecte()[0].length;
   temp+="<td align=center valign=top></td>";
   for(int i=0;i<nombreColonne;i++)
   {
     temp+="<td width="+getPropEntet()[i]+"% align=center valign=top>"+getLibelleAffiche()[i]+"</td>";
   }
   temp+="</tr>";
   for(int i=0;i<nombreLigne; i++)
   {
     temp+="<tr onmouseover=this.style.backgroundColor='#EAEAEA' onmouseout=\"this.style.backgroundColor=''\">";
     temp+="<td align=center><input type='radio' value='"+getDataDirecte()[i][0]+"' name='radio' id='radio' class='radio'/></td>";
     int nombreLien=0;
     for(int j=0;j<nombreColonne;j++)
     {
       String lien="";
       String apresLien="";
       int numeroColonne=Utilitaire.estIlDedans(getLibeEntete()[j],getColonneLien());
       if(numeroColonne!=-1)
       {

         String colLien=getLibeEntete()[j];
         String valL=getDataDirecte()[i][j];
         if(getAttLien()!=null)
         {
           colLien=getAttLien()[nombreLien];
         }
         if(getValeurLien()!=null)
         {
           Object valeurC=CGenUtil.getValeurFieldByMethod(data[i],getValeurLien()[nombreLien]);
           valL=String.valueOf(valeurC);
         }
         nombreLien++;
         lien="<a href='"+getLien()[numeroColonne]+"&"+colLien +"="+valL+"'>";
         apresLien="</a>";
       }
       if(j==1)
         temp+="<td width="+getPropEntet()[j]+"% align=center><input type='text' readonly=true style='border:none;text-align:center;' name='idEmp"+i+"' value='"+getDataDirecte()[i][j]+"'></td>";
       else
         temp+="<td width="+getPropEntet()[j]+"% align=center>"+lien+getDataDirecte()[i][j]+apresLien+"</td>";
     }
     temp+="</tr>";
   }
   temp+="</table>";
   temp += "</div>";
   setHtml(temp);
  }
  public String[] getLibeEntete() {
    return libeEntete;
  }
  public void setLibeEntete(String[] libeEntete) {
    this.libeEntete = libeEntete;
  }
  public void setData(bean.ClassMAPTable[] data) {
    this.data = data;
  }
  public bean.ClassMAPTable[] getData() {
    return data;
  }
  public void setCssEntete(String cssEntete) {
    this.cssEntete = cssEntete;
  }
  public String getCssEntete() {
    return cssEntete;
  }
  public void setCssTableau(String cssTableau) {
    this.cssTableau = cssTableau;
  }
  public String getCssTableau() {
    return cssTableau;
  }
  public void setHtml(String html) {
    this.html = html;
  }
  public String getHtml()throws Exception {
    if(html==null||html.compareToIgnoreCase("")==0)
       this.makeHtml();
    return html;
  }
  public String getHtmlCheck()throws Exception {
    if(html==null||html.compareToIgnoreCase("")==0)
       this.makeHtmlCheck();
    return html;
  }
  public void setTitre(String titre) {
    this.titre = titre;
  }
  public String getTitre() {
    return titre;
  }
  public void setPropEntet(int[] propEntet) {
    this.propEntet = propEntet;
  }
  public int[] getPropEntet() {
    if(propEntet==null)
    {
      int []ret=new int[getLibeEntete().length];
      for(int i=0;i<ret.length;i++)
      {
        ret[i]=100/ret.length;
      }
      return ret;
    }
    return propEntet;
  }
  public void setTailleTableau(String tailleTableau) {
    this.tailleTableau = tailleTableau;
  }
  public String getTailleTableau() {
    return tailleTableau;
  }
  public void setLibelleAffiche(String[] libelleAffiche) {
    this.libelleAffiche = libelleAffiche;
  }
  public String[] getLibelleAffiche() {
    if(libelleAffiche==null) return getLibeEntete();
    return libelleAffiche;
  }
  public void setDataDirecte(String[][] dataDirecte) {
    this.dataDirecte = dataDirecte;
  }
  public String[][] getDataDirecte() {
    return dataDirecte;
  }
  public void setLien(String[] lien) {
    this.lien = lien;
  }
  public String[] getLien() {
    return lien;
  }
  public void setColonneLien(String[] colonneLien) {
    this.colonneLien = colonneLien;
  }
  public String[] getColonneLien() {
    return colonneLien;
  }
  public void setModelePage(String modelePage) {
    this.modelePage = modelePage;
  }
  public String getModelePage() {
    return modelePage;
  }
  public void setAttLien(String[] attLien) {
    this.attLien = attLien;
  }
  public String[] getAttLien() {
    return attLien;
  }
  public void setValeurLien(String[] valeurLien) {
    this.valeurLien = valeurLien;
  }
  public String[] getValeurLien() {
    return valeurLien;
  }
  public String getExpxml()
  {
    return expxml;
  }
  public void setExpxml(String s)
  {
     expxml=s;
  }
  public String getExpcsv()
{
    return expcsv;
}
public void setExpcsv(String s)
  {
     expcsv=s;
  }
  public void makeHtml() throws Exception
  {
    if(getDataDirecte()==null||getDataDirecte().length==0)
      return;
    String temp="";
    String tempcsv="";
    String tempxml="<?xml version=\"1.0\" encoding=\"UTF-8\"?> \r\n <tableau>";
    temp+="<p align=center><strong><u>"+getTitre()+"</u></strong></p>";
    temp += "<div id=\"selectnonee\">";
    temp+="<table width="+getTailleTableau()+" border=0 align=center cellpadding=3 cellspacing=3 class="+getCssTableau()+">";
    temp+=  "<tr class="+getCssEntete()+">";
    int nombreLigne=0,nombreColonne=0;
    nombreLigne=getDataDirecte().length;
    nombreColonne=getDataDirecte()[0].length;
    for(int i=0;i<nombreColonne;i++)
    {
      temp+="<td width="+getPropEntet()[i]+"% align=center valign=top>"+getLibelleAffiche()[i]+"</td>";
      tempcsv+=getLibelleAffiche()[i];
      if(i!=nombreColonne-1)
        tempcsv+=";";
    }
    temp+="</tr>";
    tempcsv+="\r\n";
    tempxml+="\r\n";
    for(int i=0;i<nombreLigne; i++)
    {
      temp+="<tr onmouseover=this.style.backgroundColor='#EAEAEA' onmouseout=\"this.style.backgroundColor=''\">";
      tempxml+="<row>\r\n";
      int nombreLien=0;
      for(int j=0;j<nombreColonne;j++)
      {
        String alignement = "left";
        String lien="";
        String apresLien="";
        int numeroColonne=Utilitaire.estIlDedans(getLibeEntete()[j],getColonneLien());
        if(numeroColonne!=-1)
        {
          String colLien=getLibeEntete()[j];
          String valL=getDataDirecte()[i][j];
          if(getAttLien()!=null)
          {
            colLien=getAttLien()[nombreLien];
          }
          if(getValeurLien()!=null)
          {
            Object valeurC=CGenUtil.getValeurFieldByMethod(data[i],getValeurLien()[nombreLien]);
            valL=String.valueOf(valeurC);
          }
          nombreLien++;
          lien="<a href='"+getLien()[numeroColonne]+"&"+colLien +"="+valL+"'>";
          apresLien="</a>";
        }
        if(getDataDirecte()[i][j].getClass().getName().compareToIgnoreCase("java.lang.String")==0) alignement = "left";
        String testsplit = Utilitaire.enleverEspaceDoubleBase(getDataDirecte()[i][j]);
        if(testsplit.contains(",")){
            String[] testsplits = testsplit.split(",");
            if(Utilitaire.isStringNumeric(testsplits[0]) && Utilitaire.isStringNumeric(testsplits[1])) alignement ="right";
        }
        temp+="<td width="+getPropEntet()[j]+"% align=\""+alignement+"\">"+lien+getDataDirecte()[i][j]+apresLien+"</td>";
        tempcsv+=Utilitaire.verifNumerique(getDataDirecte()[i][j]);
        tempxml+="<"+getLibelleAffiche()[j]+">"+Utilitaire.verifNumerique(getDataDirecte()[i][j])+"</"+getLibelleAffiche()[j]+">\r\n";
        if(j!=nombreColonne-1)
          tempcsv+=";";
      }
      temp+="</tr>";
      tempcsv+="\r\n";
      tempxml+="</row>\r\n";
    }
    tempxml+="</tableau>\r\n";
    temp+="</table>";
    temp += "</div>";
        //temp+=" <p> "+tempxml+" </p>";
    setHtml(temp);
    setExpcsv(tempcsv);
    setExpxml(tempxml);
  }

}