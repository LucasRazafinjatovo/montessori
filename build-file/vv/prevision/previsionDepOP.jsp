<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="prevision.*" %>
<%

EtatPrevOP e = new EtatPrevOP();
String listeCrt[] = {"daty","depense","prevision"};
String listeInt[] = {"daty","depense","prevision"};
String libEntete[] = {"daty","depense","prevision","diff"};

PageRecherche pr = new PageRecherche(e,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("prevision/previsionDepOP.jsp");
String[]colSomme = {"depense","prevision","diff"};
pr.creerObjetPage(libEntete,colSomme);
%>
<h1>Etat pr&eacute;visions depense & OP</h1>
<form action="<%=pr.getLien()%>?but=prevision/previsionDepOP.jsp" method="post" name="previsionDepOP" id="previsionDepOP">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>

<%
String lienTableau[] = {pr.getLien()+"?but=prevision/fichePrevisionDetail.jsp"};
String colonneLien[] = null;
pr.getTableau().setLien(lienTableau);
// pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>