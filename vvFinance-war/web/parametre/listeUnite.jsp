<%@page import="user.*" %>
<%@page import="bean.*" %>
<%@page import="utilitaire.*" %>
<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="facture/factureFille.jsp";
        String lien= null;
        UserEJB u = null;
        bean.TypeObjet unite[] = null;
		historique.MapUtilisateur ut=null;

      %>
<%
try{
u=(UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
unite = u.findTypeObjet("unite","%","%");
 ut=u.getUser();
}catch(Exception e){
%>
                <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
        <%
}
%>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Liste des unit&eacute;s</h1>
<table border="0" cellpadding="0" cellspacing="0" align="center" width="450">
	<tr><td>
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr class="head">

    <td height="25" align="center" valign="middle">Unite</td>
	<td height="25" align="center" valign="middle">Description</td>

   <%
      if((ut.getIdrole().compareTo("admin"))==0 || ut.getIdrole().compareTo("dg")==0 || ut.getIdrole().compareTo("adminFacture")==0)
                {
   %>
          <td width="76"  bgcolor="#ffffff" class="left">&nbsp;</td>
<%
}
%>

  </tr>


  <%
          for(int i=0;i<u.findTypeObjet("unite","%","%").length;i++){
          %>
 <tr>

    <td height="25" align="center" valign="middle">
  <%=u.findTypeObjet("unite","%","%")[i].getVal()%></td>
<td align="center" valign="middle"> <%=u.findTypeObjet("unite","%","%")[i].getDesce()%></td>
    <%
      if((ut.getIdrole().compareTo("admin"))==0 || ut.getIdrole().compareTo("dg")==0 || ut.getIdrole().compareTo("adminFacture")==0)
                {
   %>
          <td width="76"  bgcolor="#ffffff"><a href="<%=lien%>?but=parametre/updateUnite.jsp&idUnite=<%=u.findTypeObjet("unite","%","%")[i].getId()%>">Mod</a></td>
<%
}
%>

  </tr>

   <%
     }
		%>


   <tr>
  <td colspan="6" height="1" bgcolor="#999999"></td>
  </tr>
</table></td></tr>
</table>
