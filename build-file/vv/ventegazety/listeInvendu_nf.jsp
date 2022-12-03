<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>

<%
InvenduLibelleType rv=new InvenduLibelleType();
String etat="INVENDULIBNONFACTURE";
if(request.getParameter("etat")!=null && request.getParameter("etat").compareToIgnoreCase("")!=0) etat=request.getParameter("etat");
rv.setNomTable(etat);
String listeCrt[]={"id","nom","matricule","place","province","parution","daty","journal","type"};
String listeInt[]={"daty","parution"};
String libEntete[]={"id","nom","matricule","journal","parution","daty","province","nombreinvendu","type"};
PageRecherche pr=new PageRecherche(rv,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("ventegazety/listeInvendu_nf.jsp");
affichage.Champ[] liste=new affichage.Champ[2];
Vendeur ve=new Vendeur();
liste[0]=new Liste("nom",ve,"surnom","surnom");
Journal jou=new Journal();
liste[1]=new Liste("journal",jou,"desce","val");
pr.getFormu().changerEnChamp(liste);
//String libAffiche[]={"id","nom","daty","journal","somme","type"};
String colSomme[]={"nombreinvendu"};

pr.creerObjetPage(libEntete,colSomme);
%>
<h1>Liste des saisies invendus</h1>
<form action="<%=pr.getLien()%>?but=ventegazety/listeInvendu_nf.jsp" method="post" name="rechercheVente" id="rechercheVente">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>

</form>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>
