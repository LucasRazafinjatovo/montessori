<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="facture/apresAnnulerFacture.jsp";
        String lien= null;
        UserEJB u = null;
        TypeObjet ts[] = null;
        String rep = null;
        String idTs = null;
		historique.MapUtilisateur ut=null;


 %>
 <%
 try{
   u=(user.UserEJB)session.getValue("u");
   lien=(String)session.getValue("lien");
   ts=u.findTypeObjet("TypeSortie","%","%");
      ut=u.getUser();
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Liste des types de D&eacute;pense</h1>
<table width="600" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td>
	<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr class="head">
          <td width="203" height="19" valign="top"><strong>Type</strong></td>
          <td width="275">Description</td>
         <td></td>
		   <%
      if(ut.getIdrole().compareTo("admin")==0 || ut.getIdrole().compareTo("dg")==0 || ut.getIdrole().compareTo("compta")==0)
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
          <td><%=ts[i].getVal()%></td>
          <td><%=ts[i].getDesce()%></td>
             <td><a href="<%=lien%>?but=finance/listeSortie.jsp&idType=<%=ts[i].getId()%>">Lister</a></td>
		   <%
      if(ut.getIdrole().compareTo("admin")==0 || ut.getIdrole().compareTo("dg")==0 || ut.getIdrole().compareTo("compta")==0)
		{
   %>
          <td width="104" align="center"><a href="<%=lien%>?but=finance/updateTypeSortie.jsp&idTypeSortie=<%=ts[i].getId()%>">Modifier</a></td>
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
