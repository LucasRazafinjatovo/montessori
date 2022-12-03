<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>

<%
VisaDevisLibelle e=new VisaDevisLibelle();

e.setNomTable("demandevisa");

String listeCrt[]={"idVisa","nomclient","coderv","article","designation","nombreImpression","remise","dateDevis"};
String listeInt[]=null;
String libEntete[]={"idVisa","remarque","nomclient","coderv","article","designation","nombreImpression","remise","dateDevis"};
PageRecherche pr=new PageRecherche(e,request,listeCrt,listeInt,3,libEntete,8);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("activa/listevisalibelle.jsp");

//affichage.Champ[] liste=new affichage.Champ[1];
//pr.getFormu().getChamp("idDevis").setPageAppel("listeDemandeDevisChoix.jsp");
//pr.getFormu().changerEnChamp(liste);
String[]colSomme=null;
pr.creerObjetPage(libEntete,colSomme);
%>
<h1>Liste des visa</h1>
<form action="<%=pr.getLien()%>?but=artiva/listevisalibelle.jsp" method="post" name="visa" id="visa">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=activa/fichevisa.jsp"};
String colonneLien[]={"idVisa"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>

