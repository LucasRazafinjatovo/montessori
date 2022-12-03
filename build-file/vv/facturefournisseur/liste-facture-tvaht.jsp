<%@page import="user.*"%>
<%@page import="bean.*"%>
<%@page import="utilitaire.*"%>
<%@page import="affichage.*"%>
<%@page import="facture.FactureClientTVAHT"%>
<link href="style/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function getChoix(){
  setTimeout("document.frmchx.submit()",800);
}
</script>
<%
    String champReturn = request.getParameter("champReturn");
    FactureClientTVAHT e = new FactureClientTVAHT();
    e.setNomTable("FACTUREFOURNISSEURTVAHT");

	
	
    String listeCrt[] = {"idfacturefournisseur","idfournisseur","daty","designation","resp"};
    String listeInt[] = {"daty"};
    String libEntete[]={"idfacturefournisseur","idfournisseur","daty","idtva","montantht","montantttc","designation","resp"};
    PageRecherche pr  = new PageRecherche(e, request, listeCrt, listeInt, 3, libEntete, 8);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("facturefournisseur/liste-facture-tvaht.jsp");

	
	
    pr.getFormu().getChamp("idfacturefournisseur").setLibelleAffiche("ID");
    pr.getFormu().getChamp("idfournisseur").setLibelleAffiche("Fournisseur");
    pr.getFormu().getChamp("designation").setLibelleAffiche("Designation");
    pr.getFormu().getChamp("resp").setLibelleAffiche("Responsable");

    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
    <h1>Liste facture fournisseur</h1>
    <form action="<%=pr.getLien()%>?but=facturefournisseur/liste-facture-tvaht.jsp" method="post" name="personneliste" id="personneliste">
		<% out.println(pr.getFormu().getHtmlEnsemble());%>
	</form>
	<%
		String libelles[]= {"ID","Fournisseur","Date","TVA","Montant HT","Montant ttc","Designation","Responsable"};
		pr.getTableau().setLibelleAffiche(libelles);
		out.println(pr.getTableauRecap().getHtml());
	%>
	
	<% out.println(pr.getTableau().getHtml()); %>
	<% out.println(pr.getBasPage());%>
