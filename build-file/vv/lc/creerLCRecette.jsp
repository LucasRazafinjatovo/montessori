<%@ page import="user.*"%>
<%@ page import="facture.*"%>
<%@ page import="finance.*"%>
<%@ page import="lc.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="bean.*"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage=""%>
<%!String apres = "finance/apresLCRecette.jsp";

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
                tlc = u.findTypeObjet("TypeEntree", "%", "%");
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
  <h1>Enregistrement d'une nouvelle ligne de cr&eacute;dit Recette </h1>
  <table width="450" border="0" align="center" cellpadding="0"
          cellspacing="0">
          <tr>
                  <td class="remarque">Il ya deux (2) façons d'enregistrer une
                  ligne de cr&eacute;dit: soit copier &agrave; partir d'une ligne de
                  cr&eacute;dit existante, soit cr&eacute;er une nouvelle ligne de
                  cr&eacute;dit.</td>
          </tr>
  </table>
  <h2>Copier &agrave; partir d'une ligne de cr&eacute;dit existante</h2>

  <h2>Cr&eacute;er une
  ligne de cr&eacute;dit Recette </h2>
  <form action="<%=lien%>?but=lc/apresLCRecette.jsp" method="post"
          name="recette" id="recette" target="_parent"
          onsubmit="return (verifie(daty.value)&&verifie(designation.value)&&verifie(montant.value))">

  <table width="450" border="0" align="center" cellpadding="0"
          cellspacing="0">
          <tr>
                  <td>
                  <table width="100%" border="0" align="center" cellpadding="2"
                          cellspacing="0" class="monographe">
                          <tr>
                                  <td class="left">D&eacute;signation : <span class="remarque">*</span></td>
                            <td align="center">
                                   <textarea name="designation"
                                          class="champ" id="designation"></textarea>   &nbsp;                            </td>
                          </tr>
                          <tr>
                                  <td class="left">Type :</td>
                            <td align="center">
                                   <select name="idTypeLC"
                                          class="champ" id="idTypeLC">
                                          <%
                                          for (int i = 0; i < tlc.length; i++) {
                                          %>
                                          <option value="<%=tlc[i].getId()%>"><%=tlc[i].getVal()%></option>
                                          <%
                                          }
                                          %>
                                  </select>
                            &nbsp;</td>
                          </tr>
                          <tr>
                                  <td class="left">Num Compte:</td>
                            <td align="center">
                                   <input name="numeroc" id="numeroc" type="text" value="1">
                            &nbsp;</td>
                            <td><input name='choix' type='button' class='submit' onclick=pagePopUp('listeCompteGChoix.jsp?champReturn=numeroc') value=... /></td>
                          </tr>
                          <tr>
                                  <td class="left">Cr&eacute;dit: <span class="remarque">*</span></td>
                            <td align="center">
                                   <input name="credit" type="text"
                                          class="champ" id="credit" size="20" maxlength="20">    &nbsp;                            </td>
                          </tr>

                          <tr>
                                  <td class="left" valign="top">Direction:<span class="remarque">*</span></td>
                            <td align="center"><select name="direction" class="champ"
                                          id="direction">
                                          <%
                                          for (int i = 0; i < dir.length; i++) {
                                          %>
                                          <option value="<%=dir[i].getIdDir()%>"><%=dir[i].getAbbrevDir()%></option>
                                          <%
                                          }
                                          %>
                                  </select> &nbsp;</td>
                          </tr>
                          <tr>
                                  <td class="left" valign="top">Entit&eacute;:<span
                                          class="remarque">*</span></td>
                            <td align="center"><select name="entite" class="champ"
                                          id="entite">
                                          <%
                                          for (int i = 0; i < source.length; i++) {
                                          %>
                                          <option value="<%=source[i].getId()%>"><%=source[i].getVal()%></option>
                                          <%
                                          }
                                          %>
                                  </select> &nbsp;</td>
                          </tr>
                          <tr>
                                  <td class="left" valign="top">Mois:<span class="remarque">*</span></td>
                            <td align="center"><select name="mois" class="champ" id="mois2">
                              <%
          for(int i=0;i<mois.length;i++){
          %>
                              <option value="<%=moisRang[i]%>"><%=mois[i]%></option>
                              <%
                }
                %>
                            </select>                              &nbsp;</td>
                          </tr>
                          <tr>
                                  <td class="left" valign="top">Ann&eacute;e:<span
                                          class="remarque">*</span></td>
                            <td align="center"><input type="text"
                                          name="annee" class="champ" id="annee"
                                          value="<%=String.valueOf(Utilitaire.getAneeEnCours()) %>" />
                              &nbsp;</td>
                          </tr>
                  </table>
                  </td>
          </tr>
          <tr>
                  <td height="30" align="center">
                  <table width="75%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td align="center"><input type="hidden" name="acte" value="insertLC" />
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