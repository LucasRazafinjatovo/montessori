<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>

<%
DemandeDevis a=new DemandeDevis();
a.setNomTable("demandedevisarticleprix");
PageConsulte pc=new PageConsulte(a,request,(user.UserEJB)session.getValue("u"));
//DemandeDevis e=(DemandeDevisLibelle)pc.getBase();
%>
<html>
<h1>Consultation d'une fiche de demande devis valide</h1>
<%
out.println(pc.getHtml());
%>
<%
String t=request.getParameter("idDevis");
DemandeDevisLibelle v=new DemandeDevisLibelle();
v.setNomTable("demandedevisarticleviser");
v.setIdDevis(t);
DemandeDevisLibelle[] dd=(DemandeDevisLibelle[])CGenUtil.rechercher(v,null,null,"");
if(dd.length!=0) {
%>
<a href='javascript:Popup("apercuDevis.jsp?idDevis=<%=request.getParameter("idDevis")%>","fenetre",800,600,"menubar=yes,scrollbars=yes,statusbar=no")'>Aperçu devis</a>&nbsp;
<a href='javascript:Popup("apercuDevisClient.jsp?idDevis=<%=request.getParameter("idDevis")%>","fenetre",800,600,"menubar=yes,scrollbars=yes,statusbar=no")'>Aperçu Facture Pro Format</a>
<%}
else {
%>
  <a href='javascript:Popup("apercuDevis.jsp?idDevis=<%=request.getParameter("idDevis")%>","fenetre",800,600,"menubar=yes,scrollbars=yes,statusbar=no")'>Aperçu devis</a>&nbsp;
 <a href='javascript:Popup("apercuDevisClient.jsp?idDevis=<%=request.getParameter("idDevis")%>","fenetre",800,600,"menubar=yes,scrollbars=yes,statusbar=no")'>Aperçu Facture Pro Format</a>
 <a href="<%=(String)session.getValue("lien")+"?but=activa/saisivisafille.jsp&id="+request.getParameter("idDevis")%>" target="_blank">viser</a>
<%}
%>
</html>