<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@page import="commercial.*"%>
<%
	SocieteCommercial p = new SocieteCommercial();
	p.setNomTable("STECOMMERCIALLIBELLE2");
	PageConsulte pc=new PageConsulte(p,request,(user.UserEJB)session.getValue("u"));//ou avec argument liste Libelle si besoin
	String libEnteteAffiche[] = {"Identifiant", "Date", "Nom", "Produits", "Catégorie", "Adresse", "Téléphone", "Mail", "Site", "Réseau sociaux"};

	pc.setLibAffichage(libEnteteAffiche);
%>
<html>
<h1>Consultation societe</h1>
<%out.println(pc.getHtml());%>
<a href="<%=(String)session.getValue("lien")+"?but=comptabilite/comptetiersmultiple-saisie.jsp&idsociete="+request.getParameter("id")%>">Créer tiers</a>|<a href="<%=(String)session.getValue("lien")+"?but=commercial/modifier-societe.jsp&id="+request.getParameter("id")%>">Modifier</a>

<!-- Historique etat societe -->
<%
	SituationSociete st = new SituationSociete();
	st.setNomTable("SITUATIONSOCIETELIBELLE");
	SituationSociete[] listeSituation = (SituationSociete[])CGenUtil.rechercher(st, null, null, " and societe = '"+request.getParameter("id")+"' order by ID DESC");
%>

<p align="center"><strong><u>Historique situation société</u></strong></p>
<div id="selectnonee">
	<table width="100%" border="0" align="center" cellpadding="3" cellspacing="3" class="monographe">
		<tbody>
			<tr class="head">
				<td align="center" valign="top">ID</td>
				<td align="center" valign="top">Date d'application</td>
				<td align="center" valign="top">Situation</td>
				<td align="center" valign="top">Date de rendez-vous</td>
				<td align="center" valign="top">Observation</td>
			</tr>
			<%for(int i = 0; i < listeSituation.length; i++){%>
			<tr onmouseover="this.style.backgroundColor='#EAEAEA'" onmouseout="this.style.backgroundColor=''">
				<td align="center"><%=listeSituation[i].getId()%></td>
				<td align="center"><%=listeSituation[i].getDaty()%></td>
				<td align="center"><%=listeSituation[i].getEtat()%></td>
				<td align="center"><%=listeSituation[i].getDaterdv()%></td>
				<td align="center"><%=listeSituation[i].getObservation()%></td>
			</tr>
			<%}%>
		</tbody>
	</table>
</div>
<!-- Liste personne responsable societe -->
<%
	PersRespSociete rst = new PersRespSociete();
	PersRespSociete[] listePersResp = (PersRespSociete[])CGenUtil.rechercher(rst, null, null, " and societe = '"+request.getParameter("id")+"' order by ID DESC");
%>

<p align="center"><strong><u>Personne responsable</u></strong></p>
<div id="selectnonee">
	<table width="100%" border="0" align="center" cellpadding="3" cellspacing="3" class="monographe">
		<tbody>
			<tr class="head">
				<td align="center" valign="top">ID</td>
				<td align="center" valign="top">Date de debut</td>
				<td align="center" valign="top">Nom Responsable</td>
				<td align="center" valign="top">Contact</td>
				<td align="center" valign="top">Observation</td>
			</tr>
			<%for(int i = 0; i < listePersResp.length; i++){%>
			<tr onmouseover="this.style.backgroundColor='#EAEAEA'" onmouseout="this.style.backgroundColor=''">
				<td align="center"><%=listePersResp[i].getId()%></td>
				<td align="center"><%=listePersResp[i].getDateapplication()%></td>
				<td align="center"><%=listePersResp[i].getNom()%></td>
				<td align="center"><%=listePersResp[i].getContact()%></td>
				<td align="center"><%=listePersResp[i].getObservation()%></td>
			</tr>
			<%}%>
		</tbody>
	</table>
</div>
<!-- Liste commercial responsable societe -->
</html>