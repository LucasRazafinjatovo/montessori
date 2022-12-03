<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="prevision.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage=""%>
<SCRIPT language="javascript">

    function charger(obj) {
      var selectElmt = document.getElementById("rec").value;
      var radio1=document.getElementById("value_radio1").value;
      //var idVal=document.getElementById("idVal").value;
      var choix_afficher="Tous les "+ selectElmt +" "+obj+", jusqu'au "+radio1+"";
      var choix=obj+","+selectElmt+","+radio1;
      document.getElementById("choix").value = choix;
      document.getElementById("choix_afficher").value = choix_afficher;
      }

  </SCRIPT>
<%!
        String lien = null;
        UserEJB u = null;
        JourNombre[] ljn = null;
%>
<%
                try {
                u = (user.UserEJB) session.getValue("u");
                lien = (String) session.getValue("lien");
                JourNombre jn = new JourNombre();
                ljn = (JourNombre[])CGenUtil.rechercher(jn,null,null,"");

        } catch (Exception e) {
%>
  <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
  <%
  }
  %>
  <SCRIPT language="JavaScript" src="script.js"></script>
  <link href="../style/style.css" rel="stylesheet" type="text/css">
  <h1>Reccurence tous les jours</h1>
  <form action="../<%=lien%>?but=prevision/apresPrevisionRecurrence.jsp" method="post" name="recurrencej" id="recurrencej">

  <table width="450" border="0" align="center" cellpadding="0" cellspacing="0">

		  <tr>
                  <td>
                  <table width="100%" border="0" align="center" cellpadding="2"
                          cellspacing="0" class="monographe">
                          <tr>
                            <td class="left" width="30%">R&eacute;pet&eacute; tous les :</td>
                            <td align="left">
                                   <select class="champ" id="rec" name="rec" onchange="charger('<%=request.getParameter("idVal")%>');">
                                       <%for(int i=0;i<ljn.length;i++){%>
                                            <option value="<%=ljn[i].getJour()%>"><%=ljn[i].getJour()%></option>
                                       <%}%>
                                   </select></td>
                          </tr>
                          <tr>
                                  <td class="left">Date de debut : </td>
                            <td align="left">
                                   <input class="champ" name="dateD" disabled="" type="text" readonly value="<%=Utilitaire.dateDuJour()%>"/>&nbsp;</td>
                          </tr>
                          <tr>
                                  <td class="left">Fin : </td>
                                  <td align="left"><input class="champ" id="value_radio1" name="value_radio1" type="text" value="<%=Utilitaire.dateDuJour()%>" onchange="charger('<%=request.getParameter("idVal")%>')"/></label>
                                            <!-- <br/>
                                                <label title="Se termine à une date spécifiée"><input name="radio2" id="radio2" type="radio"/> Le: <input name="value_radio2" type="text"/></label></td>-->

                                  </td>
                          </tr>
                          <tr>
                                  <td class="left">Resume : </td>
                                  <td align="left">
                                       <input type="text"  name="choix_afficher" id="choix_afficher" value="Tous les <%=request.getParameter("idVal")%>" style="border: hidden; border: 0;width:100%"/>
                                               <input type="hidden" name="choix" id="choix" value="<%=request.getParameter("idVal")%>,<%=request.getParameter("rec")%>,<%=request.getParameter("value_radio1")%>"/>
                                  </td>
                          </tr>
                  </table>
                  </td>
          </tr>
	 </table>
	 <br/>
	 <table width="450" border="0" align="center" cellpadding="0" cellspacing="0">


          <tr>
                  <td height="30" align="center">
                  <table width="75%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td align="center"><input type="hidden" name="champReturn" value="<%=request.getParameter("champReturn")%>" />
                                               <input type="hidden" name="idVal" value="<%=request.getParameter("idVal")%>" />
                                               <input type="hidden" name="champReturnAfficher" value="<%=request.getParameter("champReturnAfficher")%>" />
                                               <input type="hidden" name="acte" value="reccurence" /><input type="submit" name="Submit"  class="submit" value="OK"></td>
							<td align="center"><input type="reset" name="annuler"   value="Annuler" class="submit"></td>
                          </tr>
                  </table>
                  </td>
          </tr>
  </table>
  </form>