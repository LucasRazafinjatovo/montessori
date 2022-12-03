<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="penalite.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="facture/apresFactureInit.jsp";
        String lien= null;
        facture.Client clt[] = null;
        facture.SCatService sctserv[] = null;
        UserEJB u = null;
        TypeObjet etat[] = null;
        String typePen=null;
%>
<%
try{
u=(user.UserEJB)session.getValue("u");
clt = u.findClient("%", "%", "%", "%", "%", "%", "%", "%", "%", "%", "%");
sctserv = u.findSCatService("%", "%", "cat2", "%");
lien=(String)session.getValue("lien");
etat = u.findTypeObjet("Etat","%","%");
typePen = request.getParameter("typePen");
if (typePen==null || typePen.compareTo("")==0) typePen="%";
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Lister les p&eacute;nalit&eacute;s </h1>
<form action="<%=lien%>?but=penalites/listePenalites1.jsp" method="post">
<table border="0" cellpadding="3" cellspacing="0" align="center" width="600">
<tr><td><table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
             <tr>
            <td width="19%" class="left">Type :</td>
            <td width="28%" align="center"><select name="typePen" class="champ" id="typePen">
                <option value="%">tous</option>
                <%
          for(int i=0;i<sctserv.length;i++){
          %>
                <option value="<%=sctserv[i].getIdScatService()%>" <%if(sctserv[i].getIdScatService().compareTo(typePen)==0) out.println("selected");%>><%=sctserv[i].getNomSCatService()%></option>
                <%
                }
                %>
              </select></td>
            <td width="21%" align="left" class="left">&nbsp;</td>
            <td width="32%" align="center">&nbsp;</td>
          </tr>
        </table></td></tr>
<tr>
    <td align="center">
<table width="50%" border="0" cellspacing="0" cellpadding="0">
  <tr>
          <td align="center">
<input name="Input" type="submit" value="Afficher" class="submit">
          </td>
          <td align="center">
<input name="Input2" type="reset" value="Annuler" class="submit">
          </td>
  </tr>
</table>
    </td>
  </tr>
</table>
</form>
<br>


