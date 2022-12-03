<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="prevision.*" %>

<%
	try{
	PrevisionEtat[] listEtatPrev = null;
	double soldeFinale = 0;
	String soldeInitiale = "";
	String dateDebut = "01/01/"+Utilitaire.getAneeEnCours();
	String dateFin = "31/12/"+Utilitaire.getAneeEnCours();
	
	if(request.getParameter("datedebut") != null && request.getParameter("datedebut").compareToIgnoreCase("") != 0){
		dateDebut = request.getParameter("datedebut");
	}
	if(request.getParameter("datefin") != null && request.getParameter("datefin").compareToIgnoreCase("") != 0){
		dateFin = request.getParameter("datefin");
	}
	if(request.getParameter("reportinitiale") != null && request.getParameter("reportinitiale").compareToIgnoreCase("") != 0){
		PrevisionEtat prev = new PrevisionEtat();
		prev.setNomTable("etatcaissepardate");
		PrevisionEtat[] list = (PrevisionEtat[])CGenUtil.rechercher(prev, null, null, " and daty between '" + dateDebut + "' and '" + dateFin + "'");
		System.out.println(" and daty between '" + dateDebut + "' and '" + dateFin + "' === " + list.length);
		soldeInitiale = request.getParameter("reportinitiale");
		listEtatPrev = list;
		soldeFinale = PrevisionService.calculerSoldePrevision(Utilitaire.stringToInt(request.getParameter("reportinitiale")), listEtatPrev);
	}
%>

<h1>Etat de mouvement par date</h1>
<form action="<%=(String)session.getValue("lien")%>?but=finance/etatMvtCaisseParDate.jsp" method="post" name="liste" id="liste">
	<table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
		<tbody>
			<tr>
				<td align="left" class="left">Solde initiale</td>
				<td><input name="reportinitiale" type="text" class="champ" id="reportinitiale" value="<%=soldeInitiale%>"></td>
				<td align="left" class="left">Du</td>
				<td><input name="datedebut" type="text" class="champ" id="datedebut" value="<%=dateDebut%>"></td>
				<td align="left" class="left">Au</td>
				<td><input name="datefin" type="text" class="champ" id="datefin" value="<%=dateFin%>"></td>
			</tr>
		</tbody>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tbody>
			<tr>
				<td align="center"><input type="submit" name="Submit" value="Afficher" class="submit"></td>
			</tr>
		</tbody>
	</table>
</form>
<table border="0" align="right" cellpadding="3" cellspacing="3" class="monographe">
	<tbody>
		<tr class="head">
			<td width="25%" align="center" valign="top">Solde Finale</td>
			<td width="25%" align="center" valign="top"><strong style="font-size=18px;"><%=Utilitaire.formaterAr(soldeFinale)%></strong></td>
		</tr>
	</tbody>
</table>
<table width="100%" border="0" align="center" cellpadding="3" cellspacing="3" class="monographe">
	<tbody>
			<tr class="head">
					<td width="25%" align="center" valign="top">Date</td>
					<td width="25%" align="center" valign="top">D&eacute;bit</td>
					<td width="25%" align="center" valign="top">Cr&eacute;dit</td>
					<td width="25%" align="center" valign="top">Solde</td>
			</tr>
			<%

			try{
				double temp = 0;
				for(int i = 0; i < listEtatPrev.length; i++){
					%>
					<tr onmouseover="this.style.backgroundColor='#EAEAEA'" onmouseout="this.style.backgroundColor=''">
						<td width="25%" align="center"><%=Utilitaire.convertDatyFormtoRealDatyFormat(listEtatPrev[i].getDaty()+"")%></td>
						<td width="25%" align="right">
							<a href="<%=(String)session.getValue("lien")%>?but=finance/detailsMvtDepense.jsp&daty=<%=Utilitaire.convertDatyFormtoRealDatyFormat(listEtatPrev[i].getDaty()+"")%>" target="_blank"><%=Utilitaire.formaterAr(listEtatPrev[i].getDebit())%></a>
						</td>
						<td width="25%" align="right">
							<a href="<%=(String)session.getValue("lien")%>?but=finance/detailsMvtRecette.jsp&daty=<%=Utilitaire.convertDatyFormtoRealDatyFormat(listEtatPrev[i].getDaty()+"")%>" target="_blank"><%=Utilitaire.formaterAr(listEtatPrev[i].getCredit())%></a>
						</td>
						<td width="25%" align="right"><%=Utilitaire.formaterAr(listEtatPrev[i].getSolde())%></td>
					</tr>
					<%

				}
			}
			catch(Exception ex){
				ex.printStackTrace();
			}
			%>
	</tbody>
</table>

<%
}
catch(Exception exc){
				exc.printStackTrace();
			}
			%>
