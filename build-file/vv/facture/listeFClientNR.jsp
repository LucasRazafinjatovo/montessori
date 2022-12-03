<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="facturefournisseur.*" %>

<%
try{
FactureFournisseur p = new FactureFournisseur();
p.setNomTable("FACTURECLIENTLIBELLE");
String listeCrt[] = {"idFactureFournisseur", "daty", "remarque", "designation", "resp"};
String listeInt[] = {"daty"};
String libEntete[] = {"idFactureFournisseur", "daty", "idFournisseur", "numFact", "montantTTC", "idDevise", "designation", "resp"};
PageRecherche pr = new PageRecherche(p,request,listeCrt,listeInt,3,libEntete,8);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("facture/listeFClientNR.jsp");


String colSomme[] = null;

pr.creerObjetPage(libEntete,colSomme);%>
<h1>Liste facture client à  attachées</h1>
<form action="<%=pr.getLien()%>?but=facture/listeFClientNR.jsp" method="post" name="listerpub" id="listerpub">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[] = null;
String colonneLien[] = null;
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());
%>
<%

out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
}catch(Exception ex){
  ex.printStackTrace();
}
%>



