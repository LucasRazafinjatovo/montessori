<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="etudiant.*" %>

<%

Ecole e=new Ecole();
e.setNomTable("ECOLELIB");
String listeCrt[]={"nom","typeecole","lieu","remarque"};
String listeInt[]=null;

PageRecherche pr=new PageRecherche(e,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("etudiant/listeEcole.jsp");

affichage.Champ[] liste=new affichage.Champ[1];
TypeObjet typeecole=new TypeObjet();
typeecole.setNomTable("typeecole");
liste[0]=new Liste("typeecole",typeecole,"val","val");
pr.getFormu().changerEnChamp(liste);
String libEntete[]={"id","nom","typeecole","lieu","remarque"};
String[]colSomme=null;
pr.creerObjetPage(libEntete,colSomme);
%>

<h1>Liste des &eacute;coles</h1>
<form action="<%=pr.getLien()%>?but=etudiant/listeEcole.jsp" method="post" name="listeecole" id="listeecole">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>

<%
String lienTableau[]={pr.getLien()+"?but=etudiant/ficheEcole.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>
