<%@ page import="user.*" %>
<%@ page import="comptabilite.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>

<%
        String apres="comptabilite/apresCompta.jsp";
        String lien= null;
        UserEJB u = null;
        Societe caiss[] = null;
		TypeObjet journ[] = null;
     %>
<%
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
 caiss = u.findSociete("%", "%", "%", "%", "%", "%", "%", "%", "%", "%", "%", "%");
 journ = u.findTypeObjet("JOURNALCOMPTA","%","%");
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<script type="text/javascript">

    var tailleDefaut = 5,
    nombreLigne = 5,
    compteur = 6;
	var credit = 0;
	var debit = 0;

    function add_ecriture() {
        var html = genererLigneFromIndex (compteur);
        $('#ajout_ecriture').append(html);
        compteur ++;
        nombreLigne ++;
        inputNbrLigne();
    }

    function inputNbrLigne() {
        document.getElementById("taille").value = compteur;
		document.getElementById("nbrLigne").value = nombreLigne;
    }

    function removeLineByIndex(index)
    {
        var nomId = "ecriture-id-" + index;

        var ligne = document.getElementById(nomId);
        ligne.parentNode.removeChild(ligne);
        nombreLigne --;
        inputNbrLigne();
    }

    function genererLigneFromIndex (index)
    {
       var html =  "<tr id=\"ecriture-id-" + index + "\">";
		html += '<td><input name="numpiece_' + index + '" type="text" id="numpiece_' + index + '" value=""/></td>';
		html += '<td><input name="compte_' + index + '" type="text" id="compte_' + index + '" value="" readonly/></td>';
		html += '<td><input name="choix1_' + index + '" type="button" onClick="pagePopUp(\'comptabilite/choixCompte.jsp?champReturn=compte_' + index + '\')" value="..." class="submit"></td>';
		html += '<td><input name="tiers_' + index + '" type="text" id="tiers_' + index + '" value="" readonly/></td>';
		html += '<td><input name="choix2_' + index + '" type="button" onClick="choisirTiers('+index+')" value="..." class="submit"></td>';
		html += '<td><input name="echeance_' + index + '" type="text" id="echeance_' + index + '" value=""/></td>';
		html += '<td><input name="libelle_' + index + '" type="text" id="libelle_' + index + '" value=""/></td>';
		html += '<td><input name="montantdebit_' + index + '" type="text" id="montantdebit_' + index + '" value=""/></td>';
		html += '<td><input name="montantcredit_' + index + '" type="text" id="montantcredit_' + index + '" value=""/></td>';
		html += '<td><a onclick="removeLineByIndex(' + index + ')">X</a></td>';
		return html;
    }

	function getDate(){
		var date = new Date();
		var dat = date.getDate() + '/' + (date.getMonth() + 1) + '/' +  date.getFullYear();
		return dat;
	}

	function formatMoney(n) {
		return n.toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, "$1 ");
	}

	function calcul(){
		credit =0;
		debit =0;
		for (var i=1; i<nombreLigne+1; i++){
			if (parseFloat(document.getElementById("montantdebit_"+i).value)>0) debit += parseFloat(document.getElementById("montantdebit_"+i).value);
			if (parseFloat(document.getElementById("montantcredit_"+i).value)>0) credit += parseFloat(document.getElementById("montantcredit_"+i).value);
		}
	}
	
	function calculer (){
		calcul();
		document.getElementById("totaldebit").innerHTML = formatMoney(debit);
		document.getElementById("totalcredit").innerHTML = formatMoney(credit);
	}

	function choisirTiers(index){
		var compte = document.getElementById("compte_"+index).value;
		if (compte > 400000 && compte < 500000){
			pagePopUp('comptabilite/choixCompteTiers.jsp?compte='+compte+'&champReturn=tiers_'+index+';libelle_'+index);
		}
		else alert('compte non valide');
	}

	function verifier(){
		calculer();
		if (debit == credit) return true;
		else{
			alert('Le total debit doit etre au total credit');
			return false;
		}
	}
</script>
<link href="style.css" rel="stylesheet" type="text/css">


<h1>Ecriture</h1>
<h2>&nbsp;</h2>

<h2>&nbsp;</h2>

<form action="<%=lien%>?but=<%=apres%>" method="post" name="recette" id="recette" target="_parent" onsubmit="return verifier()">

