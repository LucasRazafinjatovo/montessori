
<script language="javascript">
function page(page_dest){
        document.location=page_dest;
}
function decision(message, url){
if(confirm(message)) location.href = url;
}
</script>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>titre</h1>

<form name="form2" method="post" action="<%=lien%>?but=facture/apresFactureFinal.jsp">
<table width="450" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
  <tr>
    <td>
	<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="formadd">
        <tr>
          <td width="144" height="23" valign="top" class="left">Date :</td>
          <td width="254" valign="top">&nbsp; <input name="date" type="text" disabled class="champ" id="date" value="<%=Utilitaire.formatterDaty(fm.getDaty())%>" size="10" maxlength="10"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle">
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
          <td valign="top">&nbsp; <textarea name="noteExplicative" cols="40" rows="5"><%=fm.getNoteExplicative()%></textarea></td>
        </tr>
        <tr>
          <td height="23" valign="top" class="left">Facture en :</td>
          <td valign="top"> &nbsp;<%=factEn.getVal()%></td>
        </tr>
        <tr>
          <td height="23" valign="top" class="left">Devise en :</td>
          <td valign="top"> </td>
        </tr>
        <tr>
          <td height="23" valign="top" class="left">Type de paiement :</td>
          <td valign="top"></td>
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


  <div align="center">
  
      <input type="hidden" value="finalise" name="acte">

    <p>
      <input type="submit" class="submit" value="Finaliser la facture">
    </p>
  </div>
</form>
<br>
<br>
<hr align="center" color="#0099FF" noshade size="1" width="85%">
<br>
<br>
<h1>Ajouter éléments factures</h1>
<form name="form1" method="post" action="../../application/05-08-08/affichage/facture/<%=lien%>?but=<%=apres%>">
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
        <td><input name="pu" type="text" id="pu" dir="rtl" size="15" maxlength="50"></td>
  <td><input name="reductionF" type="text" id="reductionF" dir="rtl" value="0" size="5" maxlength="3"  width="50"></td>
  </tr>

</table>
</td></tr></table>

  <input name="action" type="hidden" id="action" value="ajouter">
  <input name="idFactMere" type="hidden" id="" value="<%=fm.getIdFactureMere()%>">
  <br>
<div align="center">
        <input type="submit" name="Submit" value="Ajouter" onClick="MM_validateForm('designation','','R','qte','','RisNum','pu','','RisNum');return document.MM_returnValue">
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
          <td width="57"><div align="center"><%=Utilitaire.formaterAr(ff[i].getPrixUnitaire())%></div></td>
          <td width="41"><div align="center"><%=ff[i].getQuantite()%></div></td>
          <td width="58"><div align="center"><%=u.findTypeObjet("unite",ff[i].getIdUnite(),"%")[0].getVal()%></div></td>
          <td width="32"><div align="center"><%=ff[i].getReduction()%></div></td>
          <td width="142" align="center" valign="middle"><%=Utilitaire.formaterAr(ff[i].getMontant())%></td>

    <td width="26" align="center" valign="middle">
	<a href="javascript:decision('Vous voulez vraiment cet élément de la facture?','<%=lien%>?but=facture/apresFactureFille.jsp&idFactMere=<%=idFactMere%>&idFF=<%=ff[i].getIdFactureFille()%>&acte=DELETE&type=USER')">
<img src="../../application/05-08-08/affichage/facture/images/button_drop.png" width="11" height="13" border="0" alt="Supprimer"></a></td>

        </tr>
        <%
        }
		%>
		</table>
		</td></tr></table>

<%


  }
%>

