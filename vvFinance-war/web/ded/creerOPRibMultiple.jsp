<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="affichage.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%
    String[] listeRib = request.getParameterValues("id");
    String req = Utilitaire.stringToTab(listeRib, "'", ",");

	Liste lst = new Liste();
	lst.makeListeMois();

	TypeObjet to1 = new TypeObjet();
        to1.setNomTable("beneficiaire");
	TypeObjet[] entite = (TypeObjet[])CGenUtil.rechercher(to1, null, null, "");


	TypeObjet to2 = new TypeObjet();
    to2.setNomTable("typesortie");
	TypeObjet[] tplc = (TypeObjet[])CGenUtil.rechercher(to2, null, null, "");
%>
<form action="<%=(String)session.getValue("lien")%>?but=finance/apresRib.jsp" method="post" name="listeop" id="listeop">
  <input type="hidden" name="acte" id="acte" value="payerribc"/>
  <input type="hidden" name="req" id="req" value="<%=req%>"/>
<input type="hidden" name="bute" id="bute" value="ded/rib-multiple.jsp"/>
	<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
		<tr>
			<td><table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
					<tr>
						<td class="left">Client/Fournisseur : <span class="remarque">*</span></td>
						<td align="center"><input name="fournisseur" type="text" class="champ"  id="fournisseur"/></td>
						<td align="left">&nbsp;<input name="choix3" type="button" onClick="pagePopUp('ded/choix_tiers.jsp?champReturn=fournisseur')" value="..." class="submit"><img src="images/blank.gif" width="16" height="16" align="absmiddle"></td>
					</tr>

				<tr>
					<td class="left">Date de paiement: </td>
					<td align="center"><input type="text" class="champ" name="dateDePaiement" value="<%=Utilitaire.dateDuJour()%>"/></td>
					<td class="left">&nbsp;</td>
				</tr>
				<tr>
					<td class="left">Type: </td>
					<td align="center">
					  <select name="typeprevu" class="champ">
						<option value="prevu">Prevu</option>
						<option value="imprevu">Imprevu</option>
					  </select>
					</td>
					<td class="left">&nbsp;</td>
				</tr>
				<tr>
					<td class="left">Remarque</td>
					<td align="center"> <textarea name="remarquePaiement" style="width: 200px; height: 50px;" class="champ" id="remarquePaiement" maxlength="100" ></textarea></td>
					<td class="left">&nbsp;</td>
				</tr>
				<tr>
					<td class="left">Type LC: </td>
					<td align="center">
					  <select name="typelc" class="champ">
						<%
							for(int i = 0; i < tplc.length; i++){
							%>
							<option value="<%=tplc[i].getId()%>"><%=tplc[i].getVal()%></option>
							<%
							}
							%>
					  </select>
					</td>
					<td class="left">&nbsp;</td>
				</tr>
				<tr>
					<td class="left">Mois: </td>
					<td align="center">
						<select name="mois" class="champ">
							<%
							for(int i = 0; i < lst.getValeurBrute().length; i++){
							%>
							<option value="<%=lst.getColValeurBrute()[i]%>"><%=lst.getValeurBrute()[i]%></option>
							<%
							}
							%>
					  </select>
					</td>
					<td class="left">&nbsp;</td>
				</tr>
				<tr>
					<td class="left">Année: </td>
					<td align="center"> <input type="text" class="champ" name="annee" value="<%=Utilitaire.getAneeEnCours()+""%>"/></td>
					<td class="left">&nbsp;</td>
				</tr>
				<tr>
					<td class="left">Entité: </td>
					<td align="center">
					  <select name="entite" class="champ" multiple="true">
						<%
							for(int i = 0; i < entite.length; i++){
							%>
							<option value="<%=entite[i].getId()%>"><%=entite[i].getVal()%></option>
							<%
							}
							%>
					  </select>
					</td>
					<td class="left">&nbsp;</td>
				</tr></table>
			</td>
		</tr>
	</table>
	<input class="submit" type="submit" value="Valider"/>
</form>
