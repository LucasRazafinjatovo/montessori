<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="finance.*" %>
<%@ page import="ded.*" %>
<%@ page import="affichage.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%
try{
	MvtCaisse p = new MvtCaisse();
	p.setNomTable("MVTCAISSETOUS");
	MvtCaisse[] list = (MvtCaisse[])CGenUtil.rechercher(p, null, null, " and daty = '" + request.getParameter("daty") + "' and debit = 0");
		
%>
<h1>D&eacute;tails mvt recette du <%=request.getParameter("daty")%></h1>


<table width="100%" border="0" align="center" cellpadding="3" cellspacing="3" class="monographe">
	<tbody>
			<tr class="head">
					<td align="center" valign="top">ID</td>
					<td align="center" valign="top">Date</td>
					<td align="center" valign="top">Designation</td>
					<td align="center" valign="top">Montant</td>
					<td align="center" valign="top">Caisse</td>
			</tr>
			<%

			try{
				for(int i = 0; i < list.length; i++){
					%>
					<tr onmouseover="this.style.backgroundColor='#EAEAEA'" onmouseout="this.style.backgroundColor=''">
						<td align="center"><%=list[i].getId()%></td>
						<td align="center"><%=Utilitaire.convertDatyFormtoRealDatyFormat(list[i].getDaty()+"")%></td>
						<td align="left"><%=list[i].getDesignation()%></td>
						<td align="right"><%=Utilitaire.formaterAr(list[i].getCredit())%></td>
						<td align="left"><%=list[i].getIdCaisse()%></td>
					</tr>
					<%

				}
			}
			catch(Exception ex){
				ex.printStackTrace();
			}
			%>
	</tbody>
</table>

<%
}
catch(Exception exc){
	exc.printStackTrace();
}
%>