	<%@ page import="user.*" %>
	<%@ page import="utilitaire.*" %>

	<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

	<html>
	<%!

		UserEJB u = null;
		String acte=null;
		String id=null;
		String lien="modele.jsp";
                String idAcc = null;
        %>
 <%
        idAcc = request.getParameter("idAccident");
	acte=request.getParameter("acte");
      	lien=(String)session.getValue("lien");
         u=(UserEJB)session.getAttribute("u");
			try
			{
				  lien=(String)session.getAttribute("lien");
				  if (acte.compareTo("INSERT")==0)
				  {
//                                    String datySaisie, String datyAccident, String description, String nomEmploye, String rem
					id=u.createAccident(request.getParameter("date"), request.getParameter("dateAccident"),request.getParameter("description"),request.getParameter("nomEmp"),request.getParameter("remarque"));

				  %>
				  <script language="JavaScript"> document.location.replace("<%=lien%>?but=penalites/detailAccident.jsp&id=<%=id%>"); </script>
				  <%
				  }
                                  if (acte.compareTo("DELETE")==0)
                                  {
//                                    String datySaisie, String datyAccident, String description, String nomEmploye, String rem
                                   // u.deleteAccident(idAcc);
                                    u.annulerAccident(idAcc);

                                  %>
                                  <script language="JavaScript"> document.location.replace("<%=lien%>?but=penalites/listeAccident.jsp"); </script>
                                  <%
				  }
				      if (acte.compareTo("UPDATE")==0)
                                  {
//                                   String idAccident, String datySaisie, String datyAccident, String description, String nomEmploye, String rem
                                       u.updateAccident(idAcc,request.getParameter("date"), request.getParameter("dateAccident"),request.getParameter("description"),request.getParameter("nomEmp"),"");


                                  %>
                                  <script language="JavaScript"> document.location.replace("<%=lien%>?but=penalites/listeAccident.jsp"); </script>
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