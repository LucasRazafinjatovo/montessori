<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<%!
        UserEJB u 			= null;
		String soa 		= null;
		String acte 		= null;
	 	
                 String lien = null;
                 String choix="";
                 String champReturn = null;
%>
<%
  acte=request.getParameter("acte");
%>
<%
  lien	= (String)session.getValue("lien");
  u		= (UserEJB)session.getAttribute("u");

  //Verifier si le bordereau a été cloturé par l'utilisateur


 String cBq = "";
	    choix	= request.getParameter("choix");
            //soa_ =  u.findSoa(choix,"%","%","%")[0];
champReturn = request.getParameter("champReturn");

	%>

<script language="JavaScript">

        window.opener.document.all.<%=champReturn%>.value = "<%=choix%>";

        window.close();
        </script>




</html>