<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>

<%!
String apres="pub/apresPub.jsp";
String lien="";
UserEJB u = null;
TypeObjet listeJournal[]=null;
TypeObjet catPub[]=null;
TypeObjet listeAgence[]=null;
TypeObjet formatPub[]=null;

String acte="insert";
%>
<%
try{
  TypeObjet crt=new TypeObjet();
  String tempActe=request.getParameter("acte"); if((tempActe!=null)&&(tempActe.compareToIgnoreCase("")!=0)) acte=tempActe;
  lien=request.getParameter("lien");
     u=(user.UserEJB)session.getValue("u");
     lien=(String)session.getValue("lien");
     crt.setNomTable("journal");
     listeJournal=(TypeObjet[])CGenUtil.rechercher(crt,null,null," order by id asc");
     crt.setNomTable("categoriePub");
     catPub=(TypeObjet[])CGenUtil.rechercher(crt,null,null," order by id asc");
     crt.setNomTable("agence");
     listeAgence=(TypeObjet[])CGenUtil.rechercher(crt,null,null," order by id asc");
     crt.setNomTable("format");
     formatPub=(TypeObjet[])CGenUtil.rechercher(crt,null,null," order by id asc");
}
catch(Exception e)
{%>
  <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
                  <%
                  return;
}
%>
<script type="text/javascript">

 function controler()
{
  if(isNaN(pub.remis.value) == true)
  {
  pub.remis.value="";
  pub.remis.focus();
  alert("remise invalide");
  }
}
function checkRemise(obj)
{
  $.ajax({
    url:'ajaxRemise.jsp?IdEditor='+obj.value,
    success:function(data)
    {
      if(data>=0){
        $("#remiseclient").val(data);
      }
    }
  });
}
function checkRemisee()
{
  val1=document.forms["pub"].elements["client"].value;
  $.ajax({
    url:'ajaxRemise.jsp?IdEditor='+val1,
    success:function(data)
    {
      if(data>=0){
        $("#remiseclient").val(data);
      }
    }
  });
}
</script>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Document sans nom</title>
<link href="style/style.css" rel="stylesheet" type="text/css">
</head>

<body>

  <h1>PUBLICITE</h1>
Precedent <%=request.getParameter("id")%>
<center>
<form action="<%=lien%>?but=<%=apres%>" method="post" name="pub" id="pub" target="_parent">
<input type="hidden" name="acte" value="<%=acte%>">
  <table width="376" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
    <tr>
      <td class="left">Parution:</td>
      <td><input type="text" name="parution1" class="champ" value=<%=utilitaire.Utilitaire.getRequest(request.getParameter("parution1"))%>></td>
      <td><span class="remarque">(*)</span></td>
    </tr>
    <tr>
     <td class="left"><div align="center">&agrave;</div></td>
      <td><input type="text" name="parution2" class="champ"></td>
<td></td>
</tr>
    <tr>
      <td class="left">Client:</td>
      <td colspan="4"><input type="text" name="client" class="champ" onblur="checkRemise(this);">
      <span class="remarque">(*)</span><input name="choix3" type="button" class="submit" onclick="pagePopUp('ded/choix_tiers.jsp?champReturn=client')" value="..." /></td>
    </tr>
    <tr>
      <td class="left">D&eacute;signation:</td>
      <td colspan="4"><input type="text" name="designation" class="champ" onblur="checkRemisee();">
        <span class="remarque">(*)</span></td>
    </tr>
    <tr>
      <td class="left">Dimension:</td>
      <td colspan="4"><select name="dimension" size="1" class="champ">
<%
for(int i=0;i<formatPub.length;i++)
{
  %>
<option value="<%=formatPub[i].getId()%>" <%if(formatPub[i].getId().compareTo("3x3")==0)out.print(" selected");%>><%=formatPub[i].getId() %></option>
  <%
}
%>      </select>
      <span class="remarque">(*)</span></td>
<td></td>
    </tr>
    <tr>
      <td class="left">Couleur:</td>
      <td colspan="4"><select name="couleur" size="1" class="champ">
        <option value="1" selected="selected">1</option>
        <option value="2">2</option>
        <option value="3">3</option>
        <option value="4">4</option>
      </select></td><td>
      <span class="remarque">(*)</span></td>
    </tr>
    <tr>
      <td class="left">Page:</td>
      <td colspan="4"><input type="text" name="page" class="champ">
      <span class="remarque">(*)</span></td>
    </tr>
	<tr>
      <td class="left">Journal:</td>
      <td colspan="4"><select name="journal" class="champ">
<%
for(int i=0;i<listeJournal.length;i++)
{
  %>
<option value="<%=listeJournal[i].getId()%>" <%if(listeJournal[i].getId().compareTo("j1")==0)out.print(" selected");%>><%=listeJournal[i].getDesce() %></option>
  <%
}
%>
      </select>
      <span class="remarque">(*)</span></td>
    </tr>
    <tr>
      <td class="left">Cat&eacute;gorie:</td>
      <td colspan="4"><select name="cat" class="champ">
<%
for(int i=0;i<catPub.length;i++)
{
  %>
<option value="<%=catPub[i].getId()%>" <%if(catPub[i].getId().compareTo("ctp2")==0)out.print(" selected");%>><%=catPub[i].getVal() %></option>
  <%
}
%>
      </select>
      <span class="remarque">(*)</span></td>
    </tr>
    <tr>
      <td class="left">Responsable:</td>
      <td colspan="4"><select name="agence" size="1" class="champ">
<%
for(int i=0;i<listeAgence.length;i++)
{
  %>
<option value="<%=listeAgence[i].getId()%>" <%if(listeAgence[i].getId().compareTo("ag001")==0)out.print(" selected");%>><%=listeAgence[i].getVal() %></option>
  <%
}
%>
      </select>
      <span class="remarque">(*)</span></td>
    </tr>

    <tr>
      <td class="left">BC N&deg;: </td>
      <td colspan="4"><input type="text" name="numBc" class="champ"></td>
    </tr>
    <tr>
      <td class="left">Remise : </td>
      <td colspan="4"><input type="text" id="remiseclient" name="remis" class="champ" onblur='controler()'></td>%
    </tr>

    <tr>
      <td class="left">REMARQUE:</td>
      <td colspan="4"><label>
        <textarea name="rem" class="champ"></textarea></label></td>
    </tr>

    <tr>
      <td class="left">N&deg; Facture </td>
      <td colspan="4"><input type="text" name="nPiec" class="champ">      </td>
    </tr>
    <tr>
      <td class="left">Formulaire:</td>
      <td colspan="4"><input type="text" name="formulaire" class="champ"></td>
    </tr>
  </table>
  <p>&nbsp;</p>
  <table width="374" border="0">
  <tr>
    <td><input type="submit" name="Submit" value="Valider" class="submit" /></td>

    <td><input type="reset" name="Submit2" value="Annuler" class="submit"></td>
  </tr>
</table>
</form>
<p><span class="remarque">(*):Champs obligatoires</span></p>
</center>
<p align="center">
  <label></label>
</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
</body>
</html>
