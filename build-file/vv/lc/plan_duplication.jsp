<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ded.*" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.lang.reflect.Field" %>
<script>

</script>
<%
String id = request.getParameter("numObjet");
UserEJB u 	=  (UserEJB)session.getAttribute("u");
String classeLC = request.getParameter("classeLC");
String apresDupl = request.getParameter("apresDupl");


String lien = (String)session.getValue("lien");
String remarque = request.getParameter("remarque");
String montant = request.getParameter("montant");

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
<h1>Dupliquer LC</h1>

<form action="<%=lien%>?but=lc/apresLC.jsp" method="post" name="payement" id="planRemboursement">
	<table border="0px" class="monographe">
	<tr>
		<td class="left" height="25px" align="center">Remarque</td>
		<td class="left" height="25px" align="center">Montant</td>
		<td class="left" height="25px" align="center">Mois</td>
		<td class="left" height="25px" align="center">Annee</td>
	</tr>
	<% for (int iterator=0; iterator<listMois.length; iterator++){ %>
    <tr>
    	<td>
			<input name="remarque<%=iterator%>" type="text" value="<%=remarque%>" />
		</td>
    	<td><input name="montant<%=iterator%>" type="text" value="<%=montant%>" /></td>
        <td><select name="mois<%=iterator%>" >
        	<% for (int i=0; i<mois.length; i++) {%>
				<option value="<%=i+1%>"<%if(listMois[iterator].intValue() == i+1){%> selected="selected"<%}%>><%=mois[i]%> </option>
            <% }%>
            </select></td>
        <td><input name="annee<%=iterator%>" type="text" value="<%=annee%>" /></td>
    </tr>
	<%
		}
	%>
</table>
	<input name="acte" type="hidden" id="nature" value="dupliquer">
	<input name="classeLC" type="hidden" id="classe" value="<%=classeLC%>">
	<input name="apresDupl" type="hidden" value="<%=apresDupl%>">
	
	<input name="nbPR" type="hidden" id="nbPR" value="<%=listMois.length%>">
    <input name="numObjet" type="hidden" id="numObjet" value="<%=id%>">
	<table>
        <tr>
			<td align="center"> <input class="submit" type="submit" tabindex="31" value="valider" name="Submit2"> </td>
			<td align="center"> <input class="submit" type="reset" tabindex="32" value="Annuler" name="Submit2"> </td>
		</tr>
	</table>
</form>



