<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ded.*" %>
<%

OpLcComplet e = new OpLcComplet();
e.setNomTable("orvisenonPayelc");
String listeCrt[] = {"id","remarque","ded_id","designationLc","idTypeLigne","identite","iddirection","annee","numCompte","idLigne","mois","daty","montant","paye","idFournisseur"};
String listeInt[] = {"mois","daty","montant","paye"};
String libEntete[] = {"id","daty","ded_id","idLigne","montant","remarque","paye"};

PageRecherche pr = new PageRecherche(e,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("ded/reportOR.jsp");
String[]colSomme = {"montant"};
pr.creerObjetPage(libEntete,colSomme);
pr.setNpp(300);
OpLcComplet []listeP=(OpLcComplet [])pr.getRs().getResultat();
%>
<h1>Liste OR à reporter</h1>
<form action="<%=pr.getLien()%>?but=ded/reportOR.jsp" method="post" name="reportOR" id="reportOR">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[] = {pr.getLien()+"?but=finance/fichePrevisionRecDetail.jsp"};
String colonneLien[] = {"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<form name="mep" action="<%=pr.getLien() %>?but=ded/apresVisualiserOrdonnerRecette.jsp" method="post">
<input type="hidden" name="acte" value="reporter">
<input type="hidden" name="nb" value="<%=listeP.length%>">
<input type="hidden" name="bute" value="ded/reportOR.jsp">
<input type="hidden" name="classe" value="OrdonnerPayement">
<input type="hidden" name="crt" value="<%=pr.getFormu().getListeCritereString()%>&numPage=<%=pr.getNumPage()%>">
<input type="submit" value="valider">
<table width=100% border=0 align=center cellpadding=3 cellspacing=3 class=monographe>
	<tr class=head>
		<td width=7% align="center" valign="top">ID</td>
		<td width=7% align="center" valign="top">Num Fact</td>
		<td width=25% align=center valign=top>Montant</td>
		<td width=10% align=center valign=top>Description</td>
		<td width=20% align=center valign=top>Daty</td>
		<td width=10% align=center valign=top>Annuler</td>
	</tr>
	<%
	for(int i=0;i<listeP.length;i++)
	{
		%>
		<tr onmouseover=this.style.backgroundColor='#EAEAEA' onmouseout="this.style.backgroundColor=''">
			<td align=center><%=listeP[i].getId() %></td>
			<td align=center><%=listeP[i].getDed_id() %></td>
			<td align=center><%=Utilitaire.formaterAr(listeP[i].getMontant()) %></td>
			<td align=center><%=listeP[i].getRemarque() %></td>
			<td align=center><input type="text" name="daty<%=i%>" value=<%=Utilitaire.datetostring(listeP[i].getDaty()) %> ></td>
			<td align=center><a href="<%=pr.getLien()+"?but=ded/apresVisualiserOrdonnerRecette.jsp&acte=annulerOr&numObjet="+listeP[i].getId()%>">X</a></td>
		</tr>
		<input type="hidden" name="id<%=i%>" value="<%=listeP[i].getId()%>">
	<%}%>
</table>
</form>
<%
out.println(pr.getBasPage());
%>
