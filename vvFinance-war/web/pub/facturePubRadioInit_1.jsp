<%-- 
    Document   : facturePubRadioInit
    Created on : 15 juin 2017, 08:53:55
    Author     : Alain
--%>
<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="pub.*" %>
<%@ page import="java.util.Map" %>
<%@ page import="bean.*" %>
<%@ page import="ventegazety.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.TypeObjet" %>
<%@page import="bean.ClassMAPTable"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%
    String apres = "pub/factureRadioMere_1.jsp";
    String lien = null;
    facture.Client clt[] = null;
    facture.SCatService sctserv[] = null;
    TypeObjet ag[] = null;
    TypeObjet ttva[] = null;
    TypeObjet enti[] = null;
    UserEJB u = null;
    String acte = null;
    Agence agence = null;
    Agence[] lag = null;
    Beneficiaire benef = null;
    Agence[] lbenef = null;
    FactureClient fc = null;
    PubTopRadio pub = null;
    Pucompletid[] lpub = null;
    FactureMereProforma fm = null;
    FactureClient[] lfc = null;
    FactureMereProforma[] lfm = null;
    finance.ScatService scs = null;
    finance.ScatService[] lscs = null;
    Client client = null;
    Client[] lclient = null;
    String[] g = null;

    InvenduLibelleType invlbtp = null;
    InvenduLibelleType[] linvendu = null;
    int reduction = 0;

    String listepub = "";
    Connection conn = null;
    PubRadioPartenariat part = null;
    try {
        conn = (new UtilDB()).GetConn();
        u = (user.UserEJB) session.getValue("u");
        acte = request.getParameter("acte");
        clt = u.findClient("%", "%", "%", "%", "%", "%", "%", "%", "%", "%", "%", conn);
        sctserv = u.findSCatService("%", "%", "%", "%", conn);
        ag = u.findTypeObjet("Agence", "%", "%", conn);
        ttva = u.findTypeObjet("typetva", "%", "%", conn);
        enti = u.findTypeObjet("BENEFICIAIRE", "%", "%", conn);
        
        lien = (String) session.getValue("lien");

        
        if (acte.compareTo("facturer") == 0) {
            String[] idInv = request.getParameterValues("id");
            listepub = Utilitaire.stringToTab(idInv, "", ",");
            part = ((PubRadioPartenariat[])CGenUtil.rechercher(new PubRadioPartenariat(), null, null, conn, " AND ID = '"+idInv[0]+"'"))[0];
            session.setAttribute("idpubradiof", listepub);
            g = idInv;
        }
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Cr&eacute;er une nouvelle facture (1)</h1>

<form action="<%=lien%>?but=<%=apres%>" method="post" name="factureInit" id="factureInit">
    <table width="500" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr>
            <td align="center">
                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="monographe">
                    <tr>
                        <td width="33%" class="left" height="23"> &nbsp;Date :</td>
                        <td width="10%">&nbsp;</td>
                        <td width="57%">
                            <input name="date" type="text" class="champ" id="date" value="<%=Utilitaire.dateDuJour()%>" size="10" maxlength="10" onBlur="cal_prs_date1(date.value)">
                            <a href="javascript:cal1.popup()">
                                <img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle">
                            </a>
                            <span class="remarque">(date cr&eacute;ation facture)</span>
                        </td>
                    </tr>
                    <tr>
                        <td height="23" class="left"> &nbsp;Date d&eacute;but :</td>
                        <td>&nbsp;</td>
                        <td>
                            <input name="dateDebut" type="text" class="champ" id="dateDebut" value="<%=Utilitaire.dateDuJour()%>" size="10" maxlength="10" onBlur="cal_prs_date1(dateDebut.value)">
                            <a href="javascript:cal2.popup()">
                                <img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle">
                            </a>
                            <span class="remarque">(date debut facture)</span>
                        </td>
                    </tr>
                    <tr>
                        <td height="23" class="left"> &nbsp;Date fin :</td>
                        <td>&nbsp;</td>
                        <td> 
                            <input name="dateFin" type="text" class="champ" id="dateFin" value="<%=Utilitaire.dateDuJour()%>" size="10" maxlength="10" onBlur="cal_prs_date1(dateFin.value)">
                            <span class="remarque">
                                <a href="javascript:cal3.popup()">
                                    <img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>
                                (date fin facture)
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <td height="23" class="left"> &nbsp;Client :</td>
                        <td>&nbsp;</td>
                        <td><input name="idClient" type="text" class="champ" id="idClient2" size="10" maxlength="20" onBlur="cal_prs_date1(dateFin.value)" value="<%=part.getClient()%>">
                            <input name="choix3" type="button" class="submit" onclick="pagePopUp('ded/choix_tiers.jsp?champReturn=idClient')" value="..." />
                        </td>

                    </tr>

                    <tr>
                        <td height="23" class="left"> &nbsp;Type :</td>
                        <td>&nbsp;</td>
                        <td> 
                            <select name="idType" class="champ"  id="idType">
                                <%  for (int i = 0; i < sctserv.length; i++) {
                                        if (sctserv[i].getIdCategorie().compareTo("cat2") != 0) {
                                %>
                                <option value="<%=sctserv[i].getIdScatService()%>" <%if (sctserv[i].getIdScatService().compareTo("scat13") == 0) {
                                        out.println("selected");
                                    }%>><%=sctserv[i].getNomSCatService()%></option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td height="23" class="left"> Agence :</td>
                        <td>&nbsp;</td>
                        <td> <select name="agence" class="champ" id="agence">
                                <%
                                    for (int i = 0; i < ag.length; i++) {
                                %>
                                <option value="<%=ag[i].getId()%>" <%if (ag[i].getId().compareTo("ag005") == 0) {
                                        out.println("selected");
                                    }%>><%=ag[i].getVal()%></option>
                                <%
                                    }
                                %>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td height="23" class="left"> Entité :</td>
                        <td>&nbsp;</td>
                        <td> <select name="entite" class="champ" id="entite">
                                <%
                                    for (int i = 0; i < enti.length; i++) {
                                %>
                                <option value="<%=enti[i].getId()%>" <%if (enti[i].getId().compareTo("ent1") == 0) {
                                        out.println("selected");
                                    }%>><%=enti[i].getVal()%></option>
                                <%
                                    }
                                %>
                            </select></td>
                    </tr>
                    <tr>
                        <td height="23" valign="top" class="left">Parution :</td>
                        <td>&nbsp;</td>
                        <td><input name="parution" type="text" class="champ" id="parution" ></td>
                    <input name="acte" type="hidden" value="<%=acte%>">
                    </tr>

                    <tr>
                        <td height="23" valign="top" class="left">TVA :</td>
                        <td>&nbsp;</td>
                        <td> <select name="ttva" class="champ" id="ttva">
                                <%
                                    for (int i = 0; i < ttva.length; i++) {
                                %>
                                <option value="<%=ttva[i].getId()%>"><%=ttva[i].getVal()%></option>
                                <%
                                    }
                                %>
                            </select></td>
                    </tr>
                    <tr>
                        <td height="23" valign="top" class="left">Facture avec date :</td>
                        <td>&nbsp;</td>
                        <td> <select name="datyparu" class="champ" id="datyparu">
                                <option value="0">sans date</option>
                                <option value="1">avec date</option>
                            </select></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td height="30">
                <table width="75%" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="50%" height="30">
                            <div align="center">
                                <input name="idpub" type="hidden" value="<%=listepub%>">

                                <input name="typefact" type="hidden" value="normale">
                                <input type="submit" name="Submit" value="Cr&eacute;er" class="submit" onClick="MM_validateForm('date', '', 'R', 'dateDebut', '', 'R', 'dateFin', '', 'R');return document.MM_returnValue">
                            </div></td>
                        <td width="50%"><div align="center">
                                <input name="reset" type="reset" class="submit" value="R&eacute;initialiser">
                            </div></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</form>
<p align="center">&nbsp;</p>
<script language="javascript">
    var cal1 = new calendar1(document.forms['factureInit'].elements['date']);
    cal1.year_scroll = false;
    cal1.time_comp = false;
    var cal2 = new calendar1(document.forms['factureInit'].elements['dateDebut']);
    cal2.year_scroll = false;
    cal2.time_comp = false;
    var cal3 = new calendar1(document.forms['factureInit'].elements['dateFin']);
    cal3.year_scroll = false;
    cal3.time_comp = false;
</script>
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