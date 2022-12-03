<%@page import="pub.PubPlageHoraire"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.Direction" %>
<%@ page import="affichage.*" %>
<%@ page import="actualite.*" %>

<%
try{
PubPlageHoraire p=new PubPlageHoraire();
String listeCrt[]={"id","designation","numero","heure_debut","heure_fin"};
String listeInt[]={"heure_debut","heure_fin"};
PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)request.getSession().getAttribute("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("pub/pubPlagehoraire-liste.jsp");
pr.getFormu().getChamp("designation").setLibelle("Designation");
pr.getFormu().getChamp("numero").setLibelle("Numero");
pr.getFormu().getChamp("heure_debut1").setLibelle("Heure debut Min");
pr.getFormu().getChamp("heure_debut2").setLibelle("Heure debut Max");
pr.getFormu().getChamp("heure_fin1").setLibelle("Heure fin Min");
pr.getFormu().getChamp("heure_fin2").setLibelle("Heure fin Max");
String libEntete[]={"id","designation","numero","heure_debut","heure_fin"};
String[]colSomme=null;
pr.creerObjetPage(libEntete,colSomme);
%>
<h1>Liste des Plages horaire</h1>
<form action="<%=pr.getLien()%>?but=pub/pubPlagehoraire-liste.jsp" method="post" name="listeplagehoraire" id="listeplagehoraire">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=pub/pubPlagehoraire-fiche.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
}
catch(Exception e){
  e.printStackTrace();
  %>
   <script language="JavaScript"> alert('<%=e.getMessage()%>');history.back(); </script>
  <%
  return;
}
%>
