<%@ page import="user.*"%>
<%@ page import="facture.*"%>
<%@ page import="facture.*"%>
<%@ page import="lc.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="bean.*"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage=""%>
<%!
        String lien = null;

        UserEJB u = null;
		Client c=null;
		String cd;
                Client[] lc=null;
        %>
<%
                try {
                u = (user.UserEJB) session.getValue("u");
                lien = (String) session.getValue("lien");
                cd=request.getParameter("client");
				c=new Client();
				lc=(Client[])CGenUtil.rechercher(c,null,null," and idclient='"+cd+"'");
        } catch (Exception e) {
%>
  <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
  <%
  }
  %>
  <SCRIPT language="JavaScript" src="script.js"></script>
  <link href="style.css" rel="stylesheet" type="text/css">
  <h1>Mise &agrave; jour client fait</h1>
  <table width="450" border="0" align="center" cellpadding="0"
          cellspacing="0">
          <tr>
                  <td class="remarque">&nbsp;</td>
          </tr>
  </table>
  Voulez-vous supprimer le client: <B><u><%=lc[0].getNom()%></u></B> maintenant? </h2>
 <br><br>
  <form action="<%=lien%>?but=facture/apresClient.jsp" method="post" name="client" id="client" target="_parent">

  <table width="600" border="0" align="center" cellpadding="0"
          cellspacing="0">
          <tr>
                  <td height="30" align="center">
                  <table width="35%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td align="center"><input type="submit" name="Submit"  class="submit" value="Oui"></td>
                            <td align="center"><a href="<%=lien%>?but=facture/miseAJourClient.jsp"><input type="button" name="annuler"   value="Non" class="submit"></a></td>
                            <input type="hidden" name="idClient"   value="<%=lc[0].getIdClient()%>" >
                          </tr>
                  </table>
                  </td>
          </tr>
          <input type="hidden" name="acte"   value="DELETE" class="submit">
          <input type="hidden" name="bute"   value="facture/listeClient.jsp" class="submit">
  </table>
  </form>