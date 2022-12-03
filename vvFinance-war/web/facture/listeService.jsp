<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
	String apres="facture/apresInit.jsp";
	String lien= null;
	Service svc[] = null;
        UserEJB u = null;
        facture.SCatService sCatServ = null;

%>
<%
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
//String idService, String idSCatService, String daty1, String daty2, String unite, String des, String devise, String idClient
svc = u.findService("%", "%", "", "", "%", "%", "%", "%");
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
 
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Liste des services </h1>
<table width="600" border="0" align="center" cellpadding="0" cellspacing="0" class="head">
<tr><td>
<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
  <tr class="head">
    <td width="138" height="21"> Designation</td>
          <td width="99">Sous-Cat&eacute;gorie</td>
    <td width="74"><div align="center">Date d&eacute;but</div></td>
    <td width="41">unit&eacute;</td>
    <td width="39"><div align="center">pu</div></td>
    <td width="61"><div align="center">devise</div></td>
    <td width="32"><div align="center">tva</div></td>
    <td width="31"><div align="center"></div></td>
  </tr>
  <%
  for(int i=0;i<svc.length;i++){
 %>
  <tr>
    <td><%=svc[i].getDesignation()%></td>
    <td><%=u.findSCatService(svc[i].getIdSCatService(),"%","%","%")[0].getNomSCatService()%></td>
    <td><div align="center"><%=Utilitaire.formatterDaty(svc[i].getDatyDebutValid())%></div></td>
    <td><div align="center"><%=u.findTypeObjet("unite",svc[i].getIdUnite(),"%")[0].getVal()%></div></td>
    <td><div align="center"><%=svc[i].getPrixUnitaire()%></div></td>
    <td><div align="center"><%=u.findTypeObjet("devise",svc[i].getIdDevise(),"%")[0].getVal()%></div></td>
    <td><div align="center"><%=svc[i].getIdTva()  %></div></td>
    <td><div align="center"><a href="<%=lien%>?but=facture/updateService.jsp&idService=<%=svc[i].getIdService()%>">Mod.</a></div></td>
  </tr>
  <%
  }
  %>
</table>
</td>
</tr>
</table>
