<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.*" %>
<%@ page import="crieur.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>

<%!
String apres="pub/apresTarif.jsp";
String lien="";
UserEJB u = null;
String acte="insert";
TypeObjet listeJournal[]=null;
TypeObjet typ[]=null;
Grossiste gr[] = null;
TypeObjet pla[]=null;
%>
<%
	try{
		TypeObjet crt=new TypeObjet();
		Grossiste g = new Grossiste();
		String tempActe=request.getParameter("acte"); if((tempActe!=null)&&(tempActe.compareToIgnoreCase("")!=0)) acte=tempActe;
		lien=request.getParameter("lien");
		u=(user.UserEJB)session.getValue("u");
		lien=(String)session.getValue("lien");
		crt.setNomTable("journal");
		listeJournal=(TypeObjet[])CGenUtil.rechercher(crt,null,null," order by id asc");
		crt.setNomTable("place");
		pla=(TypeObjet[])CGenUtil.rechercher(crt,null,null," order by id asc");
		crt.setNomTable("typevendeur");
		typ=(TypeObjet[])CGenUtil.rechercher(crt,null,null," order by id asc");
		gr = (Grossiste[])CGenUtil.rechercher(g,null,null," order by surnom asc");
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
<script type="text/javascript">
function checkType() { 
	var typ = document.getElementById("typevendeur").value;
	if(typ == "tv2"){
		document.getElementById("grossiste").style.display = 'table-row';
	}else{
		document.getElementById("grossiste").style.display = 'none';
		document.getElementById("grossiste").value = '';
	}
}
</script>
</head>
<h1>SAISIR VENDEUR </h1>

  <center>
  <form action="<%=lien%>?but=<%=apres%>" method="post" name="saisivendeur" id="saisivendeur" target="_parent">
  <input type="hidden" name="acte" value="<%=acte%>">
  <table width="49%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
    <tr>
      <td width="186" class="left">Surnom:</td>
      <td width="124"><input type="text" name="surnom" class="champ" /></td>
    </tr>
    <tr>
      <td class="left">Place:</td>
      <td><select name="idplace" size="1" class="champ">
      <%
       for(int i=0;i<pla.length;i++)
       {
         %>
         <option value="<%=pla[i].getId()%>" <%if(pla[i].getId().compareTo("j1")==0)out.print(" selected");%>><%=pla[i].getVal() %></option>
         <%
       }
      %>
      </select></td>
    </tr>
    <tr>
      <td class="left">Nom:</td>
      <td><input type="text" name="nom" class="champ" /></td>
    </tr>
    <tr>
      <td class="left">Numero matricule:</td>
        <input type="hidden" name="prenom" value="O">
      <td><input type="text" name="nummatricule" class="champ" /></td>
    </tr>
    <tr>
      <td class="left">Type:</td>
      <td><select id="typevendeur" name="type" size="1" class="champ" onchange="checkType()">
         <%
       for(int i=0;i<typ.length;i++)
       {
         %>
         <option value="<%=typ[i].getId()%>" <%if(typ[i].getId().compareTo("j1")==0)out.print(" selected");%>><%=typ[i].getDesce() %></option>
         <%
       }
     %>
      </select>      </td>
    </tr>
	<tr id="grossiste" style="display:none">
      <td class="left">Grossiste:</td>
      <td><select name="grossiste" size="1" class="champ">
         <%
		for(int i=0;i<gr.length;i++)
		{
			%>
			<option value="<%=gr[i].getId()%>" <%if(gr[i].getId().compareTo("j1")==0)out.print(" selected");%>><%=gr[i].getSurnom() %></option>
         <%
       }
     %>
      </select>      </td>
    </tr>
    <tr>
      <td class="left">Taux :</td>
      <td><input type="text" name="taux" class="champ" /></td>
    </tr>
    <tr>
      <td class="left">Date d'embauche :</td>
      <td><input type="text" name="dateembauche" class="champ" value="<%=Utilitaire.dateDuJour()%>"/></td>
    </tr>
  </table>
  <p>&nbsp;</p>
  <table width="229" border="0">
  <tr>

    <td width="115"><input type="submit" name="Submit" value="Valider" class="submit" /></td>
    <td width="104"><div align="center" class="submit"><a href="essai.html" class="submit" style="text-decoration:none"><input type="submit" name="annuler" value="Annuler" class="submit">
    </a> </div></td>
     <input name="acte" type="hidden" id="nature" value="insert">
     <input name="bute" type="hidden" id="bute" value="ventegazety/saisivendeur.jsp">
     <input name="classe" type="hidden" id="classe" value="ventegazety.Vendeur">
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
</body>