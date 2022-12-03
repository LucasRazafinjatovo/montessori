<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<%!
        UserEJB u = null;
        String acte=null;
        String lien=null;
        //finance.Entree entree = null;

%>
<%
acte=request.getParameter("acte");
	try
	{
          lien=(String)session.getValue("lien");
          u=(UserEJB)session.getAttribute("u");
          if(acte.compareToIgnoreCase("insert")==0)
          {
            //createVend(String surnom, String place, String nom, String prenom,String type, String journal, String montant, String date)
            //u.createVend(request.getParameter("surnom"),request.getParameter("place"),request.getParameter("nom"),request.getParameter("prenom"),request.getParameter("type"),request.getParameter("journal"),request.getParameter("montant"));
          %>
          <script language="JavaScript"> document.location.replace("<%=lien%>?but=ventegazety/saisivendeur.jsp"); </script>
          <%
          }
			if (acte.compareToIgnoreCase("validerAbonnement")==0){
				// 11: valider
				String result = u.validerAbonnement(request.getParameter("id"));
				%>
          <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=result%>");</script>
          <%
			}
			if (acte.compareToIgnoreCase("modifEtatAbonne")==0){
				//modifier etat abonne 0:desactiver, 1:activer, 11: valider
				u.modifEtatAbonne(request.getParameter("id"));
				%>
          <script language="JavaScript"> document.location.replace("<%=lien%>?but=ventegazety/abonne-fiche.jsp&id=<%=request.getParameter("id")%>"); </script>
          <%
			}
          else
          {

          }
        }catch (Exception e){
e.printStackTrace();
 %>

<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
		<%
		return;
		}
		%>

</html>




