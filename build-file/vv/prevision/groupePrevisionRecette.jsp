<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="prevision.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>

<%!
EtatPrevGroupeeLC p;
%>
<%
p=new EtatPrevGroupeeLC();
p.setNomTable("PREVRECVISELC");
String listeCrt[] = {"daty","description","idligne","identite","iddirection","idtypeligne","mois","annee"};
String listeInt[] = {"daty","mois"};
String colDefaut[]={"id","daty","description","idligne"};
String somDefaut[]={"montant"};
PageRechercheGroupe pr=new PageRechercheGroupe(p,request,listeCrt,listeInt,3,colDefaut,somDefaut,5,1);

pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("prevision/groupePrevisionRecette.jsp");
affichage.Champ[] liste=new affichage.Champ[2];
liste[0]=new Liste("mois1");
((Liste)(liste[0])).makeListeMois();
liste[1]=new Liste("mois2");
((Liste)(liste[1])).makeListeMois();
pr.getFormu().getChamp("annee").setDefaut(String.valueOf(Utilitaire.getAneeEnCours()));
pr.getFormu().changerEnChamp(liste);
pr.setNpp(75);
pr.creerObjetPage();
%>
<h1>Grouper pr&eacute;vision recette</h1>
<form action="<%=pr.getLien()%>?but=prevision/groupePrevisionRecette.jsp" method="post" name="groupePrev" id="groupePrev">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>



</form>
<%
String lienTableau[]={pr.getLien()+"?but=prevision/fichePrevisionRecDetail.jsp"+pr.getFormu().getListeCritereString(),pr.getLien()+"?but=lc/visualiserDetailLCRecette.jsp"+pr.getFormu().getListeCritereString()};
String colonneLien[]={"id","idligne"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>


<script language="javascript">
  var cal1 = new calendar1(document.forms['listeRecette'].elements['dateDebut']);
  cal1.year_scroll = false;
  cal1.time_comp = false;
  var cal2 = new calendar1(document.forms['listeRecette'].elements['dateFin']);
  cal2.year_scroll = false;
  cal2.time_comp = false;

</script>
