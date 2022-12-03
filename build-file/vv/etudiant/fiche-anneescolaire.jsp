<%-- 
    Document   : rubrique-prix-entite-fiche
    Created on : 22 mai 2018, 12:08:03
    Author     : pro
--%>


<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="etudiant.*" %>
<%!
    AnneeScolaire anneescolaire;
    UserEJB u = null;
    historique.MapUtilisateur ut=null;
%>
<%
    anneescolaire = new AnneeScolaire();
    String[] libelleConsultationFiche = {"Id", "Nom"};
    PageConsulte pc=new PageConsulte(anneescolaire,request,(user.UserEJB)session.getValue("u"));
    pc.setLibAffichage(libelleConsultationFiche);
    
    u=(user.UserEJB)session.getValue("u");
    ut=u.getUser();

%>
<html>
<link href="../style/style.css" rel="stylesheet" type="text/css">
<h1>Detail ann&eacute;e scolaire</h1>
<%
out.println(pc.getHtml());
%>
<a href="<%=(String)session.getValue("lien")+"?but=etudiant/anneescolaire-modif.jsp&id="+request.getParameter("id")%>"><u>Modifier</u></a>
<a href="<%=(String)session.getValue("lien")%>"><u>Exit</u></a>
<br/>
<%
//out.println(pconf.getHtml());
%>
</html>
