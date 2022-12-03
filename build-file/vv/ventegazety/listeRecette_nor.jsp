<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>
<%@ page import="pub.*" %>
<%
RecetteLibelleType rv=new RecetteLibelleType();
String etat="RecetteLibellenonfacture";
if(request.getParameter("etat")!=null && request.getParameter("etat").compareToIgnoreCase("")!=0)
  etat=request.getParameter("etat");
rv.setNomTable(etat);
String listeCrt[]={"id","nom","matricule","place","province","numParution","daty","montant","journal","type"};
String listeInt[]={"daty","numParution","montant"};
String libEntete[]={"id","daty","nom","matricule","journal","numParution","daty","montant"};
PageRecherche pr=new PageRecherche(rv,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("ventegazety/listeRecette_nor.jsp");
affichage.Champ[] liste=new affichage.Champ[1];
Vendeur ve=new Vendeur();
liste[0]=new Liste("nom",ve,"surnom","surnom");
pr.getFormu().changerEnChamp(liste);
//String libAffiche[]={"id","nom","daty","journal","somme","type"};
String colSomme[]={"montant"};

pr.creerObjetPage(libEntete,colSomme);
%>
<h1>Liste des recettes non attach&eacute;</h1>
<form action="<%=pr.getLien()%>?but=ventegazety/listeRecette_nor.jsp" method="post" name="rechercheVente" id="rechercheVente">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
pr.setApresLienPage("&etat="+etat);
String lienTableau[]={pr.getLien()+"?but=ventegazety/ficheRecette.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());
%>
<br/><br/>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>