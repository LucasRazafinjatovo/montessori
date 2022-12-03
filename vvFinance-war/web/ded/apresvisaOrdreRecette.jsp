<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<%!
        UserEJB u = null;
        String acte=null;
        String id=null;
        String lien=null;
        finance.Entree entree = null;
        String rep = null;
        int retour = 0;
        String idEntree=null;
        String numFact=null;
        String typa=null;
	String nomClient=null;
	String nature=null;

%>
<%
acte=request.getParameter("acte");

	try
	{
          lien=(String)session.getValue("lien");
           u=(UserEJB)session.getAttribute("u");
		nature=request.getParameter("nature");
		if(acte.compareToIgnoreCase("multiple") == 0){
			String numobj = request.getParameter("idOP");
			String daty = request.getParameter("daty");
			String remarque = request.getParameter("remarque");

			String[] listop = Utilitaire.split(numobj,',');
			for(int i = 0; i < listop.length; i++){
			  u.viserOr(daty, remarque,listop[i].trim());
			}
			%><script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/visaORMultiple.jsp");</script><%
		}else{
			u.viserOr(request.getParameter("daty"), request.getParameter("remarque"),request.getParameter("idOP"));
			u.savePrevision(request.getParameter("idOP"),"ORPREVISION","ORDONNERRECETTE");
			%>
			<script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/visualiserOR.jsp&idOP=<%=request.getParameter("idOP")%>");</script>
			<%
		}
	}catch (Exception e){
		e.printStackTrace();
		%>
		<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
		<%
		return;
	}%>
<head>
<title>Document sans titre</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<table width="425" border="0" cellspacing="0">
  <tr>
    <td><div align="justify"></div>
    </td>
  </tr>
</table>
</body>
</html>




