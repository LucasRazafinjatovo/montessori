<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>

<%
EtatBenefice e=new EtatBenefice();

e.setNomTable("etatbeneficerecto");

String listeCrt[]={"idDevis","idProduction","coderv","idcmd","nombreimpression","perte"};
String listeInt[]=null;
String libEntete[]={"idProduction","nombreimpression","coderv","perte","beneficeTheorique","beneficePratique"};
//String libEntete[]={"idProduction"};
PageRecherche pr=new PageRecherche(e,request,listeCrt,listeInt,3,libEntete,6);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("activa/listeetatbeneficerecto.jsp");
//pr.getFormu().getChamp("iddevis").setPageAppel("listeDemandeDevisChoix.jsp");
String[]colSomme=null;
pr.creerObjetPage(libEntete,colSomme);
%>
<h1>Liste des etats benefices</h1>
<form action="<%=pr.getLien()%>?but=activa/listeetatbenefice.jsp" method="post" name="etat" id="etat">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=activa/ficheproduction.jsp"};
String colonneLien[]={"idProduction"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>