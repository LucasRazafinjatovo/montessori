<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="lc.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String lien= null;
        UserEJB u = null;
        Direction dir[] = null;
        String rep = null;
        String idTe = null;
		historique.MapUtilisateur ut=null;

 %>
 <%
 try{
   u=(UserEJB)session.getValue("u");
   lien=(String)session.getValue("lien");
   dir =u.findDirection("","","","","");
   ut=u.getUser();
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Liste des Directions</h1>
<table width="600" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr class="head">
          <td width="100" height="19" valign="top"><strong>Type</strong></td>
          <td width="100" height="19" valign="top"><strong>Description</strong></td>
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
  for(int i=0;i<dir.length;i++)
  {
  %>
        <tr>
          <td> <%=dir[i].getLibelledir()+ " ("+ dir[i].getAbbrevDir()+")" %></td>
          <td> <%=dir[i].getDescdir()%></td>
       
		     <%
      if(ut.getIdrole().compareTo("admin")==0 || ut.getIdrole().compareTo("dg")==0 )
		{
   %>
          <td width="25" align="center"><a href="<%=lien%>?but=lc/direction.jsp&acte=Modifier&idDirectionToUpdate=<%=dir[i].getIdDir()%>">Modifier</a></td>
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
