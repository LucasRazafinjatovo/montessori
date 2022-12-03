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
    String libEntete[]={"id","nom", "categorie", "adresse", "telephone", "mail"};
    PageRecherche pr = new PageRecherche(e, request, listeCrt, listeInt, 3, libEntete, 6);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("listeSocieteChoix.jsp");


    pr.getFormu().getChamp("id").setLibelleAffiche("ID");
    pr.getFormu().getChamp("nom").setLibelleAffiche("Nom");

    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
	SocieteCommercial []listeP=(SocieteCommercial [])pr.getRs().getResultat();//liste
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
	
	<form action="apresEtudiantChoix.jsp" method="post" name="frmchx" id="frmchx">
		<input type="hidden" name="champReturn" value="<%=champReturn%>">
		<p align="center"><strong><u>LISTE</u></strong></p>
		<div id="divchck">
			<table width="100%" border="0" align="center" cellpadding="3" cellspacing="3" class="monographe">
				<tbody>
					<tr class="head">
						<td align="center" valign="top"></td>
						<td width="16%" align="center" valign="top">ID</td>
						<td width="16%" align="center" valign="top">Nom</td>
						<td width="16%" align="center" valign="top">Categorie</td>
						<td width="16%" align="center" valign="top">Adresse</td>
						<td width="16%" align="center" valign="top">Telephone</td>
						<td width="16%" align="center" valign="top">Mail</td>
					</tr>
					<%for(int i = 0; i < listeP.length; i++){%>
					<tr onmouseover="this.style.backgroundColor='#EAEAEA'" onmouseout="this.style.backgroundColor=''">
						<td align="center">
						<input type="radio" value="<%=listeP[i].getId()%>" name="choix" id="choix" class="radio" onmousedown="getChoix()"></td>
						<td width="16%" align="center"><%=listeP[i].getId()%></td>
						<td width="16%" align="center"><%=listeP[i].getNom()%></td>
						<td width="16%" align="center"><%=listeP[i].getCategorie()%></td>
						<td width="16%" align="center"><%=listeP[i].getAdresse()%></td>
						<td width="16%" align="center"><%=listeP[i].getTelephone()%></td>
						<td width="16%" align="center"><%=listeP[i].getMail()%></td>
					</tr>
					<%}%>
				</tbody>
			</table>
		</div>

	</form>
	<% out.println(pr.getBasPage());%>
