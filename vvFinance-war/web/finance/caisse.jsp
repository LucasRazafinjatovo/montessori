<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.TypeObjet" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="finance/apresCaisse.jsp";
        String lien= null;
        UserEJB u = null;
        TypeObjet source[] =null;

%>
<%
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
source = u.findTypeObjet("Beneficiaire","%","%");
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Ajouter nouvelle caisse</h1>
<form action="<%=lien%>?but=<%=apres%>" method="post" target="_parent" onsubmit="return (verifie(caisse.value)&&verifie(comptable.value))">
<table width="600" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td><table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
          <!--DWLayoutTable-->
          <tr>
            <td width="41%" class="left">Nom caisse : <span class="remarque">*</span></td>
            <td width="59%"><input name="caisse" type="text"   id="caisse2"> </td>
          </tr>
          <tr>
            <td class="left">Entite : </td>
            <td><select name="responsable" class="champ" id="agence">
                <%
for(int i=0;i<source.length;i++){
%>
                <option value="<%=source[i].getId()%>" <%if(source[i].getId().compareTo("BE011")==0) out.println("selected");%>><%=source[i].getVal()%></option>
                <%
}
%>
              </select>
              <input name="acte" type="hidden" id="acte2" value="INSERT"> </td>
          </tr>
          <tr>
            <td class="left">Identification Comptable : <span class="remarque">*</span></td>
            <td><input name="comptable" type="text"   id="comptable" value="-"></td>
          </tr>
        </table></td>
  </tr>
  <tr>
      <td height="30" align="center">
        <table width="75%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td align="center">
<input type="submit" name="Submit" value="Enregistrer" class="submit" onClick="MM_validateForm('caisse','','R','comptable','','R');return document.MM_returnValue">
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
<table width="600" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
    <td> <div align="right" class="remarque">
        <p>(*) Champs obligatoires</p>
        <p>&gt;RMQ : La caisse nouvellement créée est ouverte par défaut </p>
      </div></td>
</tr>
</table>