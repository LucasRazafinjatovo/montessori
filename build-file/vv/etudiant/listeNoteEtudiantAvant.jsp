<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="etudiant.*" %>
<%

NoteEtudiantAvant e=new NoteEtudiantAvant();

e.setNomTable("noteetudiantavantlib");
String listeCrt[]={"typeNoteAvant","valeur","matiereavant","etudiant","mention"};
String listeInt[]=null;
PageRecherche pr=new PageRecherche(e,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("etudiant/listeNoteEtudiantAvant.jsp");
affichage.Champ[] liste=new affichage.Champ[3];
TypeObjet typenoteavant=new TypeObjet();
typenoteavant.setNomTable("typenoteavant");
liste[0]=new Liste("typeNoteAvant",typenoteavant,"val","id");
TypeObjet matiere=new TypeObjet();
matiere.setNomTable("matiereavant");
liste[1]=new Liste("matiereavant",matiere,"val","id");
TypeObjet mention=new TypeObjet();
mention.setNomTable("mention");
liste[2]=new Liste("mention",mention,"val","id");
pr.getFormu().changerEnChamp(liste);
pr.getFormu().getChamp("etudiant").setPageAppel("listeChoixEtudiant.jsp");
String libEntete[]={"id","typeNoteAvant","valeur","matiereavant","etudiant","mention"};
String[]colSomme=null;
pr.creerObjetPage(libEntete,colSomme);
%>
<h1>Liste des notes ant&eacute;rieurs</h1>
<form action="<%=pr.getLien()%>?but=etudiant/listeNoteEtudiantAvant.jsp" method="post" name="listenoteetudiantavant" id="listenoteetudiantavant">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=etudiant/ficheNoteEtudiantAvant.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>
