<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="activa.*" %>
<%@ page import="bean.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<script language="JavaScript">

        window.opener.document.all.<%=request.getParameter("champReturn")%>.value = "<%=request.getParameter("choix")%>";
        <%
        String is=request.getParameter("choix3");
        if(is!=null)
        {
          ProductionLibelle arti=new ProductionLibelle();
          arti.setNomTable("productionlibelle");
          arti.setArticle(request.getParameter("choix"));
         ProductionLibelle[] ret=(ProductionLibelle[])CGenUtil.rechercher(arti,null,null,"");
%>
window.opener.document.all.prixunitaire.value = "<%=ret[0].getArticle()%>";
<%}%>
  window.close();
 </script>




</html>
