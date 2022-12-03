<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="facturefournisseur.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
  String apres="facturefournisseur/listeFactureF.jsp";
  String lien= null;
  UserEJB u = null;
  TypeObjet dev[] = null;
  Caisse caiss[] = null;
 Utilitaire utilitR=new Utilitaire();
  FactureFournisseur factF[] = null;
FactureFournisseur factFPage[] = null;
  String numPiece=null;
  String numero=null;
  String agence=null;
  String parution=null;
  historique.MapUtilisateur ut=null;
   String client, idType, caisse, idModePaiement, dateDebut, dateFin, projet, partenaire,etat,fournisseur;
  String colonne,ordre;
  String devise=null;
  int pazy=0;
  int nbParPazy=10;
  int pazy1=0;
  int pazy2=0;
  String nomCol[]=null;
  double sommeEntree=0;
  String apresW=null;
  Entree e= new Entree();
 %>
<%
pazy=Utilitaire.stringToInt(request.getParameter("pazy"));
  u=(UserEJB)session.getValue("u");
     lien=(String)session.getValue("lien");
	 dev = u.findTypeObjet("Devise","%","%");
	 out.println("Entree "+e.getWord());
     /*te = u.findTypeObjet("TypeEntree","%","%");
     clt = u.findClient("%", "%", "%", "%", "%", "%", "%", "%", "%", "%", "%");
     mp = u.findTypeObjet("Beneficiaire","%","%");

     caiss = u.findCaisse("%","%","%","%");*/
     ut=u.getUser();
%>
<%
  try{
			nomCol = utilitR.getNomColonne(new FactureFournisseur());
		  colonne=request.getParameter("colonne");if ((colonne==null)||colonne.compareTo("")==0) colonne="%";
		  ordre=request.getParameter("ordre");if ((ordre==null)||ordre.compareTo("")==0) ordre="DESC";
		  dateDebut=request.getParameter("dateDebut");if ((dateDebut==null)||dateDebut.compareTo("")==0) dateDebut="";
		  dateFin=request.getParameter("dateFin");if ((dateFin==null)||dateFin.compareTo("")==0) dateFin="";

			projet=request.getParameter("projet");if ((projet==null)||projet.compareTo("")==0) projet="%";
			etat=request.getParameter("etat");if ((etat==null)||etat.compareTo("")==0) etat="%";
			fournisseur=request.getParameter("fournisseur");if ((fournisseur==null)||fournisseur.compareTo("")==0) fournisseur="%";
			 apresW=request.getParameter("apresW");if ((apresW==null)||apresW.compareTo("")==0) apresW="";
			 // nomCol=Utilitaire.getNomColonne(new FactureFournisseur());

		//	entree = u.findEntreeLettre("%", dateDebut, dateFin, "%", "%","%", "%",numPiece, "%", caisse, "eta2","%","%",colonne,ordre,projet, partenaire, apresW);

		//factF = u.findFactureF("%", "", "", "%", "%","%", "idFactureFournisseur", "ASC", "");
			factF = u.findFactureF("%",  dateDebut,  dateFin, fournisseur, projet,  etat, colonne, ordre, apresW);

	  int pejy=0;
	  if(pazy==0){
			pejy=0;
			pazy=1;
	  }else{
			pejy=pazy-1;
	  }
	  factFPage=new FactureFournisseur[nbParPazy];
	  pazy1=nbParPazy*pejy;
	  pazy2=pazy*nbParPazy;
	  if(pazy2>factF.length){
		pazy2=factF.length;
	  }
	 for(int i=pazy1;i<pazy2;i++){
		 for(int j=0;j<nbParPazy-1;j++){
		   factFPage[j]=factF[i];
		 }
	  }
  // sommeEntree=AdminFF.getSommeEntree(factF,pazy1,pazy2);

}
catch (Exception e){
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
  return;
}
%>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Lister les factures fournisseurs</h1>
<p align="center" class="remarque">(choisir les crit&egrave;res de votre recherche
  concernant les recettes)</p>
<form action="<%=lien%>?but=<%=apres%>" method="post" name="listeRecette" id="listeRecette">
  <table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
    <tr>
      <td><table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
          <tr>
            <td class="left">Date début :</td>
            <td align="center"><input name="dateDebut" type="text"   id="dateDebut" value="<%=dateDebut%>" size="10" maxlength="10" />
              &nbsp; <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle" /></a>
            </td>
            <td class="left">Date fin:</td>
            <td align="center"><input name="dateFin" type="text"   id="dateFin" value="<%=dateFin%>" size="10" />
              &nbsp; <a href="javascript:cal2.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle" /></a>
            </td>
          </tr>
          <tr>
            <td class="left">Fournisseur :</td>
            <td align="center"><input name="fournisseur" type="text"   id="fournisseur" value="<%=fournisseur%>"size="10" maxlength="10" /> &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle" />
            </td>
            <td class="left">Projet</td>
            <td align="center"><input name="projet" type="text"   id="projet" value="<%=projet%>"size="10" maxlength="10" />
              &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle" />
            </td>
          </tr>
          <tr>
            <td class="left">Etat :</td>
            <td align="center"><input name="etat" type="text"   id="etat" value="<%=etat%>" />
              &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle" />
            </td>
            <td class="left">&nbsp;</td>
            <td align="center">&nbsp;</td>
          </tr>
        </table></td>
    </tr>
  
    <tr>
      <td height="30" align="center"> <table width="75%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td align="center"> <input type="submit" name="Submit" value="Afficher" class="submit">            </td>
            <td align="center"> <input type="reset" name="annuler" value="R&eacute;tablir" class="submit">            </td>
          </tr>
        </table></td>
    </tr>
  </table>


</form>


<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
  <tr>
    <td>
      <br>
      <p align="center"><strong><u>LISTE</u></strong></p>
      <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr class="head">

          <td align="center" valign="top">Date</td>
		   <td align="right" valign="top"><div align="center">Designation</div></td>
          <td align="right" valign="top"><div align="center">Fournisseur</div></td>
          <td align="right" valign="top"><div align="center"><strong>Montant TTC</strong></div></td>

          <td align="center" valign="top">Montant payé</td>
		            <td align="center" valign="top">Etat</td>

        </tr>
     
        <tr onmouseover="this.style.backgroundColor='#EAEAEA'" onmouseout="this.style.backgroundColor=''">

          <td align="center"></td>
          <td align="right"></td>
		  <td align="center"></td>
          <td align="right"></td>
          <td align="center"></td>
		  <td align="center"></td>

    

      </table></td>
</tr>
</table>
<br>



<script language="javascript">
  var cal1 = new calendar1(document.forms['listeRecette'].elements['dateDebut']);
  cal1.year_scroll = false;
  cal1.time_comp = false;
  var cal2 = new calendar1(document.forms['listeRecette'].elements['dateFin']);
  cal2.year_scroll = false;
  cal2.time_comp = false;
</script>
