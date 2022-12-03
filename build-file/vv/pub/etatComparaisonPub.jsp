<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="pub.*" %>

<%
EtatComparaisonPub p = new EtatComparaisonPub();
p.setNomTable("EtatComparaisonPub");
String listeCrt[]={"daty","journal","format","couleur"};
String listeInt[]={"daty"};
PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("pub/etatComparaisonPub.jsp");
String libEntete[]={"Daty","Journal","Format","Couleur","Nbsaisie","Nbverifie","Nbpublie","Diffverif","Diffpublie"};


String colSomme[]={"Nbsaisie","Nbverifie","Nbpublie","Diffverif","Diffpublie"};
pr.creerObjetPage(libEntete,colSomme);%>
<h1>Liste des parametres</h1>
<form action="<%=pr.getLien()%>?but=pub/etatComparaisonPub.jsp" method="post" name="listePub" id="listePub">
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
