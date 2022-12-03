<%-- 
    Document   : historiquesPrix
    Created on : 18 mai 2018, 17:48:07
    Author     : Amboara
--%>
<%@page import="recette.ConfPrixEtudiant"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="etudiant.*" %>
<%@ page import="promotion.*" %>
<%@ page import="indicateur.*" %>
<%

ConfPrixEtudiant confPrixEtudiant=new ConfPrixEtudiant();
confPrixEtudiant.setNomTable("confPrixEtudiantLibelleHisto");

String listeCrt[]={"etudiant", "daty", "remarques"};
String listeInt[]={"daty"};
String libEntete[]={"id", "daty", "etudiant", "echeance", "ecolage", "food", "transport", "inscription", "autres", "remarques"};
//PageRecherche pr=new PageRecherche(confPrixEtudiant,request,listeCrt,listeInt,3,libEntete,listeInt.length);
PageRecherche pr = new PageRecherche(confPrixEtudiant, request, listeCrt, listeInt, 3);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("etudiant/histo/historiquesPrix.jsp");
String[]colSomme=null;
pr.creerObjetPage(libEntete,colSomme);
%>
<h1>Historique prix</h1>
<form action="historiquesPrix.jsp?champReturn=<%=request.getParameter("champReturn")%>" method="post" name="listeetudiantchoix" id="listeetudiantchoix">
    <%
        out.println(pr.getFormu().getHtmlEnsemble());%>
</form>


<%
    out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
    out.println(pr.getTableau().getHtml());
    out.println(pr.getBasPage());
%>
