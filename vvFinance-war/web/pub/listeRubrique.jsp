<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="pub.*" %>

<%

RubriqueLibelle p=new RubriqueLibelle();
String listeCrt[]={"desce","libelle","datyoperation"};
String listeInt[]=null;
PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("pub/listeRubrique.jsp");

pr.getFormu().getChamp("datyoperation").setLibelle("Date de l'opération");
pr.getFormu().getChamp("desce").setLibelle("Journal");

affichage.Champ[] liste=new affichage.Champ[1];
TypeObjet to=new TypeObjet();

to.setNomTable("journal");
liste[0]=new Liste("desce",to,"desce","desce");
//((Liste)(liste[0])).setColValeur("val");
/*Rubrique rub=new Rubrique();
rub.setNomTable("rubrique");
liste[1]=new Liste("rubrique",rub,"libelle","libelle");
*/

String libEntete[]={"id","desce","libelle","datyoperation"};
String colSomme[]=null;
pr.getFormu().changerEnChamp(liste);

//pr.getFormu().getChamp("daty1").setDefaut(Utilitaire.dateDuJour());
pr.creerObjetPage(libEntete,colSomme);%>
<h1>Liste des rubriques</h1>
<form action="<%=pr.getLien()%>?but=pub/listeRubrique.jsp" method="post" name="listerrubriquelibelle" id="listerrubriquelibelle">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=pub/ficheRubrique.jsp"};
String enteteTableau[]={"Identifiant", "Journal","Libelle","Date de l'opération"};
pr.getTableau().setLibelleAffiche(enteteTableau);
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
%>


<%
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%

out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>
