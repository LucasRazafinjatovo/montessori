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
 %>
<%
pazy=Utilitaire.stringToInt(request.getParameter("pazy"));
  u=(UserEJB)session.getValue("u");
     lien=(String)session.getValue("lien");
     /*te = u.findTypeObjet("TypeEntree","%","%");
     clt = u.findClient("%", "%", "%", "%", "%", "%", "%", "%", "%", "%", "%");
     mp = u.findTypeObjet("Beneficiaire","%","%");
     dev = u.findTypeObjet("Devise","%","%");
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
			 // nomCol=Utilitaire.getNomColonne(new FactureFournisseur());

		//	entree = u.findEntreeLettre("%", dateDebut, dateFin, "%", "%","%", "%",numPiece, "%", caisse, "eta2","%","%",colonne,ordre,projet, partenaire, apresW);
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
   sommeEntree=AdminFF.getSommeEntree(factF,pazy1,pazy2);

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
            <td align="center"><input name="dateDebut" type="text" class="champ" id="dateDebut" value="<%=dateDebut%>" size="10" maxlength="10" />
              &nbsp; <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle" /></a>
            </td>
            <td class="left">Date fin:</td>
            <td align="center"><input name="dateFin" type="text" class="champ" id="dateFin" value="<%=dateFin%>" size="10" />
              &nbsp; <a href="javascript:cal2.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle" /></a>
            </td>
          </tr>
          <tr>
            <td class="left">Fournisseur :</td>
            <td align="center"><input name="fournisseur" type="text" class="champ" id="fournisseur" value="<%=fournisseur%>"size="10" maxlength="10" /> &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle" />
            </td>
            <td class="left">Projet</td>
            <td align="center"><input name="projet" type="text" class="champ" id="projet" value="<%=projet%>"size="10" maxlength="10" />
              &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle" />
            </td>
          </tr>
          <tr>
            <td class="left">Etat :</td>
            <td align="center"><input name="etat" type="text" class="champ" id="etat" value="<%=etat%>" />
              &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle" />
            </td>
            <td class="left">&nbsp;</td>
            <td align="center">&nbsp;</td>
          </tr>
        </table></td>
    </tr>
    <tr>
      <td height="30" align="center"><strong><font color="#FF0000" size="+1">TRIER
        PAR </font></strong></td>
    </tr>
    <tr>
      <td height="30" align="center"><table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
          <tr>
            <td class="left">Colonne :</td>
            <td align="center"> <select name="colonne" class="champ" id="select4">
                <%
   for(int i=0;i<nomCol.length;i++){
 %>
                <option value="<%=nomCol[i]%>"><%=nomCol[i]%></option>
                <%
   }
 %>
              </select> &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
            <td class="left"><div align="center">Ordre :</div></td>
            <td align="center"> <select name="ordre" class="champ" id="select5">
                <option value="ASC">ASC</option>
                <option value="DESC">DESC</option>
              </select> &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
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
    <td> <p align="center"><strong><u>RECAPITULATION RECHERCHE</u></strong></p>

      <table width="100%" border="0" cellpadding="0" cellspacing="0" class="monographe">
        <tr class="head">
          <td width="137"  height="25" align="center" bgcolor="#C300FF"><strong>Somme de la page</strong></td>
          <td width="150" align="right">&nbsp;</td>
          <td width="57" align="center"><div align="right"></div></td>
          <td width="162" align="center"><div align="right"></div></td>
          <td width="90" align="center"><strong> </strong></td>
        </tr>
        <%
    for(int k=0;k<dev.length;k++)
    {
    %>
        <tr class="head">
          <td width="123"  height="25" align="center" bgcolor="#C300FF"><div align="right"><strong><%=dev[k].getVal()%></strong></div></td>
          <td width="153" align="right">&nbsp;</td>
          <td width="69" align="center"><div align="right"></div></td>
          <td width="138" align="center"><div align="right"></div></td>
          <td width="113" align="center"><strong> </strong></td>
        </tr>
        <tr>
          <td  height="25" align="left"><div align="right">&nbsp;<strong>Total <%=dev[k].getVal()%> :</strong></div></td>
          <td align="right"><%=utilitR.formaterAr((double)AdminFF.getSommeEntreeByDevise(factF,dev[k].getId()))%><%=dev[k].getId()%></td>
          <td align="center"><div align="right"></div></td>
          <td align="center"><div align="right"></div></td>
          <td align="center"><strong> Nb</strong> :<%=AdminFF.getNombreEntreeByDevise(factF,dev[k].getId())%> </td>
        </tr>
        <%}%>
      </table>
      <br>







   <br>
      <p align="center"><strong><u>LISTE</u></strong></p>
      <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr class="head">
          <td width="80" height="19" align="center" valign="top">Id</td>
          <td width="66" align="center" valign="top">Date</td>
		   <td width="153" align="right" valign="top"><div align="center">Designation</div></td>
          <td width="153" align="right" valign="top"><div align="center">Fournisseur</div></td>
          <td width="153" align="right" valign="top"><div align="center"><strong>MontantTTC</strong></div></td>

          <td width="102" align="center" valign="top">Projet</td>
		            <td width="102" align="center" valign="top">Etat</td>
          <%
      if(ut.getIdrole().compareTo("admin")==0 || ut.getIdrole().compareTo("dg")==0)
                {
   %>
          <td width="54" valign="top"></td>
          <%
                }
   %>
        </tr>
        <%
  for(int i=pazy1;i<pazy2;i++){
  %>
        <tr>
          <td align="center"><%=factF[i].getidFactureFournisseur()%></td>
          <td align="center"><%=utilitR.formatterDaty(factF[i].getdaty())%></td>
          <td align="right"><a href="<%=lien%>?but=facturefournisseur/detailFactureF.jsp&idFF=<%=factF[i].getidFactureFournisseur()%>"><%=factF[i].getdesignation()%></a></td>
		  <td align="center"><%=utilitR.formatterDaty(factF[i].getidFournisseur())%></td>
          <td align="right"><%=utilitR.formaterAr((double)factF[i].getmontantTTC())%><%=" "+factF[i].getidDevise()%></td>
          <td align="center"><%=factF[i].getidProjet()%></td>
		  <td align="center"><%=factF[i].getetat()%></td>
          <%
      if(ut.getIdrole().compareTo("admin")==0 || ut.getIdrole().compareTo("dg")==0)
                {
   %>
          <td align="center"><a href="<%=lien%>?but=finance/apresEntree.jsp&acte=ANNULER&idEntree=<%=factF[i].getidFactureFournisseur()%>">Ann</a></td>
          <%
                }
          %>
        </tr>
        <%
    }
  %>
      </table></td>
</tr>
</table>
<br>

<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
<tr><td height="25"><b>Nombre de r&eacute;sultat :</b> <%=factF.length%></td><td align="right"><strong>page</strong> <%=pazy%> <b>sur</b><%=factF.length/nbParPazy+1%></td>
</tr>
    <tr>
    <td width="295" valign="top" height="25">
<%if(pazy!=1){%>
        <a href="<%=lien%>?but=facturefournisseur/listeFactureF.jsp&pazy=<%=pazy-1%>&numero=<%=Utilitaire.remplacePourcentage(numero)%>&fournisseur=<%=Utilitaire.remplacePourcentage(fournisseur)%>&dateDebut=<%=dateDebut%>&dateFin=<%=dateFin%>&projet=<%=Utilitaire.remplacePourcentage(projet)%>&etat=<%=Utilitaire.remplacePourcentage(etat)%>&colonne=<%=colonne%>&ordre=<%=ordre%>">&lt;&lt;Page
      pr&eacute;c&eacute;dente</a>
<%

}
 pazy=pazy+1;
  %></td>
    <td width="305" align="right">
      <%
      if(factF.length>pazy2){
      %>
      <a href="<%=lien%>?but=finance/listeEntree.jsp&pazy=<%=pazy%>&client=<%=Utilitaire.remplacePourcentage(client)%>&idType=<%=Utilitaire.remplacePourcentage(idType)%>&caisse=<%=Utilitaire.remplacePourcentage(caisse)%>&numPiece=<%=Utilitaire.remplacePourcentage(numPiece)%>&numero=<%=Utilitaire.remplacePourcentage(numero)%>&idModePaiement=<%=Utilitaire.remplacePourcentage(idModePaiement)%>&dateDebut=<%=dateDebut%>&dateFin=<%=dateFin%>&parution=<%=Utilitaire.remplacePourcentage(parution)%>&agence=<%=Utilitaire.remplacePourcentage(agence)%>&colonne=<%=colonne%>&ordre=<%=ordre%>">Page
      suivante&gt;&gt;</a>
     <%
     }
       %></td>
  </tr>
</table>

<script language="javascript">
  var cal1 = new calendar1(document.forms['listeRecette'].elements['dateDebut']);
  cal1.year_scroll = false;
  cal1.time_comp = false;
  var cal2 = new calendar1(document.forms['listeRecette'].elements['dateFin']);
  cal2.year_scroll = false;
  cal2.time_comp = false;
</script>
