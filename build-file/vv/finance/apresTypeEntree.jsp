<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String lien= null;
        UserEJB u = null;
        TypeObjet te[] = null;
        String rep = null;
        String idTe = null;
        String designation = null;
        String description = null;
        String acte = null;
        int retour = 0;

 %>
<%
idTe = request.getParameter("idTypeEntree");
designation=request.getParameter("designation");
description=request.getParameter("description");
acte=request.getParameter("acte");
lien=(String)session.getValue("lien");
	try
	{
          u=(UserEJB)session.getAttribute("u");
          if (acte.compareTo("UPDATE")==0)
          {
               rep=u.updateTypeObjet("TypeEntree", idTe, designation,description);

           %>
  			<script language="JavaScript"> document.location.replace("<%=lien%>?but=finance/listeTypeEntree.jsp"); </script>
  			<%
          }
          if (acte.compareTo("INSERT")==0)
          {
            rep=u.createTypeObjet("TypeEntree","GetSeqTypeEntree","TENT",designation,description);
            %>
  			<script language="JavaScript"> document.location.replace("<%=lien%>?but=finance/listeTypeEntree.jsp"); </script>
  			<%
          }
          if (acte.compareTo("DELETE")==0)
          {
            //retour =u.deleteTypeObjet("TypeEntree",request.getParameter("idTypeEntree"));
          %>
 		 <script language="JavaScript"> document.location.replace("<%=lien%>?but=finance/listeTypeEntree.jsp"); </script>
  	<%
          }
        }catch (Exception e){
		%>
		<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
		<%
		return;
		}
		%>

<html>
<head>
<title>Document sans titre</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<table width="425" border="0" cellspacing="0">
  <tr>
    <td><div align="justify"><font size="2" face="Geneva, Arial, Helvetica, sans-serif">Votre
        action a &eacute;t&eacute; faite avec succ&egrave;s. son reference est
        <a href="../caisse/<%=lien%>?id=<%=rep%>&but=finance/DetailEntree.jsp"><%=rep%></a></font></div>
    </td>
  </tr>
</table>
</body>
</html>
