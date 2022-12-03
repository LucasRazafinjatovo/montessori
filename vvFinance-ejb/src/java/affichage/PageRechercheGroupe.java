package affichage;

import bean.CGenUtil;
import javax.servlet.http.HttpServletRequest;
import bean.ListeColonneTable;
import java.util.Vector;
import java.lang.reflect.Field;
import java.sql.Connection;
import utilitaire.Utilitaire;
import bean.ClassMAPTable;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class PageRechercheGroupe extends Page {

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
  private String[] colGroupe; // Tableau de chaine représentant les valeurs des colonnes selectionnées.
  private String[] sommeGroupe;
  private String ordre="";
  private int nbColGroupe=2;
  private int nbSommeGrp=2;
  private String[] colGroupeDefaut;
  private String[] sommeGroupeDefaut;
  private int npp=0;
  private String[] listeColonneMoyenne;
  private boolean premier;
  private String[] moyenneGroupe;
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
    //System.out.println(" MOYENNNNNNNNNNNNNNNNNNNE ================= 2 "+getMoyenneGroupe());
    if(premier==true)
    {
      rs=new bean.ResultatEtSomme();
      rs.initialise(getColSomme());
      //System.out.println(" nandalo preparerDataList =========== 1");
    }
    else
      rs=getUtilisateur().getDataPageGroupe(critere,getColGroupe(),getSommeGroupe(),getMoyenneGroupe(),getColInt(),getValInt(),getNumPage(),getAWhere(),getColSomme(),getOrdre(),c,npp);
    setListe ((bean.ClassMAPTable[])rs.getResultat());
    //System.out.println(" nandalo preparerDataList ================= 2");
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
    else
      rs=getUtilisateur().getDataPageGroupeMultiple(critere,getColGroupe(),getSommeGroupe(),getColInt(),getValInt(),getNumPage(),getAWhere(),getColSomme(),getOrdre(),c,npp);
	  	  
    setListe ((bean.ClassMAPTable[])rs.getResultat());
    //System.out.println(" nandalo preparerDataList ================= 2");
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
  /*public void preparerData() throws Exception
  {
    Connection c=null;
    try {
      c=new utilitaire.UtilDB().GetConn();
      preparerDataList(c);
      formu.getAllData(c);
    }
    catch (Exception ex) {
      throw (ex);
    }
    finally
    {
      if(c!=null)c.close();
    }
  }*/
  public void preparerDataMultiple() throws Exception
  {
    Connection c=null;
    try {
      c=new utilitaire.UtilDB().GetConn();
      preparerDataListMultiple(c);
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
    //System.out.println("AWHERE = "+aWhere);
    colInt=new String[colIntv.size()];
    colIntv.copyInto(colInt);
    valInt=new String[valIntv.size()];
    valIntv.copyInto(valInt);
    if(formu.getChamp("colonne").getValeur()!=null&&formu.getChamp("colonne").getValeur().compareToIgnoreCase("")!=0)
    {
      if(Utilitaire.estIlDedans(formu.getChamp("colonne").getValeur(),Utilitaire.concatener(getColGroupe(), getColSomme()))!=-1)
        setOrdre(" order by "+formu.getChamp("colonne").getValeur()+" "+formu.getChamp("ordre").getValeur());
    }
  }

  public void creerObjetPage() throws Exception
  {
    getValeurFormulaire(); //Recupération des valeurs choisi
    preparerData(); // Recuperation des données de la base
    makeTableauRecap();
    String[]enteteAuto = Utilitaire.ajouterTableauString(getColGroupe(),getSommeGroupe());
    setTableau(new TableauRecherche(getListe(),enteteAuto)); // Formation du tableau de résultat
  }
  public void creerObjetPageMultiple() throws Exception
  {
    getValeurFormulaireMultiple(); //Recupération des valeurs choisi
    preparerDataMultiple(); //preparerData(); // Recuperation des données de la base
    makeTableauRecap();
    String[]enteteAuto = Utilitaire.ajouterTableauString(getColGroupe(),getSommeGroupe());
    setTableau(new TableauRecherche(getListe(),enteteAuto)); // Formation du tableau de résultat
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
     ordre+=" order by "+formu.getChamp("colonne").getValeur()+" "+formu.getChamp("ordre").getValeur();
 }

  public void creerObjetPageMoyenne() throws Exception
  {
    getValeurFormulaire(); //Recupération des valeurs choisi
    preparerData(); // Recuperation des données de la base
    makeTableauRecap();
    String[]enteteAuto=Utilitaire.ajouterTableauString(getColGroupe(),getSommeGroupe(),getMoyenneGroupe());
    setTableau(new TableauRecherche(getListe(),enteteAuto)); // Formation du tableau de résultat
  }
  public void creerObjetPage(ClassMAPTable[] liste) throws Exception
  {
    setListe(liste);
    creerObjetPage();
  }
  public void creerObjetPage(String colGroupe[]) throws Exception
  {
    /*getValeurFormulaire();
    preparerData();
    makeTableauRecap();
    String[]enteteAuto=Utilitaire.ajouterTableauString(getColGroupe(),getSommeGroupe());
    setTableau(new TableauRecherche(getListe(),enteteAuto));*/
    creerObjetPage();
  }

  public PageRechercheGroupe(bean.ClassMAPTable o,HttpServletRequest req,String []vrt,String[] listInterval,int nbRange,String[]colGr,String[]sommGr,int nbCol,int somGr)throws Exception {
    setBase(o);
    //setTitre(titre);
    setCritere((bean.ClassMAPTable)(Class.forName(o.getClassName()).newInstance()));
    setReq(req);
    setPremier(getReq().getParameter("premier"));
    formu=new Formulaire();
    formu.setObjet(getBase());
    formu.makeChampFormu(vrt,listInterval, nbRange);
    setColGroupeDefaut(colGr);
    setSommeGroupeDefaut(sommGr);
    setNbColGroupe(nbCol);
    setNbSommeGrp(somGr);
    makeGroupe();
    formu.makeChampGroupe(getNbColGroupe(),getNbSommeGrp());
  }
  public PageRechercheGroupe(bean.ClassMAPTable o,HttpServletRequest req,String []vrt,String[] listInterval,int nbRange,String[]colGr,String[]sommGr,String[]moyenneGr,int nbCol,int somGr)throws Exception {
    setBase(o);
    //setTitre(titre);
    setCritere((bean.ClassMAPTable)(Class.forName(o.getClassName()).newInstance()));
    setReq(req);
    setPremier(getReq().getParameter("premier"));
    formu=new Formulaire();
    formu.setObjet(getBase());
    formu.makeChampFormu(vrt,listInterval, nbRange);
    setColGroupeDefaut(colGr);
    setSommeGroupeDefaut(sommGr);
    setNbColGroupe(nbCol);
    setNbSommeGrp(somGr);
    setMoyenneGroupe(moyenneGr);
    makeGroupe();
    formu.makeChampGroupe(getNbColGroupe(),getNbSommeGrp());
  }
  public void makeGroupe() throws Exception
  {
    String temp[]=new String[getNbColGroupe()];
    for(int i=0;i<temp.length;i++)
    {
      temp[i]=getReq().getParameter("colGroupe"+(i+1));
    }
    setColGroupe(Utilitaire.formerTableauGroupe(temp));
    String temp2[]=new String[getNbSommeGrp()];
    for(int i=0;i<temp2.length;i++)
    {
      temp2[i]=getReq().getParameter("colSomme"+(getNbColGroupe()+i+1));
    }
    setSommeGroupe(Utilitaire.formerTableauGroupe(temp2));
    //String st1[]={request.getParameter("colGroupe1"),request.getParameter("colGroupe2")};
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
    public String getBasPage() throws Exception
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
  /*public String getBasPage()
  {
    String retour="";
    retour+="<table border=0 cellpadding=0 cellspacing=0 align=center width='100%'>";
    retour+="<tr><td height=25><b>Nombre de r&eacute;sultat :</b> "+utilitaire.Utilitaire.formaterAr(String.valueOf(rs.getSommeEtNombre()[getNombreColonneSomme()]))+"</td><td align='right'><strong>page</strong> "+getNumPage()+" <b>sur</b>"+getNombrePage()+"</td>";
    retour+="</tr>";
    retour+="<tr>";
    retour+="<td width=50% valign='top' height=25>";
    String avantLien=getLien()+"?but=";
    String premierParam="";
    if(getLien()==null||getLien().compareToIgnoreCase("")==0)
    {
      avantLien="";
      premierParam="?1=2";
    }
    if(getNumPage()>1)
    {
      retour+="<a href="+avantLien+getApres()+premierParam+formu.getListeCritereString()+"&numPag="+String.valueOf(getNumPage()-1)+getApresLienPage()+">&lt;&lt;Page pr&eacute;c&eacute;dente</a>";
    }
    retour+="</td>";
    retour+="<td width=50% align=right>";
    if(getNumPage()<getNombrePage())
    {
      retour+="<a href="+avantLien+getApres()+premierParam+formu.getListeCritereString()+"&numPag="+String.valueOf(getNumPage()+1)+getApresLienPage()+">Page suivante&gt;&gt;</a>";
    }
    retour+="</td>";
    retour+="</tr>";
    retour+="</table>";
    return retour;
  }*/
  /*public String getBasPage()
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
  }*/
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
  public void setColGroupe(String[] colGroupe) {
    this.colGroupe = colGroupe;
  }
  public String[] getColGroupe() {
    if(colGroupe==null||colGroupe.length==0)
      return getColGroupeDefaut();
    return colGroupe;
  }
  public void setSommeGroupe(String[] sommeGroupe) {
    this.sommeGroupe = sommeGroupe;
    setColSomme(getSommeGroupe());
  }
  public String[] getSommeGroupe() {
    if(sommeGroupe==null||sommeGroupe.length==0)
      return sommeGroupeDefaut;
    return sommeGroupe;
  }
  public void setOrdre(String ordre) {
    this.ordre = ordre;
  }
  public String getOrdre() {
    return ordre;
  }
  public void setNbColGroupe(int nbColGroupe) {
    this.nbColGroupe = nbColGroupe;
  }
  public int getNbColGroupe() {
    return nbColGroupe;
  }
  public void setNbSommeGrp(int nbSommeGrp) {
    this.nbSommeGrp = nbSommeGrp;
  }
  public int getNbSommeGrp() {
    return nbSommeGrp;
  }
  public void setColGroupeDefaut(String[] colGroupeDefaut) {
    this.colGroupeDefaut = colGroupeDefaut;
  }
  public String[] getColGroupeDefaut() {
    return colGroupeDefaut;
  }
  public void setSommeGroupeDefaut(String[] sommeGroupeDefaut) {
    this.sommeGroupeDefaut = sommeGroupeDefaut;
    setColSomme(sommeGroupeDefaut);
  }
  public String[] getSommeGroupeDefaut() {
    return sommeGroupeDefaut;
  }
  public void setNpp(int npp) {
    this.npp = npp;
  }
  public int getNpp() {
    return npp;
  }
  public void setListeColonneMoyenne(String[] listeColonneMoyenne) {
    this.listeColonneMoyenne = listeColonneMoyenne;
  }
  public String[] getListeColonneMoyenne() {
    return listeColonneMoyenne;
  }
  public void setPremier(boolean premier) {
    this.premier = premier;
  }
  public boolean isPremier() {
    return premier;
  }
 public String getDownloadForm() throws Exception
  {
               String tab="";
               String[] somDefaut=this.getSommeGroupe();
               String[] colDefaut=this.getColGroupe();
               String sD="";if(somDefaut!=null) sD=somDefaut[0];
               String cD="";if(colDefaut!=null) cD=colDefaut[0];
               String awhere = " AND "+CGenUtil.makeWhereOr(getBase())+CGenUtil.makeWhereIntervalle(colInt, valInt)+this.getAWhere().replace('"','\'');
               try{

                       tab=this.getTableau().getHtml();

                       if(somDefaut!=null){
                         for(int i=1;i<somDefaut.length;i++) sD=sD+","+somDefaut[i];
                       }
                       if(colDefaut!=null){
                         for(int j=1;j<colDefaut.length;j++) cD=cD+","+colDefaut[j];
                       }
               }
               catch (Exception e)
               {
                       e.printStackTrace();
               }
               String temp="<p align=\"center\"> <strong> <u>EXPORTER</u> </strong> </p>  ";
       temp+="<div style=\"text-align:left; padding-left: 15px; border: thin solid #0099FF \" ><form action=\"downloadGroupe\" method=\"post\">";
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
       temp+="<input type=\"hidden\" name=\"awhere\" value=\""+awhere+"\" />";
       temp+="<input type=\"hidden\" name=\"table\" value=\""+tab.replace('"','*')+"\" />";
       temp+="<input type=\"hidden\" name=\"colDefaut\" value=\""+cD+"\" />";
       temp+="<input type=\"hidden\" name=\"somDefaut\" value=\""+sD+"\" />";
       temp+="<input type=\"hidden\" name=\"ordre\" value=\""+this.getOrdre()+"\" />";
              }
       temp+="<input type=\"submit\" value=\"Exporter\" class=\"submit\" /> </form> </div>";
       //System.out.println("*******");
      // System.out.println(temp);
       //System.out.println("*******");
       return temp;
  }
  public void setMoyenneGroupe(String[] moyenneGroupe) {
    this.moyenneGroupe = moyenneGroupe;
  }
  public String[] getMoyenneGroupe() {
    return moyenneGroupe;
  }
  
  public Object[] getAllDataNoPagination() throws Exception{
	Connection c=null;
    try {
      c=new utilitaire.UtilDB().GetConn();
      return getUtilisateur().getAllDataNoPagination(critere,getColGroupe(),getSommeGroupe(),getColInt(),getValInt(),-1,getAWhere(),getColSomme(),getOrdre(),c);
    }
    catch (Exception ex) {
      throw (ex);
    }
    finally
    {
      if(c!=null)c.close();
    }
  }
}