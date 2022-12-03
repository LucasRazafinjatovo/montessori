<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!

	String apres="facture/listeFacture.jsp";
	String lien= null;
	facture.FactMere fm[] = null;
	String datyinf = null;
 	String datySup = null;
  	String idFactureMere = null;
  	String idClient = null;
	String dateLimite = null;
	String idEtat = null;
	String idCatServ = null;
        String idSsCatServ = null;
        SCatService scatserv[] = null;
        UserEJB u = null;
        TypeObjet etat[] = null;
		TypeObjet cat[] = null;
                Client clt = null;
%>
<%
         datyinf = request.getParameter("datyInf");
         datySup = request.getParameter("datySup");
         idClient = request.getParameter("idClient");
         dateLimite = request.getParameter("dateLimite");
         idEtat = request.getParameter("idEtat");
         idCatServ = request.getParameter("idCatServ");
         idSsCatServ = request.getParameter("idSsCatServ");
%>
<%
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
fm = u.findFactureMere("","","%","%","","%","%","%");
etat = u.findTypeObjet("Etat","%","%");
cat = u.findTypeObjet("Categorie","%","%");
scatserv = u.findSCatService("%","%","%","%");
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
<link href="style.css" rel="stylesheet" type="text/css">
<h2>Liste historique &eacute;tat facture</h2>
<table cellpadding="3" cellspacing="0" border="0" align="center">
  <tr class="head">
		<td width="50">N° Fact</td>
    <td width="150" align="center" valign="middle">Etat</td>
	</tr>
	 <%
	  for(int i=0;i<fm.length;i++){
	  %>
	<tr>
    <td ><a href="#"><%=fm[i].getIdFactureMere()%></a></td>
    <td align="center" valign="middle"><%=u.findTypeObjet("Etat",fm[i].getIdEtat(),"%")[0].getVal()%></td>
	</tr>
	<%
		}
		%>
</table>