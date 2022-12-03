<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
	String lien = ((String)session.getValue("lien"));
%>
<h1>Modifier Prevision Depense</h1>
<form action="<%=lien%>?but=pub/apresTarif.jsp" method="post" name="PrevisionDepense" id="PrevisionDepense">
	<table width="60%"><tbody><tr><td>
	<table width="100%" class="monographe">
		<tbody>
			<tr>
				<td align="rigth" width="30%" class="left">ID</td>
				<td align="center" width="60%"><input name="id" type="textbox" class="champ" id="id" value="<%=request.getParameter("idprev")%>" tabindex="1" readonly="true"></td>
				<td width="10%"></td>
			</tr>
			<tr>
				<td align="rigth" width="30%" class="left">Date</td>
				<td align="center" width="60%"><input name="daty" type="textbox" class="champ" id="daty" value="<%=Utilitaire.convertDatyFormtoRealDatyFormat(request.getParameter("daty"))%>" tabindex="2"></td>
				<td width="10%"></td>
			</tr>
			<tr>
				<td align="rigth" width="30%" class="left">Montant</td>
				<td align="center" width="60%"><input name="montant" type="textbox" class="champ" id="montant" value="<%=request.getParameter("montant")%>" tabindex="3"></td>
				<td width="10%"></td>
			</tr>
			<tr>
				<td align="rigth" width="30%" class="left">Description</td>
				<td align="center" width="60%"><textarea name="remarque" class="champ" id="remarque" ><%=request.getParameter("remarque")%></textarea></td>
				<td width="10%"></td>
			</tr>
		</tbody>
	</table>
	</td>

	</tr><tr><td><table width="100%"><tbody>
		<tr><td align="center"><input type="submit" name="Submit2" value="valider" class="submit" tabindex="61"></td><td align="center"><input type="reset" name="Submit2" value="Annuler" class="submit" tabindex="62"></td>
		</tr>
		</tbody></table></td></tr></tbody></table>

	<input name="acte" type="hidden" id="nature" value="update">
	<input name="bute" type="hidden" id="bute" value="prevision/listePrevisionDepesne.jsp">
	<input name="classe" type="hidden" id="classe" value="prevision.PrevisionDepense">
</form>
