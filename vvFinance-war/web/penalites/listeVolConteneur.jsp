<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="penalite.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
	String apres="facture/apresInit.jsp";
	String lien= null;
        penalite.VolConteneur volcont[]= null;
        UserEJB u = null;
	historique.MapUtilisateur ut=null;
	String datyInfVol = null;
	String datySupVol = null;
        int pazy=0;
        int nbParPazy=Parametre.getNbParPage();
%>
<%
datyInfVol = request.getParameter("datyInfVol");
datySupVol = request.getParameter("datySupVol");
pazy=Utilitaire.stringToInt(request.getParameter("pazy"));
if(datyInfVol== null)datyInfVol="";
if(datySupVol== null)datySupVol="";
%>
<%
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
try{
//String idVol, String datySaisie, String datyVol, String numCont, String designation, String idDossier, String proprietaire, String montant
volcont = u.findVolCont("%",datyInfVol,datySupVol,"%","%","%","%","%");
  ut=u.getUser();

}catch (Exception e){
                        %>
                                      <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
                        <%
                          return;
}

	                %>
<script language="javascript">
function decision(message, url){
if(confirm(message)) location.href = url;
}
</script>

<link href="style.css" rel="stylesheet" type="text/css">
<h1>Liste des vols de conteneurs </h1>
<form action="<%=lien%>?but=penalites/listeVolConteneur.jsp" method="post" name="vol" id="vol">
  <table width="600" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td> <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
          <!--DWLayoutTable-->
          <tr>
            <td width="238" height="24" class="left"> Date d&eacute;but :<strong>
              </strong></td>
            <td valign="top" align="center" width="350"><strong>
              <input name="datyInfVol" type="text" id="datyInfVol" value="<%=datyInfVol%>">&nbsp;<a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a></strong></td>
            <td width="350" align="center" valign="top" class="left">Date fin
              :</td>
            <td valign="top" align="center" width="350"><strong>
              <input name="datySupVol" type="text" id="datySupVol" value="<%=datySupVol%>">&nbsp;<a href="javascript:cal2.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>
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
<h1>
  <script language="JavaScript">
var cal1 = new calendar1(document.forms['vol'].elements['datyInfVol']);
cal1.year_scroll = false;
cal1.time_comp = false;
var cal2 = new calendar1(document.forms['vol'].elements['datySupVol']);
cal2.year_scroll = false;
cal2.time_comp = false;
</script>
</h1>
<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
<tr><td><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr class="head"> 
          <td width="88" align="center">N&deg; Vol</td>
          <td width="88" height="25" align="center"><strong>Date</strong></td>
          <td width="93" align="center">Date du vol</td>
          <td width="103" align="center">N° Cont.</td>
          <td align="center" width="161">D&eacute;clarant</td>
          <%
      if(ut.getIdrole().compareTo("admin")==0 || ut.getIdrole().compareTo("dg")==0 || ut.getIdrole().compareTo("adminFacture")==0)
		{
   %>
          <td width="53" align="center"><!--DWLayoutEmptyCell-->&nbsp;</td>
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
if(pazy2>volcont.length){
  pazy2=volcont.length;
}
%>
        <%
  for(int i=pazy1;i<pazy2;i++){
  %>
        <tr> 
          <td width="88" align="center"><a href="<%=lien%>?but=penalites/detailVolConteneur.jsp&idVol=<%=volcont[i].getIdVol()%>"><%=volcont[i].getIdVol()%></a></td>
          <td width="88" height="25" align="center"><%=Utilitaire.formatterDaty(volcont[i].getDatySaisie())%></td>
          <td width="93" align="center"><%=Utilitaire.formatterDaty(volcont[i].getDatyVol())%></td>
          <td width="103" align="center"><%=volcont[i].getNumeroConteneur()%></td>
          <td align="center" width="161"><%=volcont[i].getNomProprietaire()%></td>
          <%
      if(ut.getIdrole().compareTo("admin")==0 || ut.getIdrole().compareTo("dg")==0 || ut.getIdrole().compareTo("adminFacture")==0)
		{
   %>
          <td align="center"><a href="javascript:decision('Vous voulez vraiment annuler ce vol?\n\nCette opération supprimera définitivement ce vol du système.','<%=lien%>?but=penalites/apresVolConteneur.jsp&idVol=<%=volcont[i].getIdVol()%>&acte=DELETE')">Annuler</a></td>
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
<tr><td height="25"><b>Nombre de r&eacute;sultat :</b> <%=volcont.length%></td><td align="right"><strong><%if(volcont.length!=0){%>page</strong> <%=pazy%> <b>sur</b> <%if(volcont.length%nbParPazy==0)out.println(volcont.length/nbParPazy);else out.println(volcont.length/nbParPazy+1);}%> </td></tr>
    <tr>
    <td width="295" valign="top" height="25">
<%if(pazy!=1){%>
        <a href="<%=lien%>?but=penalites/listeVolConteneur.jsp&pazy=<%=pazy-1%>&datyInfVol=<%=datyInfVol%>&datySupVol=<%=datySupVol%>">&lt;&lt;Page
      pr&eacute;c&eacute;dente</a>
<%

}
 pazy=pazy+1;
  %></td>
    <td width="305" align="right">
      <%
      if(volcont.length>pazy2){
      %>
      <a href="<%=lien%>?but=penalites/listeVolConteneur.jsp&pazy=<%=pazy%>&datyInfVol=<%=datyInfVol%>&datySupVol=<%=datySupVol%>">Page
      suivante&gt;&gt;</a>
     <%
     }
       %></td>
  </tr>
</table>