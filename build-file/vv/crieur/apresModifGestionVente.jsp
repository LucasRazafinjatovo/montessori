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
	String acte = null;
	String lien = null;
	String type = null;
	String id = null;
	%>
	<%
	acte = request.getParameter("acte");
	type = request.getParameter("type");
	id = request.getParameter("id").trim();
	try
	{
        lien = (String)session.getValue("lien");
        u = (UserEJB)session.getAttribute("u");
        if(acte.compareToIgnoreCase("UPDATE")==0)
        {
			if(type.compareToIgnoreCase("prise")==0)
			{
				%>
				<script language="JavaScript"> document.location.replace("<%=lien%>?but=crieur/updatePrise.jsp&id=<%=id%>&type=<%=type%>"); </script>
				<%
			}
			if(type.compareToIgnoreCase("invendu")==0)
			{
				%>
				<script language="JavaScript"> document.location.replace("<%=lien%>?but=crieur/updateInvendu.jsp&id=<%=id%>&type=<%=type%>"); </script>
				<%
			}
			if(type.compareToIgnoreCase("recette")==0)
			{
				/*VenteFacture vf = new VenteFacture();
				vf.setId1(request.getParameter("id"));
				VenteFacture[] lv = (VenteFacture[])CGenUtil.rechercher(vf,null,null,"");
				if(lv.length!=0)throw new Exception("Recette non modifiable");
				*/%>
				<script language="JavaScript"> document.location.replace("<%=lien%>?but=crieur/updateRecette.jsp&id=<%=id%>&type=<%=type%>"); </script>
				<%
			}
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




