<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
    String apres = "facture/apresInit.jsp";
    String lien = null;
    facture.Client clt = null;
    facture.FactMere fm = null;
    String idFactMere = null;
    facture.FactureFille ff[] = null;
    String idClient = null;
    facture.Tva tva = null;
    UserEJB u = null;
    TypeObjet factEn = null;
    TypeObjet deviseEn = null;
    Societe spat = null;
    String[] texto = new String[2];
    Societe vv = null;
%>
<%
    idFactMere = request.getParameter("idFactureMere");
%>
<%
    try {
        u = (user.UserEJB) session.getValue("u");
        lien = (String) session.getValue("lien");
        fm = u.findFactureMereProforma("", "", idFactMere, "%", "", "%", "%", "%")[0];
        idClient = fm.getIdClient();
//tva = u.findTva(fm.getIdTva(),"","%","")[0];
        clt = u.findClient(fm.getIdClient(), "%", "%", "%", "%", "%", "%", "%", "%", "%", "%")[0];
        ff = u.findFactureFilleProforma("%", "%", "%", idFactMere);
        factEn = u.findTypeObjet("devise", fm.getIdFactureEn(), "%")[0];
        deviseEn = u.findTypeObjet("devise", fm.getIdDeviseEn(), "%")[0];
//tva = u.loadTva(String.valueOf(fm.getDaty()));
//spat = u.findMaSociete("%","%","%","%","%","%","%","%","%","%");
        texto = ChiffreLettre.convertRealToStringSepare((double) fm.getMontantAPayer());
//vv = u.findMaSociete("%","%","%","%","%","%","%","%","%","%");
    } catch (Exception e) {
%>
<script language="JavaScript"> document.location.replace("../erreur.jsp?message=<%=e.getMessage()%>");</script>
<%
    }
%>
<link href="style.css" rel="stylesheet" type="text/css">
<style type="text/css">
    div#selectnone{
        -webkit-touch-callout: none;
        -webkit-user-select: none;
        -khtml-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
    }
    table {
        border-collapse: collapse;
    }
