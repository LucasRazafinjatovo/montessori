<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>
<%@ page import="crieur.*" %>

<%
Prisecrieurlib rv=new Prisecrieurlib();
rv.setNomTable("prisecrieurlib");
String listeCrt[]={"grossiste","vendeur","matricule","idPlace","province","journal","type","idplace","numParution","daty","titre"};
String listeInt[]={"daty","numParution"};
String libEntete[]={"id","vendeur","matricule","type","idplace","journal","numParution","nbrePrise","prix","titre"};
PageRecherche pr=new PageRecherche(rv,request,listeCrt,listeInt,2,libEntete,9);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("crieur/listePrise.jsp");
affichage.Champ[] liste=new affichage.Champ[2];
Vendeur ve=new Vendeur();
liste[0]=new Liste("vendeur",ve,"surnom","surnom");
Grossiste g = new Grossiste();
liste[1]=new Liste("grossiste",g,"surnom","surnom");
pr.getFormu().changerEnChamp(liste);
//String libAffiche[]={"id","nom","daty","journal","somme","type"};
String colSomme[]={"nbrePrise"};

pr.creerObjetPage(libEntete,colSomme);
//pr.preparerDataFormu();
%>
<h1>Liste des prises</h1>
<form action="<%=pr.getLien()%>?but=crieur/listePrise.jsp" method="post" name="rechercheVente" id="rechercheVente">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=crieur/fichePrise.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>
