0.<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<%!
        UserEJB u = null;
        String idType=null;
        String lien=null;
        String date= null;
		String dateDebut = null;
		String dateFin=null;
        String idClient = null;
%>
<%
idType = request.getParameter("idType");
idClient=request.getParameter("idClient");
dateDebut=request.getParameter("mois");
dateFin=request.getParameter("annee");
%>
<%
 	lien=(String)session.getValue("lien");
	try
	{
          u=(UserEJB)session.getAttribute("u");
                                                          //String idClient, String daty, String dateDebut, String datyFin, String sCatService
           u.verifPenalite(dateDebut,dateFin);

          %>
		  <script language="JavaScript">

                  document.location.replace("<%=lien%>?but=penalites/listePenalites.jsp");
                  </script>

	  <%
        }catch (Exception e){
	 %>
             <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
	<%
        return;
	}
	%>
<head>
<title>Document sans titre</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<head>
</head>
</html>
