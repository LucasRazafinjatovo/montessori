<%-- 
    Document   : rubrique-prix-entite-fiche
    Created on : 22 mai 2018, 12:08:03
    Author     : pro
--%>

<%@page import="recette.RubriquePrixEntite"%>
<%@page import="recette.ConfPrixEtudiant"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="etudiant.*" %>
<%!
    RubriquePrixEntite rubriquePrixEntite;
    UserEJB u = null;
    historique.MapUtilisateur ut=null;
%>
<%
    rubriquePrixEntite=new RubriquePrixEntite();
    String[] libelleConsultationFiche = {"Id", "Libelle", "Montant", "Entite", "Daty"};
    PageConsulte pc=new PageConsulte(rubriquePrixEntite,request,(user.UserEJB)session.getValue("u"));//ou avec argument liste Libelle si besoin
    pc.setLibAffichage(libelleConsultationFiche);
    
    u=(user.UserEJB)session.getValue("u");
    ut=u.getUser();

%>
<html>
<link href="../style/style.css" rel="stylesheet" type="text/css">
<h1>Fiche rubrique prix entite</h1>
<%
out.println(pc.getHtml());
%>
<a href="<%=(String)session.getValue("lien")+"?but=rubrique/rubrique-prix-entite-modif.jsp&id="+request.getParameter("id")%>"><u>Modifier</u></a>
<a href="<%=(String)session.getValue("lien")%>"><u>Exit</u></a>
<br/>
<%
//out.println(pconf.getHtml());
%>
</html>
