<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String lien= null;
        UserEJB u = null;
        String idFact = null;
   

%>

<%
  idFact = request.getParameter("idFactMere");

%>
<%
try{
  u=(UserEJB)session.getValue("u");
  lien=(String)session.getValue("lien");
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
<link href="style.css" rel="stylesheet" type="text/css">
</head>

<body>
<table width="425" border="0" cellspacing="0">
  <tr>
    <td><div align="justify"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">La
        facture a &eacute;t&eacute; faite avec succ&egrave;s. </font></div>
      <div align="left">
        <p><font color="#333399" size="2" face="Verdana, Arial, Helvetica, sans-serif">Vous
          pouvez faire les op&eacute;rations suivantes :</font><br>
           <font size="2" face="Geneva, Arial, Helvetica, sans-serif"><a href="<%=lien%>?but=facture/detailFacture.jsp&idFactureMere=<%=request.getParameter("idFactureMere")%>">-
          Afficher les d&eacute;tails de la facture</a></font></p>
      </div>
      <ul>
      </ul>
</td>
  </tr>
</table>
<font size="2" face="Geneva, Arial, Helvetica, sans-serif"></font>
</body>
</html>
