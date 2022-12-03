<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>

<%
DemandeDevis a=new DemandeDevis();
a.setNomTable("demandedevisarticleprix");
a.setIdDevis(request.getParameter("idDevis"));
PageConsulte pc=new PageConsulte(a,request,(user.UserEJB)session.getValue("u"));
//DemandeDevis e=(DemandeDevisLibelle)pc.getBase();
%>
<html>
<h1>Consultation d'une fiche de demande devis</h1>
<%
out.println(pc.getHtml());
%>
  <a href="<%=(String)session.getValue("lien")+"?but=activa/modifdemandedevis.jsp&idDevis="+request.getParameter("idDevis")%>">Modifier</a>&nbsp;
  <a href='javascript:Popup("apercuDevis.jsp?idDevis=<%=request.getParameter("idDevis")%>","fenetre",800,600,"menubar=yes,scrollbars=yes,statusbar=no")'>Aperçu devis</a>&nbsp;
  <a href="<%=(String)session.getValue("lien")+"?but=activa/modifdemandedevisautre.jsp&idDevis="+request.getParameter("idDevis")%>" target="_blank">Valider</a>&nbsp;

</html>