package affichage;

import javax.servlet.http.HttpServletRequest;
import bean.ListeColonneTable;
import java.util.Vector;
import java.lang.reflect.Field;
import java.sql.Connection;
import utilitaire.Utilitaire;
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

public class PageRecherche extends Page {

  private TableauRecherche listeTabDet;
  private bean.ClassMAPTable[] liste;
  private bean.ClassMAPTable critere;
  private String[] colInt;
  private String[] valInt;
  private bean.ResultatEtSomme rs;
  private int numPage=1;
  private String[] colSomme;
  private String apres;
  private String aWhere="";
  private String apresLienPage="";
  private int npp=0;
  private String[] tableauAffiche;
  private String[] tableauAfficheDefaut;
  private int nbTableauAffiche;
  private boolean premier=false;
  private MapUtilisateur u;


  public void makeTableauAffiche()throws Exception {
    String temp[]=new String[getNbTableauAffiche()];
    for(int i=0;i<temp.length;i++)
    {
      temp[i]=getReq().getParameter("colAffiche"+(i+1));
    }
    setTableauAffiche(Utilitaire.formerTableauGroupe(temp));
  }
  public void setPremier(String prim)
  {
    if (prim==null||prim.compareToIgnoreCase("")==0)return;
    if(prim.compareToIgnoreCase("true")==0)
    {
      setPremier(true);
    }
    if(prim.compareToIgnoreCase("false")==0)
    {
          setPremier(false);
    }
  }
  public void preparerDataList(Connection c) throws Exception
  {
    //if(critere.getNomTable()==null||critere.getNomTable().compareToIgnoreCase("")==0)
    critere.setNomTable(getBase().getNomTable());
    makeCritere();
    if(premier==true)
    {
      rs=new bean.ResultatEtSomme();
      rs.initialise(getColSomme());
    }
    else
      rs=getUtilisateur().getDataPage(critere,getColInt(),getValInt(),getNumPage(),getAWhere(),getColSomme(),c,npp);
    setListe ((bean.ClassMAPTable[])rs.getResultat());
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
  public void preparerData() throws Exception
  {
    Connection c=null;
    try {
      c=new utilitaire.UtilDB().GetConn();
      preparerDataList(c);
      formu.getAllData(c);
      getReq().getSession().setAttribute("critere",getCritere());
    }
    catch (Exception ex) {
      throw (ex);
    }
    finally
    {
      if(c!=null)c.close();
    }
  }
  public void makeCritere() throws Exception
  {
    Vector colIntv=new Vector();
    Vector valIntv=new Vector();
    Champ[] tempChamp=formu.getCrtFormu();
    for(int i=0;i<tempChamp.length;i++)
    {
      Field f=bean.CGenUtil.getField(getBase(),tempChamp[i].getNom());
      if(tempChamp[i].getEstIntervalle()==1)
      {
        colIntv.add(tempChamp[i].getNom());
        valIntv.add(getParamSansNull(tempChamp[i].getNom()+"1"));
        valIntv.add(getParamSansNull(tempChamp[i].getNom()+"2"));
      }
      else if(f.getType().getName().compareToIgnoreCase("java.lang.String")==0)
      {
        String temp=getReq().getParameter(utilitaire.Utilitaire.remplacerUnderscore(tempChamp[i].getNom()));
        if(temp!=null&&temp.compareToIgnoreCase("")!=0)
        bean.CGenUtil.setValChamp(getCritere(),f,getParamSansNull(tempChamp[i].getNom()));
      }
      else
      {
        //aWhere+=" and "+f.getName() +" like '"+ Utilitaire.getValeurNonNull(formu.getListeChamp()[i].getValeur()) +"'";
        aWhere+=" and "+f.getName() +" like '"+ Utilitaire.getValeurNonNull(getParamSansNull(tempChamp[i].getNom())) +"'";
      }
    }

    colInt=new String[colIntv.size()];
    colIntv.copyInto(colInt);
    valInt=new String[valIntv.size()];
    valIntv.copyInto(valInt);
    if(formu.getChamp("colonne").getValeur()!=null&&formu.getChamp("colonne").getValeur().compareToIgnoreCase("")!=0)
      aWhere+=" order by "+formu.getChamp("colonne").getValeur()+" "+formu.getChamp("ordre").getValeur();

  }
  public void creerObjetPage(String libEntete[]) throws Exception
  {
    getValeurFormulaire();
    preparerData();
    makeTableauRecap();
    setTableau(new TableauRecherche(getListe(),libEntete));
  }
  public void creerObjetPage(ClassMAPTable[] liste,String libEntete[]) throws Exception
  {
    setListe(liste);

    creerObjetPage(libEntete);
  }
  public void creerObjetPage(String libEnteteDefaut[],String []colSom) throws Exception
  {
    setColSomme(colSom);
    getValeurFormulaire();
    preparerData();
    makeTableauRecap();
   String[]enteteAuto= getTableauAffiche();
    if(getTableauAffiche()==null){
      setTableau(new TableauRecherche(getListe(),libEnteteDefaut));
    }
    else
      setTableau(new TableauRecherche(getListe(),enteteAuto));
  }


  public void creerObjetPageMultiple(String libEnteteDefaut[],String []colSom) throws Exception{
    setColSomme(colSom);
    getValeurFormulaireMultiple();
    preparerDataMultiple();
    makeTableauRecap();
    String[]enteteAuto= getTableauAffiche();
    if(getTableauAffiche()==null){
      setTableau(new TableauRecherche(getListe(),libEnteteDefaut));
    }else{
      setTableau(new TableauRecherche(getListe(),enteteAuto));
    }
  }

  public void preparerDataMultiple() throws Exception
  {
    Connection c=null;
    try {
      c=new utilitaire.UtilDB().GetConn();
      preparerDataListMultiple(c);
      formu.getAllData(c);
    }
    catch (Exception ex) {
      throw (ex);
    }
    finally{
      if(c!=null)c.close();
    }
 }

 public void preparerDataListMultiple(Connection c) throws Exception
 {
   critere.setNomTable(getBase().getNomTable());
   makeCritereMultiple();
   if(premier==true)
   {
     rs=new bean.ResultatEtSomme();
     rs.initialise(getColSomme());
   }
   else{
     rs=getUtilisateur().getDataPageMultiple(critere,getColInt(),getValInt(),getNumPage(),getAWhere(),getColSomme(),c,npp);
   }
   setListe ((bean.ClassMAPTable[])rs.getResultat());
 }

 public void makeCritereMultiple() throws Exception
 {
   Vector colIntv=new Vector();
   Vector valIntv=new Vector();
   Champ[] tempChamp=formu.getCrtFormu();
   for(int i=0;i<tempChamp.length;i++)
   {
     Field f=bean.CGenUtil.getField(getBase(),tempChamp[i].getNom());
     if(tempChamp[i].getEstIntervalle()==1)
     {
       colIntv.add(tempChamp[i].getNom());
       valIntv.add(getParamSansNull(tempChamp[i].getNom()+"1"));
       valIntv.add(getParamSansNull(tempChamp[i].getNom()+"2"));
     }
     else if(f.getType().getName().compareToIgnoreCase("java.lang.String")==0)
     {
       String temp=getReq().getParameter(utilitaire.Utilitaire.remplacerUnderscore(tempChamp[i].getNom()));
       if(temp!=null&&temp.compareToIgnoreCase("")!=0)
         bean.CGenUtil.setValChamp(getCritere(),f,getParamSansNullMultiple(tempChamp[i].getNom()));
     }
     else
     {
       //aWhere+=" and "+f.getName() +" like '"+ Utilitaire.getValeurNonNull(formu.getListeChamp() [i].getValeur()) +"'";
       aWhere+=" and "+f.getName() +" like '"+ Utilitaire.getValeurNonNull(getParamSansNullMultiple(tempChamp[i].getNom())) +"'";
     }
   }
   colInt=new String[colIntv.size()];
   colIntv.copyInto(colInt);
   valInt=new String[valIntv.size()];
   valIntv.copyInto(valInt);
   if(formu.getChamp("colonne").getValeur()!=null&&formu.getChamp("colonne").getValeur().compareToIgnoreCase("")!=0)
     aWhere+=" order by "+formu.getChamp("colonne").getValeur()+" "+formu.getChamp("ordre").getValeur();
 }

 /* public void creerObjetPage() throws Exception
  {
    getValeurFormulaire();
    preparerData();
    makeTableauRecap();
    String[]enteteAuto= getTableauAffiche();
    setTableau(new TableauRecherche(getListe(),enteteAuto));
  } */

  public PageRecherche(bean.ClassMAPTable o,HttpServletRequest req,String []vrt,String[] listInterval,int nbRange,String[] tabAff,int nbAff)throws Exception {
    setBase(o);
    if(o.getClass().toString().compareToIgnoreCase("class pub.Pucomplet")==0){

      //throw new Exception("Profil invalide");
    }
    //setTitre(titre);
    setCritere((bean.ClassMAPTable)(Class.forName(o.getClassName()).newInstance()));
    setReq(req);
    setPremier(getReq().getParameter("premier"));
    formu=new Formulaire();
    formu.setObjet(getBase());
    formu.makeChampFormu(vrt,listInterval, nbRange);
    setNbTableauAffiche(nbAff);
    setTableauAfficheDefaut(tabAff);
    makeTableauAffiche();
    formu.makeChampTableauAffiche(getNbTableauAffiche(),tabAff);
  }
  public PageRecherche(bean.ClassMAPTable o,HttpServletRequest req,String []vrt,String[] listInterval,int nbRange)throws Exception {
  // if(o.toString().)
    setBase(o);
    //setTitre(titre);
    setCritere((bean.ClassMAPTable)(Class.forName(o.getClassName()).newInstance()));
    setReq(req);
    setPremier(getReq().getParameter("premier"));
    formu=new Formulaire();
    formu.setObjet(getBase());
    formu.makeChampFormu(vrt,listInterval, nbRange);
  }
  public bean.ClassMAPTable[] getListe() {
    return liste;
  }
  public void setListe(bean.ClassMAPTable[] liste) {
    this.liste = liste;
  }
  public void setListeTabDet(TableauRecherche listeTabDet) {
    this.listeTabDet = listeTabDet;
  }
  public TableauRecherche getListeTabDet() {
    return listeTabDet;
  }
  public void setCritere(bean.ClassMAPTable critere) {
    this.critere = critere;
  }
  public bean.ClassMAPTable getCritere() {
    return critere;
  }
  public void setColInt(String[] colInt) {
    this.colInt = colInt;
  }
  public String[] getColInt() {
    return colInt;
  }
  public void setValInt(String[] valInt) {
    this.valInt = valInt;
  }
  public String[] getValInt() {
    return valInt;
  }
  public void makeHtml()
  {

  }
  public void setRs(bean.ResultatEtSomme rs) {
    this.rs = rs;
  }
  public bean.ResultatEtSomme getRs() {
    return rs;
  }
  public void setNumPage(int numPage) {
    this.numPage = numPage;
  }
  public int getNumPage() {
    int temp=1;
    String tempS=getParamSansNull("numPag");
    if (tempS==null||tempS.compareToIgnoreCase("")==0) return numPage;
    temp=utilitaire.Utilitaire.stringToInt(tempS);
    if(temp>0)
      return temp;
    return numPage;
  }
  public void setColSomme(String[] colSomme) {
    this.colSomme = colSomme;
  }
  public String[] getColSomme() {
    return colSomme;
  }
  public void makeTableauRecap() throws Exception
  {
    String[][] data=null;
    String [] entete=null;
    int nbColSomme=0;

    if (getColSomme()!=null)
      nbColSomme=getColSomme().length;
    entete=new String[nbColSomme+2];
    data=new String[1][entete.length];
    entete[0]="";
    data[0][0]="Total";
    entete[1]="Nombre";
    data[0][1]=utilitaire.Utilitaire.formaterAr(String.valueOf(rs.getSommeEtNombre()[nbColSomme]));
    for(int i=0;i<nbColSomme;i++)
    {
      data[0][i+2]=utilitaire.Utilitaire.formaterAr(String.valueOf(rs.getSommeEtNombre()[i]));
      entete[i+2]="Somme de "+String.valueOf(getColSomme()[i]);
    }
    TableauRecherche t=new TableauRecherche(data,entete);
    t.setTitre("RECAP");
    setTableauRecap(t);
  }
  public int getNombrePage()
  {
    return (Utilitaire.calculNbPage(rs.getSommeEtNombre()[getNombreColonneSomme()],getNpp()));
  }
  public int getNombreColonneSomme()
  {
    int nbColSomme=0;
    if (getColSomme()!=null)
      nbColSomme=getColSomme().length;
    return nbColSomme;
  }
  public String getBasPage()
{
  String retour="";
  retour+="<table border=0 cellpadding=0 cellspacing=0 align=center width='100%'>";
  retour+="<tr><td height=25><b>Nombre de r&eacute;sultat :</b> "+utilitaire.Utilitaire.formaterAr(String.valueOf(rs.getSommeEtNombre()[getNombreColonneSomme()]))+"</td><td align='right'><strong>page</strong> "+getNumPage()+" <b>sur</b> "+getNombrePage()+"</td>";
  retour+="</tr>";
  retour+="<tr>";
  retour+="<td width=50% valign='top' height=25>";
  if(getNumPage()>1)
  {
    retour+="<a href="+getLien()+"?but="+getApres()+formu.getListeCritereString()+"&numPag="+String.valueOf(getNumPage()-1)+getApresLienPage()+">&lt;&lt;Page pr&eacute;c&eacute;dente</a>";
  }
  retour+="</td>";
  retour+="<td width=50% align=right>";
  if(getNumPage()<getNombrePage())
  {
    retour+="<a href="+getLien()+"?but="+getApres()+formu.getListeCritereString()+"&numPag="+String.valueOf(getNumPage()+1)+getApresLienPage()+">Page suivante&gt;&gt;</a>";
  }
  retour+="</td>";
  retour+="</tr>";
  retour+="</table>";
      retour+=getDownloadForm();
  return retour;
  }
  public String getBasPagee()
  {
    /*misy champ return etudiant*/
    String retour="";
    retour+="<table border=0 cellpadding=0 cellspacing=0 align=center width='100%'>";
    retour+="<tr><td height=25><b>Nombre de r&eacute;sultat :</b> "+utilitaire.Utilitaire.formaterAr(String.valueOf(rs.getSommeEtNombre()[getNombreColonneSomme()]))+"</td><td align='right'><strong>page</strong> "+getNumPage()+" <b>sur</b>"+getNombrePage()+"</td>";
    retour+="</tr>";
    if(getNumPage()>1)
    {
      retour+="<a href="+getApres()+"?"+formu.getListeCritereString()+"&numPag="+String.valueOf(getNumPage()-1)+getApresLienPage()+"&champReturn=idEtudiant>&lt;&lt;Page pr&eacute;c&eacute;dente</a>";
    }
    retour+="</td>";
    retour+="<td width=50% align=right>";
    if(getNumPage()<getNombrePage())
    {
      retour+="<a href="+getApres()+"?"+formu.getListeCritereString()+"&numPag="+String.valueOf(getNumPage()+1)+getApresLienPage()+"&champReturn=idEtudiant>Page suivante&gt;&gt;</a>";
    }
    retour+="</td>";
    retour+="</tr>";
    retour+="</table>";
    return retour;
  }
 public String getBasPageSansLien()
{
  String retour="";
  retour+="<table border=0 cellpadding=0 cellspacing=0 align=center width='100%'>";
  retour+="<tr><td height=25><b>Nombre de r&eacute;sultat :</b> "+utilitaire.Utilitaire.formaterAr(String.valueOf(rs.getSommeEtNombre()[getNombreColonneSomme()]))+"</td><td align='right'><strong>page</strong> "+getNumPage()+" <b>sur</b> "+getNombrePage()+"</td>";
  retour+="</tr>";
  retour+="<tr>";
  retour+="<td width=50% valign='top' height=25>";
  if(getNumPage()>1)
  {
    retour+="<a href=../"+getApres()+"?1<2"+formu.getListeCritereString()+"&numPag="+String.valueOf(getNumPage()-1)+getApresLienPage()+">&lt;&lt;Page pr&eacute;c&eacute;dente</a>";
  }
  retour+="</td>";
  retour+="<td width=50% align=right>";
  if(getNumPage()<getNombrePage())
  {
    retour+="<a href=../"+getApres()+"?1<2"+formu.getListeCritereString()+"&numPag="+String.valueOf(getNumPage()+1)+getApresLienPage()+">Page suivante&gt;&gt;</a>";
  }
  retour+="</td>";
  retour+="</tr>";
  retour+="</table>";
      retour+=getDownloadFormSansLien();
  return retour;
  }
  public String getBasPageOld()
  {
    String retour="";
    retour+="<table border=0 cellpadding=0 cellspacing=0 align=center width='100%'>";
    retour+="<tr><td height=25><b>Nombre de r&eacute;sultat :</b> "+utilitaire.Utilitaire.formaterAr(String.valueOf(rs.getSommeEtNombre()[getNombreColonneSomme()]))+"</td><td align='right'><strong>page</strong> "+getNumPage()+" <b>sur</b> "+getNombrePage()+"</td>";
    retour+="</tr>";
    retour+="<tr>";
    retour+="<td width=50% valign='top' height=25>";
    if(getNumPage()>1)
    {
      retour+="<a href="+getLien()+"?but="+getApres()+formu.getListeCritereString()+"&numPag="+String.valueOf(getNumPage()-1)+getApresLienPage()+">&lt;&lt;Page pr&eacute;c&eacute;dente</a>";
    }
    retour+="</td>";
    retour+="<td width=50% align=right>";
    if(getNumPage()<getNombrePage())
    {
      retour+="<a href="+getLien()+"?but="+getApres()+formu.getListeCritereString()+"&numPag="+String.valueOf(getNumPage()+1)+getApresLienPage()+">Page suivante&gt;&gt;</a>";
    }
    retour+="</td>";
    retour+="</tr>";
    retour+="</table>";
    return retour;
  }
  public void setApres(String apres) {
    this.apres = apres;
  }
  public String getApres() {
    return apres;
  }
  public String getAWhere() {
    return aWhere;
  }
  public void setAWhere(String aWhere) {
    this.aWhere = aWhere;
  }
  public void setApresLienPage(String apresLienPage) {
    this.apresLienPage = apresLienPage;
  }
  public String getApresLienPage() {
    return apresLienPage;
  }
  public void setNpp(int npp) {
    this.npp = npp;
  }
  public int getNpp() {
    return npp;
  }
  public String[] getTableauAffiche() {
    if(tableauAffiche==null||tableauAffiche.length==0) return tableauAfficheDefaut;
    return tableauAffiche;
  }
  public String[] getTableauAfficheDefaut() {
    return tableauAfficheDefaut;
  }
  public void setTableauAfficheDefaut(String[] tableauAfficheDefaut) {
    this.tableauAfficheDefaut = tableauAfficheDefaut;
  }
  public void setTableauAffiche(String[] tableauAffiche) {
    this.tableauAffiche = tableauAffiche;
  }
  public int getNbTableauAffiche() {
    return nbTableauAffiche;
  }
  public void setNbTableauAffiche(int nbTableauAffiche) {
    this.nbTableauAffiche = nbTableauAffiche;
  }
  public void setPremier(boolean premier) {
    this.premier = premier;
  }
  public boolean isPremier() {
    return premier;
  }
  public String getDownloadForm()
  {
               String tab="";
               try{

                       tab=this.getTableau().getHtml();
               }
               catch (Exception e)
               {
                       e.printStackTrace();
               }
               String temp="<p align=\"center\"> <strong> <u>EXPORTER</u> </strong> </p>  ";
       temp+="<div style=\"text-align:left; padding-left: 15px; border: thin solid #0099FF \" ><form action=\"download\" method=\"post\">";
       temp+="<h3> Format</h3>";
       temp+="<p> csv ";
       temp+="<input type=\"radio\" name=\"ext\" value=\"csv\" checked=\"checked\" /> </p>";

       temp+="<p> xml ";
       temp+="<input type=\"radio\" name=\"ext\" value=\"xml\" /> </p>";

               temp+="<p> xls ";
       temp+="<input type=\"radio\" name=\"ext\" value=\"xls\" /> </p>";

       temp+="<h3> Donne&eacute;es &agrave; exporter</h3> ";
       temp+="<p> page en cours ";
       temp+="<input type=\"radio\" name=\"donnee\" value=\""+0+"\" checked=\"checked\" /> </p>";
       temp+="<p> ensemble des donn&eacute;es ";
       temp+="<input type=\"radio\" name=\"donnee\" value=\""+1+"\" /> </p>";
               if(this.getTableau().getExpxml()!=null){

       temp+="<input type=\"hidden\" name=\"xml\" value=\""+this.getTableau().getExpxml().replace('"','*')+"\" />";
       temp+="<input type=\"hidden\" name=\"csv\" value=\""+this.getTableau().getExpcsv().replace('"','*')+"\" />";
               temp+="<input type=\"hidden\" name=\"awhere\" value=\""+this.getAWhere().replace('"','\'')+"\" />";
               temp+="<input type=\"hidden\" name=\"table\" value=\""+tab.replace('"','*')+"\" />";
               }
       temp+="<input type=\"submit\" value=\"Exporter\" class=\"submit\" /> </form> </div>";

       return temp;
  }
  public String getDownloadFormSansLien()
  {
               String tab="";
               try{

                       tab=this.getTableau().getHtml();
               }
               catch (Exception e)
               {
                       e.printStackTrace();
               }
               String temp="<p align=\"center\"> <strong> <u>EXPORTER</u> </strong> </p>  ";
       temp+="<div style=\"text-align:left; padding-left: 15px; border: thin solid #0099FF \" ><form action=\"../download\" method=\"post\">";
       temp+="<h3> Format</h3>";
       temp+="<p> csv ";
       temp+="<input type=\"radio\" name=\"ext\" value=\"csv\" checked=\"checked\" /> </p>";

       temp+="<p> xml ";
       temp+="<input type=\"radio\" name=\"ext\" value=\"xml\" /> </p>";

               temp+="<p> xls ";
       temp+="<input type=\"radio\" name=\"ext\" value=\"xls\" /> </p>";

       temp+="<h3> Donne&eacute;es &agrave; exporter</h3> ";
       temp+="<p> page en cours ";
       temp+="<input type=\"radio\" name=\"donnee\" value=\""+0+"\" checked=\"checked\" /> </p>";
       temp+="<p> ensemble des donn&eacute;es ";
       temp+="<input type=\"radio\" name=\"donnee\" value=\""+1+"\" /> </p>";
               if(this.getTableau().getExpxml()!=null){

       temp+="<input type=\"hidden\" name=\"xml\" value=\""+this.getTableau().getExpxml().replace('"','*')+"\" />";
       temp+="<input type=\"hidden\" name=\"csv\" value=\""+this.getTableau().getExpcsv().replace('"','*')+"\" />";
               temp+="<input type=\"hidden\" name=\"awhere\" value=\""+this.getAWhere().replace('"','\'')+"\" />";
               temp+="<input type=\"hidden\" name=\"table\" value=\""+tab.replace('"','*')+"\" />";
               }
       temp+="<input type=\"submit\" value=\"Exporter\" class=\"submit\" /> </form> </div>";

       return temp;
  }
}