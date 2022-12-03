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
int ajout = 0;
OrdonnerPayement pj = new OrdonnerPayement();
pj.setNomTable("OrdonnerPayement");
PageInsert pi = new PageInsert(pj,request,(user.UserEJB)session.getValue("u"));

pi.setLien((String)session.getValue("lien"));
String remarque = request.getParameter("remarque");
String montant = request.getParameter("montant");

Liste l = new Liste("mois");
l.makeListeMois();
Object[] mois = (String[])l.getValeurBrute();

java.sql.Date datedujour = Utilitaire.dateDuJourSql();

String[] jours = request.getParameterValues("jours");
Date[] listDaty = u.getListDateDuplication(request.getParameter("datyinf"), request.getParameter("datysup"), jours, request.getParameter("reccurrence"));

int month = Utilitaire.getMois(listDaty[0]);
int year = Utilitaire.getAnnee(listDaty[0]);
int moisCourant = month - 1;
int depart = 0;
/************************************************************/
%>
<h1>Dupliquer OP</h1>
<p><b>Somme:<%out.println(montant);%></b></p>

<form action="<%=pi.getLien()%>?but=ded/apresOrdonnerPayement.jsp" method="post" name="payement" id="planRemboursement">
	<table border="0px" class="monographe">
	<tr>
		<td class="left" height="25px" align="center">Remarque</td>
		<td class="left" height="25px" align="center">Montant</td>
		<td class="left" height="25px" align="center">Mois</td>
		<td class="left" height="25px" align="center">Annee</td>
		<td class="left" height="25px" align="center">Date</td>
	</tr>
		<%
			int i = 0;
			int yeardep = year;
			double somme = 0;
			while (i<listDaty.length){
				
				depart = 0;
		%>
    <tr>
    	<td>
			<input name="remarque<%=i%>" type="text" value="<%=remarque%>" />
		</td>
    	<td><input name="montant<%=i%>" type="text" value="<%=montant%>" /></td>
        <td><select name="mois<%=i%>" onchange="select();" >
        	<% while (depart<mois.length) {%>
			<option value="<%=(depart+1)%>"<%if((Utilitaire.getMois(listDaty[i])-1)==depart){%> selected="selected"<%}%>><%=((String)mois[depart])%> </option>
            <%depart++; }%>
            </select></td>
        <td><input name="annee<%=i%>" type="text" value="<%=Utilitaire.getAnnee(listDaty[i])%>" /></td>
        <td><input name="date<%=i%>" type="text" value="<%=Utilitaire.convertDatyFormtoRealDatyFormat(listDaty[i].toString())%>" /></td>
    </tr>
	<%
		i++ ;
		}
	%>
</table>
	<input name="acte" type="hidden" id="nature" value="dupliquer">
	<input name="classe" type="hidden" id="classe" value="ded.OrdonnerPayement">
	<input name="nbPR" type="hidden" id="nbPR" value="<%=listDaty.length%>">
    <input name="numObjet" type="hidden" id="numObjet" value="<%=id%>">
	<table>
        <tr>
			<td align="center"> <input class="submit" type="submit" tabindex="31" value="valider" name="Submit2"> </td>
			<td align="center"> <input class="submit" type="reset" tabindex="32" value="Annuler" name="Submit2"> </td>
		</tr>
	</table>
</form>



