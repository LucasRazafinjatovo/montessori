<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%!
	String apres="facture/apresClientChoix.jsp";
	String lien=null;
	UserEJB u=null;
	TypeObjet regime[] = null;

%>
<%
try{
  u=(UserEJB)session.getValue("u");
  lien=(String)session.getValue("lien");
  regime = u.findTypeObjet("Regime","%","%");



}catch(Exception e){
%>
   <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<SCRIPT language="JavaScript" src="jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
$("#autoSuggestionsList").hide();
})
function recherche(obj) {
clearForm();
$.ajax({
    url:'traitementClientAjax.jsp?recherche='+obj.value+'&action=suggestions',
    success:function(data)
    {
    //max-height: 100px;
      if($("#autoSuggestionsList").height() <= 100){
         $("#autoSuggestionsList").css("overflow-y","scroll");
      }
      else{
          $("#autoSuggestionsList").css("overflow-y","none");
      }
      if(data != ""){
        $("#autoSuggestionsList").show();
        $("#autoSuggestionsList").html(data);
      }else{
        $("#autoSuggestionsList").hide();
        $("#idClient").val("");
      }

    }
  });
}
function choixVendeur(obj) {
var nom =  $(obj).html();
var idClient = $(obj).attr("id");
$('#nomClient').val(nom);
$('#autoSuggestionsList').html("");
$("#idClient").val(idClient);
$("#autoSuggestionsList").hide();
$.ajax({
    url:'traitementClientAjax.jsp?recherche='+idClient+'&action=inforamtion',
    success:function(data)
    {
       var dataArray = data.split("|");
       populateForm(dataArray);
    }
  });
}
function populateForm(data){
$("#telephone").val(data[0]);
$("#fax").val(data[1]);
$("#adresse").val(data[2]);
$("#numStat").val(data[3]);
$("#nif").val(data[4]);
$("#rc").val(data[5]);
$("#quittance").val(data[6]);
$("#idRegime").val(data[7]);
$("#tp").val(data[8]);

}
function confirmUpdate(){
   if($("#idClient").val() != ""){
      if (confirm("Mettre à jour le client")) { // Clic sur OK
        $("#acte").val("UPDATE");
      }
      else{
        $("#acte").val("ANNULER");
      }
   }
}
function clearForm(){
       $("#idClient").val("");
       $("#telephone").val("-");
       $("#fax").val("-");
       $("#adresse").val("-");
       $("#numStat").val("-");
       $("#nif").val("-");
       $("#rc").val("-");
       $("#quittance").val("-");
       $("#idRegime").val('reg1');
       $("#tp").val("-");
}
function fill() {
   // $("#autoSuggestionsList").hide();
}
</script>
<style type="text/css">
body {
font-family: Helvetica;
font-size: 13px;
color: #000;
}
h3 {
margin: 0px;
padding: 0px;
}
#autoSuggestionsList {
    height: auto;
    margin: 0 0 0 -27px;
    max-height: 100px;
    min-width: 134px;
    position: absolute;
    width: auto;
}
.suggestionList li {
margin:0px;
padding: 3px;
cursor: pointer;
min-width: 134px;
background-color: #DDDDDD;
list-style-type: none;
}
.suggestionList li:hover {
background-color: #78DDDD;
}

</style>

