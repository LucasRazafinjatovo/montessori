<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="prevision.*" %>
<%

EtatPrevOR e = new EtatPrevOR();
String listeCrt[] = {"daty","recette","prevision"};
String listeInt[] = {"daty","recette","prevision"};
String libEntete[] = {"daty","recette","prevision","diff"};

PageRecherche pr = new PageRecherche(e,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("prevision/previsionRecOR.jsp");
String[]colSomme = {"recette","prevision","diff"};
pr.creerObjetPage(libEntete,colSomme);
%>
<h1>Etat pr&eacute;visions recette & OR</h1>
<form action="<%=pr.getLien()%>?but=prevision/previsionRecOR.jsp" method="post" name="previsionRecOR" id="previsionRecOR">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>

<%
String lienTableau[] = {pr.getLien()+"?but=prevision/fichePrevisionDetail.jsp"};
String colonneLien[] = {"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>