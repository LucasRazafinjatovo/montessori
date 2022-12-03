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

                                    //String tauxDirBcEurop, String majorBcEurop, String delaiPaiementPenalit, String performAnnuel, String slTauxOccup, String majorTauxOccup, String slRappPerteAnnu, String slNbPerteAnnu, String pxUnitVol, String slRappDommagTotal, String pxPourcExc, String valLimitcont, String nbLimitAccAnnu, String datyD, String pxAccExc
                                    u.updateParametrePenalite(request.getParameter("tauxDirBce"),request.getParameter("majorSpat"),request.getParameter("delaiPaie"),request.getParameter("objPerfAnnuel"),request.getParameter("slTauxOccup"),request.getParameter("majorTauxOccup"),request.getParameter("slRappPerteAnnu"),request.getParameter("slNbPerteAnnu"),request.getParameter("pxUnitVol"),request.getParameter("slRappDommagTotal"),request.getParameter("pxPourcExc"),request.getParameter("valLimitcont"),request.getParameter("nbLimitAccAnnu"),request.getParameter("datyD"),request.getParameter("pxAccExc"));




				  %>
				  <script language="JavaScript"> document.location.replace("<%=lien%>?but=penalites/listeParamPenalite.jsp"); </script>
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