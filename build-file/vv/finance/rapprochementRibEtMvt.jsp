<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.*" %>
<%@ page import="ded.Ded" %>
<%@ page import="ded.OrdonnerPayement" %>
<%@ page import="affichage.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>

<%
try{
	UserEJB u = (user.UserEJB)session.getValue("u");
	Rib rib = u.findDetailRib(request.getParameter("idrib"));

	String[] idmv = Utilitaire.split(request.getParameter("idmvt"),",");
	MvtCaisseTous[] mvt = new MvtCaisseTous[idmv.length];
	for(int i = 0; i < idmv.length; i++){
		MvtCaisseTous[] mvts = (MvtCaisseTous[])CGenUtil.rechercher(new MvtCaisseTous(),null,null," and id like '%"+idmv[i]+"%'");
		mvt[i] = mvts[0];
	}


%>

</br>
VOTRE CHOIX
<table width="100%"  border="0" class="monographe">
  <tr>
    <td width="27%" class="left">Num <%=request.getParameter("idrib")%></td>
    <td width="73%"><div align="center"><%=rib.getDesignation()%></div></td>
  </tr>
  <tr>
    <td class="left">Num Cheque</td>
    <td><div align="center"><%=rib.getNumcheque()%></div></td>
  </tr>
  <tr>
    <td class="left">Caisse</td>
    <td><div align="center"><%=u.getDetailCaisse(rib.getCaisse())%>: (<%=rib.getCaisse()%>)</div></td>
  </tr>
  <tr>
    <td class="left">Montant</td>
    <td><div align="center"><% if(rib.getDebit() > 0) out.println(Utilitaire.formaterAr(rib.getDebit())); else out.println(Utilitaire.formaterAr(rib.getCredit()));%> Ar </div></td>
  </tr>
</table><br>
<table width="100%"><tbody><tr>

		<td align="center"><a class="submit" href="<%=session.getValue("lien")%>?but=finance/modifRib.jsp&idrib=<%=request.getParameter("idrib")%>" target="_blank">Modifier RIB</a></td></tr></tbody>
	</table>
<h1>Lister des Mouvements de caisse selectionnée</h1>

<table width="100%"  border="0" class="monographe">
	<tr>
		<td class="left"></td>
		<td class="left">Caisse</td>
		<td class="left"><div align="center">Débit</div></td>
		<td class="left"><div align="center">Crédit</div></td>
		<td class="left"><div align="center">Num Chéque</div></td>
		<td class="left"><div align="center">Designation</div></td>
		<td class="left"><div align="center">Action</div></td>
	</tr>
	<% for(int i = 0; i < mvt.length; i++){%>
	<tr>
		<td class="left"> <%=mvt[i].getId()%></td>
		<td><div align="center"><%=mvt[i].getIdcaisse()%></div></td>
		<td><div align="center"><%=Utilitaire.formaterAr(mvt[i].getDebit())%></div></td>
		<td><div align="center"><%=Utilitaire.formaterAr(mvt[i].getCredit())%></div></td>
		<td><div align="center"><%=mvt[i].getNumcheque() %></div></td>
		<td><div align="center"><%=mvt[i].getDesignation()%></div></td>
		<td><div align="center"><a href="<%=session.getValue("lien")%>?but=finance/modifierMVTCaisse.jsp&amp;id=<%=mvt[i].getId()+"&idrib="+request.getParameter("idrib")+"&idmvt="+request.getParameter("idmvt")%>">Modifier</a></div></td>
	</tr>
	<%}%>
</table><br>
<form action="<%=session.getValue("lien")%>?but=finance/apresRib.jsp" method="post" name="listePub" id="listePub">
	<input type="hidden" name="idrib" value="<%=request.getParameter("idrib")%>">
	<input type="hidden" name="idmvt" value="<%=request.getParameter("idmvt")%>">
	<input name="acte" type="hidden" id="nature" value="ribupdate">
	<input name="bute" type="hidden" id="bute" value="finance/listeribnonr.jsp">
	<input name="classe" type="hidden" id="classe" value="finance.RapprochementBancaire">
	<table width="100%"><tbody><tr>
		<td align="center"><input type="submit" name="Submit2" value="Valider" class="submit" tabindex="61"></td>
		<td align="center"><input type="reset" name="Submit2" value="Annuler" class="submit" tabindex="62"></td></tr></tbody>
	</table>
</form>
<%
}catch(Exception e){
	e.printStackTrace();
	%>
	<script language="JavaScript"> alert('<%=e.getMessage()%>');history.back(); </script>
	<%
	return;
}
%>