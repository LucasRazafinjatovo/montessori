<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>

<%
Vendeur ven=new Vendeur();
ven.setNomTable("Vendeurlib");
String listeCrt[]={"id","type","idplace","nom","nummatricule","surnom","dateembauche","etat","datesortie"};
String listeInt[]={"dateembauche"};
PageRecherche pr=new PageRecherche(ven,request,listeCrt,listeInt,3);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("ventegazety/listeVendeur.jsp");
affichage.Champ[] liste=new affichage.Champ[3];
TypeObjet to=new TypeObjet();
to.setNomTable("typevendeur");
liste[0]=new Liste("type",to,"val","val");
TypeObjet pl= new TypeObjet();
pl.setNomTable("place");
liste[1]=new Liste("idplace",pl,"val","val");
EtatVendeur ev=new EtatVendeur();
ev.setNomTable("etatvendeur");
liste[2]=new Liste("etat",ev,"val","id");
pr.getFormu().changerEnChamp(liste);
String libEntete[]={"id","type","idplace","nom","nummatricule","surnom","taux","dateembauche","datesortie"};
String colSomme[]=null;
pr.setNpp(100);
pr.creerObjetPage(libEntete,colSomme);
pr.preparerDataFormu();%>

<h1>Liste des vendeurs</h1>
<form action="<%=pr.getLien()%>?but=ventegazety/listeVendeur.jsp" method="post" name="listeVendeur" id="listeVendeur">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=ventegazety/ficheVendeur.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>
