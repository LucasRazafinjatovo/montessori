<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>


<%
DemandeDevis e=new DemandeDevis();

e.setNomTable("demandedevis");

String listeCrt[]={"idDevis","idCodeRV","idArticle","designation","margeBenefice","nbExemplaireA3","remise","dateDevis"};
String listeInt[]=null;
String libEntete[]={"idDevis","idCodeRV","idArticle","designation","remise","dateDevis"};
PageRecherche pr=new PageRecherche(e,request,listeCrt,listeInt,3,libEntete,8);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("activa/listedemandedevis.jsp");

affichage.Champ[] liste=new affichage.Champ[1];

CodeRV c=new CodeRV();
c.setNomTable("coderv");
liste[0]=new Liste("idCodeRV",c,"val","idcoderv");
pr.getFormu().changerEnChamp(liste);
pr.preparerDataFormu();
pr.getFormu().getChamp("idArticle").setPageAppel("listeArticleChoix.jsp");
String[]colSomme=null;
pr.creerObjetPage(libEntete,colSomme);
%>
<h1>Liste des demandes devis</h1>
<form action="<%=pr.getLien()%>?but=activa/listedemandedevis.jsp" method="post" name="demandedevis" id="demandedevis">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=activa/fichedemandedevis.jsp"};
String colonneLien[]={"idDevis"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>