<table width="30%" border="1" align="right" cellpadding="0" cellspacing="0">
	<tr class="head">
		<td width="50%" align="center">Total debit</td>
		<td width="50%" align="center">Total credit</td>
	</tr>
	<tr>
		<td id="totaldebit" align="right">&nbsp;</td>
		<td id="totalcredit" align="right">&nbsp;</td>
	</tr>
</table>
<br>
<br>
<br>

<table border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td>DATY : </td>
		<td><input name="daty" type="text" id="daty" value="<%=Utilitaire.dateDuJour()%>"/></td>
	</tr>
	<tr>
		<td>SOCIETE : </td>
		<td>
			<select name="idsociete" class="champ" id="idsociete">
			<% for(int i=0;i<caiss.length;i++){ %>
				<option value="<%=caiss[i].getId()%>"><%=caiss[i].getNom()%></option>
			<% } %>
			</select>
		</td>
	</tr>
	<tr>
		<td>JOURNAL : </td>
		<td>
			<select name="journal" class="champ" id="journal">
			<% for(int i=0;i<journ.length;i++){ %>
				<option value="<%=journ[i].getId()%>"><%=journ[i].getDesce()%></option>
			<% } %>
			</select>
		</td>
	</tr>
</table>
<br>

<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td> <table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
		<thead>
			<td>N° PIECE</td>
			<td colspan="2">COMPTE</td>
			<td colspan="2">TIERS</td>
			<td>ECHEANCE</td>
			<td>LIBELLE</td>
			<td>MONTANT DEBIT</td>
			<td>MONTANT CREDIT</td>
			<td></td>
		</thead>
        <tbody id="ajout_ecriture">
			<% for (int iteratorTR = 1; iteratorTR < 6; iteratorTR++){ %>
			<tr id="ecriture-id-<%=iteratorTR%>">
				<td><input name="numpiece_<%=iteratorTR%>" type="text" id="numpiece_<%=iteratorTR%>" value=""/></td>
				<td><input name="compte_<%=iteratorTR%>" type="text" id="compte_<%=iteratorTR%>" value="" readonly/></td>
				<td>
					<input name="choix1_<%=iteratorTR%>" type="button" onClick="pagePopUp('comptabilite/choixCompte.jsp?champReturn=compte_<%=iteratorTR%>')" value="..." class="submit">
				</td>
				<td><input name="tiers_<%=iteratorTR%>" type="text" id="tiers_<%=iteratorTR%>" value="" readonly/></td>
				<td>
					<input name="choix2_<%=iteratorTR%>" type="button" value="..." class="submit" onClick="choisirTiers(<%=iteratorTR%>)">
				</td>
				<td><input name="echeance_<%=iteratorTR%>" type="text" id="echeance_<%=iteratorTR%>"/></td>
				<td><input name="libelle_<%=iteratorTR%>" type="text" id="libelle_<%=iteratorTR%>"/></td>
				<td><input name="montantdebit_<%=iteratorTR%>" type="text" id="montantdebit_<%=iteratorTR%>" value=""/></td>
				<td><input name="montantcredit_<%=iteratorTR%>" type="text" id="montantcredit_<%=iteratorTR%>" value=""/></td>
				<td><a onclick="removeLineByIndex(<%=iteratorTR%>)">X</a></td>
			</tr>
			<% } %>
		</tbody>
		</table></td>
    </tr>
	<tr>
		<div class="box-footer">
            <button type="button" class="btn-sm btn-default pull-right" onclick="add_ecriture()">Ajouter une ligne</button>
        </div>
	</tr>
        <tr>
    <td height="30" align="center">
      <table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
		<td align="center">
			<button type="button" class="btn-sm btn-default pull-right" onclick="calculer()">Calculer</button>
		</td>
			<td align="center">
			  <input id="taille" name="taille" type="hidden" value="5"/>
			  <input id="nbrLigne" name="nbrLigne" type="hidden" value="5"/>
			  <input name="acte" type="hidden" id="acte" value="insertmultiple-Ecriture">
              <input type="submit" name="Submit" value="Enregistrer" class="submit">
			</td>
          <td align="center"><input type="reset" name="annuler" value="R&eacute;tablir" class="submit" /></td>
 <input name="bute" type="hidden" id="bute" value="comptabilite/ecriture-saisie.jsp">
 <input name="classe" type="hidden" id="classe" value="comptabilite.Ecriture">
  </tr>
</table>
    </td>
        </tr>
</table>










</form>