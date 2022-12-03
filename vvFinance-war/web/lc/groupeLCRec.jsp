<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="lc.*" %>
<%!
LigneCreditCompletCompte p;
%>
<%
p=new LigneCreditCompletCompte();
p.setNomTable("LIGNECREDITRECETTECOMPLETCPT");
String listeCrt[]={"designation","idLigne","mois","annee","libelledir","typeLC","entite","parution","creditInitial","montantEng","montantVis","montantFac","numcompte"};
String listeInt[]={"mois","parution","creditInitial","montantEng","montantVis","montantFac"};

String colDefaut[]={"idLigne","designation","typeLC","numcompte", "libelledir"};
String somDefaut[]={"creditInitial","montantEng","montantVis","montantFac"};
PageRechercheGroupe pr=new PageRechercheGroupe(p,request,listeCrt,listeInt,2,colDefaut,somDefaut,5,4);

pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("lc/groupeLCRec.jsp");
affichage.Champ[] liste=new affichage.Champ[5];
TypeObjet to=new TypeObjet();
to.setNomTable("typeEntree");
liste[0]=new Liste("typeLC",to,"val","val");
TypeObjet to1=new TypeObjet();
to1.setNomTable("beneficiaire");
liste[1]=new Liste("entite",to1,"val","val", true);
Direction to2=new Direction();
to2.setNomTable("direction");
liste[2]=new Liste("libelledir",to2,"libelledir","libelledir");
liste[3]=new Liste("mois1");
((Liste)(liste[3])).makeListeMois();
liste[4]=new Liste("mois2");
((Liste)(liste[4])).makeListeMois();
pr.getFormu().changerEnChamp(liste);
pr.setNpp(100);
pr.creerObjetPageMultiple();
pr.getFormu().getChamp("annee").setDefaut(String.valueOf(Utilitaire.getAneeEnCours()));
%>
<h1>Grouper LC Recette</h1>
<form action="<%=pr.getLien()%>?but=lc/groupeLCRec.jsp" method="post" name="listePub" id="listePub">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=lc/visualiserDetailLCRecette.jsp"+pr.getFormu().getListeCritereString() ,pr.getLien()+"?but=finance/listeMvtCaisse.jsp&idordre="+pr.getCritere().getTuppleID() ,pr.getLien()+"?but=ded/listeOR.jsp"+pr.getFormu().getListeCritereString(),pr.getLien()+"?but=facturefournisseur/critereEntreFactureOr.jsp"+pr.getFormu().getListeCritereString()};
String colonneLien[]={"idLigne","montantEng","montantVis","montantFac"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>
