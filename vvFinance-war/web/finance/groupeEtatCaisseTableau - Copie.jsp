<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="finance.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<link href="../style/style.css" rel="stylesheet" type="text/css">
<%!
EtatCaisseTableau p;
%>
<%
p = new EtatCaisseTableau();
String etat = "EtatCaisseTableau";
if(request.getParameter("etat")!=null && request.getParameter("etat").compareToIgnoreCase("")!=0)
	etat = request.getParameter("etat");
p.setNomTable("EtatCaisseTableau");
String listeCrt[] = {"daty","caisse","debit","credit"};
String listeInt[] = {"daty","debit","credit"};

String colDefaut[]={"caisse"};
String somDefaut[]={"debit","credit","disponiblenet"};
String moyenneDefaut[]={"plafonnement"};
String dt = "01/02/"+Utilitaire.getAneeEnCours();

PageRechercheGroupe pr = new PageRechercheGroupe(p,request,listeCrt,listeInt,2,colDefaut,somDefaut,moyenneDefaut,6,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("groupeEtatCaisseTableau.jsp");
affichage.Champ[] liste=new affichage.Champ[1];
Caisse to = new Caisse();
to.setNomTable("caisse");
liste[0] = new Liste("caisse",to,"descCaisse","descCaisse", true);
pr.getFormu().changerEnChamp(liste);
pr.setNpp(400);
pr.getFormu().getChamp("daty1").setDefaut(dt);
pr.creerObjetPageMoyenne();
EtatCaisseTableau[] list = (EtatCaisseTableau[])pr.getRs().getResultat();
EtatCaisseTableau temp = new EtatCaisseTableau();
EtatCaisseTableau[] pf = temp.calculer(list, request.getParameter("date1"));
String date2 = Utilitaire.dateDuJour();
date2 = (request.getParameter("daty2") == null || request.getParameter("daty2").compareToIgnoreCase("") == 0)? Utilitaire.dateDuJour(): request.getParameter("daty2");
%>
<script type="text/javascript">
function calculere(j)
{
	var c;
	for(c=0;c<j;c++)
	{
		var report = document.getElementById("report"+c).value;
                var debit = document.getElementById("debitcol"+c).value;
                var credit = document.getElementById("creditcol"+c).value;


		var plafonnement = document.getElementById("plafonnement"+c).value;

		var disp =  (parseFloat(credit) + parseFloat(report) + parseFloat(plafonnement)) - parseFloat(debit);
                var disponible = disp.toFixed(2);
                for (var i = 0; i < Math.floor((disponible.length-(1+i))/3); i++){
                  disponible = disponible.substring(0,disponible.length-(4*i+3))+' '+ disponible.substring(disponible.length-(4*i+3));
                }
                document.getElementById("disponible"+c).value = disponible;
                report = 0; debit = 0; credit = 0; plafonnement = 0;
	}
}
</script>
<h1>Grouper etat de caisse</h1>
<form action="groupeEtatCaisseTableau.jsp" method="post" name="groupePrev" id="groupePrev">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
<br/>
	<center>etat : 	<select name="etat" class="champ" id="etat" >
        <option value="MONTANTCAISSEINDISPONIBLE"  <%if(etat.compareTo("MONTANTCAISSEINDISPONIBLE")==0) out.println("selected");%>> tous </option>
        <option value="EtatCaisseTableau"  <%if(etat.compareTo("EtatCaisseTableau")==0) out.println("selected");%>>exclure debit & credit indisponible</option>
	</select></center>
</form>
<%
out.println(pr.getTableauRecap().getHtml());%>
<br>
<div id="selectnonee">
<form action="groupeEtatCaisseTableau.jsp" method="POST" name="frmListe" id="frmListe">
	<table width="100%" border="0" align="center" cellpadding="3" cellspacing="3" class="monographe">
		<tbody>
			<tr class="head">
				<td width="20%" align="center" valign="top">Caisse</td>
				<td width="20%" align="center" valign="top">Report</td>
				<td width="20%" align="center" valign="top">Debit</td>
				<td width="20%" align="center" valign="top">Credit</td>
				<td width="20%" align="center" valign="top">Disponiblenet</td>
				<td width="20%" align="center" valign="top">Plafonnement</td>
			</tr>
			<% for(int i = 0; i < pf.length; i++){%>
				<tr onmouseover="this.style.backgroundColor='#EAEAEA'" onmouseout="this.style.backgroundColor=''">
					<td width="20%" align="center"><%=pf[i].getCaisse()%></td>
					<td width="20%" align="center">
						<input name="report<%=i%>" type="textbox" class="champ" id="report<%=i%>" value="<%=pf[i].getReport()%>">
					</td>
					<td width="20%" align="center">
						<input name="debit<%=i%>" type="hidden" class="champ" id="debitcol<%=i%>" value="<%=pf[i].getDebit()%>">
						<a href="../modeleAdmin.jsp?but=finance/listeMvtCaisseSansLc.jsp&credit1=0&credit2=0&daty1=<%=request.getParameter("daty1")%>&daty2=<%=date2%>&idcaisse=<%=pf[i].getCaisse()%>">
						<%=Utilitaire.formaterAr(pf[i].getDebit())%>
						</a>
						</td>
					<td width="20%" align="center">
						<input name="credit<%=i%>" type="hidden" class="champ" id="creditcol<%=i%>" value="<%=pf[i].getCredit()%>" >
						<a href="../modeleAdmin.jsp?but=finance/listeMvtCaisseSansLc.jsp&debit1=0&debit2=0&daty1=<%=request.getParameter("daty1")%>&daty2=<%=date2%>&idcaisse=<%=pf[i].getCaisse()%>">
						<%=Utilitaire.formaterAr(pf[i].getCredit())%>
						</a>
						</td>
					<td width="20%" align="center">
						<input name="disponible<%=i%>" type="textbox" class="champ" id="disponible<%=i%>" value="<%=Utilitaire.formaterAr(pf[i].getDisponiblenet())%>"readonly></td>
					<td width="20%" align="center">
						<input name="plafonnement<%=i%>" type="textbox" class="champ" id="plafonnement<%=i%>" value="<%=pf[i].getPlafonnement()%>" ></td>
				</tr>
			<% }%>
		</tbody>
	</table>
	<center><input name="calculer" type="button" value="calculer" onClick='calculere(<%=pf.length%>)'></center>
</form>
	<% if(etat.compareToIgnoreCase("MONTANTCAISSEINDISPONIBLE") == 0){
		EtatCaisseTableau tempin = new EtatCaisseTableau();
		tempin.setNomTable("MONTANTCAISSEINDISPONIBLE");
		String somDefaut2[]={"debit","credit"};
		PageRechercheGroupe prin = new PageRechercheGroupe(tempin,request,listeCrt,listeInt,2,colDefaut,somDefaut2,moyenneDefaut,6,2);
		prin.setUtilisateur((user.UserEJB)session.getValue("u"));
		prin.creerObjetPage();
		EtatCaisseTableau[] listin = (EtatCaisseTableau[])prin.getRs().getResultat();
		EtatCaisseTableau[] pfin = temp.calculer(listin, request.getParameter("daty1"));
	%>
	<h1>Montant indisponible</h1>
	<%
	out.println(prin.getTableauRecap().getHtml());%>
	<br>
	<table width="100%" border="0" align="center" cellpadding="3" cellspacing="3" class="monographe">
		<tbody>
			<tr class="head">
				<td width="20%" align="center" valign="top">Caisse</td>
				<td width="20%" align="center" valign="top">Debit</td>
				<td width="20%" align="center" valign="top">Credit</td>
			</tr>
			<% for(int k = 0; k < pfin.length; k++){%>
				<tr onmouseover="this.style.backgroundColor='#EAEAEA'" onmouseout="this.style.backgroundColor=''">
					<td width="20%" align="center"><%=pfin[k].getCaisse()%></td>
					<td width="20%" align="center"><%=Utilitaire.formaterAr(pfin[k].getDebit())%></td>
					<td width="20%" align="center"><%=Utilitaire.formaterAr(pfin[k].getCredit())%></td>
				</tr>
			<% }%>
		</tbody>
	</table>
	<%}%>
</div>
<%
out.println(pr.getBasPage());
%>

