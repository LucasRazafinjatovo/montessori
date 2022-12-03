<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ded.*" %>
<%@ page import="java.lang.reflect.Field" %>
<script>

</script>
<%
String id = request.getParameter("numObjet");

OrdonnerPayement cri = new OrdonnerPayement();
cri.setNomTable("OrdonnerRecette");
cri.setId(id);
OrdonnerPayement[] dem = (OrdonnerPayement[])CGenUtil.rechercher(cri,null,null,"");

UserEJB u 	=  (UserEJB)session.getAttribute("u");
String lien = (String)session.getValue("lien");

java.sql.Date datedujour = Utilitaire.dateDuJourSql();


/************************************************************/
%>
<h1>Dupliquer OP</h1>


<form action="<%=lien%>?but=ded/plan_duplicationOR.jsp" method="post" name="payement" id="planRemboursement">
	<table border="0px" class="monographe">
		<tr>
			<td class="left" height="25px" >Remarque</td>
			<td height="25px" align="center"><%=id%></td>
		</tr>
		<tr>
			<td class="left" height="25px" >Montant</td>
			<td height="25px" align="center"><%=dem[0].getMontant()%></td>
		</tr>
		<tr>
			<td class="left" height="25px" >Du:</td>
			<td height="25px" align="center"><input type="text" tabindex="0" id="datyinf" name="datyinf"></td>
		</tr>
		<tr>
			<td class="left" height="25px" >à:</td>
			<td height="25px" align="center"><input type="text" tabindex="1" id="datysup" name="datysup"></td>
		</tr>
		<tr>
			<td class="left" height="25px">Option de duplication:</td>
			<td height="25px" align="center">
				<select name="reccurrence" >
					<option value="28"> Mensuel </option>
					<option value="7"> Hebdomadaire </option>
				</select>
			</td>
		</tr>
		<tr>
			<td class="left" height="25px" >Jour(s)</td>
			<td height="25px" align="center">
				<input type="checkbox" tabindex="3" value="1" id="jours" name="jours">Lun.
				<input type="checkbox" tabindex="4" value="2" id="jours" name="jours">Mar.
				<input type="checkbox" tabindex="5" value="3" id="jours" name="jours">Mer.
				<input type="checkbox" tabindex="6" value="4" id="jours" name="jours">Jeu.
				<input type="checkbox" tabindex="7" value="5" id="jours" name="jours">Ven.
				<input type="checkbox" tabindex="8" value="6" id="jours" name="jours">Sam.
			</td>
		</tr>
    </table>

	<table>
        <tr>
			<td align="center">
				<input class="submit" type="submit"  value="Continuer" name="Submit2">
				<input  type="hidden"  value="av_dupl" name="acte">
				<input  type="hidden"  value="<%=id%>" name="numObjet">
				<input  type="hidden"  value="<%=dem[0].getMontant()%>" name="montant">
				<input  type="hidden"  value="<%=dem[0].getRemarque()%>" name="remarque">
			</td>
		</tr>
	</table>
</form>


