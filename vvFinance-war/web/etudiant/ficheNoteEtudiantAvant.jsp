<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="etudiant.*" %>
<%!
Etudiant p;
%>
<%
p=new Etudiant();
p.setNomTable("etudiantlib");
PageConsulte pc=new PageConsulte(p,request,(user.UserEJB)session.getValue("u"));//ou avec argument liste Libelle si besoin
%>
<html>
<h1>Consultation d'une fiche &eacute;tudiant</h1>
<%
out.println(pc.getHtml());
%>
<a href="<%=(String)session.getValue("lien")+"?but=etudiant/modifEtudiant.jsp&id="+request.getParameter("id")%>">Modifier</a>
<a href="<%=(String)session.getValue("lien")+"?but=pub/apresTarif.jsp&id="+request.getParameter("id")%>&acte=delete&bute=etudiant/listeEtudiant.jsp&classe=etudiant.Etudiant">Supprimer</a>
</html>
