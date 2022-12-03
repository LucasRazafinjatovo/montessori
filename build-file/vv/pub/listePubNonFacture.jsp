<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="pub.*" %>

<%
Pucomplet p=new Pucomplet();
p.setNomTable("pubnonfacture");
String listeCrt[]={"id","libClient","idCat","idAgence","designation","numParution","pagemisyazy","formulaire","libJournal"};
String listeInt[]={"pagemisyazy","formulaire"};
PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("pub/listePub.jsp");
affichage.Champ[] liste=new affichage.Champ[1];
TypeObjet to=new TypeObjet();
to.setNomTable("categoriePub");
liste[0]=new Liste("idCat",to);
pr.getFormu().changerEnChamp(liste);
String libEntete[]={"id","libClient","numParution","datyParution","montantVal","libAgence"};
String colSomme[]={"montantVal"};
pr.creerObjetPage(libEntete,colSomme);%>
<h1>Liste des pubicites</h1>
<form action="<%=pr.getLien()%>?but=pub/listePubNonFacture.jsp" method="post" name="listePub" id="listePub">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
  String lienTableau[]={pr.getLien()+"?but=pub/fichePub.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>
