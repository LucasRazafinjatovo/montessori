<%@page import="user.*"%>
<%@page import="bean.*"%>
<%@page import="utilitaire.*"%>
<%@page import="affichage.*"%>
<%@page import="commercial.PersRespSociete"%>
<link href="style/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function getChoix(){
  setTimeout("document.frmchx.submit()",800);
}
</script>
<%
    String champReturn = request.getParameter("champReturn");
    PersRespSociete e = new PersRespSociete();
    e.setNomTable("PERSRESPSOCIETELIBELLE");

    String listeCrt[]={"id","nom","societe"};
    String listeInt[]=null;
    String libEntete[]={"id", "dateapplication",  "nom", "societe", "contact", "observation"};
    PageRecherche pr = new PageRecherche(e, request, listeCrt, listeInt, 3, libEntete, 6);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("commercial/liste-pers-ste.jsp");

	
	
    pr.getFormu().getChamp("id").setLibelleAffiche("ID");
    pr.getFormu().getChamp("nom").setLibelleAffiche("Nom");
    pr.getFormu().getChamp("societe").setLibelleAffiche("Societe");

    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
    <h1>Liste contact societe</h1>
    <form action="<%=pr.getLien()%>?but=commercial/liste-pers-ste.jsp" method="post" name="personneliste" id="personneliste">
		<% out.println(pr.getFormu().getHtmlEnsemble());%>
	</form>
	<%
		String libelles[]= {"ID", "Date d'application",  "Responsable", "Societe", "Contact", "Observation"};
		pr.getTableau().setLibelleAffiche(libelles);
		out.println(pr.getTableauRecap().getHtml());
	%>
	
	<% out.println(pr.getTableau().getHtml()); %>
	<% out.println(pr.getBasPage());%>
