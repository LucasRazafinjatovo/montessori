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
	String type=null;
	%>
	<%
	acte=request.getParameter("acte");
	type=request.getParameter("type");
    try{
        lien = (String)session.getValue("lien");
        u = (UserEJB)session.getAttribute("u");
        if(acte.compareToIgnoreCase("update")==0){
            if(type.compareToIgnoreCase("prise")==0){
				u.updateTypeVente2(type,request.getParameter("daty"),request.getParameter("nbre"),request.getParameter("id"),request.getParameter("publicat"),request.getParameter("vendeur"),request.getParameter("idPrix"));
            }else {
				u.updateTypeVente2(type,request.getParameter("daty"),request.getParameter("nbre"),request.getParameter("id"),request.getParameter("publicat"),request.getParameter("vendeur"));
            }
			%>
			<script language="JavaScript"> document.location.replace("<%=lien%>?but=crieur/updateAdminGestionVente.jsp&type=<%=type%>"); </script>
			<%
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




