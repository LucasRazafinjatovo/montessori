<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="facture/apresInit.jsp";
        String lien= null;
        UserEJB u = null;
        String rep = null;
	String idFact = null;
        String acte = null;
        String idFF = null;
	String type = null;

%>

<%
  idFact = request.getParameter("idFactMere");
  idFF = request.getParameter("idFF");
  acte = request.getParameter("acte");
  type= request.getParameter("type");
%>
<%
try{
	u = (UserEJB)session.getValue("u");
	lien=(String)session.getValue("lien");
	if(acte.compareTo("DELETE") == 0){
		u.deleteFactureFille(idFF);
		if(type.compareTo("ADMIN")==0){
		%>
			<script language="JavaScript"> document.location.replace("<%=lien%>?but=facture/factureFilleAdmin.jsp&idFactMere=<%=idFact%>&idTypeFacture=<%=		request.getParameter("idTypeFacture")%>"); </script>
			<%
		}else{
			%>
			<script language="JavaScript"> document.location.replace("<%=lien%>?but=facture/factureFille.jsp&idFactMere=<%=idFact%>"); </script>
			<%
		}
	}

}catch(Exception e){
	%>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
	<%
	}
	%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
 
<head>
<title>Document sans titre</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="style/monographie.css" rel="stylesheet" type="text/css">
</head>

<body>
<font size="2" face="Geneva, Arial, Helvetica, sans-serif"></font>
</body>
</html>
