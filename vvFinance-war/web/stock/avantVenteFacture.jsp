
<script language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Créer une nouvelle facture (1)</h1>

<form action="modeleAdmin.jsp?but=stock/venteFacture.jsp" method="post" name="factureInit" id="factureInit">
	<table width="500" border="0" cellspacing="0" cellpadding="0" align="center">
		<tbody>
			<tr>
				<td align="center"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="monographe">
				<table>
					<tbody>
						<tr>
							<td width="33%" class="left" height="23"> &nbsp;Date :</td><td width="10%">&nbsp;</td>
							<td width="57%"><input name="date" type="text" class="champ" id="date" value="27/08/2014" size="10" maxlength="10" onblur="cal_prs_date1(date.value)"><a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width="16" height="16" border="0" align="absmiddle"></a><span class="remarque">(date création facture)</span></td>
						</tr>
						<tr>
							<td height="23" class="left"> &nbsp;Date début :</td><td>&nbsp;</td>
							<td><input name="dateDebut" type="text" class="champ" id="dateDebut" value="27/08/2014" size="10" maxlength="10" onblur="cal_prs_date1(dateDebut.value)"><a href="javascript:cal2.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width="16" height="16" border="0" align="absmiddle"></a><span class="remarque">(date debut facture)</span></td>
						</tr>
						<tr>
							<td height="23" class="left"> &nbsp;Date fin :</td><td>&nbsp;</td>
							<td> <input name="dateFin" type="text" class="champ" id="dateFin" value="27/08/2014" size="10" maxlength="10" onblur="cal_prs_date1(dateFin.value)"><span class="remarque"><a href="javascript:cal3.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width="16" height="16" border="0" align="absmiddle"></a>(date fin facture)</span></td>
						</tr>
						<tr>
							<td height="23" class="left"> &nbsp;Client :</td><td>&nbsp;</td>
							<td><input name="idClient" type="text" class="champ" id="idClient2" size="10" maxlength="20" onblur="cal_prs_date1(dateFin.value)"><input name="choix3" type="button" class="submit" onclick="pagePopUp('ded/choix_tiers.jsp?champReturn=idClient')" value="..."></td>
						</tr>
						<tr>
							<td height="23" valign="top" class="left">Note explicative :</td><td>&nbsp;</td>
							<td valign="top">&nbsp;<textarea name="note" cols="30" rows="5" id="note">-</textarea></td>
						</tr>
					</tbody>
				</table>
			</tr>
			<tr>
				<td height="30">
					<table width="75%" border="0" align="center" cellpadding="0" cellspacing="0">
						<tbody>
							<tr>
								<td width="50%" height="30">
									<div align="center">
										<input name="idpub" type="hidden" value="null">
										<input name="typefact" type="hidden" value="normale">
										<input name="prixunit" type="hidden" value="<%=request.getParameter("prixunit")%>">
										<input name="designation" type="hidden" value="<%=request.getParameter("designation")%>">
										<input name="quantite" type="hidden" value="<%=request.getParameter("quantite")%>">
										<input type="submit" name="Submit" value="Créer" class="submit" onclick="MM_validateForm('date','','R','dateDebut','','R','dateFin','','R');return document.MM_returnValue">
									</div>
								</td>
								<td width="50%">
									<div align="center">
										<input name="reset" type="reset" class="submit" value="Réinitialiser">
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</td>
			</tr>
		</tbody>
	</table>
</form>
<p align="center">&nbsp;</p>
<script language="javascript">
var cal1 = new calendar1(document.forms['factureInit'].elements['date']);
cal1.year_scroll = false;
cal1.time_comp = false;
var cal2 = new calendar1(document.forms['factureInit'].elements['dateDebut']);
cal2.year_scroll = false;
cal2.time_comp = false;
var cal3 = new calendar1(document.forms['factureInit'].elements['dateFin']);
cal3.year_scroll = false;
cal3.time_comp = false;
</script>

                  </div>