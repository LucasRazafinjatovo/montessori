<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="prevision.*" %>
<%

PrevDepenseNonPaye e = new PrevDepenseNonPaye();
String etat = "PrevDepenseNonPaye";
e.setNomTable(etat);
String listeCrt[] = {"id","daty","montant","description"};
String listeInt[] = {"daty"};
String libEntete[]={"id","daty","montant","description"};

PageRecherche pr=new PageRecherche(e,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("prevision/listePrevisionNonPaye.jsp");
String[]colSomme=null;
pr.creerObjetPage(libEntete,colSomme);
%>
<h1>Liste des pr&eacute;visions d&eacute;pense &agrave; viser</h1>
<form action="<%=pr.getLien()%>?but=prevision/listePrevisionDepAViser.jsp" method="post" name="listePrevisionDepAViser" id="listePrevisionDepAViser">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[] = {pr.getLien()+"?but=prevision/fichePrevisionDepenseAViser.jsp"};
String colonneLien[] = {"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>
