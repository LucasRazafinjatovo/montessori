<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="prevision.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<link href="../style/style.css" rel="stylesheet" type="text/css">
<%!
AnalysePrevisionGroupe p;
%>
<%
p=new AnalysePrevisionGroupe();
p.setNomTable("ANALYSEPREVISIONEFFECTIFGROUPE");
String listeCrt[] = {"daty","mois","semaine","annee"};
String listeInt[] = {"daty","mois","semaine"};

String colDefaut[]={"daty","mois","annee","semaine"};
String somDefaut[]={"rec_prev","rec_eff","ecart_rec","dep_prev","dep_eff","ecart_dep"};
PageRechercheGroupe pr = new PageRechercheGroupe(p,request,listeCrt,listeInt,2,colDefaut,somDefaut,4,6);

pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("groupeAnalysePrevision.jsp");
affichage.Champ[] liste=new affichage.Champ[2];
liste[0]=new Liste("mois1");
((Liste)(liste[0])).makeListeMois();
liste[1]=new Liste("mois2");
((Liste)(liste[1])).makeListeMois();
pr.getFormu().getChamp("annee").setDefaut(String.valueOf(Utilitaire.getAneeEnCours()));
pr.getFormu().changerEnChamp(liste);
pr.setNpp(400);
pr.creerObjetPage();
%>
<h1>Grouper analyse pr&eacute;vision</h1>
<form action="groupeAnalysePrevision.jsp" method="post" name="groupePrev" id="groupePrev">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>



</form>
<%
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>

