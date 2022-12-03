<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="lc.*" %>
<%!
Difflcgroupe p;
%>
<%
p=new Difflcgroupe();
String etat="DIFFLCGROUPE";
p.setNomTable(etat);
String listeCrt[]={"entite","idDirection","annee","mois"};
String listeInt[]={"mois"};

String colDefaut[]={"entite","annee"};
String somDefaut[]={"facrec","facdep","facreste","engrec","engdep","engreste"};
PageRechercheGroupe pr=new PageRechercheGroupe(p,request,listeCrt,listeInt,2,colDefaut,somDefaut,4,4);

pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien("");
pr.setApres("listeFCCSynthese.jsp");
affichage.Champ[] liste=new affichage.Champ[3];
Direction to=new Direction();
to.setNomTable("direction");
liste[0]=new Liste("idDirection",to,"libelledir","libelledir");
liste[1]=new Liste("mois1");
((Liste)(liste[1])).makeListeMois();
liste[2]=new Liste("mois2");
((Liste)(liste[2])).makeListeMois();

((Liste)(pr.getFormu().getChamp("colonne"))).setDefaultSelected("facrec");
pr.getFormu().changerEnChamp(liste);
pr.getFormu().getChamp("annee").setDefaut(String.valueOf(Utilitaire.getAneeEnCours()));
pr.creerObjetPage();

%>
<link href="../style/style.css" rel="stylesheet" type="text/css">
<h1>Etat de synthese FCC</h1>
<form action="listeFCCSynthese.jsp" method="post" name="listePub" id="listePub">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=pub/listeFCC.jsp"+pr.getFormu().getListeCritereString() ,pr.getLien()+"?but=pub/listePub.jsp"+pr.getFormu().getListeCritereString()};
String colonneLien[]=pr.getColGroupe();
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>