</style>
<%
    if (fm.getIdEtat().compareTo("eta4") == 0 || fm.getIdEtat().compareTo("eta3") == 0) {
%>
<title>Apercu facture </title>
<div id="selectnone">
    <table width="80%" border="0" align="center">
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td><table width="90%" border="1" align="center" bordercolor="#cccccc">
                    <tr>
                        <td> <table width="100%" border="0" cellpadding="0" cellspacing="0" align="center" >
                                <!--DWLayoutTable-->
                                <tr>
                                    <td height="21" colspan="4"  align="right">Antananarivo - <%=Utilitaire.formatterDaty(fm.getDaty())%></td>
                                </tr>
                                <tr>
                                    <td width="368" height="21" colspan="4" align="center"><div align="left"><strong><font color="15" size="+2">Facture PROFORMA
                                                n&deg;</font></strong><font size="+1"><%=fm.getIdFactureMere()%></font> <br>
                                        </div></td>
                                </tr>
                                <tr>
                                    <td height="23" colspan="4" valign="top"><table width="100%" border="0">
                                            <tr>
                                                <td><strong>Doit :</strong> <%=clt.getNom()%></td>
                                            </tr>
                                            <tr>
                                                <td><table width="100%" border="0">
                                                        <tr>
                                                            <td><strong>Stat :</strong><font color="15"> <%=clt.getNumstat()%></font></td>
                                                            <td><strong>NIF : </strong><%=clt.getNif()%></td>
                                                            <td><strong>RC :</strong> <%=clt.getRc()%></td>
                                                        </tr>
                                                    </table></td>
                                            </tr>
                                            <tr>
                                                <td><table width="100%" border="0">
                                                        <tr>
                                                            <td width="51%"><strong>Adresse :</strong><%=clt.getAdresse()%></td>

                                                        </tr>
                                                    </table></td>
                                            </tr>
                                            <tr>
                                                <td><table width="100%" border="0">
                                                        <tr>
                                                            <td><strong>Devise en :</strong> <font color="15"><%=deviseEn.getVal()%></font></td>
                                                            <td><font color="15"><strong>Paiement en : </strong><font color="15"><%=factEn.getVal()%> ---- <%=u.findTypeObjet("TypePaiement", fm.getIdTypePaiement(), "%")[0].getVal()%></font></font></td>
                                                        </tr>
                                                    </table></td>
                                            </tr>
                                            <tr>
                                                <td><strong>Note explicative : <%=fm.getNoteExplicative()%></strong></td>
                                            </tr>
                                        </table></td>
                                </tr>
                            </table>

                        </td>
                    </tr>
                </table></td>
        </tr>
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <table width="90%" border="1" style="border-collapse: collapse;" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td colspan="13" height="1" bgcolor="#CCCCCC"></td>
                    </tr>
                    <tr class="headFact">
                        <td width="50%"> <div align="center">D&eacute;signation </div></td>
                        <td align="center">&nbsp; </td>
                        <td align="center"> Qt&eacute; </td>
                        <td align="center"> Unit&eacute; </td>
                        <td align="center">R&eacute;d.</td>
                        <td align="center" valign="middle"> Montant</td>
                    </tr>

                    <%
                        double montantSansReduction = 0;
                        double sommeReduction = 0;
                        for (int i = 0; i < ff.length; i++) {
                    %>
                    <tr>
                        <td><%=ff[i].getDesignation()%> </td>
                        <td align="right"><div align="center"><font color="15"><%=Utilitaire.formaterAr((double) ff[i].getPrixUnitaire())%></font></div></td>
                        <td align="center"><font color="15"><%=ff[i].getQuantite()%></font></td>
                        <td align="center"><%=u.findTypeObjet("unite", ff[i].getIdUnite(), "%")[0].getVal()%></td>
                        <td align="center"><%=ff[i].getReduction()%></td>
                        <td align="right"><font color="15"><%=Utilitaire.formaterAr((double) (ff[i].getMontant()))%><%=deviseEn.getVal()%></font></td>
                    </tr>
                    <%
                            montantSansReduction = montantSansReduction + (ff[i].getQuantite() * ff[i].getPrixUnitaire());
                            sommeReduction = (ff[i].getQuantite() * ff[i].getPrixUnitaire()) - ff[i].getMontant();
                        }
                        if (sommeReduction == 0) {
                            sommeReduction = fm.getMontantReductionProforma();
                        }
                    %>

                </table>
                <table width="90%" border="1" cellspacing="0" cellpadding="3" align="center">
                    <tr>
                        <td height="30" valign="bottom"   align="right"><strong>Total :</strong>
                            <font color="15"><%=Utilitaire.formaterAr((double) (AdminFacture.calculSommeFacture(ff)))%> <%=deviseEn.getVal()%></font></td>
                    </tr>
                </table></td>
        </tr>
        <tr>
            <td>&nbsp;</td>
        </tr>

        <tr>
            <td><table align="center" width="90%">
                    <td> </td>
        </tr>
        <tr>
            <td height="93" colspan="5" valign="top" width="90%"> <table width="100%" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td width="250" height="75" valign="top" align="center">&nbsp; </td>
                        <td width="60%" valign="top" align="right"> <table width="98%" height="100%" >
                                <!--DWLayoutTable-->
                                <tr>
                                    <td height="21"><strong>Montant sans r&eacute;duction :</strong></td>
                                    <td align="right"><%=Utilitaire.formaterAr(montantSansReduction)%> Ar</td>
                                </tr>
                                <tr>
                                    <td height="21"><strong>R&eacute;duction:</strong></td>
                                    <td align="right"><%=Utilitaire.formaterAr(sommeReduction)%> Ar</td>
                                </tr>
                                <%
                                    if (fm.getIdTva() > 0) {
                                %>
                                <tr>
                                    <td width="57%" height="21"><strong>Montant HTVA en <%=factEn.getVal()%> :</strong> </td>
                                    <td width="43%" align="right"><font color="15"><%=Utilitaire.formaterAr((double) (fm.getMontantHTvaProforma()))%> Ar</font></td>
                                </tr>
                                <tr>
                                    <td height="21"><strong>Montant TVA <%=fm.getIdTva()%>% en <%=factEn.getVal()%> :</strong></td>
                                    <td align="right"><font color="15"><%=Utilitaire.formaterAr((double) (fm.getMontantTvaProforma()))%> Ar</font></td>
                                </tr>
                                <%
                                    }
                                %>
                                <tr>
                                    <td height="21"><strong>Net &agrave; payer :</strong></td>
                                    <td align="right"> <%=Utilitaire.formaterAr((double) fm.getMontantTtcProforma())%> Ar</td>
                                </tr>
                            </table></td>
                        <td width="26"></td>
                    </tr>
                </table></td>
        </tr>
        <tr>
            <td height="26" colspan="5" valign="top"> Arr&ecirc;t&eacute; la pr&eacute;sente
                facture proforma &agrave; la somme de : <i> <font color="15"><%=texto[0]%> <%=factEn.getDesce()%><%="," + texto[1]%></font><font color="15"></font></i><br></td>
        </tr>
        <tr>
            <td height="26" colspan="5" valign="top" align="right"><div align="left">
                    <strong>Mode de Paiement : </strong></div></td>
        </tr>
        <tr>
            <td height="26" colspan="5" valign="top" align="right"><br> <table width="60%" border="0">
                    <tr>
                        <td><div align="left">Le Client</div></td>
                        <td><div align="right">Le Responsable</div></td>
                    </tr>
                </table></td>
        </tr>
    </table></td>
</tr>
<tr>
    <td height="128" valign="bottom">
        <div align="center"><font face="Verdana, Arial, Helvetica, sans-serif"></font>
        </div></td>
</tr>
</table>
</div>
<div align="center"></div>
<br>
<br>
<br>
<%
} else {
%>
<p align="center">
<h3 align="center">Facture non finalis&eacute;e</h3></p>
<div align="center">L'aperçu de cette facture n'est pas disponible parce qu'elle
    n'a pas encore été finalisée
    <%
        }
    %>
</div>

