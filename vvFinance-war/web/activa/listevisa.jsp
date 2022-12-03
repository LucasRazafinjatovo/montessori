<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>


<%
VisaDevis e=new VisaDevis();

e.setNomTable("visadevis");

String listeCrt[]={"idVisa","idDevis","dateVisa","remarque","login"};
String listeInt[]=null;
String libEntete[]={"idVisa","idDevis","dateVisa","remarque","login"};
PageRecherche pr=new PageRecherche(e,request,listeCrt,listeInt,3,libEntete,5);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("activa/listevisa.jsp");

//affichage.Champ[] liste=new affichage.Champ[1];
//pr.getFormu().getChamp("idDevis").setPageAppel("listeDemandeDevisLibelleVisaChoix.jsp");
//pr.getFormu().changerEnChamp(liste);
String[]colSomme=null;
pr.creerObjetPage(libEntete,colSomme);
%>
<h1>Liste des demandes devis</h1>
<form action="<%=pr.getLien()%>?but=artiva/listevisa.jsp" method="post" name="visa" id="visa">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=activa/listevisa.jsp"};
String colonneLien[]={"idVisa"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>

