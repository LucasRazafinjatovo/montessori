<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="lc.Direction" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%@ page import="finance.*" %>
<SCRIPT language="JavaScript" src="script.js"></script>
<%!
user.UserEJB u=null;
String lien;
Caisse caiss[] = null;
MvtCaisse[] mvt = null;
String idrib;
String idmvt;
%>
<%
try{
	u = (user.UserEJB)session.getValue("u");
	lien = (String)session.getValue("lien");
	caiss = u.findCaisse("%","%","%","%");
	mvt = (MvtCaisse[])CGenUtil.rechercher(new MvtCaisse(),null,null," and id like '%"+request.getParameter("id")+"%'");
        idrib = request.getParameter("idrib");
        idmvt = request.getParameter("idmvt");
%>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Modifier MVT </h1>
<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
        <td class="remarque" align="center"></td>
    </tr>
</table>
<h2>&nbsp;</h2>
<form action="<%=lien%>?but=pub/apresTarif.jsp" method="post" name="recette" id="recette" target="_parent">
<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td> <table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
            <tr>
				<td class="left">Id : </td>
				<td align="center"><input name="id" type="text" class="champ" id="id"  value="<%=mvt[0].getId()%>" readonly="true"/></td>
				<td align="center">&nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle"> </td>
            </tr>
			<tr>
				<td class="left">Date :  <span class="remarque">*</span></td>
				<td align="center"><input name="daty" type="text" style="border-style : hidden;" id="daty"  readonly value="<%=Utilitaire.convertDatyFormtoRealDatyFormat(mvt[0].getDaty().toString())%>" /></td>
				<td align="left">&nbsp;
				</td>
			</tr>
            <tr>
				<td class="left">Designation : </td>
				<td align="center"><input name="designation" type="text" style="border-style : hidden;" id="designation" readonly  value="<%=mvt[0].getDesignation()%>"/></td>
				<td align="center">&nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle"> </td>
            </tr>
			<tr>
				<td class="left">N° cheque :  <span class="remarque">*</span></td>
				<td align="center"><input name="numcheque" type="text" class="champ" id="numcheque" value="<%=mvt[0].getNumcheque()%>"/></td>
				<td align="center">&nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
			</tr>
			<tr>
				<td class="left">Caisse :  <span class="remarque">*</span></td>
				<td align="center"> <select name="idCaisse" class="champ" id="caisse">

				<%
				for(int i=0;i<caiss.length;i++){
				%>
					<option value="<%=caiss[i].getIdCaisse()%>"><%=caiss[i].getDescCaisse()%></option>
                <%
				}
				%>
				</select> </td>
				<td align="center">&nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
			</tr>
			<tr>
				<td class="left">N° reference : </td>
				<td align="center"><%=mvt[0].getNumPiece()%> </td>
				<td align="center"><img src="images/blank.gif" width="16" height="16" align="absmiddle"></td>
			</tr>
			<tr>
				<td class="left">Debit : <span class="remarque">*</span></td>
				<td align="center"><input name="debit" type="text" style="border-style : hidden;" id="debit"  value="<%=mvt[0].getDebit()%>"/></td>
				<td align="center"><img src="images/blank.gif" width="16" height="16" align="absmiddle"></td>
			</tr>
			<tr>
				<td class="left">Credit : <span class="remarque">*</span></td>
				<td align="center"><input name="credit" type="text" style="border-style : hidden;" id="credit"  value="<%=mvt[0].getCredit()%>"/></td>
				<td align="center"><img src="images/blank.gif" width="16" height="16" align="absmiddle"></td>
			</tr>
				<input name="idDevise" type="hidden" id="IdDevise"  value="<%=mvt[0].getIdDevise()%>"/>
				<input name="idMode" type="hidden" id="IdMode"  value="<%=mvt[0].getIdMode()%>"/>
				<input name="remarque" type="hidden" id="remarque"  value="<%=mvt[0].getRemarque()%>"/>
				<input name="agence" type="hidden" id="agence"  value="<%=mvt[0].getAgence()%>"/>
				<input name="tiers" type="hidden" id="tiers"  value="<%=mvt[0].getTiers()%>"/>
				<input name="numPiece" type="hidden" id="numPiece"  value="<%=mvt[0].getNumPiece()%>"/>
				<input name="typeMvt" type="hidden" id="TypeMvt"  value="<%=mvt[0].getTypeMvt()%>"/>
				<input name="datyValeur" type="hidden" id="DatyValeur"  value="<%=Utilitaire.convertDatyFormtoRealDatyFormat(mvt[0].getDatyValeur().toString())%>"/>
				<input name="idOrdre" type="hidden" id="IdOrdre"  value="<%=mvt[0].getIdOrdre()%>"/>
				<input name="numcheque" type="hidden" id="numcheque"  value="<%=mvt[0].getNumcheque()%>"/>
				<input name="etablissement" type="hidden" id="etablissement"  value="<%=mvt[0].getEtablissement()%>"/>
				<input name="idmvtor" type="hidden" id="idmvtor"  value="<%=mvt[0].getIdmvtor()%>"/>
		</table></td>
    </tr>
	<tr>
		<td height="30" align="center">
			<table width="75%" border="0" cellspacing="0" cellpadding="0">
			<tr>
                <td>
					<input name="acte" type="hidden" id="nature" value="update">
					<input name="bute" type="hidden" id="bute" value="finance/rapprochementRibEtMvt.jsp&idrib=<%out.print(idrib);%>&idmvt=<%out.print(idmvt);%>"/>
					<input name="classe" type="hidden" id="classe" value="finance.MvtCaisse">
					<input type="submit" name="valider" value="Modifier" class="submit">
				</td>
				<td align="center">
					<input type="reset" name="annuler" value="R&eacute;tablir" class="submit">
				</td>
			</tr>
			</table>
		</td>
    </tr>
</table>
</form>
<%

}catch(Exception ex){


}

%>
<div align="center">

  <span class="remarque">(*) Champs obligatoires</span></div>