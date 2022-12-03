<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="comptabilite.*" %>
<script language="JavaScript">
  $(document).ready(function() {
      $('#cocheTout').click(function() {

          var cases = $("#divchck").find(':checkbox');
          if(this.checked){
              cases.attr('checked', true);
              $('#cocheText').html('Tout decocher');
          }else{
              cases.attr('checked', false);
              $('#cocheText').html('Tout cocher');
          }

      });

});
</script>
<script type="text/javascript">
	var $namesJournal = [];
	var nombrechoix =0;
	var debitD = 0;
	var debitU = 0;
	var creditD = 0;
	var creditU = 0;
	
	function formatMoney(n) {
		return n.toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, "$1 ");
	}
	
	function getChoixGazety(element, num){
		$name = $(element).attr("name");
		var montantD = 0;
		var montantC = 0;
		
		var nid = $(element).val();
		montantD = parseInt($('#debit_'+num+nid).val());
		montantC = parseInt($('#credit_'+num+nid).val());
		
		if(element.checked){
			if (num == '') document.getElementById('checkbox2'+nid).disabled = true;
			if (num == '2') document.getElementById('checkbox4'+nid).disabled = true;
			debitD = debitD + montantD;
			creditD = creditD + montantC;
		}
		else if(!element.checked){
			if (num == '') document.getElementById('checkbox2'+nid).disabled = false;
			if (num == '2') document.getElementById('checkbox4'+nid).disabled = false;
			debitD = debitD - montantD;
			creditD = creditD - montantC;
		}
		setTableRecap();
	}
	
	function getChoixGazety2(element, num){
		$name = $(element).attr("name");
		var montantD = 0;
		var montantC = 0;
		
		var nid = $(element).val();
		montantD = parseInt($('#debit_'+num+nid).val());
		montantC = parseInt($('#credit_'+num+nid).val());
		
		if( element.checked){
			if (num == '') document.getElementById('checkbox'+nid).disabled = true;
			if (num == '2') document.getElementById('checkbox3'+nid).disabled = true;
			debitU = debitU + montantD;
			creditU = creditU + montantC;
		}
		else if(!element.checked){
			if (num == '') document.getElementById('checkbox'+nid).disabled = false;
			if (num == '2') document.getElementById('checkbox3'+nid).disabled = false;
			debitU = debitU - montantD;
			creditU = creditU - montantC;
		}
		setTableRecap();
	}
	
	function setTableRecap(){
		document.getElementById("totaldebitD").innerHTML = formatMoney(debitD);
		document.getElementById("totalcreditD").innerHTML = formatMoney(creditD);
		document.getElementById("totaldebitU").innerHTML = formatMoney(debitU);
		document.getElementById("totalcreditU").innerHTML = formatMoney(creditU);
		
		$('#debitDV').val(debitD);
		$('#creditDV').val(creditD);
		$('#debitUV').val(debitU);
		$('#creditUV').val(creditU);
	}
	
</script>
<%
try
{
Ecriture p=new Ecriture();
String etat="adeclarer4456";
p.setNomTable(etat);
String listeCrt[]={"societe", "exercice", "numero", "compte", "libelle", "daty", "echeance"};
String listeInt[]={"numero", "daty", "echeance"};

PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));

affichage.Champ[] liste=new affichage.Champ[1];
Societe to1=new Societe();
liste[0]=new Liste("societe",to1,"nom","id");
pr.getFormu().changerEnChamp(liste);

pr.getFormu().getChamp("exercice").setPageAppel("comptabilite/choixExercice.jsp");
pr.getFormu().getChamp("compte").setPageAppel("comptabilite/choixCompte.jsp");
pr.getFormu().getChamp("daty1").setLibelle("Date (min)");
pr.getFormu().getChamp("daty2").setLibelle("Date (max)");
pr.getFormu().getChamp("echeance1").setLibelle("Echeance (min)");
pr.getFormu().getChamp("echeance2").setLibelle("Echeance (max)");
pr.getFormu().getChamp("numero1").setLibelle("Numero (min)");
pr.getFormu().getChamp("numero2").setLibelle("Numero (max)");
pr.setApres("comptabilite/declaration-adeclarer.jsp");

