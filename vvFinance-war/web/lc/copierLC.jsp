<%@ page import="user.*"%>
<%@ page import="facture.*"%>
<%@ page import="finance.*"%>
<%@ page import="lc.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="bean.*"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage=""%>
<%!String apres = "finance/apresLC.jsp";

        String lien = null;

        UserEJB u = null;

        LigneCredit lc = null;

        TypeObjet source[] = null;

        TypeObjet tlc[] = null; //type ligne credit

        TypeObjet compte[] = null; //compte compta

        Direction dir[] = null;

        String idLC = "";

        String mois2 = null;

        String annee = null;

        String acte = null;

        String designation = "";

        String numCompte = "";

        String idTypeLC = "";

        String credit = "";

        String direction = "";

        String readOnly = "readonly";
        String mois[] = Constante.getMois();
         String moisRang[] = Constante.getMoisRang();
        String msg = "";
        %>
<%
                try {
                u = (user.UserEJB) session.getValue("u");
                lien = (String) session.getValue("lien");
                annee = request.getParameter("annee");
                if ((annee == null) || annee.compareTo("") == 0)
                        annee = String.valueOf(Utilitaire.getAneeEnCours());

                msg = request.getParameter("msg");
                source = u.findTypeObjet("Beneficiaire", "%", "%");
                tlc = u.findTypeObjet("TypeSortieliste", "%", "%");
                compte = u.findTypeObjet("comptecompta", "%", "%");
                dir = u.findDirection("", "", "", "", "");
        } catch (Exception e) {
%>
  <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
  <%
  }
  %>
  <SCRIPT language="JavaScript" src="script.js"></script>
  <link href="style.css" rel="stylesheet" type="text/css">
  <h1>Copier des lignes de cr&eacute;dit</h1>
  <table width="450" border="0" align="center" cellpadding="0"
          cellspacing="0">
          <tr>
                  <td class="remarque">&nbsp;</td>
          </tr>
  </table>
  <h2>Copier &agrave; partir des lignes &eacute;xistantes </h2>

  <form action="<%=lien%>?but=lc/apresLC.jsp" method="post"
          name="recette" id="recette" target="_parent"
          onsubmit="return (verifie(daty.value)&&verifie(designation.value)&&verifie(montant.value))">

  <table width="600" border="0" align="center" cellpadding="0"
          cellspacing="0">
          <tr>
                  <td>
                  <table width="100%" border="0" align="center" cellpadding="2"
                          cellspacing="0" class="monographe">
                          <tr>
                                  <td class="left" width="25%" valign="top"><div align="center">Mois de d&eacute;part :<span class="remarque">*</span></div></td>
                            <td align="center" width="25%"><select name="mois" class="champ" id="mois2">
                              <option value="%">Tous</option>
                              <%
          for(int i=0;i<mois.length;i++){
          %>
                              <option value="<%=moisRang[i]%>"><%=mois[i]%></option>
                              <%
                }
                %>
                            </select>                              &nbsp;</td>
                            <td align="center" width="25%"><span class="left"><strong>Ann&eacute;e de d&eacute;part :</strong><span
                                          class="remarque">*</span></span></td>
                            <td align="center" width="25%"><input type="text" readonly="readonly"
                                          name="annee" class="champ" id="annee"
                                          value="<%=String.valueOf(Utilitaire.getAneeEnCours()) %>" /></td>
                          </tr>
                          <tr>
                            <td class="left" valign="top"><div align="center">Mois cible :<span class="remarque">*</span></div></td>
                            <td align="center"><select name="mois2" class="champ" id="mois2">
                                <option value="%">Tous</option>
                                <%
          for(int i=0;i<mois.length;i++){
          %>
                                <option value="<%=moisRang[i]%>"><%=mois[i]%></option>
                                <%
                }
                %>
                              </select>
&nbsp;</td>
                            <td align="center"><span class="left"><strong>Ann&eacute;e cible :</strong><span
                                          class="remarque">*</span></span></td>
                            <td align="center"><input type="text" readonly="readonly"
                                          name="annee2" class="champ" id="annee2"
                                          value="<%=String.valueOf(Utilitaire.getAneeEnCours()) %>" /></td>
                          </tr>
                  </table>
                  </td>
          </tr>
          <tr>
                  <td height="30" align="center">
                  <table width="75%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td align="center"><input type="hidden" name="acte" value="copieLC" />
<input type="submit" name="Submit"  class="submit"></td>
<td align="center"><input type="reset" name="annuler"   value="R&eacute;tablir" class="submit"></td>
                          </tr>
                  </table>
                  </td>
          </tr>
  </table>
  </form>
  <div align="center"><span class="remarque">(*) Champs
  obligatoires</span></div>
  <%
  if (msg != null) {
  %>
  <br />
  <div align="center"><span
          style="text-align: center; font-weight: bold; color: blue; font-size: medium"><%=msg%></span>
  </div>

  <%
  }
%>