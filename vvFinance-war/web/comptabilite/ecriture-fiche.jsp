<%@ page import="user.*" %>
<%@ page import="comptabilite.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%
	String apres="comptabilite/apresCompta.jsp";
	String lien= null;
    String numero = null;
	Ecriture ecritures[] = null;
    UserEJB u = null;
	Ecriture fc = null;

try{
	fc = new Ecriture();
	fc.setNomTable("ecriture_libelle2");
	numero = request.getParameter("numero");
	u=(user.UserEJB)session.getValue("u");
	lien=(String)session.getValue("lien");
	ecritures=(Ecriture[])CGenUtil.rechercher(fc,null,null," and numero = "+numero);
	if (ecritures.length == 0){ %>
		<script language="JavaScript"> 
			alert('Pas de resultat');
			history.back();
		</script>
	<%}
}
catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
<div id="selectnone">
<link href="style.css" rel="stylesheet" type="text/css">
<h2>D&eacute;tails Ecriture N° <font color="15"><%=numero%></font></h2>
<table  border="0" cellpadding="0" cellspacing="0" align="center" width="600">
  <tr><td>
	<table  border="0" cellpadding="0" cellspacing="0" align="center" >
        <tr>
          <td width="560" height="23" valign="top">&nbsp;<strong>Soci&eacute;t&eacute;
            : </strong><font color="15"><%=ecritures[0].getSociete()%></font></td>
          <td colspan="2" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
          <td colspan="2" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
        </tr>
        <tr>
          <td height="23" colspan="4" valign="top">&nbsp;<strong>Journal :</strong>
            <font color="15"><%=ecritures[0].getCodejournal()%></font></td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td height="23" valign="top" colspan="5">&nbsp;<strong>Etat : 
		  </strong>&nbsp;<font color="15"><%=ecritures[0].getEtatLibelle()%></font></td>
        </tr>
        <tr>
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" >
              <tr>
                <td  height="23" valign="top"> 
				<table width="100%" border="0" cellpadding="0" cellpadding="5" cellspacing="2" class="monographe">
                    <tr class="head">
                      <td width="50">Daty </td>
                      <td>N° piece </td>
					  <td>Compte </td>
					  <td>Compte tiers </td>
					  <td>Echeance </td>
					  <td>Libelle </td>
					  <td>Montant debit </td>
					  <td>Montant credit </td>
                    </tr>
					
					<%
						for(int i=0;i<ecritures.length;i++){
					%>
                    <tr>
                      <td height="23" valign="top"><font color="15"><%if (ecritures[i].getDaty()!= null) out.print(Utilitaire.datetostring(ecritures[i].getDaty()));%></font></td>
                      <td align="center" valign="top"><font color="15"><%=ecritures[i].getNumpiece()%></font></td>
					  <td align="center" valign="top"><font color="15"><%=ecritures[i].getCompte()%></font></td>
					  <td align="center" valign="top"><font color="15"><%=Utilitaire.champNull(ecritures[i].getComptetiers())%></font></td>
					  <td align="center" valign="top"><font color="15"><%if (ecritures[i].getEcheance()!= null) out.print(Utilitaire.datetostring(ecritures[i].getEcheance()));%></font></td>
					  <td align="center" valign="top"><font color="15"><%=ecritures[i].getLibelle()%></font></td>
                      <td align="right" valign="top"><%=Utilitaire.formaterAr((double)ecritures[i].getMontantdebit())%> &nbsp;</td>
					  <td align="right" valign="top"><%=Utilitaire.formaterAr((double)ecritures[i].getMontantcredit())%> &nbsp;</td>
                    </tr>
                    <%
                    }
                    %>
				</table>
				</td>
			 </tr>
			</table>
		</tr>
	</table>
</td></tr>
</table>
<div align="center">
	<% if (ecritures[0].getEtat() == 1){ %>
	<a href="<%=(String)session.getValue("lien")%>?but=comptabilite/ecriture-update.jsp&numero=<%=numero%>">Modifier</a>
	<a href="<%=(String)session.getValue("lien")%>?but=comptabilite/apresCompta.jsp&acte=visa-ecriture&numero=<%=numero%>&bute=comptabilite/ecriture-avise.jsp">Viser</a>
	<% }
		else if (ecritures[0].getEtat() == 0){ %>
	<a href="<%=(String)session.getValue("lien")%>?but=comptabilite/apresCompta.jsp&acte=extourne-ecriture&numero=<%=numero%>&bute=comptabilite/ecriture-liste.jsp">Extourner</a>
	<% } %>
</div>
  </div>
