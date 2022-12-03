<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>
<%@ page import="pub.*" %>

<%
Suiviventelib sv=new Suiviventelib();
String listeCrt[]={"numparution","nom","journal","nbreprise","somme"};
String listeInt[]={"numparution"};
PageRecherche pr=new PageRecherche(sv,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("ventegazety/suivivente.jsp");
affichage.Champ[] liste=new affichage.Champ[2];
Publication p=new Publication();
liste[0]=new Liste("journal",p,"journal");
Vendeur ve=new Vendeur();
liste[1]=new Liste("nom",ve,"nom");
pr.getFormu().changerEnChamp(liste);
String libEntete[]={"id","nom","numparution","journal","nbreprise","somme"};
String libAffiche[]={"id","nom","numparution","journal","nbreprise","somme"};
String colSomme[]=null;
pr.creerObjetPage(libEntete,colSomme);
pr.getTableau().setLibelleAffiche(libAffiche);
pr.preparerDataFormu();%>
<h1>Suivi vente Journal</h1>
<form action="<%=pr.getLien()%>?but=ventegazety/suivivente.jsp" method="post" name="suivivente" id="suivivente">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=ventegazety/suivivente.jsp"};
String colonneLien[]={"somme"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>
