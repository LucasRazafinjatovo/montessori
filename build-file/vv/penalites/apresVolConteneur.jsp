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
                                    //String datySaisie, String datyVol, String numCont, String designation, String idDossier, String proprietaire, String montant
				    id=u.createVolCont(request.getParameter("date"), request.getParameter("dateVol"),request.getParameter("numCont"),request.getParameter("designation"), request.getParameter("numDossier"), request.getParameter("proprietaire"),request.getParameter("montant"));
				  %>
				  <script language="JavaScript"> document.location.replace("<%=lien%>?but=penalites/detailVolConteneur.jsp&idVol=<%=id%>"); </script>
				  <%
				  }
                                  if (acte.compareTo("UPDATE")==0)
                                  {
                                    //String datySaisie, String datyVol, String numCont, String designation, String idDossier, String proprietaire, String montant
                                    id=u.updateVolCont(request.getParameter("idVol"),request.getParameter("date"), request.getParameter("dateVol"),request.getParameter("numCont"),request.getParameter("designation"), request.getParameter("numDossier"), request.getParameter("proprietaire"),request.getParameter("montant"));
                                  %>
                                  <script language="JavaScript"> document.location.replace("<%=lien%>?but=penalites/listeVolConteneur.jsp"); </script>
                                  <%
				  }
                                  if (acte.compareTo("DELETE")==0)
                                  {
                                    //String datySaisie, String datyVol, String numCont, String designation, String idDossier, String proprietaire, String montant
                                   // u.deleteVolCont(request.getParameter("idVol"));
                                       u.annulerVol(request.getParameter("idVol"));
                                  %>
                                  <script language="JavaScript"> document.location.replace("<%=lien%>?but=penalites/listeVolConteneur.jsp"); </script>
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