<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="quitte.*" %>
<%

QuitteComplet e=new QuitteComplet();

//e.setNomTable("notecomplet");
String listeCrt[]={"daty","motif","categoriemotif","etudiant"};
String listeInt[]=null;
PageRecherche pr=new PageRecherche(e,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("quitte/listeQuitte.jsp");
affichage.Champ[] liste=new affichage.Champ[1];
TypeObjet categorie=new TypeObjet();
categorie.setNomTable("categoriequitte");
//System.out.println("HITANY LE CATEGORIE");
liste[0]=new Liste("categorieMotif",categorie,"val","val");
pr.getFormu().changerEnChamp(liste);
pr.getFormu().getChamp("etudiant").setPageAppel("listeEtudiantChoix2.jsp");

String libEntete[]={"id","daty","motif","categoriemotif","etudiant"};
pr.getFormu().getChamp("daty").setLibelle("Date de quitte");
//pr.getFormu().getChamp("inscription").setLibelle("Date d'inscription");
String[]colSomme=null;
pr.creerObjetPage(libEntete,colSomme);
%>
<h1>Liste quitte</h1>
<form action="<%=pr.getLien()%>?but=quitte/listeQuitte.jsp" method="post" name="listequitte" id="listequitte">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=quitte/ficheQuitte.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>
