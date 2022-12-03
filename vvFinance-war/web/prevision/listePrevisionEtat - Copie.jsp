<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="prevision.*" %>
<%

PrevisionState e = new PrevisionState();
String etat = "PREVISIONGLOBALSTATE";
e.setNomTable(etat);
String listeCrt[] = {"daty"};
String listeInt[] = {"daty"};
String libEntete[] = {"daty","debit","credit","solde"};

PageRecherche pr = new PageRecherche(e,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("prevision/listePrevisionEtat.jsp");
String[]colSomme = {"debit","credit","solde"};
pr.creerObjetPage(libEntete,colSomme);
PrevisionState[] liste = (PrevisionState[])pr.getRs().getResultat();
%>
<h1>Liste pr&eacute;visions</h1>
<form action="<%=pr.getLien()%>?but=prevision/listePrevisionEtat.jsp" method="post" name="listePrevisionEtat" id="listePrevisionEtat">
<%out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<% out.println(pr.getTableauRecap().getHtml());%>


<table width="100%" border="0" align="center" cellpadding="3" cellspacing="3" class="monographe">
	<tbody>
			<tr class="head">
					<td width="25%" align="center" valign="top">Date</td>
					<td width="25%" align="center" valign="top">Debit</td>
					<td width="25%" align="center" valign="top">Credit</td>
					<td width="25%" align="center" valign="top">Solde</td>
			</tr>
			<%

			try{
				double temp = 0;
				for(int i = 0; i < liste.length; i++){
									  temp = temp + liste[i].getSolde();
					%>
					<tr onmouseover="this.style.backgroundColor='#EAEAEA'" onmouseout="this.style.backgroundColor=''">
						<td width="25%" align="center"><%=Utilitaire.convertDatyFormtoRealDatyFormat(liste[i].getDaty()+"")%></td>
						<td width="25%" align="center"><%=Utilitaire.formaterAr(liste[i].getDebit())%></td>
						<td width="25%" align="center"><%=Utilitaire.formaterAr(liste[i].getCredit())%></td>
						<td width="25%" align="center"><%=Utilitaire.formaterAr(temp)%></td>
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
out.println(pr.getBasPage());
%>

