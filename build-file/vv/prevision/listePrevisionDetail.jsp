<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="prevision.*" %>
<%

EtatPrevGroupeeLC e = new EtatPrevGroupeeLC();
String etat = "PrevisionDepense";
e.setNomTable(etat);
String listeCrt[] = {"id","daty","mois","annee","description"};
String listeInt[] = {"daty","mois"};
String libEntete[] = {"id","daty","description","montant","idor"};

PageRecherche pr = new PageRecherche(e,request,listeCrt,listeInt,2,libEntete,5);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("prevision/listePrevisionDetail.jsp");
String[]colSomme = {"montant"};
affichage.Champ[] liste=new affichage.Champ[2];
liste[0]=new Liste("mois1");
((Liste)(liste[0])).makeListeMois();
liste[1]=new Liste("mois2");
((Liste)(liste[1])).makeListeMois();
pr.getFormu().getChamp("annee").setDefaut(String.valueOf(Utilitaire.getAneeEnCours()));
pr.getFormu().changerEnChamp(liste);
pr.setNpp(300);
pr.creerObjetPage(libEntete,colSomme);
%>
<h1>Liste pr&eacute;visions d&eacute;penses</h1>
<form action="<%=pr.getLien()%>?but=prevision/listePrevisionDetail.jsp" method="post" name="listePrevisionDetail" id="listePrevisionDetail">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[] = {pr.getLien()+"?but=prevision/fichePrevisionDetail.jsp",pr.getLien()+"?but=lc/visualiserDetailLC.jsp",pr.getLien()+"?but=ded/visualiserOP.jsp"};
String colonneLien[] = {"id","idligne","idor"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>
