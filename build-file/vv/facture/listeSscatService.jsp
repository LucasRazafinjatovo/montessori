<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
	String apres="facture/apresInit.jsp";
	String lien= null;
        UserEJB u = null;
        facture.SCatService scatserv[] = null;

%>
<%
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
scatserv = u.findSCatService("%","%","%","%");
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
%>
 
<link href="style.css" rel="stylesheet" type="text/css">
<h2>Liste des sous-cat&eacute;gorie existantes</h2>
<table width="500" border="1" align="center" cellpadding="0" cellspacing="0">
  <tr class="head">
    <td><div align="center">Nom ss-cat&eacute;gorie</div></td>
    <td><div align="center">Cat&eacute;gorie</div></td>
    <td><div align="center">P&eacute;riode de facturation</div></td>
  </tr>
   <%
	  for(int i=0;i<scatserv.length;i++){
	  %>


  <tr>
    <td><%=scatserv[i].getNomSCatService()%></td>
    <td><%=u.findTypeObjet("categorie",scatserv[i].getIdCategorie(),"%")[i].getVal()%></td>
    <td><%=scatserv[i].getPeriodeFacturation()%></td>
  </tr>
  <%
		}
		%>

</table>
