<%-- 
    Document   : apresEntiteChoix
    Created on : 22 mai 2018, 10:39:06
    Author     : pro
--%>

<%@page import="recette.RubriquePrixEntite"%>
<%@ page import="user.*" %>
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
          RubriquePrixEntite arti=new RubriquePrixEntite();
          //arti.setNomTable("demandeDevis");
          arti.setEntite(request.getParameter("choix"));
          RubriquePrixEntite[] ret=(RubriquePrixEntite[])CGenUtil.rechercher(arti,null,null,"");
%>
window.opener.document.all.prixunitaire.value = "<%=ret[0].getId() %>";
<%}%>
  window.close();
 </script>




</html>