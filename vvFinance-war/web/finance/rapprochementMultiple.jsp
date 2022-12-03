<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="affichage.*" %>
<%@ page import="pub.*" %>
<%@ page import="prevision.*" %>
<%@ page import="finance.*" %>
  <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<%!
	UserEJB u = null;
	String acte = null;
	String lien = null;
	String bute;
	%>
	<%
	try
	{
		lien = (String)session.getValue("lien");
		u = (UserEJB)session.getAttribute("u");
		String[] idrib = request.getParameterValues("id"); // request.getParameter("id");
		String listrib = "";
		for(int i=0;i<idmvt.length;i++){
			if(i == 0){
				listrib = idmvt[i]+",";
			}else{
				listrib += idmvt[i]+",";
			}
		}
	}catch (Exception e){
        e.printStackTrace();
        %>
		<script language="JavaScript"> alert('<%=e.getMessage()%>');history.back(); </script>
        <%
        return;
    }
    %>
</html>