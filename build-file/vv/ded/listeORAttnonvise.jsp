<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="lc.Direction" %>
<%@ page import="ded.OrdonnerPayement" %>
<%
UserEJB u = null;
u=(user.UserEJB)session.getValue("u");
OrdonnerPayement p=new OrdonnerPayement();
p.setNomTable("ORNONVISEATTACHER");
String listeCrt[]={"ID", "DED_ID", "IDLIGNE", "DATY", "MONTANT", "REMARQUE"};
String listeInt[]={"daty","montant"};
String libEntete[]={"ID", "DED_ID", "IDLIGNE", "DATY", "MONTANT", "REMARQUE"};
PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,2,libEntete,6);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("ded/listeORAttnonvise.jsp");
affichage.Champ[] liste=new affichage.Champ[1];

TypeObjet to1=new TypeObjet();
to1.setNomTable("agence");
liste[0]=new Liste("IDLIGNE",to1,"val","val");


pr.getFormu().changerEnChamp(liste);
String colSomme[]={"montant"};
pr.creerObjetPageMultiple(libEntete,colSomme);

%>
<h1>Liste des OR attache non visée</h1>
<form action="<%=pr.getLien()%>?but=ded/listeORAttnonvise.jsp" method="post" name="listePub" id="listePub">
<%
out.println(pr.getFormu().getHtmlEnsemble());
%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=ded/visualiserOR.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
  out.println(pr.getTableau().getHtml());
	out.println(pr.getBasPage());%>
