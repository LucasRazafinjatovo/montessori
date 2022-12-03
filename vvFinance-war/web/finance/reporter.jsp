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
<h1>REPORTER LE RESTE DE LA CAISSE</h1>
<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
<tr>
    <td class="remarque"> Reporter le reste de la caiss.</td>
</tr>
</table>
<h2>&nbsp;</h2>

<h2>&nbsp;</h2>
<form action="<%=lien%>?but=<%=apres%>" method="post" name="recette" id="recette" target="_parent" onsubmit="return (verifie(daty.value)&&verifie(designation.value)&&verifie(montant.value))">

<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td> <table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
          <tr>
            <td class="left">Date de report : <span class="remarque">*</span></td>
            <td align="center"> <input name="daty" type="text" class="champ" id="date" value="<%=Utilitaire.dateDuJour()%>" size="10" maxlength="10">
              &nbsp; <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>
            </td>
          </tr>
          <tr>
            <td class="left">Montant : <span class="remarque">*</span></td>
            <td align="center"> <input name="montant" type="text" class="champ" id="montant" size="20" maxlength="20">
              &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">
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
            <td class="left">Caisse  : </td>
            <td align="center"> <select name="caisse" class="champ" id="idCaisse">
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
        </table></td>
	</tr>
	<tr>
    <td height="30" align="center">
      <table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
          <td align="center"><input name="acte" type="hidden" id="acte" value="REPORTERCAISSE">
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