<link href="style.css" rel="stylesheet" type="text/css">
<h1>Ajouter un nouveau client </h1>
<form action="<%=lien%>?but=<%=apres%>" method="post" onsubmit="return (verifie(nomClient.value)&&verifie(comptable.value));">

	<table width="600" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
	<tr>
            <td valign="top">
              <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" height="100%">
                <!--DWLayoutTable-->
                <tr>
                  <td height="23" valign="top" class="left">Nom du client :</td>
                  <td align="center" valign="top"><div><input name="nomClient" id="nomClient" type="text" class="champ" onkeyup="recherche(this);" onblur="fill();" autocomplete="off">
                        <span class="remarque">(*)</span></div>
                  <input name="idClient" id="idClient" type="hidden">
                  <div class="suggestionList"><ul id="autoSuggestionsList"></ul></div></div></td>
                </tr>
                <tr>
                  <td height="23" valign="top" class="left">T&eacute;l&eacute;phone
                    : </td>
                  <td align="center" valign="top"> <input name="telephone" type="text" class="champ" id="telephone" value="-">
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </td>
                </tr>
                <tr>
                  <td height="23" valign="top" class="left">Fax :</td>
                  <td align="center" valign="top"> <input name="fax" type="text" class="champ" id="fax" value="-">
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </td>
                </tr>
                <tr>
                  <td height="23" valign="top" class="left">Adresse :</td>
                  <td align="center" valign="top"> <textarea name="adresse" rows="4" class="champ" id="adresse">-</textarea>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                </tr>
				<tr>
                  <td height="43" valign="top" class="left"></td>
                  <td align="center" valign="top">
                  </td>
                </tr>
              </table></td>
            <td valign="top">
<table width="100%" height="100%" border="0" align="center" cellpadding="3" cellspacing="0">
                <tr>
                  <td height="23" valign="top" class="left">R&eacute;gime :</td>
                  <td align="left" valign="top">
                    <select name="idRegime" class="champ" id="idRegime">
              <%
for(int i=0;i<regime.length;i++){
%>
              <option value="<%=regime[i].getId()%>"><%=regime[i].getVal()%></option>
              <%
}
%>
            </select>
                  </td>
        </tr>
	<tr>
                  <td height="23" valign="top" class="left">Num&eacute;ro Stat.
                    :</td>
          <td valign="top"><input name="numStat" type="text" class="champ" id="numStat" value="-"></td>
        </tr>
        <tr>
          <td height="23" valign="top" class="left">NIF :</td>
          <td valign="top"><input name="nif" type="text" class="champ" id="nif" value="-"></td>
        </tr>
        <tr>
          <td height="23" valign="top" class="left">RC :</td>
          <td valign="top"><input name="rc" type="text" class="champ" id="rc" value="-"></td>
        </tr>
        <tr>
          <td height="23" valign="top" class="left">Taxe professionnelle:</td>
          <td valign="top" ><input name="tp" type="text" class="champ" id="tp" value="-" size="18">
          </td>
        </tr>
        <tr>
          <td height="23" valign="top" class="left">Quittance :</td>
          <td valign="top" ><input name="quittance" type="text" class="champ" id="quittance" value="-" size="18">
            <!--<input name="acte" type="hidden" id="acte" value="INSERT">--> </td>
        </tr>
		 <tr>

            <td height="30" valign="top" class="left">&nbsp;</td>
                  <td valign="top" >&nbsp;</td>
        </tr>
      </table>
	</td></tr>
	</table>

  <br><table width="600" border="0" align="center" class="monographe">
    <tr>
      <td><div align="center"><strong><u>INFORMATION COMPTABLE</u></strong></div></td>
    </tr>
    <tr>
      <td><table width="100%" border="0">
          <tr>
            <td width="14%"><div align="right"><strong>Identification Comptable
                :</strong></div></td>
            <td width="17%"><div align="center">
                <input name="comptable" type="text" class="champ" id="comptable" value="-" size="18" >
                <span class="remarque">(*)</span></div></td>
          </tr>
        </table></td>
    </tr>
  </table>

  <br><table width="600" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
            <td align="center">
<input type="submit" name="Submit" value="Update" class="submit" onClick="MM_validateForm('nomClient','','R');return document.MM_returnValue;"></td>
 <td align="center"><input type="submit" name="Submit" value="Insertion" class="submit" onClick="MM_validateForm('nomClient','','R');return document.MM_returnValue;">           </td>
            <td align="center">
<input type="reset" name="Submit2" value="Annuler" class="submit">
            </td>
        </tr>
      </table>

</form>
<table width="388" border="0" cellpadding="0" cellspacing="0" align="center">
  <!--DWLayoutTable-->
  <tr>
    <td width="388" height="29" valign="top" class="remarque">Entrer les informations
      relatives au nouveau client<br>
	  (*) le nom du client est obligatoire</td>
  </tr>
</table>
