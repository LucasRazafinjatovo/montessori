<%@page import="pub.PubTarif"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.Direction" %>
<%@ page import="affichage.*" %>
<%@ page import="actualite.*" %>

<%
try{
PubTarif p=new PubTarif();
p.setNomTable("PUB_TARIF_LIBELLE");
String listeCrt[]={"id","idtype","id_plage_horaire","durees","montant","date_effective"};
String listeInt[]={"montant","date_effective"};
PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)request.getSession().getAttribute("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("pub/pubTarif-liste.jsp");
pr.getFormu().getChamp("idtype").setLibelle("Type");
pr.getFormu().getChamp("id_plage_horaire").setLibelle("Plage horaire");
pr.getFormu().getChamp("montant1").setLibelle("Montant Min");
pr.getFormu().getChamp("montant2").setLibelle("Montant Max");
pr.getFormu().getChamp("date_effective1").setLibelle("Date Effective Min");
pr.getFormu().getChamp("date_effective2").setLibelle("Date Effective Max");
String libEntete[]={"id","idtype","id_plage_horaire","durees","montant","date_effective"};
String[]colSomme=null;
pr.creerObjetPage(libEntete,colSomme);
%>
<h1>Liste Tarif pub</h1>
<form action="<%=pr.getLien()%>?but=pub/pubTarif-liste.jsp" method="post" name="listeTarif" id="listeTarif">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=pub/pubTarif-fiche.jsp"};
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
