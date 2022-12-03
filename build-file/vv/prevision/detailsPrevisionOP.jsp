<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="prevision.*" %>
<%@ page import="ded.*" %>
<%@ page import="affichage.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%
try{
	OrdonnerPayementLC p = new OrdonnerPayementLC();
	p.setNomTable("OrdonnerPayementLC");
	OrdonnerPayementLC[] list = (OrdonnerPayementLC[])CGenUtil.rechercher(p, null, null, " and daty = '" + request.getParameter("daty") + "'");
	String lien = (String)session.getValue("lien");
%>
<h1>D&eacute;tails Pr&eacute;vision d&eacute;pense du <%=request.getParameter("daty")%></h1>


<table width="100%" border="0" align="center" cellpadding="3" cellspacing="3" class="monographe">
	<tbody>
			<tr class="head">
					<td align="center" valign="top">ID</td>
					<td align="center" valign="top">Date</td>
					<td align="center" valign="top">Designation LC</td>
					<td align="center" valign="top">Montant</td>
			</tr>
			<%

			try{
				for(int i = 0; i < list.length; i++){
					%>
					<tr onmouseover="this.style.backgroundColor='#EAEAEA'" onmouseout="this.style.backgroundColor=''">
						<td align="center">
							<a href="<%=lien%>?but=finance/modifierOPPrevision.jsp&id=<%=list[i].getId()%>"><%=list[i].getId()%></a>
						</td>
						<td align="center"><%=Utilitaire.convertDatyFormtoRealDatyFormat(list[i].getDaty()+"")%></td>
						<td align="left"><%=list[i].getDesignationlc()%></td>
						<td align="right"><%=Utilitaire.formaterAr(list[i].getMontant())%></td>
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