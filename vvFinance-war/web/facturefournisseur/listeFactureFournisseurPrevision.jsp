<%@ page import="user.*" %>
<%@ page import="facturefournisseur.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="affichage.*" %>
<%!
FactureFournisseurPrevision p;
%>
<%
p=new FactureFournisseurPrevision();
String etat="facturefournisseurprevision";
p.setNomTable(etat);
String listeCrt[]={"daty","idfournisseur","tva","montantttc","iddevise","designation","dateemission","remarque","numfact","resp"};
String listeInt[]=null;
String tabAffDefaut[]={"id","daty","idfournisseur","tva","montantttc","iddevise","designation","numfact"};

PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,3,tabAffDefaut,8);

pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("facturefournisseur/listeFactureFournisseurPrevision.jsp");
affichage.Champ[] liste=new affichage.Champ[1];
TypeObjet act=new TypeObjet();
act.setNomTable("devise");
liste[0]=new Liste("iddevise",act,"val","id");
pr.getFormu().changerEnChamp(liste);
//((Liste)(pr.getFormu().getChamp("mois2"))).setDefaultSelected("12");
pr.getFormu().changerEnChamp(liste);
//pr.getFormu().getChamp("idfournisseur").setPageAppel("ded/choix_tiers.jsp");
//String libEnteteDefaut[]={"idFournisseur","identite","montantttc","opmontant","reste"};
String colSomme[]={"montantttc"};
pr.creerObjetPage(tabAffDefaut,colSomme);
%>
<h1>Liste des factures fournisseurs</h1>
<form action="<%=pr.getLien()%>?but=facturefournisseur/listeFactureFournisseurPrevision.jsp" method="post" name="listePub" id="listePub">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
//pr.setApresLienPage("&etat="+etat);
  String lienTableau[]={pr.getLien()+"?but=facturefournisseur/ficheFactureFournisseurPrevision.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>
