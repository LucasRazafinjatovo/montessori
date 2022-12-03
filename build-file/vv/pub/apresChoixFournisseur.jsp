<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<script language="JavaScript">

        window.opener.document.all.<%=request.getParameter("champReturn")%>.value = "<%=request.getParameter("choix")%>";
		window.close();
 </script>




</html>
