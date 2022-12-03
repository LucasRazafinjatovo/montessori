<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="lc.*" %>
<%@ page import="java.lang.reflect.Field" %>
<script>
function verifier(){
	var month1 = document.getElementById("mois1").value;
	var month2 = document.getElementById("mois2").value;
	var test = month1-month2;
	if (test>0){
		alert('Le mois fin doit etre un mois suivant le mois depart ');
		return false;
	}
	return true;
}
</script>
<%
String[] idLC = request.getParameterValues("id");
String ids = Utilitaire.stringToTab(idLC,"'",",");

String classeLC = request.getParameter("classeLC");
String apresDupl = request.getParameter("apresDupl");


LigneCreditComplet cri = new LigneCreditComplet();
cri.setNomTable(classeLC);
LigneCreditComplet[] dem = (LigneCreditComplet[])CGenUtil.rechercher(cri,null,null," and idLigne in ("+ids+")");

UserEJB u 	=  (UserEJB)session.getAttribute("u");
String lien = (String)session.getValue("lien");

java.sql.Date datedujour = Utilitaire.dateDuJourSql();

String mois[] = Constante.getMois();
String moisRang[] = Constante.getMoisRang();
/************************************************************/
%>
<h1>Dupliquer LC</h1>


<form action="<%=lien%>?but=lc/plan_duplicationMultiple.jsp" method="post" name="payement" id="planRemboursement" onsubmit="return verifier()">
	<table border="0px" class="monographe">
		<tr>
			<td class="left" height="25px" >Du : </td>
			<td height="25px" align="center">
			<select name="mois1" class="champ" id="mois1">
				<%
					for(int i=0;i<mois.length;i++){
				%>
						<option value="<%=moisRang[i]%>"><%=mois[i]%></option>
                <%
					}
                %>
			</select>
			</td>
		</tr>
		<tr>
			<td class="left" height="25px" >Au : </td>
			<td height="25px" align="center">
			<select name="mois2" class="champ" id="mois2">
				<%
					for(int i=0;i<mois.length;i++){
				%>
						<option value="<%=moisRang[i]%>"><%=mois[i]%></option>
                <%
					}
                %>
			</select>
			</td>
		</tr>
		<tr>
			<td class="left" height="25px" >Ann&eacute;e:</td>
			<td height="25px" align="center"><input type="text" name="annee" class="champ" id="annee" value="<%=String.valueOf(Utilitaire.getAneeEnCours()) %>" /></td>
		</tr>
		<tr>
			<td class="left" height="25px">Option de duplication:</td>
			<td height="25px" align="center">
				<select name="reccurrence" >
					<option value="1"> Mensuel </option>
					<option value="2"> Bimestriel </option>
					<option value="3"> Trimestre </option>
					<option value="6"> Semestriel </option>
				</select>
			</td>
		</tr>
    </table>
	
	<table width="100%" border="0px" class="monographe">
		<tr>
			<td width="35%">Designation</td>
			<td width="20%">Credit</td>
			<td width="15%">Type</td>
			<td width="15%">Direction</td>
			<td width="15%">Entite</td>
		</tr>
	
		<%	for(int i=0;i<dem.length;i++){ %>
			<tr>
				<td><%=dem[i].getDesignation()%></td>
				<td><%=Utilitaire.formaterAr(dem[i].getCreditInitial())%></td>
				<td><%=dem[i].getTypeLC()%></td>
				<td><%=dem[i].getAbbrevdir()%></td>
				<td><%=dem[i].getEntite()%></td>
			</tr>
        <%	} %>
	</table>
	
	<table>
        <tr>
			<td align="center"> 
				<input class="submit" type="submit"  value="Continuer" name="Submit2"> 
				<input  type="hidden"  value="av_dupl" name="acte"> 
				<input  type="hidden"  value="<%=ids%>" name="numObjet"> 
				<input  type="hidden"  value="<%=classeLC%>" name="classeLC"> 
				<input type="hidden" name="apresDupl" value="<%=apresDupl%>">
			</td>
		</tr>
	</table>
</form>


