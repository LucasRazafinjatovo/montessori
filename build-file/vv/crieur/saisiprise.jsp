<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="crieur.*" %>
<%@ page import="ventegazety.*" %>
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
    xhr.open("POST", "ajaxCrieur.jsp", true);
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
    url:'ajaxCrieur.jsp?IdEditor='+obj.value,
    success:function(data)
    {
      $("#vendeur").html(data);
    }
  });
}

function loadVendeur(req)
{
  $.ajax({
    url:'ajaxCrieur.jsp?IdEditor='+req,
    success:function(data)
    {
      $("#vendeur").html(data);
    }
  });
}


//-->
</script>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%
	String lien= null;
	UserEJB u = null;
	Grossiste crt = null;
	String idPrise = null;
	Utilitaire util = new Utilitaire();
	String grossiste = null;
	u=(user.UserEJB)session.getValue("u");
	lien=(String)session.getValue("lien");
	grossiste = (request.getParameter("grossiste")!=null)?request.getParameter("grossiste"):"";
%>
	<link href="style.css" rel="stylesheet" type="text/css">
	<h1>Saisir prise</h1>
<form action="<%=lien%>?but=pub/apresTarif.jsp" method="post">
	<table cellpadding="0" width="450" cellspacing="0" border="0" align="center">
		<tr>
			<td>
				<table cellpadding="3" cellspacing="0" border="0" align="center" class="monographe" width="100%">
					<tr>
						<td class="left">Publicat : </td>
						<td><input name="publicat" type="text" class="champ" id="caisse" value="<%if(request.getParameter("publicat")==null)out.print("");else out.print(request.getParameter("publicat"));%>"></td>
					</tr>
					<tr>
						<td height="26" class="left">Daty: </td>
						<td><input name="daty" type="text" class="champ" value="<%if(request.getParameter("daty")==null)out.print("");else out.print(request.getParameter("daty"));%>"></td>
					</tr>
					<tr>
						<td height="26" class="left">Nombre prise : </td>
						<td><input id="nbreprise" name="nbreprise" type="text" class="champ"></td>
					</tr>
					<tr>
						<td height="26" class="left">Grossiste : </td>
						<td><select id="grossiste" name="grossiste" onchange="checkVendeur(this);" >
							<option value="none">aucun</option>
							<%
							crt = new Grossiste();
							Grossiste[] pl = (Grossiste[])CGenUtil.rechercher(crt,null,null," order by surnom asc");
							for(int i=0;i<pl.length;i++){ %>
								<option value='<%=pl[i].getSurnom()%>'	<% if(pl[i].getId().compareTo(grossiste)==0){%>selected<%}%>><%=pl[i].getSurnom()%></option>
							<%	}%>
							</select><span id="loader" style="display: none;"><img src="images/loader.gif" alt="loading" /></span>
						</td>
					</tr>
					<tr>
						<td height="26" class="left">vendeur : </td>
						<td><select id="vendeur" name="vendeur"><option>Choisir vendeur</option></select></td>
					</tr>
					<tr>
						<input name="acte" type="hidden" id="acte" value="insert">
						<input name="bute" type="hidden" id="bute" value="crieur/saisiprise.jsp">
						<input name="classe" type="hidden" id="classe" value="crieur.Prisecrieur">
						<input name="rajoutLien" type="hidden" id="classe" value="publicat-daty-grossiste">
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align="center" height="30">
				<table width="75%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td align="center"><input type="submit" name="Submit2" value="Enregistrer" class="submit"></td>
						<td align="center"><input type="reset" name="Submit" value="R&eacute;tablir" class="submit"></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</form>
<script type='text/javascript'>
$(document).ready(function(){
loadVendeur('<%=grossiste%>');
$("#nbreprise").focus();
});
</script>
