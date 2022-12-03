<%@ page import="user.*"%>
<%@ page import="facture.*"%>
<%@ page import="finance.*"%>
<%@ page import="lc.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="bean.*"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage=""%>
<%!String apres = "finance/";

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
String idLigne ="";
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
                idLigne = request.getParameter("numObjet");
                if ((annee == null) || annee.compareTo("") == 0)
                        annee = String.valueOf(Utilitaire.getAneeEnCours());
                lc =  u.findLC(idLigne,"%","%","%","%","%","%","lignecreditRecette")[0];
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
  <h1>Modification d'une  ligne de cr&eacute;dit</h1>


  <form action="<%=lien%>?but=lc/apresLCRecette.jsp" method="post"
          name="recette" id="recette" target="_parent"
          onsubmit="return (verifie(daty.value)&&verifie(designation.value)&&verifie(montant.value))">

  <table width="450" border="0" align="center" cellpadding="0"
          cellspacing="0">
          <tr>
                  <td>
                  <table width="100%" border="0" align="center" cellpadding="2"
                          cellspacing="0" class="monographe">
                          <input type="hidden" value="<%=lc.getIdLigne()%>" name="idLigne" id="idLigne">
                          <tr>
                                  <td class="left">D&eacute;signation : <span class="remarque">*</span></td>
                            <td align="center">
                                   <input name="designation"
                                          type="text" class="champ" id="designation" value="<%=lc.getDesignation()%>">    &nbsp;                            </td>
                          </tr>
                          <tr>
                                  <td class="left">Type :</td>
                            <td align="center">
                                   <select name="idTypeLC"
                                          class="champ" id="idTypeLC">
                                          <%
                                          for (int i = 0; i < tlc.length; i++) {
                                          %>
                                          <option value="<%=tlc[i].getId()%>" <%if(tlc[i].getId().equalsIgnoreCase(lc.getIdTypeLigne()) )out.println("selected"); %>><%=tlc[i].getVal()%></option>
                                          <%
                                          }
                                          %>
                                  </select>
                            &nbsp;</td>
                          </tr>
                          <tr>
                                  <td class="left">Num Compte:</td>
                            <td align="center">
                                   <select name="numeroc"
                                          class="champ" id="numeroc">
                                          <%
                                          for (int i = 0; i < compte.length; i++) {
                                          %>
                                          <option value="<%=compte[i].getId()%>" <%if(compte[i].getId().equalsIgnoreCase(lc.getNumCompte()) )out.println("selected"); %>><%=compte[i].getVal()%></option>
                                          <%
                                          }
                                          %>
                                  </select>
                            &nbsp;</td>
                          </tr>
                          <tr>
                                  <td class="left">Cr&eacute;dit initial:  <span class="remarque">*</span></td>
                            <td align="center">
                                   <input name="creditIni" type="text"
                                          class="champ" id="creditIni" size="20" maxlength="20" value="<%=lc.getCreditInitial()%>">    &nbsp;                            </td>
                          </tr>
<tr>
                                  <td class="left">Cr&eacute;dit modifié: <span class="remarque">*</span></td>
                            <td align="center">
                                   <input name="creditMod" type="text"
                                          class="champ" id="creditMod" size="20" maxlength="20" value="<%=lc.getCreditModifier()%>">    &nbsp;                            </td>
                          </tr>
                          <tr>
                                  <td class="left" valign="top">Direction:<span class="remarque">*</span></td>
                            <td align="center"><select name="direction" class="champ"
                                          id="direction">
                                          <%
                                          for (int i = 0; i < dir.length; i++) {
                                          %>
                                          <option value="<%=dir[i].getIdDir()%>"  <%if(dir[i].getIdDir().equalsIgnoreCase(lc.getIdDirection()) )out.println("selected"); %>><%=dir[i].getAbbrevDir()%></option>
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
                                          <option value="<%=source[i].getId()%>"  <%if(source[i].getId().equalsIgnoreCase(lc.getIdEntite()) )out.println("selected"); %>><%=source[i].getVal()%></option>
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
                              <option value="<%=moisRang[i]%>"  <%if(moisRang[i].equalsIgnoreCase(lc.getMois()) )out.println("selected"); %>><%=mois[i]%></option>
                              <%
                }
                %>
                            </select>                              &nbsp;</td>
                          </tr>
                          <tr>
                                  <td class="left" valign="top">Ann&eacute;e:<span
                                          class="remarque">*</span></td>
                            <td align="center"><input type="text" readonly="readonly"
                                          name="annee" class="champ" id="annee"
                                          value="<%=String.valueOf(Utilitaire.getAneeEnCours()) %>" />
                              &nbsp;</td>
                          </tr>
                          <tr>
                                  <td class="left" valign="top">Parution inf &agrave; sup :</td>
                            <td align="center"> <input type="text" name="paruInf" class="champ" id="paruSup" />
                              &nbsp;&agrave;
                              <input type="text" name="paruSup" class="champ" id="paruInf" /></td>
                          </tr>
                  </table>
                  </td>
          </tr>
          <tr>
                  <td height="30" align="center">
                  <table width="75%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td align="center"><input type="hidden" name="idLigne" value="<%=idLigne%>" />
                            <input type="hidden" name="acte" value="update" />
<input type="submit" name="submit"  class="submit" value="Modifier"></td>
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