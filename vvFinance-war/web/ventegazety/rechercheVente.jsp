<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>

<%
Etatvente rv=new Etatvente();
String listeCrt[]={"id","vendeur","matricule","place","province","journal","type","numParution","daty","vente","montant","recette","reste"};
String listeInt[]={"daty","numParution","vente","montant","recette","reste"};
String libEntete[]={"id","vendeur","matricule","journal","numParution","nbrePrise","vente","montant","recette","reste"};
PageRecherche pr=new PageRecherche(rv,request,listeCrt,listeInt,2,libEntete,9);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("ventegazety/rechercheVente.jsp");
affichage.Champ[] liste=new affichage.Champ[1];
Vendeur ve=new Vendeur();
liste[0]=new Liste("vendeur",ve,"nom","surnom");
pr.getFormu().changerEnChamp(liste);
//String libAffiche[]={"id","nom","daty","journal","somme","type"};
String colSomme[]={"nbrePrise","vente","montant","recette","reste"};

pr.creerObjetPage(libEntete,colSomme);
pr.preparerDataFormu();%>
<h1>Etat vente Journal</h1>
<form action="<%=pr.getLien()%>?but=ventegazety/rechercheVente.jsp" method="post" name="rechercheVente" id="rechercheVente">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=ventegazety/fichePrise.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>
