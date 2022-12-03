<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="pcg.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="facture/apresAnnulerFacture.jsp";
        String lien= null;
        UserEJB u = null;
        Pcg pcg[] = null;
		String etatpcge=null;
		historique.MapUtilisateur ut=null;

%>
<%
try{
u=(UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
pcg = u.findCompteTab("%", "%", "%", "%");
 ut=u.getUser();
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Liste des comptes enregistr&eacute;es</h1>
<table width="600" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td>
	<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr class="head">
          <td width="81" height="19" valign="top"><strong>Compte</strong></td>
          <td width="268" valign="top"><strong>Libell&eacute; du compte</strong></td>
	
          <td width="392" align="center" valign="top"><strong>Actions</strong></td>
	
  </tr>
  <%
	  for(int i=0;i<pcg.length;i++){
	  %>
  <tr>
    <td height="24"><%=pcg[i].getCOMPTE()%> </td>
    <td><%=pcg[i].getLIBELLE()%> </td>
	 <%
      if(ut.getIdrole().compareTo("admin")==0 || ut.getIdrole().compareTo("dg")==0 || ut.getIdrole().compareTo("compta")==0)
		{
   %>
          <td valign="top"> 
           <a href="<%=lien%>?but=pcg/entreeCompte.jsp&idCompte=<%=pcg[i].getIDCOMPTE()%>&compte=<%=pcg[i].getCOMPTE()%>&libelle=<%=pcg[i].getLIBELLE()%>&pcompte=<%=pcg[i].getPCOMPTE()%>&acte=UPDATE">Mod</a>&nbsp;&nbsp;<a href="<%=lien%>?but=pcg/entreeCompte.jsp&idCompte=<%=pcg[i].getCOMPTE()%>&idPCompte=<%=pcg[i].getPCOMPTE()%>&acte=DELETE">Suppr</a> &nbsp;&nbsp; <a href="<%=lien%>?but=pcg/entreeCompte.jsp&pcompte=<%=pcg[i].getCOMPTE()%>&acte=ADDSSC">Ajouter sous compte</a>
          </td>
	<%
	}
	%>
    </tr>
  <%
		}
	%>
</table>
</td>
  </tr>
</table>

