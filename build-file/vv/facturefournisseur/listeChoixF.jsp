<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="facturefournisseur.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
  String apres="facturefournisseur/listeChoixFF.jsp";
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
	
     /*te = u.findTypeObjet("TypeEntree","%","%");
     clt = u.findClient("%", "%", "%", "%", "%", "%", "%", "%", "%", "%", "%");
     mp = u.findTypeObjet("Beneficiaire","%","%");
     
     caiss = u.findCaisse("%","%","%","%");*/
     ut=u.getUser();     
%>
<%
try{
if (request.getParameter("idFacture")!=null){
%>
<%
}
if (request.getParameter("chx")!=null){
%>
<script language="JavaScript">
//alert ("envoyer  <%=request.getParameter("idFacture")%>");
window.opener.document.forms["<%=request.getParameter("targetForm")%>"].elements["<%=request.getParameter("targetInput")%>"].value = "<%=request.getParameter("idFacture")%>";
window.close();
</script>
<%
}

nomCol = utilitR.getNomColonne(new FactureFournisseur());
		  colonne=request.getParameter("colonne");if ((colonne==null)||colonne.compareTo("")==0) colonne="idFactureFournisseur";
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
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
//out.println(datyinf + datySup + client + idEtat + idCatServ + idSsCatServ + numFact);
%>
 
  <html>
  <link href="style.css" rel="stylesheet" type="text/css">
<body>

<h1>Lister choix facture</h1>
<p align="center" class="remarque">(choisir les crit&egrave;res de votre recherche
  concernant les factures)</p>

<form action="listeChoixFF.jsp" method="post" name="listeRecette" id="listeRecette">
 <input type="hidden" name="targetInput" value="<%=request.getParameter("targetInput")%>">
		    <input type="hidden" name="targetForm" value="<%=request.getParameter("targetForm")%>">
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
<br>
<br>
 <form  action="listeChoixFF.jsp" method="post" name="choix" id="choix">

  <table width="600" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td><div align="center">
          <input  type="submit" class="submit" value="Choisir" >
		  <input type="hidden" name="chx" value="chx">
		   <input type="hidden" name="targetInput" value="<%=request.getParameter("targetInput")%>">
		    <input type="hidden" name="targetForm" value="<%=request.getParameter("targetForm")%>">
		  
        </div></td>
    </tr>
 </table>   <br>
<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
  <!--DWLayoutTable-->
  <tr>
    <td align="center">

      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr class="head">
			<td width="80" height="19" align="center" valign="top">Id</td>
          <td width="66" align="center" valign="top">Date</td>
		   <td width="153" align="right" valign="top"><div align="center">Designation</div></td>
          <td width="153" align="right" valign="top"><div align="center">Fournisseur</div></td>
        </tr>
        <%
  for(int i=0;i<factF.length;i++){

%>
        <tr>
          <td align="center" width="24"><input type="radio" name="idFacture" value="<%=factF[i].getidFactureFournisseur()%>">
	
		  
		  </td>
          <td align="center"><%=utilitR.formatterDaty(factF[i].getdaty())%></td>
          <td align="right"><a href="<%=lien%>?but=facturefournisseur/detailFactureF.jsp&idFactureFournisseur=<%=factF[i].getidFactureFournisseur()%>"><%=factF[i].getdesignation()%></a></td>
		  <td align="center"><%=factF[i].getidFournisseur()%></td>
        </tr>
        <%
    }

  %>
      </table>
 </td>
</tr>
</table>

</form>
</body>
<br>
</html>
<script language="javascript">
function Update(){
alert("test="+document.forms["choix"].elements['id'].value);
//refsaisie=document.forms[0].elements["reference"].value;
alert(document.forms["choix"].elements['idFacture'].value);
	//window.opener.document.mainform.<?echo $_REQUEST[val]?>.value =  ;
	//window.close();
}
</script>
