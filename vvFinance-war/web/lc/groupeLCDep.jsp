<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="affichage.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.*" %>
<%@ page import="lc.Direction" %>

<%
LigneCreditCompletCompte p = new LigneCreditCompletCompte();
p.setNomTable("LIGNECREDITCOMPLETCOMPTE");

String listeCrt[]={"designation","idLigne","mois","annee","libelledir","typeLC","entite","parution","creditInitial","montantEng","montantVis","montantFac","numcompte"};
String listeInt[]={"mois","parution","creditInitial","montantEng","montantVis","montantFac"};

String colDefaut[]={"idLigne","designation","typeLC","numcompte", "libelledir"};
String somDefaut[]={"creditInitial","montantEng","montantVis","montantFac"};
PageRechercheGroupe pr=new PageRechercheGroupe(p,request,listeCrt,listeInt,2,colDefaut,somDefaut,5,4);


pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("lc/groupeLCDep.jsp");
affichage.Champ[] liste=new affichage.Champ[5];
liste[0]=new Liste("mois1");
((Liste)(liste[0])).makeListeMois();
liste[1]=new Liste("mois2");
((Liste)(liste[1])).makeListeMois();
TypeObjet to1=new TypeObjet();
to1.setNomTable("beneficiaire");
liste[2]=new Liste("entite",to1,"val","val", true);
Direction to2=new Direction();
to2.setNomTable("direction");
liste[3]=new Liste("libelledir",to2,"libelledir","libelledir");
TypeObjet to3=new TypeObjet();
to3.setNomTable("typesortie");
liste[4]=new Liste("typeLC",to3,"val","val");

pr.getFormu().changerEnChamp(liste);
pr.getFormu().getChamp("annee").setDefaut(String.valueOf(Utilitaire.getAneeEnCours()));
pr.setNpp(100);
pr.creerObjetPageMultiple();


%>
<h1>Grouper LC Depense</h1>
<form action="<%=pr.getLien()%>?but=lc/groupeLCDep.jsp" method="post" name="listelc" id="listelc">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=lc/visualiserDetailLCRecette.jsp"+pr.getFormu().getListeCritereString() ,pr.getLien()+"?but=finance/listeMvtCaisse.jsp"+pr.getFormu().getListeCritereString() ,pr.getLien()+"?but=ded/listeOR.jsp"+pr.getFormu().getListeCritereString(),pr.getLien()+"?but=facturefournisseur/critereEntreFactureOr.jsp"+pr.getFormu().getListeCritereString()};
String colonneLien[]={"idLigne","montantEng","montantVis","montantFac"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>