pr.setNpp(10000);
String libEntete[]={"daty","compte", "libelle", "montantdebit", "montantcredit"};


String colSomme[]={"MONTANTDEBIT", "MONTANTCREDIT"};
pr.creerObjetPage(libEntete,colSomme);

Ecriture[] pf=(Ecriture[])pr.getRs().getResultat();

Ecriture p2=new Ecriture();
p2.setNomTable("adeclarer4457");
String listeCrt2[]={"societe", "exercice", "numero", "compte",  "libelle", "daty", "echeance"};
String listeInt2[]={"numero", "daty", "echeance"};

PageRecherche pr2=new PageRecherche(p2,request,listeCrt2,listeInt2,2);
pr2.setUtilisateur((user.UserEJB)session.getValue("u"));
pr2.setLien((String)session.getValue("lien"));

affichage.Champ[] liste2=new affichage.Champ[1];
Societe to12=new Societe();
liste2[0]=new Liste("societe",to12,"nom","id");
pr2.getFormu().changerEnChamp(liste2);

pr2.getFormu().getChamp("exercice").setPageAppel("comptabilite/choixExercice.jsp");
pr2.getFormu().getChamp("compte").setPageAppel("comptabilite/choixCompte.jsp");
pr2.getFormu().getChamp("daty1").setLibelle("Date (min)");
pr2.getFormu().getChamp("daty2").setLibelle("Date (max)");
pr2.getFormu().getChamp("echeance1").setLibelle("Echeance (min)");
pr2.getFormu().getChamp("echeance2").setLibelle("Echeance (max)");
pr2.getFormu().getChamp("numero1").setLibelle("Numero (min)");
pr2.getFormu().getChamp("numero2").setLibelle("Numero (max)");
pr2.setApres("comptabilite/declaration-adeclarer.jsp");

pr2.creerObjetPage(libEntete,colSomme);
Ecriture[] pf2=(Ecriture[])pr2.getRs().getResultat();


%>
<h1>Declaration</h1>
<form action="<%=pr.getLien()%>?but=comptabilite/declaration-adeclarer.jsp" method="post" name="listePub" id="listePub">
<%
out.println(pr.getFormu().getHtmlEnsemble());
out.println(pr2.getFormu().getHtmlEnsemble());
%> 
</form>
<%
out.println(pr.getTableauRecap().getHtml());
out.println(pr2.getTableauRecap().getHtml());
%>
<br>

<table width="40%" border="1" align="right" cellpadding="0" cellspacing="0">
	<tr class="head">
		<td width="50%" align="center" colspan="2">A declarer au fix</td>
		<td width="50%" align="center" colspan="2">A declarer (en attente)</td>
	</tr>
	<tr class="head">
		<td width="25%" align="center">Total debit</td>
		<td width="25%" align="center">Total credit</td>
		<td width="25%" align="center">Total debit</td>
		<td width="25%" align="center">Total credit</td>
	</tr>
	<tr>
		<td id="totaldebitD" align="right">&nbsp;</td>
		<td id="totalcreditD" align="right">&nbsp;</td>
		<td id="totaldebitU" align="right">&nbsp;</td>
		<td id="totalcreditU" align="right">&nbsp;</td>
	</tr>
</table>
<br>

<table>
</table>

