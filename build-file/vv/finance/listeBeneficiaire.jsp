<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="facture/apresAnnulerFacture.jsp";
        String lien= null;
        UserEJB u = null;
        TypeObjet to[] = null;
historique.MapUtilisateur ut=null;
%>
<%
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
to = u.findTypeObjet("Beneficiaire","%","%");
 ut=u.getUser();
%>
<script language="javascript">
function decision(message, url){
if(confirm(message)) location.href = url;
}
</script>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Liste des b&eacute;n&eacute;ficiaires</h1>
<table border="0" cellpadding="0" cellspacing="0" align="center" width="450">
<tr><td>
<table border="0" cellpadding="3" cellspacing="0" align="center" width="100%" class="monographe">
  <!--DWLayoutTable-->
  <tr class="head">
    <td width="163" height="19" valign="top"><strong>B&eacute;n&eacute;ficiaire</strong></td>
	      <td width="160">Description </td>
 <%
      if(ut.getIdrole().compareTo("admin")==0 || ut.getIdrole().compareTo("dg")==0)
                {
   %>
    <td valign="top" align="center"><strong>Action</strong></td>
   <%
                }
                %>
  </tr>
  <%
  for(int i=0;i<to.length;i++){
  %>
  <tr>
    <td><%=to[i].getVal()%></td>
	<td><%=to[i].getDesce()%></td>
   <%
      if(ut.getIdrole().compareTo("admin")==0 || ut.getIdrole().compareTo("dg")==0)
                {
   %>
    <td width="38"><div align="center"><a href="<%=lien%>?but=finance/updateBeneficiaire.jsp&idBen=<%=to[i].getId()%>">Modifier</a></div></td>
    
   <%
                }
                %>
  </tr>
  <%
  }
    %>
</table>
</td></tr></table>