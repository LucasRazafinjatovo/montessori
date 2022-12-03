<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="penalite.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="facture/apresInit.jsp";
        String lien= null;
        penalite.DommageConteneur dc[]= null;
        UserEJB u = null;
	historique.MapUtilisateur ut=null;
        int pazy=0;
        int nbParPazy=Parametre.getNbParPage();
        String datyInfDomm = null;
        String datySupDomm = null;
%>
<%
datyInfDomm = request.getParameter("datyInfDomm");
datySupDomm = request.getParameter("datySupDomm");
%>
<%
if(datyInfDomm== null)datyInfDomm="";
if(datySupDomm== null)datySupDomm="";
%>
<%
pazy=Utilitaire.stringToInt(request.getParameter("pazy"));
%>
<%
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
//String idDommage, String datySaisie, String datyDommage, String designation, String montant, String idDossier, String nomProprietaire
dc = u.findDommageConteneur("%",datyInfDomm,datySupDomm,"%","%","%","%");
ut=u.getUser();
}
catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("erreur.jsp?message=<%=e.getMessage()%>"); </script>
<%
}
%>
<script language="javascript">
function decision(message, url){
if(confirm(message)) location.href = url;
}
</script>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Liste des dommages de conteneur</h1>
<form action="<%=lien%>?but=penalites/listeDommCont.jsp" method="post" name="dommage" id="vol">
  <table width="600" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td> <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
          <!--DWLayoutTable-->
          <tr>
            <td width="238" height="24" class="left"> Date d&eacute;but :<strong>
              </strong></td>
            <td valign="top" align="center" width="350"><strong>
              <input name="datyInfDomm" type="text" id="datyInfVol" value="<%=datyInfDomm%>">
              &nbsp;<a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a></strong></td>
            <td width="350" align="center" valign="top" class="left">Date fin
              :</td>
            <td valign="top" align="center" width="350"><strong>
              <input name="datySupDomm" type="text" id="datySupVol" value="<%=datySupDomm%>">
              &nbsp;<a href="javascript:cal2.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>
              </strong></td>
          </tr>
        </table></td>
    </tr>
    <tr>
      <td height="30" align="center"> <table width="75%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td align="center"> <input name="Submit" type="submit" class="submit" value="Afficher">
            </td>
            <td align="center"> <input name="Submit2" type="reset" class="submit" value="R&eacute;tablir">
            </td>
          </tr>
        </table></td>
    </tr>
  </table>
</form>
<script language="JavaScript">
var cal1 = new calendar1(document.forms['dommage'].elements['datyInfDomm']);
cal1.year_scroll = false;
cal1.time_comp = false;
var cal2 = new calendar1(document.forms['dommage'].elements['datySupDomm']);
cal2.year_scroll = false;
cal2.time_comp = false;
</script>
<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
<tr><td><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr class="head"> 
          <td width="73" align="center">N&deg; Domm.</td>
          <td width="73" height="25" align="center"><strong>Date</strong></td>
          <td width="76" height="25" align="center">D. du dom.</td>
          <td width="73" align="center">N° Doss.</td>
          <td align="center" width="100">Montant </td>
          <td width="138" align="center">D&eacute;clarant</td>
          <%
      if(ut.getIdrole().compareTo("admin")==0 || ut.getIdrole().compareTo("dg")==0 || ut.getIdrole().compareTo("adminFacture")==0)
		{
   %>
          <td align="center" width="51"><!--DWLayoutEmptyCell-->&nbsp;</td>
          <%
		  }
		  %>
        </tr>
        <%
int pejy=0;
if(pazy==0){
        pejy=0;
        pazy=1;
}else{
        pejy=pazy-1;
}
int pazy1=nbParPazy*pejy;
int pazy2=pazy*nbParPazy;
if(pazy2>dc.length){
  pazy2=dc.length;
}
%>
        <%
  for(int i=pazy1;i<pazy2;i++){
  %>
        <tr> 
          <td width="73" align="center"><a href="<%=lien%>?idDomm=<%=dc[i].getIdDommage()%>&but=penalites/detailDommCont.jsp"><%=dc[i].getIdDommage()%></a></td>
          <td width="73" height="25" align="center"><%=Utilitaire.formatterDaty(dc[i].getDatySaisie())%></td>
          <td width="76" height="25" align="center"><%=Utilitaire.formatterDaty(dc[i].getDatyDommage())%></td>
          <td width="73" align="center"><%=dc[i].getIdDossier()%></td>
          <td align="center" width="100"><%=(long)dc[i].getMontant()%></td>
          <td width="138" align="center"><%=dc[i].getNomProprietaire()%></td>
          <%
      if(ut.getIdrole().compareTo("admin")==0 || ut.getIdrole().compareTo("dg")==0 || ut.getIdrole().compareTo("adminFacture")==0)
		{
   %>
          <td align="center" width="51"><a href="javascript:decision('Vous voulez vraiment annuler cette dommage?\n\nCette opération supprimera définitivement ce dommage du système.','<%=lien%>?idDomm=<%=dc[i].getIdDommage()%>&but=penalites/apresDommCont.jsp&acte=DELETE')">Annuler</a></td>
          <%
	   }
	   %>
        </tr>
        <%
}
   %>
      </table></td></tr>
</table>

<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
<tr><td height="25"><b>Nombre de r&eacute;sultat :</b> <%=dc.length%></td><td align="right"><%if(dc.length!=0){%><strong>page</strong> <%=pazy%> <b>sur</b> <%if(dc.length%nbParPazy==0)out.println(dc.length/nbParPazy);else out.println(dc.length/nbParPazy+1);}%> </td></tr>
    <tr>
    <td width="295" valign="top" height="25">
<%if(pazy!=1){%>
        <a href="<%=lien%>?but=penalites/listeDommCont.jsp&pazy=<%=pazy-1%>&datyInfDomm=<%=datyInfDomm%>&datySupDomm=<%=datySupDomm%>">&lt;&lt;Page
      pr&eacute;c&eacute;dente</a>
<%

}
 pazy=pazy+1;
  %></td>
    <td width="305" align="right">
      <%
      if(dc.length>pazy2){
      %>
      <a href="<%=lien%>?but=penalites/listeDommCont.jsp&pazy=<%=pazy%>&datyInfDomm=<%=datyInfDomm%>&datySupDomm=<%=datySupDomm%>">Page
      suivante&gt;&gt;</a>
     <%
     }
       %></td>
  </tr>
</table>