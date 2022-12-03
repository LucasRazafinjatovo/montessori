<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.*" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<%!
        UserEJB u 			= null;
		String lien  		=null;
		String sender 		= null;
	 	
%>
<%
  sender=request.getParameter("sender");
%>
<%
  lien	= (String)session.getValue("lien");
  u		= (UserEJB)session.getAttribute("u");
 

 if(sender.compareToIgnoreCase("LC")==0){ 
	%>
   <script language="JavaScript">
        window.opener.document.all.idLigneACopier.value = "<%=request.getParameter("choix")%>";
        window.opener.document.all.idLigneACopier.readonly=true;
        window.close();
 </script>

	<%
 }
 if(sender.compareToIgnoreCase("entree")==0){ 
		%>
	   <script language="JavaScript">
	        window.opener.document.all.numLCEntrer.value ="<%=request.getParameter("choix")%>";
	        window.close();
	 </script>

<%} 
 if(sender.compareToIgnoreCase("sortie")==0){ 
%>
<script language="JavaScript">
	        window.opener.document.all.numLigneSortie.value ="<%=request.getParameter("choix")%>";
	        window.close();
	 </script>

<%}  
%>




</html>
