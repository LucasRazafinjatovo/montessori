<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>

<%
EtatLivraisonProduction e=new EtatLivraisonProduction();

e.setNomTable("etatlivraisonproduction");

String listeCrt[]={"idProduction","nomclient","article","coderv","designation","quantiteLivre","quantiteRestant"};
String listeInt[]=null;
String libEntete[]={"idProduction","nomclient","article","coderv","quantiteLivre","quantiteRestant"};
PageRecherche pr=new PageRecherche(e,request,listeCrt,listeInt,2,libEntete,6);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("activa/listeEtat.jsp");
//pr.getFormu().getChamp("iddevis").setPageAppel("listeDemandeDevisChoix.jsp");
String[]colSomme=null;
pr.creerObjetPage(libEntete,colSomme);
%>
<h1>Liste des etats livraisons</h1>
<form action="<%=pr.getLien()%>?but=activa/listeEtat.jsp" method="post" name="etat" id="etat">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=activa/ficheproduction.jsp"};
String colonneLien[]={"idProduction"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>