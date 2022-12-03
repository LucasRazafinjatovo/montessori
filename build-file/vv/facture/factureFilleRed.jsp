<%@page import="user.*" %>
<%@page import="bean.*" %>
<%@page import="utilitaire.*" %>
<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="facture/factureFille.jsp";
		String lien= null;
		facture.SCatService sctserv[] = null;
		String idClient = null;
		//facture.Tva tva = null;
		TypeObjet devEn = null;
        TypeObjet factEn = null;
        facture.FactMere fm = null;
        UserEJB u = null;
        String idFactMere = null;
        bean.TypeObjet unite = null;
        facture.FactureFille ff[]= null;
        String designation = null;
        String qte = null;
        String idUnite = null;
        String pu = null;
        String action = null;
        String idFactureMere = null;
        String refObj = null;
        String reductionF = null;
	facture.Client clt = null;
	String acte = null;
         historique.MapUtilisateur ut=null;
      %>
<%
action = request.getParameter("action");
idFactMere = request.getParameter("idFactMere");
acte = request.getParameter("acte");
try{
	u=(UserEJB)session.getValue("u");
	lien=(String)session.getValue("lien");
         ut=u.getUser();
	if(action == null || action.compareTo("red")==0){
		fm = u.findFactureMere("","",idFactMere,"%","","%","%","%")[0];
		clt = u.findClient(fm.getIdClient(), "%", "%", "%", "%", "%", "%", "%", "%", "%","%")[0];
		//tva = u.findTva("%",String.valueOf(fm.getIdTva()), "", "")[0];
                devEn = u.findTypeObjet("Devise",fm.getIdDeviseEn(),"%")[0];
		factEn = u.findTypeObjet("Devise", fm.getIdFactureEn(), "%")[0];
		ff=u.findFactureFille("%","%","%",idFactMere);
	}else{
		idUnite = request.getParameter("unite");
		designation = request.getParameter("designation");
		qte = request.getParameter("qte");
		pu = request.getParameter("pu");
		reductionF = request.getParameter("reductionF");
		//String idFactureMere, String refObj, String des, String qte, String unite, String pu, String reductionF
		//out.println(request.getParameter("idFactMere")+"scat10"+designation+qte+request.getParameter("idUnite")+pu+reductionF);
		u.createFactureFille(request.getParameter("idFactMere"),"scat10",designation,qte,request.getParameter("idUnite"),pu,reductionF);
		ff=u.findFactureFille("%","%","%",idFactMere);
	}
}catch(Exception e){
%>
                <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
	<%
}
%>

 
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Cr&eacute;ation d'une facture(3) - Ajout des d&eacute;tails</h1>
<table width="450" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
  <tr>
    <td>
	<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="formadd">
        <tr>
          <td width="144" height="23" valign="top" class="left">Date :</td>
          <td width="254" valign="top">&nbsp; <input name="date" type="text" disabled class="champ" id="date" value="<%=Utilitaire.formatterDaty(fm.getDaty())%>" size="10" maxlength="10">
          </td>
        </tr>
        <tr>
          <td width="144" height="23" valign="top" class="left">Date d&eacute;but
            :</td>
          <td width="254" valign="top">&nbsp; <input name="date" type="text" disabled class="champ" id="date" value="<%=Utilitaire.formatterDaty(fm.getPeriodeDebut())%>" size="10" maxlength="10"></td>
        </tr>
        <tr>
          <td width="144" height="23" valign="top" class="left">Date fin :</td>
          <td width="254" valign="top">&nbsp; <input name="date" type="text" disabled class="champ" id="date" value="<%=Utilitaire.formatterDaty(fm.getPeriodeFin())%>" size="10" maxlength="10"></td>
        </tr>
        <tr>
          <td height="23" valign="top" class="left">Nom client :</td>
          <td valign="top">&nbsp; <input name="textfield" type="text" disabled class="champ" value="<%=clt.getNom()%>"></td>
        </tr>
        <tr>
          <td height="23" valign="top" class="left">Note explicative :</td>
          <td valign="top">&nbsp; <textarea name="textarea" cols="40" rows="5" disabled><%=fm.getNoteExplicative()%></textarea></td>
        </tr>
        <tr>
          <td height="23" valign="top" class="left">Facture en :</td>
          <td valign="top"> &nbsp;<%=factEn.getVal()%></td>
        </tr>
        <tr>
          <td height="23" valign="top" class="left">Devise en :</td>
          <td valign="top"> &nbsp;<%=devEn.getVal()%> </td>
        </tr>
        <tr>
          <td height="23" valign="top" class="left">Type de paiement :</td>
          <td valign="top">&nbsp;<%=u.findTypeObjet("TypePaiement",fm.getIdTypePaiement(),"%")[0].getVal()%></td>
        </tr>
        <tr>
          <td height="23" valign="top" class="left">TVA :</td>
          <td valign="top">&nbsp; <input name="textfield3" type="text" class="champ" value="<%=fm.getIdTva()%>" size="3" maxlength="3" disabled>
            % </td>
        </tr>
        <tr>
          <td height="23" valign="top" class="left">R&eacute;duction :</td>
          <td valign="top">&nbsp; <input name="reduction" type="text" disabled class="champ" id="reduction" value="<%=fm.getReduction()%>" size="3" maxlength="3">
            % </td>
        </tr>
      </table></td>
  </tr>
