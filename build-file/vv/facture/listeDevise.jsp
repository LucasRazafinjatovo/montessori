<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
	String apres="facture/apresInit.jsp";
	String lien= null;
	TypeObjet dev[] = null;
    UserEJB u = null;
	historique.MapUtilisateur ut=null;
%>
<%
try{
  u=(user.UserEJB)session.getValue("u");
  ut=u.getUser();
lien=(String)session.getValue("lien");
dev =u.findTypeObjet("Devise","%","%");
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
<h1>Liste des devises d&eacute;j&agrave; enregistr&eacute;es</h1>
<table width="600" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td>
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr class="head">
   <td width="77">&nbsp;N° Devise</td>
    <td width="121" height="25" align="center" valign="middle">Devise</td>


    <td width="234" height="25" align="center" valign="middle">Decription</td>
<%
      if((ut.getIdrole().compareTo("admin"))==0 || ut.getIdrole().compareTo("dg")==0 || ut.getIdrole().compareTo("adminFacture")==0)
		{
   %>
          <td width="164"  bgcolor="#ffffff" class="left">&nbsp;</td>
<%
}
%>
  </tr>

<%
for(int i=0;i<dev.length;i++){

%>
  <tr>
  <td>&nbsp;<%=dev[i].getId()%></td>
    <td width="121" height="25" align="center" valign="middle"><%=dev[i].getVal()%></td>

           <td width="234" height="25" align="center" valign="middle"><%=dev[i].getDesce()%></td>
<%
      if(ut.getIdrole().compareTo("admin")==0 || ut.getIdrole().compareTo("dg")==0 || ut.getIdrole().compareTo("adminFacture")==0)
		{
   %>
    <td width="164"  bgcolor="#ffffff" align="center">
<a href="<%=lien%>?but=facture/updateDevise.jsp&idDevise=<%=dev[i].getId()%>">Mod.</a>&nbsp;&nbsp;|&nbsp;&nbsp;
<a href="javascript:decision('Vous voulez vraiment annuler cette devise?\n\nCette opération supprimera définitivement la devise du système.','<%=lien%>?but=facture/apresDevise.jsp&idDevise=<%=dev[i].getId()%>&acte=DELETE')">
Annuler</a>
</td>
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

