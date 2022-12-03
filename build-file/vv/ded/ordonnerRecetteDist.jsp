<%@page import="java.sql.Connection"%>
<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="ventegazety.*" %>
<%@ page import="lc.Direction" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%!
    String apres = "ded/apresOrdonnerRecette.jsp";
    String lien = null;
    facture.Client clt[] = null;
    UserEJB u = null;
    TypeObjet tyo[] = null;
    TypeObjet dev[] = null;
    TypeObjet mp[] = null;
    TypeObjet source[] = null;
    TypeObjet ag[] = null;
    Caisse caiss[] = null;
    String idFact = null;
    facture.Tva tva = null;
    String nature = null;
    String numObjet = null;
    String typeObjet = null;
    String idLigne = null;
    double montant = 0;
    RecetteLibelleType p;

    String listerecette;
%>
<%
    idFact = request.getParameter("idFacture");
    typeObjet = request.getParameter("typeObjet");
    numObjet = request.getParameter("numObjet");
    if (numObjet == null) {
        numObjet = "";
    }
    idLigne = request.getParameter("idLigne");
    nature = request.getParameter("nature");
    if ((nature == null) || nature.compareTo("") == 0) {
        nature = "factureF";
    }
    if (idFact == null) {
        idFact = "";
    }
    Connection conn = null;
    try {
        conn = (new UtilDB()).GetConn();
        u = (user.UserEJB) session.getValue("u");
        lien = (String) session.getValue("lien");
        dev = u.findTypeObjet("Devise", "%", "%",conn);
        ag = u.findTypeObjet("Agence", "%", "%",conn);
        p = new RecetteLibelleType();
        p.setNomTable("RecetteLibellenonfacture");
        montant = 0;
        String[] idRec = request.getParameterValues("choix");
        listerecette = "";
        String reqeutte = Utilitaire.stringToTab(idRec, "'", ",");
        RecetteLibelleType[] lfp = (RecetteLibelleType[]) CGenUtil.rechercher(p, null, null, " and id in (" + reqeutte + ")");
        for (int i = 0; i < lfp.length; i++) {
            
            montant = montant + lfp[i].getMontant();
            listerecette += "," + idRec[i];
        }
        //System.out.println(" ====== WTF ======= " + listerecette);
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">


<h1>Ordonner Recette </h1>
<h2>&nbsp;</h2>

<h2>&nbsp;</h2>

<form action="<%=lien%>?but=<%=apres%>" method="post" name="recette" id="recette" target="_parent" onsubmit="return (verifie(daty.value) && verifie(designation.value) && verifie(montant.value))">

    <table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr><td> <table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
                    <tr>
                        <td class="left">Date : </td>
                        <td align="center"><input name="daty" type="text" class="champ" id="daty" value=<%=Utilitaire.dateDuJour()%> /></td>
                        <td align="left">&nbsp;
                            <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>
                            <img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
                    </tr>
                    <tr>
                        <td class="left">Designation : </td>
                        <td align="center"><textarea name="remarque" class="champ" id="remarque" maxlength="100">ddist-<%=request.getParameter("daty")%>-vente sd et gros tana</textarea></td>
                        <td align="center">&nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle"> </td>
                    </tr>
                    <tr>
                        <td class="left">Montant : </td>
                        <td align="center"><input name="montantTTC" type="text" class="champ" id="montantTTC" value="<%=montant%>" readonly/></td>
                        <td align="center">&nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
                    </tr>
                    <tr>
                        <td class="left">Montant TVA : </td>
                        <td align="center">
                            <input name="tva" type="text" class="champ" id="tva">&nbsp; </td>
                        <td align="center"><img src="images/blank.gif" width="16" height="16" align="absmiddle"></td>
                    </tr>
                    <tr>
                        <td class="left">Devise : <span class="remarque">*</span></td>
                        <td align="center"><input type="text" class="champ" name="idDevise" maxlenght="100" value="Ar" readonly/>&nbsp; </td>
                        <td align="center"><img src="images/blank.gif" width="16" height="16" align="absmiddle"></td>
                    </tr>
                    <tr>
                        <td class="left">Client : <span class="remarque">*</span></td>
                        <td align="center">
                            <input type="text" class="champ" name="fournisseur" maxlenght="100" value="clt005710" readonly/>&nbsp; </td>
                    <img src="images/blank.gif" width="16" height="16" align="absmiddle"></td>
                    </tr>
                    <tr>
                        <td class="left">Lc unique : <span class="remarque">*</span></td>
                        <td align="center">          <input type="text" class="champ" name="lc" value=""/>
                            &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
                        <td align="center"><input name="choix3" type="button" class="submit" onclick="pagePopUp('lc/listeLC2RecetteChoix.jsp?champReturn=lc')" value="lc" /></td>
                    </tr>
                    <tr>
                        <td class="left">resp : </td>
                        <td align="center">          <select name="resp" class="champ" id="idDevise">
                                <%
                                    for (int i = 0; i < ag.length; i++) {
                                %>
                                <option value="<%=ag[i].getId()%>" <% if (ag[i].getId().compareToIgnoreCase("agb24") == 0) {
                                                out.print("selected");
                                            }%>><%=ag[i].getVal()%></option>
                                <%
                                    }
                                %>
                            </select>            </td>
                        <td align="center"><input name="choix3" type="button" class="submit" onclick="pagePopUp('lc/listeLC2RecetteChoix.jsp?champReturn=lc')" value="lc" /></td>
                    </tr>

                </table></td></tr>

        <tr><td height="30" align="center"><table width="75%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td align="center"><input name="nature" type="hidden" id="nature" value="<%=nature%>">
                            <input name="typeOp" type="hidden" id="typeOp" value="<%=Constante.typeOpNormale%>">
                            <input name="acte" type="hidden" id="acte" value="INSERT">
                            <input name="typeor" type="hidden" id="typeor" value="dist">
                            <input name="listerecette" type="hidden" id="listerecette" value="<%=listerecette%>">
                            <input name="nbrechoix" type="hidden" id="nbrechoix" value="<%=idRec.length%>">
                            <input name="avecOp" type="hidden" id="acte" value="ok">
                            <input type="submit" name="Submit" value="Enregistrer" class="submit">
                        </td>
                        <td align="center">
                            <input type="reset" name="annuler" value="R&eacute;tablir" class="submit">
                        </td>
                    </tr>
                </table></td></tr>
    </table>


    <%
    } catch (Exception e) {
        e.printStackTrace();
    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>");</script>
    <%
        } finally {
            if (conn != null) {
                conn.close();
            }
        }
    %>






</form>
<div align="center">
    <script language="javascript">
        var cal1 = new calendar1(document.forms['recette'].elements['daty']);
        cal1.year_scroll = false;
        cal1.time_comp = false;

    </script>
    <span class="remarque">(*) Champs obligatoires</span></div>