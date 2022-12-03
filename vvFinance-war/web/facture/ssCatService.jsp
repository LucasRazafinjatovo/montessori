<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="facture/apresSsCatService.jsp";
        String lien= null;
        TypeObjet catsvc[] = null;
        UserEJB u = null;
    %>
<%
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
catsvc = u.findTypeObjet("categorie","%","%");
    }catch(Exception e){
    %>
         <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
    <%
    }
%>
%>
 
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Ajouter une nouvelle sous-cat&eacute;gorie</h1>
<form>
  <table width="450" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
    <!--DWLayoutTable-->
    <tr>
      <td width="111" class="left">D&eacute;signation : </td>
    <td width="144"><input name="designation" type="text" class="champ" id="designation"> </td>
  </tr>
   <tr>
      <td class="left">Cat&eacute;gorie : </td>
      <td><select name="idCat" class="champ" id="idCat">
          <%
	  for(int i=0;i<catsvc.length;i++){
	  %>
	  <option value=<%=catsvc[i].getId()%>><%=catsvc[i].getVal()%></option>
	  <%
	  }
	  %>
        </select> </td>
  </tr>
   <tr>
      <td class="left">P&eacute;riode de facturation : </td>
      <td><input name="periodeFact" type="text" class="champ" id="periodeFact"> </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><input type="submit" name="Submit" value="Enregistrer" class="submit">
      <input type="reset" name="Submit" value="R&eacute;tablir" class="submit"></td>
  </tr>
</table>
</form>