<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>
<%@ page import="pub.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<%!
	UserEJB u = null;
	String acte=null;
	String lien=null;
	String type=null;
	String id=null;
	//finance.Entree entree = null;

%>
<%
	acte = request.getParameter("acte");
	id = request.getParameter("id").trim();
	try
	{
		lien=(String)session.getValue("lien");
		u=(UserEJB)session.getAttribute("u");
		if(acte.compareToIgnoreCase("search")==0)
		{
			%>
			<script language="JavaScript"> document.location.replace("<%=lien%>?but=admin/updateMvtCaisse.jsp&id=<%=id%>"); </script>
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




