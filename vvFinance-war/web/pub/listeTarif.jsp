<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="pub.*" %>

<%
Montant p=new Montant();
String etat="montantlibelle";
p.setNomTable(etat);
String listeCrt[]={"idgazety","taille"};
PageRecherche pr=new PageRecherche(p,request,listeCrt,null,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("pub/listeTarif.jsp");
String libEntete[]={"id","idGazety","couleur","taille","mont","page"};
//String colSomme[]={"montantVal"};
String[]colSomme=null;
pr.creerObjetPage(libEntete,colSomme);
%>
<h1>Liste des tarifs</h1>
<form action="<%=pr.getLien()%>?but=pub/listeTarif.jsp" method="post" name="listeParution" id="listeParution">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
  String lienTableau[]={pr.getLien()+"?but=pub/ficheTarif.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>