<form method="post" name="e" action="<%=pr.getLien()%>?but=comptabilite/declaration-confirmation.jsp">
	<div id="divchck">
	<table class="monographe" width="100%" cellspacing="3" cellpadding="3" border="0" align="center" id="mydiv">
	<tr>
		<td colspan="6" align="center">4456<td>
		<td></td>
		<td colspan="6" align="center">4457<td>
	</tr>
	<tr>
		<td bgcolor="#66CCFF" align="center" width="5%"><b>Date</b></td>
		<td bgcolor="#66CCFF" align="center" width="30%"><b>Libell&eacute;</b></td>
		<td bgcolor="#66CCFF" align="center" width="10%"><b>Montant d&eacute;bit</b></td>
		<td bgcolor="#66CCFF" align="center" width="10%"><b>Montant cr&eacute;dit</b></td>
		<td bgcolor="#66CCFF" align="center" width="5%"><input type="checkbox" id="cocheTout"></td>
		<td bgcolor="#66CCFF" align="center" width="5%"><input type="checkbox" id="cocheTout2"></td>
		<td></td>
		<td bgcolor="#66CCFF" align="center" width="5%"><b>Date</b></td>
		<td bgcolor="#66CCFF" align="center" width="30%"><b>Libell&eacute;</b></td>
		<td bgcolor="#66CCFF" align="center" width="10%"><b>Montant d&eacute;bit</b></td>
		<td bgcolor="#66CCFF" align="center" width="10%"><b>Montant cr&eacute;dit</b></td>
		<td bgcolor="#66CCFF" align="center" width="5%"><input type="checkbox" id="cocheTout3"></td>
		<td bgcolor="#66CCFF" align="center" width="5%"><input type="checkbox" id="cocheTout4"></td>
		
	</tr>
	<% 
		int count = pf.length;
		if (pf2.length > pf.length) count = pf2.length;
		for(int i=0;i<count;i++){
	%>
	<tr>
		<% if (i<pf.length){ %>
		<td align="center"><% if (pf[i].getDaty()!= null) out.print(Utilitaire.datetostring(pf[i].getDaty()));%></td>
		<td align="center"><%=pf[i].getLibelle()%></td>
		<td align="right"><input type="hidden" id="debit_<%=pf[i].getId()%>" value="<%=pf[i].getMontantdebit()%>"/><%=Utilitaire.formaterAr(pf[i].getMontantdebit())%></td>
		<td align="right"><input type="hidden" id="credit_<%=pf[i].getId()%>" value="<%=pf[i].getMontantcredit()%>"/><%=Utilitaire.formaterAr(pf[i].getMontantcredit())%></td>
		<td><input type="checkbox" id="checkbox<%=pf[i].getId()%>" onclick="getChoixGazety(this, '')" name="id1" value="<%=pf[i].getId()%>" /></td>
		<td><input type="checkbox" id="checkbox2<%=pf[i].getId()%>" onclick="getChoixGazety2(this, '')" name="id2" value="<%=pf[i].getId()%>"/></td>
		<% } else {%>
			<td></td><td></td><td></td><td></td><td></td><td></td>
		<% } %>
		<td></td>
		<% if (i<pf2.length){ %>
		<td align="center"><% if (pf2[i].getDaty()!= null) out.print(Utilitaire.datetostring(pf2[i].getDaty()));%></td>
		<td align="center"><%=pf[i].getLibelle()%></td>
		<td align="right"><input type="hidden" id="debit2_<%=pf2[i].getId()%>" value="<%=pf2[i].getMontantdebit()%>"/><%=Utilitaire.formaterAr(pf2[i].getMontantdebit())%></td>
		<td align="right"><input type="hidden" id="credit2_<%=pf2[i].getId()%>" value="<%=pf2[i].getMontantcredit()%>"/><%=Utilitaire.formaterAr(pf2[i].getMontantcredit())%></td>
		<td><input type="checkbox" id="checkbox3<%=pf2[i].getId()%>" onclick="getChoixGazety(this, '2')" name="id3" value="<%=pf2[i].getId()%>"/></td>
		<td><input type="checkbox" id="checkbox4<%=pf2[i].getId()%>" onclick="getChoixGazety2(this, '2')" name="id4" value="<%=pf2[i].getId()%>"/></td>
		<% } else {%>
			<td></td><td></td><td></td><td></td><td></td><td></td>
		<% } %>
	<%}%>
	</tr>
</table>
<div>
		<input name="nombrechoix" id="nombrechoix" class="submit" type="hidden" value="0">
        <input name="nomjournal" id="nomjournal" class="submit" type="hidden" value="0">
		
		<input name="debitDV" id="debitDV" class="submit" type="hidden" value="0">
		<input name="creditDV" id="creditDV" class="submit" type="hidden" value="0">
		<input name="debitUV" id="debitUV" class="submit" type="hidden" value="0">
		<input name="creditUV" id="creditUV" class="submit" type="hidden" value="0">
</div>
 <div align="center">
            <input type="submit" value="Valider">
     </div>
</div>
</form>
<%
//out.println(pr.getBasPage());
}
catch(Exception e)
{
  e.printStackTrace();
}
%>
