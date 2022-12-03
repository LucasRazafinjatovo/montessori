<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>
<%@ page import="pub.*" %>
<script type='text/javascript'>
function getXhr(){
        var xhr = null;

        if (window.XMLHttpRequest || window.ActiveXObject) {
                if (window.ActiveXObject) {
                        try {
                                xhr = new ActiveXObject("Msxml2.XMLHTTP");
                        } catch(e) {
                                xhr = new ActiveXObject("Microsoft.XMLHTTP");
                        }
                } else {
                        xhr = new XMLHttpRequest();
                }
        } else {
                alert("Votre navigateur ne supporte pas l'objet XMLHTTPRequest...");
                return null;
        }

        return xhr;
}
function request(oSelect) {
    var xhr   = getXhr();
    xhr.onreadystatechange = function() {
       if (xhr.readyState == 4 && (xhr.status == 200 || xhr.status == 0)) {
             readData(xhr.responseXML);
             document.getElementById("loader").style.display = "none";
       }
    };
    xhr.open("POST", "ajaxVendeur.jsp", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    var value = oSelect.options[oSelect.selectedIndex].value;
    xhr.send("IdEditor=" + value);
}
function readData(oData) {
    var nodes   = oData.getElementsByTagName("item");
    var oSelect = document.getElementById("vendeur");
    var oOption, oInner;
    oSelect.innerHTML = "";
    var i=0;
    for(i=0;i<nodes.length;i++){
        oOption = document.createElement("option");
        oInner  = document.createTextNode(nodes[i].getAttribute("name"));
        oOption.value = nodes[i].getAttribute("id");

        oOption.appendChild(oInner);
        oSelect.appendChild(oOption);
    }
}
function checkVendeur(obj)
{
  $.ajax({
    url:'ajaxVendeur.jsp?IdEditor='+obj.value,
    success:function(data)
    {
      $("#vendeur").html(data);
    }
  });
}
function loadVendeur(req)
{
  if(req!=""){
  $.ajax({
    url:'ajaxVendeur.jsp?IdEditor='+req,
    success:function(data)
    {
      $("#vendeur").html(data);
    }
  });
  }
}
//-->
</script>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        //String apres="pub/apresAnnulerFacture.jsp";
        String lien= null;
        UserEJB u = null;
        Place crt = null;
        String idPrise = null;
        String place = null;

%>
<%
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
place = (request.getParameter("place")!=null)?request.getParameter("place"):"";
%>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Saisir invendu</h1>
<form action="<%=lien%>?but=pub/apresTarif.jsp" method="post">
  <table cellpadding="0" width="450" cellspacing="0" border="0" align="center">
  <tr><td>
 <table cellpadding="3" cellspacing="0" border="0" align="center" class="monographe" width="100%">
  <tr>
   <td height="26" class="left">Lieu : </td>
           <td><select id="place" name="place" onchange="checkVendeur(this);">
                  <option value="none">aucun</option>
           <%
                        crt = new Place();
                        Place[] pl = (Place[])CGenUtil.rechercher(crt,null,null," ");
                        for(int i=0;i<pl.length;i++){ %>
                                        <option value='<%=pl[i].getId()%>'
                                           <% if(pl[i].getId().compareTo(place)==0){%>
                                            selected
                                            <%}%>
                                        >
                                              <%=pl[i].getVal()%>
                                        </option>
                <%	}
           %>
           </select><span id="loader" style="display: none;"><img src="images/loader.gif" alt="loading" /></span>
           </td>
  </tr>
  <tr>
       <td height="26" class="left">Nom : </td>
           <td><select id="vendeur" name="nom"><option>Choisir vendeur</option>
               </select></td>
  </tr>
  <tr>
      <td class="left">Journal : </td>
    <td><input name="journal" type="text" class="champ" value="<%if(request.getParameter("journal")==null)out.print("");else out.print(request.getParameter("journal"));%>"></td>
  </tr>
  <tr>
      <td class="left">Parution : </td>
      <td><input name="parution" type="text" class="champ" value="<%if(request.getParameter("parution")==null)out.print("");else out.print(request.getParameter("parution"));%>"></td>
  </tr>
  <tr>
      <td class="left">Daty : </td>
      <td><input name="daty" type="text" class="champ" value="<%if(request.getParameter("daty")==null)out.print("");else out.print(request.getParameter("daty"));%>"></td>
  </tr>
  <tr>
      <td class="left">Nombre invendu : </td>
      <td><input name="nombreinvendu" type="text" class="champ"></td>
  </tr>
  <tr>
      <td class="left">Remarque : </td>
      <td><input name="remarque" type="text" class="champ"></td>
  </tr>
   <input name="acte" type="hidden" id="nature" value="insert">
   <input name="bute" type="hidden" id="bute" value="ventegazety/saisinvendu.jsp">
   <input name="classe" type="hidden" id="classe" value="ventegazety.InvenduLibelle">
   <input name="rajoutLien" type="hidden" id="classe" value="journal-parution-daty-place">
</tr>
   </table>
  </td></tr>
  <tr>

      <td align="center" height="30">
        <table width="75%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td align="center"><input type="submit" name="Submit2" value="Valider" class="submit"></td>
            <td align="center"><input type="reset" name="Submit" value="Annuler" class="submit"></td>
          </tr>
        </table></td>
  </tr>
</table>
</form>

<script type='text/javascript'>
$(document).ready(function(){
loadVendeur('<%=place%>');
$("#vendeur").focus();
});
</script>
