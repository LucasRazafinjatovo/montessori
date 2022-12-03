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
		 Ecriture[] listeD = null;
		 String dD = "", cD = "", dU = "", cU = "";
     %>
<%
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
 caiss = u.findSociete("%", "%", "%", "%", "%", "%", "%", "%", "%", "%", "%", "%");
 journ = u.findTypeObjet("JOURNALCOMPTA","%","%");
 
 String[] debitD= request.getParameterValues("id1");
 String[] creditD = request.getParameterValues("id3");
 String[] debitU = request.getParameterValues("id2");
 String[] creditU = request.getParameterValues("id4");
 
  if (debitD!=null) dD = Utilitaire.stringToTab(debitD,"'",",");
  if (creditD!=null)cD = Utilitaire.stringToTab(creditD,"'",",");
  if (debitU!=null)dU = Utilitaire.stringToTab(debitU,"'",",");
  if (creditU!=null)cU = Utilitaire.stringToTab(creditU,"'",",");
 
 
 //getMontant par compte 
 listeD = u.getPrevDeclaration(debitD, creditD, debitU, creditU);
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<script type="text/javascript">
	var tailleDefaut = <%=listeD.length%>,
    nombreLigne = <%=listeD.length%>,
    compteur = <%=listeD.length%>+1;
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
		html += '<td><input name="compte_' + index + '" type="text" id="compte_' + index + '" value="" readonly/><input type="hidden" id="tiers_' + index + ' name="tiers_' + index + '" value=""/> </td>';
		html += '<td><input name="choix1_' + index + '" type="button" onClick="pagePopUp(\'comptabilite/choixCompte.jsp?champReturn=compte_' + index + '\')" value="..." class="submit"></td>';
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
	
	function choisirTiers(index){
		var compte = document.getElementById("compte_"+index).value;
		if (compte > 400000 && compte < 500000){
			pagePopUp('comptabilite/choixCompteTiers.jsp?compte='+compte+'&champReturn=tiers_'+index+';libelle_'+index);
		}
		else alert('compte non valide');
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


<h1>Declaration</h1>
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
			<% 
				for(int i=0;i<caiss.length;i++){ 
					if (caiss[i].getId() == listeD[0].getSociete()){
			%>
						<option value="<%=caiss[i].getId()%>" selected><%=caiss[i].getNom()%></option>
			<% 
					} else{
			%>
						<option value="<%=caiss[i].getId()%>"><%=caiss[i].getNom()%></option>
			<%
					}
				} 
			%>
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
<br>

<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td> <table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
		<thead>
			<td>N° PIECE</td>
			<td colspan="2">COMPTE</td>
			<td>ECHEANCE</td>
			<td>LIBELLE</td>
			<td>MONTANT DEBIT</td>
			<td>MONTANT CREDIT</td>
			<td></td>
		</thead>
        <tbody id="ajout_ecriture">
			<% for (int iterator=0; iterator<listeD.length; iterator++) {
				int i = iterator +1;
			%>
			<tr id="ecriture-id-<%=i%>">
				<td><input name="numpiece_<%=i%>" type="text" id="numpiece_<%=i%>" value=""/></td>
				<td><input name="compte_<%=i%>" type="text" id="compte_<%=i%>" value="<%=Utilitaire.remplacerNull(listeD[iterator].getCompte())%>" readonly/>
				<input type="hidden" id="tiers_<%=i%>" name="tiers_<%=i%>" value=""/></td>
				<td>
					<input name="choix1_<%=i%>" type="button" onClick="pagePopUp('comptabilite/choixCompte.jsp?champReturn=compte_<%=i%>')" value="..." class="submit">
				</td>
				<td><input name="echeance_<%=i%>" type="daty" id="echeance_<%=i%>"/></td>
				<td><input name="libelle_<%=i%>" type="text" id="libelle_<%=i%>" value="<%=Utilitaire.remplacerNull(listeD[iterator].getLibelle())%>"/></td>
				<td><input name="montantdebit_<%=i%>" type="text" id="montantdebit_<%=i%>" value="<%=listeD[iterator].getMontantdebit()%>"/></td>
				<td><input name="montantcredit_<%=i%>" type="text" id="montantcredit_<%=i%>" value="<%=listeD[iterator].getMontantcredit()%>"/></td>
				<td><a onclick="removeLineByIndex(<%=i%>)">X</a></td>
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
			  <input id="taille" name="taille" type="hidden" value="<%=listeD.length+1%>"/>
			  <input id="nbrLigne" name="nbrLigne" type="hidden" value="<%=listeD.length%>"/>
			  <input id="id1" name="id1" type="hidden" value="<%=dD%>"/>
			  <input id="id2" name="id2" type="hidden" value="<%=cD%>"/>
			  <input id="id3" name="id3" type="hidden" value="<%=dU%>"/>
			  <input id="id4" name="id4" type="hidden" value="<%=cU%>"/>
			  <input name="acte" type="hidden" id="acte" value="declarer">
              <input type="submit" name="Submit" value="Enregistrer" class="submit">
			</td>
          <td align="center"><input type="reset" name="annuler" value="R&eacute;tablir" class="submit" /></td>
  <input name="bute" type="hidden" id="bute" value="comptabilite/declaration-adeclarer.jsp">
 <input name="classe" type="hidden" id="classe" value="comptabilite.Ecriture">
  </tr>
</table>
    </td>
        </tr>
</table>










</form>