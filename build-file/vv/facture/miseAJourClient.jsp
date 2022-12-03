<%@ page import="user.*"%>
<%@ page import="facture.*"%>
<%@ page import="finance.*"%>
<%@ page import="lc.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="bean.*"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage=""%>
<%!
	String lien = null;
    UserEJB u = null;
	%>
	<%
    u = (user.UserEJB) session.getValue("u");
    lien = (String) session.getValue("lien");
	%>
	<SCRIPT language="JavaScript" src="script.js"></script>
	<script>
		function recupInfoClient($idClient){
			var nom = "";
			$.ajax({
				async: false,
				type: "GET",
				dataType: "html",
				url: 'traitementClientAjax.jsp?recherche='+$idClient+'&action=inforamtion',
				success: function(data) {
					var dataArray = data.split("|");
					nom =  dataArray[9];
				}
			});
			return nom;
		}
		function confirmMessage() {
			clientcible =  $("#clientcible").val();
			clientdepart =  $("#clientdepart").val();
			nomclientcible = recupInfoClient(clientcible);
			nomclientdepart =recupInfoClient(clientdepart);
			message = "Mettre a jour le client: "+nomclientcible+" par le client: "+nomclientdepart+"?" ;
			if (confirm(message)) { // Clic sur OK
				$("#acte").val("MISEAJOUR");
			}else{
				$("#acte").val("ANNULERMISEAJOUR");
			}
		}
	</script>
	<link href="style.css" rel="stylesheet" type="text/css">
	<h1>Mise &agrave; jour client</h1>
	<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td class="remarque">&nbsp;</td>
        </tr>
	</table>
	<h2>Copier &agrave; partir des clients existantes </h2>
	<form action="<%=lien%>?but=facture/apresClient.jsp" method="post" name="client" id="client" target="_parent" onsubmit="confirmMessage()">
		<table width="600" border="0" align="center" cellpadding="0" cellspacing="0">
			<tr>
				<td>
					<table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
                        <tr>
							<td class="left" width="20%" valign="top"><div align="center">Client d&eacute;part:<span class="remarque">*</span></div></td>
                            <td align="center" width="30%">
								<input type="text" name="clientdepart" class="champ" id="clientdepart" />
								<input class="submit" type="button" value="..." onclick="pagePopUp('facture/listeClientChoixPopUp.jsp?champReturn=clientdepart')" name="choix3">
							</td>
                            <td align="center" width="20%">
								<span class="left"><strong>Client cible :</strong><span class="remarque">*</span></span>
							</td>
                            <td align="center" width="30%">
								<input type="text" name="clientcible" class="champ" id="clientcible" />
                                <input class="submit" type="button" value="..." onclick="pagePopUp('facture/listeClientChoixPopUp.jsp?champReturn=clientcible')" name="choix3"></td>
							</tr>
						</table>
					</td>
				</tr>
			<tr>
				<td height="30" align="center">
					<table width="75%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
							<td align="center"><input type="submit" name="Submit"  class="submit" value="Valider"></td>
                            <td align="center"><input type="reset" name="annuler"   value="R&eacute;tablir" class="submit"></td>
                        </tr>
					</table>
                </td>
			</tr>
			<input type="hidden" name="acte"  id="acte" value="MISEAJOUR" class="submit">
			<input type="hidden" name="bute"   value="facture/suppression.jsp" class="submit">
		</table>
	</form>
	<div align="center"><span class="remarque">(*) Champs obligatoires</span>
	<p><u>Client depart:</u> l'identifiant du client à supprimer<br><u>Client cible:</u> l'identifiant du client à mettre à jour</p></div>
