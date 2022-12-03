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

	String mois[] = { "Janvier", "Février", "Mars", "Avril", "Mai", "Juin",
			"Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre" };

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

	String msg = "";%>
<%
		try {
		u = (user.UserEJB) session.getValue("u");
		lien = (String) session.getValue("lien");
		mois2 = request.getParameter("mois");
		if ((mois2 == null) || mois2.compareTo("") == 0)
			mois2 = "%";
		annee = request.getParameter("annee");
		if ((annee == null) || annee.compareTo("") == 0)
			annee = String.valueOf(Utilitaire.getAneeEnCours());
		acte = request.getParameter("acte");
		if ((acte == null) || acte.compareTo("") == 0)
			acte = "Créer";
		idLC = request.getParameter("idLigneACopier");
		if ((idLC == null) || idLC.compareTo("") == 0)
			idLC = "";

		msg = request.getParameter("msg");
		source = u.findTypeObjet("Beneficiaire", "%", "%");
		tlc = u.findTypeObjet("TypeLigneCredit", "%", "%");
		compte = u.findTypeObjet("comptecompta", "%", "%");
		dir = u.findDirection("", "", "", "", "");
		if (acte.compareToIgnoreCase("copier") == 0) {
			lc =  u.findLC(idLC,"%","%","%","%","%","%","lignecredit")[0];
			designation = lc.getDesignation();
			numCompte = lc.getNumCompte();
			idTypeLC = lc.getIdTypeLigne();
			credit = String.valueOf(lc.getCreditInitial());
			direction = lc.getIdDirection();
		}

	} catch (Exception e) {
%>
  <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
  <%
  }
  %>
  <SCRIPT language="JavaScript" src="script.js"></script>
  <link href="style.css" rel="stylesheet" type="text/css">
  <h1>Enregistrement d'une nouvelle ligne de cr&eacute;dit</h1>
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

  <form action="<%=lien%>?but=lc/nouvelleLC.jsp" method="post">
  <table width="450" border="0" align="center" cellpadding="0"
          cellspacing="0">
          <tr>
                  <td>
                  <table width="100%" border="0" align="center" cellpadding="2"
                          cellspacing="0" class="monographe">
                          <!--DWLayoutTable-->
                          <tr>
                                  <td class="left">Numero Ligne :</td>
                                  <td align="center"><input name="idLigneACopier" type="text"
                                          class="champ" id="idLigneACopier" value="<%=idLC %>"> <input
                                          name="acte" type="hidden" id="acte" value="Copier"> <input
                                          name="choix3" type="button" onClick="pagePopUp('lc/listeLC.jsp')"
                                          value="..."></td>
                          </tr>


                  </table>
                  </td>
          </tr>
          <tr>
                  <td height="30" align="center">
                  <table width="75%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                                  <td align="center"><input type="submit" name="Submit2"  value="Copier 1" class="submit"
                                          onClick="MM_validateForm('numFact','','R');return document.MM_returnValue">
                                  </td>
                                  <td align="center"><input type="reset" name="annuler2"
                                          value="R&eacute;tablir" class="submit"></td>
                          </tr>
                  </table>
                  </td>
          </tr>
  </table>
  </form>
  <h2><%=(acte.compareTo("Créer") == 0 ? "Nouvelle" : "Copier")%> une
  ligne de cr&eacute;dit</h2>
  <form action="<%=lien%>?but=lc/apresLC.jsp" method="post"
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
                                  <%
                                  if (acte.compareTo("Créer") == 0) {
                                  %> <input name="designation"
                                          type="text" class="champ" id="designation"
                                          value="<%=designation %>"> <%
   } else {
   %> <input
                                          readonly="readonly" style="background-color:#FFBDCD "
                                          name="designation" type="text" class="champ" id="designation"
                                          value="<%=designation %>"> <%
   }
   %> &nbsp;<img
                                          src="images/blank.gif" width="16" height="16" align="absmiddle">
                                  </td>
                          </tr>
                          <tr>
                                  <td class="left">Type :</td>
                                  <td align="center">
                                  <%
                                  if (acte.compareTo("Créer") == 0) {
                                  %> <select name="idTypeLC"
                                          class="champ" id="idTypeLC">
                                          <%
                                          for (int i = 0; i < tlc.length; i++) {
                                          %>
                                          <option value="<%=tlc[i].getId()%>"
                                                  <%if(tlc[i].getId().compareTo(idTypeLC)==0) out.println(" selected ");%>><%=tlc[i].getVal()%></option>
                                          <%
                                          }
                                          %>
                                  </select> <%
   } else {
   %> <input readonly="readonly"
                                          style="background-color:#FFBDCD " type="text" name="idTypeLC"
                                          class="champ" id="idTypeLC" value="<%=idTypeLC %>"> <%
   }
   %>
                                  &nbsp;<img src="images/blank.gif" width="16" height="16"
                                          align="absmiddle"></td>
                          </tr>
                          <tr>
                                  <td class="left">Num Compte:</td>
                                  <td align="center">
                                  <%
                                  if (acte.compareTo("Créer") == 0) {
                                  %> <select name="numCompte"
                                          class="champ" id="numCompte">
                                          <%
                                          for (int i = 0; i < compte.length; i++) {
                                          %>
                                          <option value="<%=compte[i].getId()%>"
                                                  <%if(compte[i].getId().compareTo(numCompte)==0) out.println(" selected ");%>><%=compte[i].getVal()%></option>
                                          <%
                                          }
                                          %>
                                  </select> <%
   } else {
   %> <input readonly="readonly"
                                          style="background-color:#FFBDCD " type="text" name="numCompte"
                                          class="champ" id="numCompte" value="<%=numCompte %>"> <%
   }
   %>
                                  &nbsp;<img src="images/blank.gif" width="16" height="16"
                                          align="absmiddle"></td>
                          </tr>
                          <tr>
                                  <td class="left">Cr&eacute;dit: <span class="remarque">*</span></td>
                                  <td align="center">
                                  <%
                                  if (acte.compareTo("Créer") == 0) {
                                  %> <input name="credit" type="text"
                                          class="champ" id="credit" size="20" maxlength="20"
                                          value="<%=credit %>"> <%
   } else {
   %> <input readonly="readonly"
                                          style="background-color:#FFBDCD " name="credit" type="text"
                                          class="champ" id="credit" value="<%=credit %>"> <%
   }
   %> &nbsp;<img
                                          src="images/blank.gif" width="16" height="16" align="absmiddle">
                                  </td>
                          </tr>

                          <tr>
                                  <td class="left" valign="top">Direction:<span class="remarque">*</span></td>
                                  <td align="center"><select name="direction" class="champ"
                                          id="direction">
                                          <%
                                          for (int i = 0; i < dir.length; i++) {
                                          %>
                                          <option value="<%=dir[i].getIdDir()%>"
                                                  <%if(dir[i].getIdDir().compareTo(direction)==0) out.println(" selected ");%>><%=dir[i].getAbbrevDir()%></option>
                                          <%
                                          }
                                          %>
                                  </select> &nbsp;<img src="images/blank.gif" width="16" height="16"
                                          align="absmiddle"></td>
                          </tr>
                          <tr>
                                  <td class="left" valign="top">Entit&eacute;:<span
                                          class="remarque">*</span></td>
                                  <td align="center"><select name="entite" class="champ"
                                          id="entite">
                                          <%
                                          for (int i = 0; i < source.length; i++) {
                                          %>
                                          <option value="<%=source[i].getId()%>"
                                                  <%if(source[i].getId().compareTo("BE011")==0) out.println(" selected ");%>><%=source[i].getVal()%></option>
                                          <%
                                          }
                                          %>
                                  </select> &nbsp;<img src="images/blank.gif" width="16" height="16"
                                          align="absmiddle"></td>
                          </tr>
                          <tr>
                                  <td class="left" valign="top">Mois:<span class="remarque">*</span></td>
                                  <td align="center"><select name="mois" class="champ">
                                          <%
                                          for (int i = 0; i < mois.length; i++) {
                                          %>
                                          <option <%if(mois[i].compareTo(mois2)==0)out.print(" selected ");%>><%=mois[i]%></option>
                                          <%
                                          }
                                          %>
                                  </select> &nbsp;<img src="images/blank.gif" width="16" height="16"
                                          align="absmiddle"></td>
                          </tr>
                          <tr>
                                  <td class="left" valign="top">Ann&eacute;e:<span
                                          class="remarque">*</span></td>
                                  <td align="center"><input type="text" readonly="readonly"
                                          name="annee" class="champ" id="annee"
                                          value="<%=String.valueOf(Utilitaire.getAneeEnCours()) %>" />
                                  &nbsp;<img src="images/blank.gif" width="16" height="16"
                                          align="absmiddle"></td>
                          </tr>
                          <tr>
                                  <td class="left" valign="top">Remarque:</td>
                                  <td align="center"><textarea rows="2" cols="15" name="rmq"
                                          class="champ" id="rmq"> </textarea> &nbsp;<img
                                          src="images/blank.gif" width="16" height="16" align="absmiddle">
                                  </td>
                          </tr>
                  </table>
                  </td>
          </tr>
          <tr>
                  <td height="30" align="center">
                  <table width="75%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                                  <td align="center"><input name="acte" type="hidden" id="acte"
                                          value="<%=(acte.compareTo("Créer")==0)?"insert":"copier" %>">
                                  <%
                                  if (acte.compareTo("Créer") != 0) {
                                  %> <input type="hidden"
                                          id="idLigneACopier" name="idLigneACopier"
                                          value=<%=lc.getIdLigne() %> /> <%
   }
   %> <input type="submit"
                                          name="Submit"
                                          value="<%=(acte.compareTo("Créer")==0)?"Enregistrer":"Valider Copie" %>"
                                          class="submit"></td>
                                  <td align="center"><input type="reset" name="annuler"
                                          value="R&eacute;tablir" class="submit"></td>
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
