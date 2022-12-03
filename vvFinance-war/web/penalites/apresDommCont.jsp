	<%@ page import="user.*" %>
	<%@ page import="utilitaire.*" %>

	<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

	<html>
	<%!

		UserEJB u = null;
		String acte=null;
		String id=null;
		String lien="modele.jsp";
        %>
	<%
	acte=request.getParameter("acte");
	lien=(String)session.getValue("lien");
         u=(UserEJB)session.getAttribute("u");
			try
			{
				  lien=(String)session.getAttribute("lien");
				  if (acte.compareTo("INSERT")==0)
				  {
                                   	id=u.createDommageConteneur(request.getParameter("date"), request.getParameter("dateDommage"),request.getParameter("designation"),request.getParameter("montant"), request.getParameter("numDossier"), request.getParameter("proprietaire"));
				  %>
				  <script language="JavaScript"> document.location.replace("<%=lien%>?but=penalites/listeDommCont.jsp"); </script>
				  <%
				  }
                                  if (acte.compareTo("UPDATE")==0)
                                  {
                                           id=u.updateDommageConteneur(request.getParameter("idDomm"),request.getParameter("date"), request.getParameter("dateDommage"),request.getParameter("designation"),request.getParameter("montant"), request.getParameter("numDossier"), request.getParameter("proprietaire"));
                                  %>
                                  <script language="JavaScript"> document.location.replace("<%=lien%>?but=penalites/listeDommCont.jsp"); </script>
                                  <%
				  }
                                  if (acte.compareTo("DELETE")==0)
                                  {

//                                    u.deleteDommageConteneur(request.getParameter("idDomm"));
                                    u.annulerDommage(request.getParameter("idDomm"));

                                  %>
                                  <script language="JavaScript"> document.location.replace("<%=lien%>?but=penalites/listeDommCont.jsp"); </script>
                                  <%
				  }
                        }
			catch (Exception e)
			{
                        %>
                                      <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
			<%
                          return;
			}

	                %>