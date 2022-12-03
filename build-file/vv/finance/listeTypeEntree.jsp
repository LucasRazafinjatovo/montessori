<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String lien= null;
        UserEJB u = null;
        TypeObjet te[] = null;
        String rep = null;
        String idTe = null;
		historique.MapUtilisateur ut=null;

 %>
 <%
 try{
   u=(UserEJB)session.getValue("u");
   lien=(String)session.getValue("lien");
   te=u.findTypeObjet("TypeEntree","%","%");
   ut=u.getUser();
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Liste des types de Recette</h1>
<table width="600" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr class="head">
          <td width="100" height="19" valign="top"><strong>Type</strong></td>
          <td width="100" height="19" valign="top"><strong>Description</strong></td>
         <td></td>
		     <%
      if(ut.getIdrole().compareTo("admin")==0 || ut.getIdrole().compareTo("dg")==0 || ut.getIdrole().compareTo("compta")==0)
		{
   %>
          <td valign="top" align="center"><strong>Action</strong></td>
		  <%
		  }
		  %>
        </tr>
        <%
  for(int i=0;i<te.length;i++)
  {
  %>
        <tr>
          <td> <%=te[i].getVal()%></td>
          <td> <%=te[i].getDesce()%></td>
         <td><a href="<%=lien%>?but=finance/listeEntree.jsp&idType=<%=te[i].getId()%>">Lister</a></td>
		     <%
      if(ut.getIdrole().compareTo("admin")==0 || ut.getIdrole().compareTo("dg")==0 || ut.getIdrole().compareTo("compta")==0)
		{
   %>
          <td width="25" align="center"><a href="<%=lien%>?but=finance/updateTypeEntree.jsp&idTypeEntree=<%=te[i].getId()%>">Modifier</a></td>
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
