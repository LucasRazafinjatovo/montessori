<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>

<%!
VisaDevis a;
%>
<%
a=new VisaDevis();
a.setNomTable("visadevis");
PageConsulte pc=new PageConsulte(a,request,(user.UserEJB)session.getValue("u"));
VisaDevis e=(VisaDevis)pc.getBase();
%>
<html>
<h1>Consultation d'une fiche Visa</h1>
<%
out.println(pc.getHtml());
%>
<a href="<%=(String)session.getValue("lien")+"?but=activa/modifvisa.jsp&id="+request.getParameter("idVisa")%>">Modifier</a>
</html>