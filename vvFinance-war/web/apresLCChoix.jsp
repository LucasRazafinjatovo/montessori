<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>

<%
	String tailleString = request.getParameter("taille_tableau");
	int taille = Integer.parseInt(tailleString);
	int compteurid = 0;
	String listidlc = "";
	
	
	for(int i = 0; i < taille; i++)
    {
		String id = request.getParameter("identifiant"+i);
		if(id != null && id.compareToIgnoreCase("") != 0)
		{
			listidlc = listidlc+"-"+id;
		}
	}
%>
<script language="JavaScript">
		window.opener.document.all.<%=request.getParameter("champReturn")%>.value = "<%=listidlc%>";
        window.close();
 </script>




</html>
