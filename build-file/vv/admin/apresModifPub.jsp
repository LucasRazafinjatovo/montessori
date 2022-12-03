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
	String id = null;
	//finance.Entree entree = null;
	String bute;
	String rajoutLie = "";

%>
<%
	acte = request.getParameter("acte");
	id = request.getParameter("id").trim();
	bute = request.getParameter("bute");
	try
	{
		lien=(String)session.getValue("lien");
		u = (UserEJB)session.getAttribute("u");
		ClassMAPTable t = null;
		String classe = request.getParameter("classe");
		if(acte.compareToIgnoreCase("search")==0)
		{
			%>
			<script language="JavaScript"> document.location.replace("<%=lien%>?but=admin/updatePublicite.jsp&id=<%=id%>"); </script>
			<%
		}
		if(acte.compareToIgnoreCase("update")==0)
		{
			t = (ClassMAPTable)(Class.forName(classe).newInstance());
			Page p = new Page(t,request);
			ClassMAPTable f = p.getObjectAvecValeur();
			u.updateObject(f);
		}
		%>
		<script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute+rajoutLie%>"); </script>
		<%
    }catch (Exception e){
		e.printStackTrace();
		%>
		<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
		<%
		return;
	}
	%>
</html>