</table>









 <form name="form1" method="post" action="<%=lien%>?but=<%=apres%>">
 <table width="450" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
  <tr>
    <td>
  <table width="100%" border="0" cellpadding="3" cellspacing="0" align="center">
  <!--DWLayoutTable-->
  <tr class="head">
    <td  width="200" valign="top">D&eacute;signation</td>
    <td width="72" valign="top">Quantit&eacute;</td>
    <td width="68" valign="top">Unit&eacute;</td>
    <td width="72" valign="top">PU</td>
      <td  width="50" valign="top">R&eacute;d.</td>
  </tr>
  <tr>
         <td ><input name="designation" type="text" id="designation" size="30" > </td>

      <td width="70"><input name="qte" type="text" id="qte" dir="rtl" size="5"  width="70">
      </td>
        <td valign="top">
        <select  name="idUnite" id="idUnite">
      <%
          for(int i=0;i<u.findTypeObjet("unite","%","%").length;i++){
          %>


        <option value=<%=u.findTypeObjet("unite","%","%")[i].getId()%>><%=u.findTypeObjet("unite","%","%")[i].getVal()%></option>


                <%
                }
                %>

            </select></td>
        <td><input name="pu" type="text" id="pu" dir="rtl" size="15" maxlength="15"></td>
  <td><input name="reductionF" type="text" id="reductionF" dir="rtl" value="0" size="5" maxlength="3"  width="50"></td>
  </tr>

</table>
</td></tr></table>

  <input name="action" type="hidden" id="action" value="ajouter">
  <input name="idFactMere" type="hidden" id="" value="<%=fm.getIdFactureMere()%>">
  <br>
<div align="center">
        <input type="submit" name="Submit" value="Ajouter" onClick="MM_validateForm('designation','','R','qte','','RisNum','pu','','RisNum');return document.MM_returnValue" disabled>
        <input type="reset" name="Submit2" value="Annuler">
      </div></form>

<%
if(ff != null){
%>

<table width="600" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
  <tr><td>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">

  <tr class="head">
    <td width="66"  height="20">&nbsp;RefObjet</td>
          <td width="132">&nbsp; D&eacute;signation </td>
          <td width="57"><div align="center">&nbsp; PU</div></td>
          <td width="41">&nbsp; Qt&eacute; </td>
          <td width="58">&nbsp; Unit&eacute; </td>
          <td width="32">&nbsp;R&eacute;d.</td>
          <td width="142" align="center" valign="middle">&nbsp; Montant</td>
<%
%>
          <td width="26" align="center" valign="middle">&nbsp;</td>
<%
%>
        </tr>
		<%

		for(int i=0;i<ff.length;i++){

        %>
     <tr>
          <td width="66"  height="20">&nbsp;<%=ff[i].getRefObj()%></td>
          <td width="132"><%=ff[i].getDesignation()%> </td>
          <td width="57"><div align="center"><%=Utilitaire.formaterAr((double)ff[i].getPrixUnitaire())%></div></td>
          <td width="41"><div align="center"><%=ff[i].getQuantite()%></div></td>
          <td width="58"><div align="center"><%=u.findTypeObjet("unite",ff[i].getIdUnite(),"%")[0].getVal()%></div></td>
          <td width="32"><div align="center"><%=ff[i].getReduction()%></div></td>
          <td width="142" align="center" valign="middle"><%=Utilitaire.formaterAr(ff[i].getMontant())%></td>

          <td width="26" align="center" valign="middle">&nbsp;</td>

        </tr>
        <%
        }
		%>
		</table>
		</td></tr></table>
                <form name="form2" method="post" action="<%=lien%>?but=facture/apresFactureFinal.jsp">
  <div align="center">
       <input type="hidden" value="<%=Utilitaire.formatterDaty(fm.getDaty())%>" name="daty">
      <input type="hidden" value="<%=Utilitaire.formatterDaty(fm.getPeriodeDebut())%>" name="periodeDebut">
      <input type="hidden" value="<%=Utilitaire.formatterDaty(fm.getPeriodeFin())%>" name="periodeFin">
      <input type="hidden" value="<%=fm.getIdClient()%>" name="idClient">
      <input type="hidden" value="<%=fm.getIdTva()%>" name="idTva">
      <input type="hidden" value="<%=fm.getIdFactureEn()%>" name="idFactureEn">
      <input type="hidden" value="<%=fm.getIdDeviseEn()%>" name="idDeviseEn">
      <input type="hidden" value="<%=fm.getReduction()%>" name="reduction">
      <input type="hidden" value="<%=fm.getIdSCatService()%>" name="idSCatService">
      <input type="hidden" value="<%=fm.getIdTypePaiement()%>" name="idTypePaiement">
      <input type="hidden" value="<%=fm.getIdFactureMere()%>" name="idFactMere">
      <input type="hidden" value="<%=fm.getNoteExplicative()%>" name="noteExplicative">
     <input type="hidden" value="finalise" name="acte">
     <input type="submit" class="submit" value="Finaliser la facture">
  </div>
</form>
<%
  }
%>

