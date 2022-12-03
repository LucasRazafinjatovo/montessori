<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>

<%!
String apres="ventegazety/prixjournvend.jsp";
String lien="";
String date;
UserEJB u = null;
String acte="insert";
TypeObjet listeJournal[]=null;
%>
<%
try{
  TypeObjet crt=new TypeObjet();
  date = request.getParameter("datyVal");if ((date==null)||date.compareTo("")==0) date="01/01/"+String.valueOf(Utilitaire.getAneeEnCours());
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
<link href="../style/style.css" rel="stylesheet" type="text/css">
</head>
<body>
<h1>PRIX JOURNAL PAR VENDEUR  </h1>

  <center>
  <form action="<%=lien%>?but=<%=apres%>" method="post" name="prjvend" id="prjvend" target="_parent">
  <table width="49%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
    <tr>
      <td width="186" class="left">Surnom:</td>
      <td width="124"><select name="surnom" size="1" class="champ">
        <option value="AI" selected="selected">Agence Immobilier</option>
        <option value="AF">Agence Faniry</option>
      </select></td>
    </tr>
    <tr>
      <td class="left">Journal:</td>
      <td><select name="journal" size="1" class="champ">
     <%
       for(int i=0;i<listeJournal.length;i++)
       {
         %>
         <option value="<%=listeJournal[i].getId()%>" <%if(listeJournal[i].getId().compareTo("j1")==0)out.print(" selected");%>><%=listeJournal[i].getDesce() %></option>
         <%
       }
     %>
      </select></td>
    </tr>
    <tr>
      <td class="left">Prix Unitaire :</td>
      <td><select name="pu" size="1" class="champ">
        <option value="AI" selected="selected">Agence Immobilier</option>
        <option value="AF">Agence Faniry</option>
      </select></td>
    </tr>
    <tr>
      <td class="left">date validit&eacute; :</td>
      <td><input name="datyVal" type="text" class="champ" id="datyVal" value="<%=date%>"></td>
      <td><a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a></td>

    </tr>

  </table>
  <p>&nbsp;</p>
  <table width="229" border="0">
  <tr>

    <td width="115"><input type="submit" name="valider" value="Valider" class="submit" /></td>

    <td width="104"><div align="center" class="Style8"><a href="essai.html" class="Style8" style="text-decoration:none"><input type="submit" name="annuler" value="Annuler" class="submit">
    </a> </div></td>
  </tr>
</table>
</form>
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
<script language="javascript">
var cal1 = new calendar1(document.forms['ventegazety'].elements['datyVal']);
cal1.year_scroll = false;
cal1.time_comp = false;
</script>
</body>

