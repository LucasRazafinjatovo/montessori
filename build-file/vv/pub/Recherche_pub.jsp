<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.*" %>
<%@ page import="affichage.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>

<%!
String apres="pub/Recherche_pub.jsp";
String lien="";
UserEJB u = null;
TypeObjet listeJournal[]=null;
TypeObjet catPub[]=null;
TypeObjet listeAgence[]=null;
String listeFiltre[]={"paruInf","paruSup","ref","formu","client","designation",
"daty1","daty2","dimension","agence","cat","correction","page","journal","pageFait"};
ListeAffichage la;
%>
<%
try{
  TypeObjet crt=new TypeObjet();
  lien=request.getParameter("lien");
     u=(user.UserEJB)session.getValue("u");
     lien=(String)session.getValue("lien");
     crt.setNomTable("journal");
     listeJournal=(TypeObjet[])CGenUtil.rechercher(crt,null,null," order by id asc");
     crt.setNomTable("categoriePub");
     catPub=(TypeObjet[])CGenUtil.rechercher(crt,null,null," order by id asc");
     crt.setNomTable("agence");
     listeAgence=(TypeObjet[])CGenUtil.rechercher(crt,null,null," order by id asc");
     la=new ListeAffichage(request,listeFiltre);
     la.getValeur();
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
</head>

<body>
  <h1 align="center">RECHERCHE PUB</h1>
<center>
<form action="<%=lien%>?but=<%=apres%>" method="post" name="pub" id="pub" target="_parent">
  <table width="100%"  border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
    <tr>
      <td width="150" class="left"><u>Parution Inferieur N&deg; </u></td>
      <td width="157"><input type="text" name="paruInf" class="champ"/></td>
      <td width="154" class="left"><u>Parution Sup&eacute;rieur N&deg; </u></td>
      <td width="155"><input type="text" name="paruSup" class="champ"/></td>
    </tr>
    <tr>
      <td class="left"><u>REF  N&deg; </u></td>
      <td><input type="text" name="ref" class="champ"/></td>
      <td class="left">Formulaire</td>
      <td><input type="text" name="formu" class="champ"/></td>
    </tr>
    <tr>
      <td class="left">Client</td>
      <td><input type="text" name="client" class="champ" /></td>
      <td class="left">Designation</td>
      <td><input type="text" name="textfield4" /></td>
    </tr>
    <tr>
      <td class="left">Date Inf </td>
      <td><input type="text" name="daty1" class="champ"/></td>
      <td class="left">Date Sup </td>
      <td><input type="text" name="daty2" class="champ"/></td>
    </tr>
    <tr>
      <td class="left">Dimension</td>
      <td><select name="dimension" size="1" class="champ">
        <option value="1">1</option>
        <option value="1/2" selected="selected">1/2</option>
        <option value="1/4">1/4</option>
        <option value="1/8">1/8</option>
        <option value="11x6">11x6</option>
        <option value="3x3">3x3</option>
        <option value="7x3">7x3</option>
        <option value="7x6">7x6</option>
        <option value="Titre">Titre</option>
      </select></td>
      <td class="left">agence</td>
      <td><select name="agence" size="1" class="champ">
<option value="%" selected="selected">tous</option>
<%
for(int i=0;i<listeAgence.length;i++)
{
  %>
<option value="<%=listeAgence[i].getId()%>" <%if(listeAgence[i].getId().compareTo("ag001")==0)out.print(" selected");%>><%=listeAgence[i].getVal() %></option>
  <%
}
%>
      </select></td>
    </tr>
    <tr>
      <td class="left">categorie pub </td>
      <td><select name="cat" class="champ">
<%
for(int i=0;i<catPub.length;i++)
{
  %>
<option value="<%=catPub[i].getId()%>" <%if(catPub[i].getId().compareTo("ctp2")==0)out.print(" selected");%>><%=catPub[i].getVal() %></option>
  <%
}
%>
      </select></td>
      <td class="left">Corrig&eacute;</td>
      <td><select name="correction" size="1" class="champ">
        <option value="%" selected="selected">tous</option>
        <option value="1">Oui</option>
        <option value="0">Non</option>
      </select></td>
    </tr>
    <tr>
      <td class="left">Page</td>
      <td><input type="text" name="page" class="champ"/></td>
      <td class="left">Journal </td>
      <td><select name="journal" class="champ">
<option value="%" selected="selected">tous</option>
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
      <td class="left">Page nisy azy</td>
      <td><input type="text" name="pageFait" class="champ"/></td>
      <td class="left"> </td>
      <td></td>
    </tr>
  </table>
  <p>&nbsp;</p>
  <table width="100%" border="0">
    <tr>
      <td colspan="4">
	  <div align="center">
	  <p><strong><font color="#FF0000" size="+l">TRIER PAR</font></strong></p>
	  </div>
	  </td>
    </tr>
    <tr>
      <td width="120" class="left">Colonne</td>
      <td width="214"><label>
        <select name="select7" size="1" class="champ">
          <option value="ref">Reference</option>
          <option value="client">Client</option>
          <option value="design">Designation</option>
          <option value="type">Type</option>
          <option value="resp">Responsable</option>
          <option value="page">Page</option>
          <option value="form">Formulaire</option>
          <option value="date">Date</option>
          <option value="saisie">Saisie</option>
          <option value="etat">Etat</option>
          <option value="pub">Publi&eacute;</option>
          <option value="dim">dimension</option>
        </select>
      </label></td>
      <td width="78" class="left"><label>Ordre</label></td>
      <td width="117"><select name="select7" size="1" class="champ">
          <option value="desc">Decroissant</option>
          <option value="croi">Croissant</option>
      </select></td>
    </tr>
  </table>
  <table width="100%" border="0">
    <tr>
      <td colspan="7"><div align="center">
          <p><strong><font color="#FF0000" size="+l">REGROUPER PAR</font></strong></p>
      </div></td>
    </tr>
    <tr>
      <td width="25%" class="left"><div align="right">Colonne1</div></td>
      <td width="25%">
      <select name="select8" size="1" class="champ">
        <option value="ref">Reference</option>
        <option value="client">Client</option>
        <option value="design">Designation</option>
        <option value="type">Type</option>
        <option value="resp">Responsable</option>
        <option value="page">Page</option>
        <option value="form">Formulaire</option>
        <option value="date">Date</option>
        <option value="saisie">Saisie</option>
        <option value="etat">Etat</option>
        <option value="pub">Publi&eacute;</option>
        <option value="dim">dimension</option>
      </select>
      </td>
      <td width="25%"><div align="right">Colonne 2 </div></td>
      <td width="25%"><select name="select" size="1" class="champ">
        <option value="ref">Reference</option>
        <option value="client">Client</option>
        <option value="design">Designation</option>
        <option value="type">Type</option>
        <option value="resp">Responsable</option>
        <option value="page">Page</option>
        <option value="form">Formulaire</option>
        <option value="date">Date</option>
        <option value="saisie">Saisie</option>
        <option value="etat">Etat</option>
        <option value="pub">Publi&eacute;</option>
        <option value="dim">dimension</option>
      </select></td>
    </tr>
  </table>
  <table width="100%" border="0">
  <tr>
    <td width="25%" class="Style3">
      <div align="center">
        <input type="submit" name="Submit" value="FIND" class="submit">
      </div></td>
    <td width="25%">
      <div align="center">
        <input type="submit" name="Submit2" value="RESULT" class="submit">
        </div></td>
    <td width="25%">
      <div align="center">
        <input type="submit" name="Submit3" value="Pub D Page" class="submit">
        </div></td>
    <td width="25%">
      <div align="center">
        <input type="submit" name="Submit4" value="Pub Page" class="submit" />
      </div></td>
    </tr>
</table>
</form>
</center>
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
