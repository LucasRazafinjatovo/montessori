<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="facture/apresCompte.jsp";
        String lien= null;
        UserEJB u = null;
        Compte ts[]= null;
        String rep = null;
        String idTs = null;
        historique.MapUtilisateur ut=null;
 %>
 <%
 try{
   u=(user.UserEJB)session.getValue("u");
   lien=(String)session.getValue("lien");
   ts=u.findCompte("%","%","%","");
   ut=u.getUser();
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
<h1>Liste des Comptes Comptables Existantes</h1>
<table width="600" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td>
	<table width="99%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr class="head">
          <td width="84" valign="top"><div align="center"><strong>Id</strong></div></td>
          <td width="104" valign="top">Date d. validit&eacute;</td>
          <td width="121" height="19" valign="top"><div align="center"><strong>Type</strong></div></td>
          <td width="162"><div align="center">Description</div></td>
          <%
      if(ut.getIdrole().compareTo("admin")==0 || ut.getIdrole().compareTo("dg")==0 || ut.getIdrole().compareTo("adminFacture")==0)
                {
   %>
          <td valign="top" colspan="3" align="center"><strong>Action</strong></td>
          <%
                }
   %>
        </tr>
        <%
	  for(int i=0;i<ts.length;i++){
	  %>
        <tr>
          <td><div align="center"><%=ts[i].getId()%></div></td>
          <td><%=Utilitaire.formatterDaty(ts[i].getDatyDebutValid())%></td>
          <td><div align="center"><%=ts[i].getVal()%></div></td>
          <td><div align="center"><%=ts[i].getDesce()%></div></td>
          <%
      if(ut.getIdrole().compareTo("admin")==0 || ut.getIdrole().compareTo("dg")==0 || ut.getIdrole().compareTo("adminFacture")==0)
                {
   %>
          <td width="89" align="center"><a href="<%=lien%>?but=facture/updateCompte.jsp&idTypeEntree=<%=ts[i].getId()%>">Mod.</a>&nbsp;&nbsp;|&nbsp;&nbsp;
            <a href="javascript:decision('Vous voulez vraiment annuler ce compte?\n\nCette opération supprimera définitivement le compte du système.','<%=lien%>?but=<%=apres%>&idTypeEntree=<%=ts[i].getId()%>&acte=DELETE')">
            Annuler</a></td>
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
