<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="penalite.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
	String apres="facture/apresInit.jsp";
	String lien= null;
        penalite.Accident penAcc[] = null;
        UserEJB u = null;
	historique.MapUtilisateur ut=null;
	String nomEmp=null;
	String datyInfAcc = null;
        String datySupAcc = null;
        int pazy=0;
        int nbParPazy=Parametre.getNbParPage();
%>
<%
nomEmp = request.getParameter("nomEmp");
datyInfAcc = request.getParameter("datyInfAcc");
datySupAcc = request.getParameter("datySupAcc");
pazy=Utilitaire.stringToInt(request.getParameter("pazy"));
%>
<%
if(datyInfAcc== null)datyInfAcc="";
if(datySupAcc== null)datySupAcc="";
if(nomEmp == null) nomEmp ="%";
%>
<%
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
//String idAccident, String datySaisie, String datyAccident, String description, String nomEmploye
 //= u.findAccident("%","",dateAcc,"%",nomEmp);
//String idAccident, String datySaisie, String datyAccInf, String datyAccSup, String description, String nomEmploye
penAcc=u.findAccident("%",datyInfAcc,datySupAcc,"%",nomEmp);
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
<h1>Lister les accidents </h1>
<form action="<%=lien%>?but=penalites/listeAccident.jsp" method="post" name="accident" id="accident">
  <table width="600" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td> <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
          <!--DWLayoutTable-->
          <tr>

            <td width="238" height="24" class="left"> Date d&eacute;but :<strong>
              </strong></td>
            <td valign="top" align="center" width="350"><strong>
              <input name="datyInfAcc" type="text" id="datyInfAcc" value="<%=datyInfAcc%>">
              &nbsp;<a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a></strong></td>
            <td width="350" align="center" valign="top" class="left">Date fin
              :</td>
            <td valign="top" align="center" width="350"><strong>
              <input name="datySupAcc" type="text" id="datySupAcc" value="<%=datySupAcc%>">
              &nbsp; <a href="javascript:cal2.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>
              </strong></td>
          </tr>
        </table></td>
  </tr>
  <tr>
    <td height="30" align="center">
      <table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
          <td align="center">
            <input name="Submit" type="submit" class="submit" value="Afficher">
          </td>
          <td align="center">
<input name="Submit2" type="reset" class="submit" value="R&eacute;tablir">
          </td>
  </tr>
</table>
    </td>
  </tr>
</table>
</form>
<table cellpadding="0" cellspacing="0" border="0" width="600" align="center">
<tr>
    <td> <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr class="head"> 
          <td width="87"><div align="center">N° Accident</div></td>
          <td width="74" height="25" align="center" valign="middle">Date enr.</td>
          <td width="181" align="center" valign="middle">Employ&eacute; accident&eacute;</td>
          <td width="110" align="center" valign="middle">Date acc.</td>
          <%
      if(ut.getIdrole().compareTo("admin")==0 || ut.getIdrole().compareTo("dg")==0 || ut.getIdrole().compareTo("adminFacture")==0)
		{
   %>
          <td width="41" align="center" valign="middle"></td>
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
if(pazy2>penAcc.length){
  pazy2=penAcc.length;
}
%>
        <%
  for(int i=pazy1;i<pazy2;i++){
  %>
        <tr> 
          <td><div align="center"><a href="<%=lien%>?id=<%=penAcc[i].getIdAccident()%>&but=penalites/detailAccident.jsp"><%=penAcc[i].getIdAccident()%></a></div></td>
          <td width="74" height="25" align="center" valign="middle"><%=Utilitaire.formatterDaty(penAcc[i].getDatySaisie())%></td>
          <td width="181" align="center" valign="middle"><%=penAcc[i].getNomEmploye()%></td>
          <td width="110" align="center" valign="middle"><%=Utilitaire.formatterDaty(penAcc[i].getDatyAccident())%></td>
          <%
      if(ut.getIdrole().compareTo("admin")==0 || ut.getIdrole().compareTo("dg")==0 || ut.getIdrole().compareTo("adminFacture")==0)
		{
   %>
          <td width="41" align="center" valign="middle"><a href="javascript:decision('Vous voulez vraiment annuler cette accident?\n\nCette opération supprimera définitivement l\'accident du système.','<%=lien%>?idAccident=<%=penAcc[i].getIdAccident()%>&but=penalites/apresAccident.jsp&acte=DELETE')">Annuler</a></td>
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
<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
<tr>
<td height="25"><b>Nombre de r&eacute;sultat :</b> <%=penAcc.length%></td><td align="right"><%if(penAcc.length!=0){%><strong>page</strong> <%=pazy%> <b>sur</b> <%if(penAcc.length%nbParPazy==0)out.println(penAcc.length/nbParPazy);else out.println(penAcc.length/nbParPazy+1);}%></td></tr>
    <tr>
    <td width="295" valign="top" height="25">
<%if(pazy!=1){%>
        <a href="<%=lien%>?but=penalites/listeAccident.jsp&pazy=<%=pazy-1%>&datyInfAcc=<%=datyInfAcc%>&datySupAcc=<%=datySupAcc%>">&lt;&lt;Page
      pr&eacute;c&eacute;dente</a>
<%

}
 pazy=pazy+1;
  %>
  </td>
    <td width="305" align="right">
      <%
      if(penAcc.length>pazy2){
      %>
      <a href="<%=lien%>?but=penalites/listeAccident.jsp&pazy=<%=pazy%>&datyInfAcc=<%=datyInfAcc%>&datySupAcc=<%=datySupAcc%>">Page
      suivante&gt;&gt;</a>
     <%
     }
       %></td>
  </tr>
</table>
<script language="JavaScript">
var cal1 = new calendar1(document.forms['accident'].elements['datyInfAcc']);
cal1.year_scroll = false;
cal1.time_comp = false;
var cal2 = new calendar1(document.forms['accident'].elements['datySupAcc']);
cal2.year_scroll = false;
cal2.time_comp = false;
</script>
