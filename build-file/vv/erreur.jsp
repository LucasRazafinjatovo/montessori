<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:include page='EnTete.jsp' />
<html>
<head>
<title>Document sans titre</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="style/style.css" rel="stylesheet" type="text/css">
</head>

<body>
<p class="error">&nbsp;</p>
<table width="425" border="0" cellspacing="0">
  <tr>
    <td>
      <%!
	String message=null;
	%>
      <%
	message=request.getParameter("message");
	%>
      <span class="error"><strong>Erreur lors de votres op&eacute;ration.</strong>
      <BR>
      <u><strong>Message :</strong></u> <%=message%><BR>
      Merci.</span> </td>
  </tr>
</table>
</body>
</html>
