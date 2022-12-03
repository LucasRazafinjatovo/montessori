<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%!
        String apres="finance/apresEntree.jsp";
        String lien= null;
        UserEJB u = null;
        TypeObjet tyo[] = null;
        TypeObjet dev[] = null;
        Client clt[] = null;
        TypeObjet mp[] =null;
        TypeObjet source[] =null;
		TypeObjet ag[] =null;
        Caisse caiss[] = null;
		String idFact = null;

     %>
<%
idFact=request.getParameter("idFacture");
if(idFact == null) idFact = "";
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
tyo = u.findTypeObjet("TypeEntree","%","%");
clt = u.findClient("%", "%", "%", "%", "%", "%", "%", "%", "%", "%", "%");
mp = u.findTypeObjet("ModePaiement","%","%");
ag = u.findTypeObjet("Agence","%","%");
dev = u.findTypeObjet("Devise","%","%");
source = u.findTypeObjet("Beneficiaire","%","%");
caiss = u.findCaisse("%","%","%","%");

}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
//out.println(datyinf + datySup + client + idEtat + idCatServ + idSsCatServ + numFact);
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Enregistrement d'une recette</h1>
<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
<tr>
    <td class="remarque"> Il ya deux (2) façons d'enregistrer une recette : soit
      une recette relative à une facture (paiement integrale ou partielle), soit
      une nouvelle recette.</td>
</tr>
</table>
<h2>Recette &agrave; partir d'une facture existante</h2>

<form action="<%=lien%>?but=finance/entreeFact.jsp" method="post">
<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
          <!--DWLayoutTable-->
          <tr>
          <td class="left">Numero facture :</td>
          <td align="center">
<input name="numFact" type="text" class="champ" id="numFact" value="<%=idFact%>">
            <input name="acte2" type="hidden" id="acte2" value="INSERT">
              <a href="<%=lien%>?but=facture/listeChoixFactureVide.jsp">[Chercher]</a></td>
        </tr>


      </table></td>
  </tr>
  <tr>
    <td height="30" align="center">
      <table width="75%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td align="center">
<input type="submit" name="Submit2" value="Envoyer" class="submit" onClick="MM_validateForm('numFact','','R');return document.MM_returnValue">
            </td>
          <td align="center">
<input type="reset" name="annuler2" value="R&eacute;tablir" class="submit">
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</form>
<h2>Ajouter nouvelle recette </h2>
<form action="<%=lien%>?but=<%=apres%>" method="post" name="recette" id="recette" target="_parent" onsubmit="return (verifie(daty.value)&&verifie(designation.value)&&verifie(montant.value))">

<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td> <table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
          <tr>
            <td class="left">Date : <span class="remarque">*</span></td>
            <td align="center"> <input name="daty" type="text" class="champ" id="date" value="<%=Utilitaire.dateDuJour()%>" size="10" maxlength="10">
              &nbsp; <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>
            </td>
          </tr>
          <tr>
            <td class="left">D&eacute;signation : <span class="remarque">*</span></td>
            <td align="center"> <input name="designation" type="text" class="champ" id="designation">
              &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
          </tr>
          <tr>
            <td class="left">Client : </td>
            <td align="center"> <select name="idClient" class="champ" id="idClient">
                <%
for(int i=0;i<clt.length;i++){
%>
                <option value="<%=clt[i].getIdClient()%>"><%=clt[i].getNom()%></option>
                <%
}
%>
              </select> &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
          </tr>
          <tr>
            <td class="left">Type : </td>
            <td align="center"> <select name="idType" class="champ" id="idType">
                <%
for(int i=0;i<tyo.length;i++){
%>
                <option value="<%=tyo[i].getId()%>"><%=tyo[i].getVal()%></option>
                <%
}
%>
              </select> &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
          </tr>
          <tr>
            <td class="left">Num&eacute;ro pi&egrave;ce : </td>
            <td align="center"> <input name="numPiece" type="text" class="champ" id="numPiece">
              &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
          </tr>
          <tr>
            <td class="left">Montant : <span class="remarque">*</span></td>
            <td align="center"> <input name="montant" type="text" class="champ" id="montant" size="20" maxlength="20">
              &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
          </tr>
          <tr>
            <td class="left">Caisse : </td>
            <td align="center"> <select name="idCaisse" class="champ" id="idCaisse">
                <%
for(int i=0;i<caiss.length;i++){
%>
                <option value="<%=caiss[i].getIdCaisse()%>" <%if(caiss[i].getIdCaisse().compareTo("CE000026")==0) out.println("selected");%>><%=caiss[i].getDescCaisse()%></option>
                <%
}
%>
              </select> &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
          </tr>
          <tr>
            <td class="left">Devise en : </td>
            <td align="center"> <select name="idDevise" class="champ" id="idDevise">
			<option value="Ar">Ar</option>
                <%
for(int i=0;i<dev.length;i++){
%>
                <option value="<%=dev[i].getId()%>"><%=dev[i].getVal()%></option>
                <%
}
%>
              </select> &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
          </tr>
          <tr>
            <td class="left">Mode de paiement : </td>
            <td align="center"> <select name="idModeP" class="champ" id="idModeP">
                <%
for(int i=0;i<mp.length;i++){
%>
                <option value="<%=mp[i].getId()%>"><%=mp[i].getVal()%></option>
                <%
}
%>
              </select> &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
          </tr>
          <tr>
            <td class="left" valign="top">Nom du remettant :</td>
            <td align="center"> <input name="remarque" type="text" class="champ" id="remarque">
              &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
          </tr>
          <tr>
            <td class="left" valign="top">Parution :</td>
            <td align="center"> <input name="parution" type="text" class="champ" id="parution">
              &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
          </tr>
          <tr>
            <td class="left" valign="top">Agence :</td>
            <td align="center"> <select name="agence" class="champ" id="agence">
                <%
for(int i=0;i<ag.length;i++){
%>
                <option value="<%=ag[i].getId()%>" <%if(ag[i].getId().compareTo("ag006")==0) out.println("selected");%>><%=ag[i].getVal()%></option>
                <%
}
%>
              </select>
              &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
          </tr>
          <tr>
            <td class="left" valign="top">Source :</td>
            <td align="center"> <select name="source" class="champ" id="agence">
                <%
for(int i=0;i<source.length;i++){
%>
                <option value="<%=source[i].getId()%>" <%if(source[i].getId().compareTo("BE011")==0) out.println("selected");%>><%=source[i].getVal()%></option>
                <%
}
%>
              </select>
              &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
          </tr>
          <tr>
            <td class="left" valign="top">Num Ligne Crédit :</td>
            <td align="center"> <input name="numLCEntrer" type="text" class="champ" id="numLCEntrer" size="10">
              &nbsp; <input		name="choix3" type="button" onClick="pagePopUp('lc/listeLC.jsp?sender=entree')"
					value="...">
            </td>
          </tr>
        </table></td>
	</tr>
	<tr>
    <td height="30" align="center">
      <table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
          <td align="center"><input name="acte" type="hidden" id="acte" value="INSERT">
              <input type="submit" name="Submit" value="Enregistrer" class="submit">
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
<div align="center">
  <script language="javascript">
var cal1 = new calendar1(document.forms['recette'].elements['daty']);
cal1.year_scroll = false;
cal1.time_comp = false;
</script>
  <span class="remarque">(*) Champs obligatoires</span></div>
