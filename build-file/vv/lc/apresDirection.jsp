<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<%!
        UserEJB u = null;
        String lien=null;
        String acte = null;
    	String designation = null;
    	String directeur = null;
    	String abbrev = null;
    	String description = null;
    	String idAModifier = null;
   
%>
<%
	acte=request.getParameter("acte");
    designation=request.getParameter("designation");
    directeur = request.getParameter("directeur");
	abbrev = request.getParameter("abbrev");
	description = request.getParameter("description");
	idAModifier = request.getParameter("idAModifier");
    try
	{
          lien=(String)session.getValue("lien");
          u=(UserEJB)session.getAttribute("u");
          if (acte.compareToIgnoreCase("Créer")==0)
          {
        	  
          u.createDirection(designation,description,Utilitaire.stringToDouble(directeur)," "+abbrev);
           %>
           <script language="JavaScript"> document.location.replace("<%=lien%>?but=lc/listeDirection.jsp"); </script>
           <%
          }
          if (acte.compareToIgnoreCase("modifier")==0)
          {
        	 	
            u.updateDirection(idAModifier,designation,description,Utilitaire.stringToDouble(directeur),abbrev);
		%>
        <script language="JavaScript"> document.location.replace("<%=lien%>?but=lc/listeDirection.jsp"); </script>
          <%
          }
        }
      catch (Exception e){
 %>

<script language="JavaScript"> ///document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
		<%
		return;
		}
		%>
</html>
