<%@page import="user.*"%>
<%@page import="bean.*"%>
<%@page import="utilitaire.*"%>
<%@page import="affichage.*"%>
<%@page import="commercial.SocieteCommercial"%>
<link href="style/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function getChoix(){
  setTimeout("document.frmchx.submit()",800);
}
</script>
<%
    String champReturn = request.getParameter("champReturn");
    SocieteCommercial e = new SocieteCommercial();
    //e.setNomTable("ARTICLE_VUE");

    String listeCrt[]={"id","nom"};
    String listeInt[]=null;
    String libEntete[]={"id", "nom", "categorie", "adresse", "telephone", "mail"};
    PageRecherche pr = new PageRecherche(e, request, listeCrt, listeInt, 3, libEntete, 6);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("listeSocieteChoix.jsp");


    pr.getFormu().getChamp("id").setLibelleAffiche("ID");
    pr.getFormu().getChamp("nom").setLibelleAffiche("Nom");

    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
    <h1>Liste societe</h1>
    <form action="<%=pr.getApres()%>?champReturn=<%=champReturn%>" method="post" name="personneliste" id="personneliste">
		<% out.println(pr.getFormu().getHtmlEnsemble());%>
	</form>
	<%
		String libelles[]= {"ID","Nom", "Categorie", "Adresse", "Telephone", "Mail"};
		pr.getTableau().setLibelleAffiche(libelles);
		out.println(pr.getTableauRecap().getHtml());
	%>
	
	<% out.println(pr.getTableau().getHtml()); %>
	<% out.println(pr.getBasPage());%>
