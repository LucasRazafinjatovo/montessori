<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="facture.*" %>
<%@ page import="historique.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
  String lien = null;
  String apres = "facture/listeClient.jsp";
  Client clt[] = null;
  UserEJB u = null;
  String nomClient = null;
  String role = null;
  historique.MapUtilisateur ut=null;

%>
<%
nomClient = request.getParameter("nomClient");
%>
<%
if(nomClient == null){
	nomClient ="%";
}
%>
<%
try{
	u=(UserEJB)session.getValue("u");
	lien=(String)session.getValue("lien");
        ut=u.getUser();
	apres = "facture/listeClient.jsp";
	clt = u.findClient("%", nomClient, "%", "%", "%", "%", "%", "%", "%", "%", "%");
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
<script language="javascript">
function decision(message, url){
if(confirm(message)) location.href = url;
}
</script>
<link href="style.css" rel="stylesheet" type="text/css">
 
<h1>Liste des clients enregistr&eacute;s</h1>
<form action="<%=lien%>?but=<%=apres%>" method="post">
<table width="600" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
          <!--DWLayoutTable-->
          <tr>
    <td width="238" height="24" class="left"> Nom :<strong>
        <input name="nomClient" type="text" id="nomClient" value="<%=nomClient%>">
      </strong></td>
    <td valign="top" align="center" width="350"><input name="Submit" type="submit" class="submit" value="Afficher">
              <span class="remarque">(Entrer le nom du client &agrave; rechercher)</span></td>
  </tr>


</table>
</td>
  </tr>
</table>
</form>

<table width="600" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td> <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <tr class="head">
          <td width="44" valign="middle"> R&eacute;f.</td>
          <td width="129" align="left" valign="middle"><strong>Nom</strong></td>
          <td width="145" align="left" valign="middle">Adresse</td>
          <td width="155" height="19" align="left" valign="middle">T&eacute;l&eacute;phone</td>
          <%
      if(ut.getIdrole().compareTo("admin")==0 || ut.getIdrole().compareTo("dg")==0 || ut.getIdrole().compareTo("adminFacture")==0)
		{
   %>
          <td valign="top" align="center"><strong>Action</strong></td>
          <%
	}
	%>
        </tr>
        <%
  for(int i=0;i<clt.length;i++){
  %>
        <tr>
          <td>&nbsp;<a href="<%=lien%>?idClient=<%=clt[i].getIdClient()%>&but=facture/detailClient.jsp"><%=clt[i].getIdClient()%></a></td>
          <td align="left"><%=clt[i].getNom()%></td>
          <td align="left"><%=clt[i].getAdresse()%></td>
          <td align="left"><%=clt[i].getTelephone()%></td>
          <%
     if(ut.getIdrole().compareTo("admin")==0 || ut.getIdrole().compareTo("dg")==0 || ut.getIdrole().compareTo("adminFacture")==0)
		{
   %>
          <td> <div align="center"><a href="<%=lien%>?idClient=<%=clt[i].getIdClient()%>&but=facture/updateClient.jsp">Mod.</a></div>

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
