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
String acte="sparution";
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
}
catch(Exception e)
{%>
  <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
                  <%
                  return;
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Document sans nom</title>
<link href="style/style.css" rel="stylesheet" type="text/css">
<SCRIPT language="JavaScript" src="script.js"></script>
</head>

<body>

  <h1>PARUTION</h1>

<center>
<form action="<%=lien%>?but=<%=apres%>" method="post" name="pub" id="pub" target="_parent">
<input type="hidden" name="acte" value="<%=acte%>">
  <table width="376" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
    <tr>
      <td class="left">Parution:</td>
      <td><input type="text" name="parution1" class="champ"></td>
      <td><span class="remarque">(*)</span></td>
    </tr>
    <tr>
     <td class="left"><div align="center">Date parution (*)</div></td>
      <td>
          <input name="date" type="text" class="champ" id="date" value="<%=Utilitaire.dateDuJour()%>" size="10" maxlength="10" onBlur="cal_prs_date1(date.value)">
          <a href="javascript:cal2.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>
      </td>
<td></td>
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
      <td class="left">Nombre de page:</td>
      <td><input type="text" name="nbpage" class="champ"></td>
      <td><span class="remarque">(*)</span></td>
    </tr>

	<tr>
      <td class="left">Remarque:</td>
      <td><textarea name="remarque" class="champ" id="actualite"></textarea></td>
      <td></td>
    </tr>

  </table>
  <p>&nbsp;</p>
  <table width="374" border="0">
  <tr>
    <td><input type="submit" name="Submit" value="Valider" class="submit" onClick="MM_validateForm('nbpage','','R','parution1','','R');return document.MM_returnValue"/></td>

    <td><input type="reset" name="Submit2" value="Annuler" class="submit"></td>
  </tr>
</table>
</form>
<script language="javascript">
var cal1 = new calendar1(document.forms['pub'].elements['date']);
cal1.year_scroll = false;
cal1.time_comp = false;
var cal2 = new calendar1(document.forms['pub'].elements['date']);
cal2.year_scroll = false;
cal2.time_comp = false;
var cal3 = new calendar1(document.forms['pub'].elements['date']);
cal3.year_scroll = false;
cal3.time_comp = false;
</script>


<p><span class="remarque">(*):Champs obligatoires</span></p>
</center>
</body>
</html>
