<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="compte.*" %>
<%

CompteG c=new CompteG();
String listeCrt[]={"id","val","desce","datyDebutValid"};
String listeInt[]=null;
String libEntete[]={"id","val","desce","datyDebutValid"};

PageRecherche pr=new PageRecherche(c,request,listeCrt,listeInt,2,libEntete,4);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("compte/listeCompteG.jsp");


%>

<h1>Liste CompteG</h1>
<form action="<%=pr.getLien()%>?but=compte/listeCompteG.jsp" method="post" name="listecompteg" id="listecompteg">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>

<%
String lienTableau[]={pr.getLien()+"?but=compte/ficheCompteG.jsp"};
String colonneLien[]={"id"};
String[]colSomme=null;
pr.creerObjetPage(libEntete,colSomme);
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>
