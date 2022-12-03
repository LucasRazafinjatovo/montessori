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
UserEJB u = (UserEJB)session.getValue("u");
String lien = (String)session.getValue("lien");
pr.setApres("prevision/listePrevisionEtat.jsp");
String[]colSomme = {"debit","credit","solde"};
pr.creerObjetPage(libEntete,colSomme);
String date1 = null;
String date2 = null;
 	try{
           date1 = request.getParameter("date1");
           if(date1 == null || date1.compareTo("") == 0) date1 = "01/01/"+Utilitaire.getAneeEnCours();
           date2 = request.getParameter("date2");
           if(date2 == null || date2.compareTo("") == 0) date2 = "31/12/"+Utilitaire.getAneeEnCours();

           PrevisionState[] liste = (PrevisionState[])CGenUtil.rechercher(e,null,null,"");
           double temp = 0;
           PrevisionState[] liste_n = new PrevisionState[liste.length];
           for(int i = 0; i < liste.length; i++){
             temp = temp + liste[i].getSolde();
             PrevisionState ps = liste[i];
             ps.setSolde(temp);
             liste_n[i] = ps;
           }
           pr.getRs().setResultat(liste_n);
	%>
	<h1>Liste pr&eacute;visions</h1>
	<form action="<%=lien%>?but=prevision/listePrevisionEtat.jsp" method="post" name="listePrevisionEtat" id="listePrevisionEtat">
		<table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
			<tbody>
				<tr>
					<td align="left" class="left">daty1</td>
					<td align="center" class="champ"><input name="daty1" type="textbox" class="champ" id="daty1" value=""></td>
					<td></td>
					<td align="left" class="left">daty2</td>
					<td align="center" class="champ"><input name="daty2" type="textbox" class="champ" id="daty2" value=""></td>
					<td></td>
				</tr>
				<tr></tr>
				<tr></tr>
			</tbody>
		</table>
		<br>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tbody>
				<tr>
					<td align="center"> <input type="submit" name="Submit" value="Afficher" class="submit"></td>
					<td align="center"> <input type="reset" name="Submit" value="annuler" class="submit"></td>
				</tr>
			</tbody>
		</table>
		
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
				for(int i = 0; i < liste_n.length; i++){
					java.sql.Date date11 = Utilitaire.stringToSqlDate("dd/MM/yyyy",date1);
					java.sql.Date date21 = Utilitaire.stringToSqlDate("dd/MM/yyyy",date2);

					if(liste_n[i].getDaty().after(date11) == true && liste_n[i].getDaty().before(date21) == true){
					%>
					<tr onmouseover="this.style.backgroundColor='#EAEAEA'" onmouseout="this.style.backgroundColor=''">
						<td width="25%" align="center"><%=Utilitaire.convertDatyFormtoRealDatyFormat(liste_n[i].getDaty()+"")%></td>
						<td width="25%" align="center"><%=Utilitaire.formaterAr(liste_n[i].getDebit())%></td>
						<td width="25%" align="center"><%=Utilitaire.formaterAr(liste_n[i].getCredit())%></td>
						<td width="25%" align="center"><%=Utilitaire.formaterAr(liste_n[i].getSolde())%></td>
					</tr>
					<%
					}
				}
				%>
		</tbody>
	</table>
	<%
	}
	catch(Exception ex){
		ex.printStackTrace();
	}
	out.println(pr.getBasPage());
%>

