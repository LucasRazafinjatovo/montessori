<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<%!
        UserEJB u = null;
        String type=null;
        String id=null;
        String lien=null;
        //finance.Entree entree = null;

%>
<%
type=request.getParameter("type");
id=request.getParameter("id");
	try
	{
          lien=(String)session.getValue("lien");
          u=(UserEJB)session.getAttribute("u");
          if(type.compareToIgnoreCase("parution")==0)
          {
           %>
          <script language="JavaScript"> document.location.replace("listeParutionChoix.jsp"); </script>
          <%
          }
          if(type.compareToIgnoreCase("publication")==0)
          {
           %>
          <script language="JavaScript"> document.location.replace("listePublicationChoix.jsp"); </script>
          <%
          }
          if(type.compareToIgnoreCase("vendeur")==0)
          {
           %>
          <script language="JavaScript"> document.location.replace("listeVendeurChoix.jsp"); </script>
          <%
          }
          if(type.compareToIgnoreCase("prise")==0)
          {
           %>
          <script language="JavaScript"> document.location.replace("listePriseChoix.jsp"); </script>
          <%
          }
          if(type.compareToIgnoreCase("invendu")==0)
          {
           %>
          <script language="JavaScript"> document.location.replace("listeInvenduChoix.jsp"); </script>
          <%
          }
          if(type.compareToIgnoreCase("recette")==0)
          {
           %>
          <script language="JavaScript"> document.location.replace("listeRecetteChoix.jsp"); </script>
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




