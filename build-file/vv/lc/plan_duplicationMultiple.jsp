<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="lc.*" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.lang.reflect.Field" %>
<script>

</script>
<%
String ids = request.getParameter("numObjet");
UserEJB u 	=  (UserEJB)session.getAttribute("u");
String classeLC = request.getParameter("classeLC");
String apresDupl = request.getParameter("apresDupl");


LigneCreditComplet cri = new LigneCreditComplet();
cri.setNomTable(classeLC);
LigneCreditComplet[] dem = (LigneCreditComplet[])CGenUtil.rechercher(cri,null,null," and idLigne in ("+ids+")");

String lien = (String)session.getValue("lien");

Liste l = new Liste("mois");
l.makeListeMois();
String[] mois = (String[])l.getValeurBrute();


String classe = request.getParameter("classe");
String mois1 = request.getParameter("mois1");
String mois2 = request.getParameter("mois2");
String annee = request.getParameter("annee");


Integer[] listMois = u.getListMoisDuplication(mois1, mois2, request.getParameter("reccurrence"));

/************************************************************/
%>
<h1>Duplication pour chaque LC</h1>

<form action="<%=lien%>?but=lc/apresLC.jsp" method="post" name="payement" id="planRemboursement">
	<table border="0px" class="monographe">
	<tr>
		<td class="left" height="25px" align="center">Designation</td>
		<td class="left" height="25px" align="center">Montant</td>
		<td class="left" height="25px" align="center">Mois</td>
		<td class="left" height="25px" align="center">Annee</td>
	</tr>
	<% int iterator2 = 0;
	for (int iterator1 = 0; iterator1<dem.length; iterator1++){
			for (int iterator=0; iterator<listMois.length; iterator++){ %>
    <tr>
    	<td>
			<input name="id<%=iterator2%>" type="hidden" value="<%=dem[iterator1].getIdLigne()%>" />
			<input name="remarque<%=iterator2%>" type="text" value="<%=dem[iterator1].getDesignation()%>" />
		</td>
    	<td><input name="montant<%=iterator2%>" type="text" value="<%=dem[iterator1].getCreditInitial()%>" /></td>
        <td><select name="mois<%=iterator2%>" >
        	<% for (int i=0; i<mois.length; i++) {%>
				<option value="<%=i+1%>"<%if(listMois[iterator].intValue() == i+1){%> selected="selected"<%}%>><%=mois[i]%> </option>
            <% }%>
            </select></td>
        <td><input name="annee<%=iterator2%>" type="text" value="<%=annee%>" /></td>
    </tr>
	<%
			iterator2 ++;
		}
			}
	%>
</table>
	<input name="acte" type="hidden" id="nature" value="dupliquerMultiple">
	<input name="nbPR" type="hidden" id="nbPR" value="<%=listMois.length*dem.length%>">
	<input  type="hidden"  value="<%=classeLC%>" name="classeLC">
	<input type="hidden" name="apresDupl" value="<%=apresDupl%>">
	<table>
        <tr>
			<td align="center"> <input class="submit" type="submit" tabindex="31" value="valider" name="Submit2"> </td>
			<td align="center"> <input class="submit" type="reset" tabindex="32" value="Annuler" name="Submit2"> </td>
		</tr>
	</table>
</form>



