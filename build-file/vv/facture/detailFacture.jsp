<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
    String apres = "facture/apresInit.jsp";
    String lien = null;
    facture.Client clt = null;
    facture.FactMere fm = null;
    String idFactMere = null;
    facture.FactureFille ff[] = null;
    String idClient = null;
    UserEJB u = null;
    Change dollar = null;
    TypeObjet factEn = null;
    TypeObjet devEn = null;
    historique.MapUtilisateur ut = null;
    VisaFactureClient v = null;
    FactureClientFiche fc = null;
    VisaFactureClient[] lvf;
    FactureClientFiche[] lfc;
%>
<%
    idFactMere = request.getParameter("idFactureMere");
    Connection conn = null;
    try {

        conn = (new UtilDB()).GetConn();
        u = (user.UserEJB) session.getValue("u");
        lien = (String) session.getValue("lien");
        ut = u.getUser();
        fm = u.findFactureMere("", "", idFactMere, "%", "", "%", "%", "%", conn)[0];
        idClient = fm.getIdClient();
        factEn = u.findTypeObjet("devise", fm.getIdFactureEn(), "%", conn)[0];
        devEn = u.findTypeObjet("devise", fm.getIdDeviseEn(), "%", conn)[0];
        clt = u.findClient(fm.getIdClient(), "%", "%", "%", "%", "%", "%", "%", "%", "%", "%", conn)[0];
        ff = u.findFactureFilleConn("%", "%", "%", idFactMere, conn);
        fc = new FactureClientFiche();
        v = new VisaFactureClient();
        lfc = (FactureClientFiche[]) CGenUtil.rechercher(fc, null, null, conn, " and numfact = '" + idFactMere + "'");
        lvf = (VisaFactureClient[]) CGenUtil.rechercher(v, null, null, conn," and idobjet='" + lfc[0].getIdfacturefournisseur() + "'");
    
%>
<div id="selectnone">

    <link href="style.css" rel="stylesheet" type="text/css">
    <title>Aper&ccedil;u facture</title><h2><font color="#CC3300">Facture non imprimable</font><br>
        <br>
        D&eacute;tails Facture N° <font color="15"><%=fm.getIdFactureMere()%></font></h2>
    <table  border="0" cellpadding="0" cellspacing="0" align="center" width="600">
        <tr><td>
                <table  border="0" cellpadding="0" cellspacing="0" align="center" >
                    <tr>
                        <td width="560" height="23" valign="top">&nbsp;<strong>Date de facturation
                                : </strong><font color="15"><%=Utilitaire.formatterDaty(fm.getDaty())%></font></td>
                        <td colspan="2" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                        <td colspan="2" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                    </tr>
                    <tr>
                        <td height="23" colspan="4" valign="top">&nbsp;<strong>Client :</strong>
                            <font color="15"><%=clt.getNom()%></font></td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td height="23" valign="top" colspan="4">&nbsp;<strong>Factur&eacute;e
                                en : </strong>&nbsp;<font color="15"><%=u.findTypeObjet("devise", fm.getIdFactureEn(), "%")[0].getVal()%></font></td>
                        <td height="23" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                    </tr>
                    <tr>
                        <td height="23" valign="top" colspan="5"><table width="552" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="262"><strong> &nbsp;Date d&eacute;but</strong> : <font color="15"><%=Utilitaire.formatterDaty(fm.getPeriodeDebut())%></font></td>
                                    <td width="290"> <strong>Date fin : </strong><font color="15"><%=Utilitaire.formatterDaty(fm.getPeriodeFin())%></font></td>
                                </tr>
                            </table></td>
                    </tr>
                    <tr>
                        <td height="23" valign="top" colspan="5">&nbsp;<strong>Etat : </strong>&nbsp;<font color="15"><%=u.findTypeObjet("Etat", fm.getIdEtat(), "%")[0].getVal()%></font></td>
                    </tr>
                    <tr>
                        <td height="23" valign="top" colspan="5">&nbsp;<strong>Type de paiement
                                : </strong>&nbsp;<font color="15"><%=u.findTypeObjet("TypePaiement", fm.getIdTypePaiement(), "%")[0].getVal()%></font></td>
                    </tr>
                    <tr>
                        <td height="23" colspan="2" valign="top">&nbsp;<strong>Note explicative
                                :</strong></td>
                        <td valign="top">&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td height="23" valign="top" colspan="3">&nbsp;<%=fm.getNoteExplicative()%></td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <%
                        if (fm.getScatService().getIdCategorie().compareTo("cat2") == 0) {
                    %>
                    <tr>
                        <td height="23" valign="top" colspan="3">&nbsp;<a href="<%=lien%>?but=penalites/apresListePenalites1.jsp&idPen=<%=ff[0].getRefObj()%>&idScat=<%=fm.getIdSCatService()%>">[
                                Voir d&eacute;tails p&eacute;nalit&eacute ]</a></td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <%
                        }
                    %>
                    <tr>
                        <td height="23" colspan="2" valign="top">&nbsp;<strong>R&eacute;duction
                                :</strong> <font color="15"><%=fm.getReduction()%></font>&nbsp;% </td>
                        <td valign="top"></td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td height="150" colspan="5" valign="top" align="center"><div align="left"><strong>
                                    &nbsp;Date limite de paiement :</strong> <font color="15"><%=Utilitaire.formatterDaty(fm.getDateLimitePaiement())%></font><br>
                                <br>
                            </div>
                            <table width="560" border="0" align="center" cellpadding="0" cellspacing="0" >
                                <tr>
                                    <td  height="23" valign="top"> 
                                        <table width="100%" border="0" cellpadding="0" cellpadding="5" cellspacing="2" class="monographe">
                                            <tr class="head">
                                                <td width="171">D&eacute;signation </td>
                                                <td width="36"><div align="center">Qt&eacute; </div></td>
                                                <td width="93"><div align="center">PU </div></td>
                                                <td width="52"><div align="center">Unit&eacute; </div></td>
                                                <td width="52"><div align="center">R&eacute;d(%)</div></td>
                                                <td width="116" valign="top" align="right">Montant&nbsp;</td>
                                            </tr>

                                            <%
                                                int tempred = 0;
                                                double sommered = 0;
                                                for (int i = 0; i < ff.length; i++) {
                                                    if (ff[i].getReduction() > 0) {
                                                        tempred = 1;
                                                    }
                                                    sommered = sommered + ((ff[i].getPrixUnitaire() * ff[i].getReduction()) / 100);
                                            %>
                                            <tr>
                                                <td height="23" valign="top"><font color="15"><%=ff[i].getDesignation()%></font></td>
                                                <td align="center" valign="top"><font color="15"><%=ff[i].getQuantite()%></font></td>
                                                <td valign="top"> <div align="center"><font color="15"><%=Utilitaire.formaterAr(ff[i].getPrixUnitaire())%></font></div></td>
                                                <td valign="top"> <div align="center"><font color="15"><%=ff[i].getIdUnite()%></font></div></td>
                                                <td align="center" valign="top"><font color="15"><%=ff[i].getReduction()%></font></td>
                                                <td align="right" valign="top"><%=Utilitaire.formaterAr((double) ff[i].getMontant())%> &nbsp;</td>
                                            </tr>
                                            <%
                                                }
                                            %>
                                            <tr>
                                                <td colspan="6" height="2" bgcolor="#0099FF"></td>
                                            </tr>
                                            <tr>
                                                <td colspan="6"> <table width="560" border="0" cellpadding="0" cellspacing="0">
                                                        <tr>
                                                            <td width="427" height="23"   align="right" valign="middle"><strong>Total
                                                                    :</strong></td>
                                                            <td width="133" align="right" valign="middle"> <%=Utilitaire.formaterAr((double) (AdminFacture.calculSommeFacture(ff)))%>&nbsp;<%=devEn.getVal()%></td>
                                                        </tr>
                                                    </table></td>
                                            </tr>
                                        </table></td>
                                </tr>
                            </table></td>
                    </tr>
                    <tr>
                        <td height="93" colspan="5" valign="top" width="560"> <table align="right" width="560">
                                <!--DWLayoutTable-->
                                <tr>
                                    <td width="230" height="75" valign="top"><!--DWLayoutEmptyCell-->&nbsp; </td>
                                    <td width="334" valign="top" align="right"> <table >
                                            <%if (tempred <= 0) {%>

                                            <tr>
                                                <td height="21"><strong>Montant sans réduction :</strong>
                                                </td>
                                                <td align="right"><font color="15"><%=Utilitaire.formaterAr((double) (fm.getMontantSansReduction(conn)))%> <%=factEn.getVal()%></font></td>
                                            </tr>
                                            <tr>
                                                <td height="21"><strong>Montant réduction :</strong></td>
                                                <td align="right"><font color="15"><%=Utilitaire.formaterAr((double) (fm.getMontantReduction(conn)))%> <%=factEn.getVal()%></font></td>
                                            </tr>
                                            <%} else {%>
                                            <tr>
                                                <td height="21"><strong>Somme r&eacute;duction :</strong></td>
                                                <td align="right"><%=Utilitaire.formaterAr(sommered)%> <%=factEn.getVal()%></td>
                                            </tr>
                                            <tr>
                                                <td height="21"><strong>Montant avec réduction :</strong>
                                                </td>
                                                <td align="right"><font color="15"><%=Utilitaire.formaterAr((double) (fm.getMontantSansReduction(conn)))%> <%=factEn.getVal()%></font></td>
                                            </tr>
                                            <%}%>

                                            <tr>
                                                <td height="21"><strong>Montant HTVA :</strong> </td>
                                                <td align="right"><font color="15"><%=Utilitaire.formaterAr((double) (fm.getMontantHTva(conn)))%> <%=factEn.getVal()%></font></td>
                                            </tr>
                                            <tr>
                                                <td height="21"><strong>TVA <%=fm.getIdTva()%>% :</strong></td>
                                                <td align="right"><font color="15"><%=Utilitaire.formaterAr((double) (fm.getMontantTva(conn)))%> <%=factEn.getVal()%></font></td>
                                            </tr>
                                            <tr>
                                                <td height="21"><strong>Total TTC :</strong> </td>
                                                <td align="right"><%=Utilitaire.formaterAr((double) fm.getMontantTtc(conn))%> <%=factEn.getVal()%></td>
                                            </tr>
                                        </table></td>
                                    <td width="26"></td>
                                </tr>
                            </table></td>
                    </tr>
                </table>
            </td></tr>
    </table>
    <div align="center">
        <h2><font color="#CC3300">Facture non imprimable</font></h2>

        <%if (lvf.length != 0) {%>
        <a href='javascript:Popup("facture/apercuFacture.jsp?idFactureMere=<%=fm.getIdFactureMere()%>","fenetre",800,600,"menubar=yes,scrollbars=yes,statusbar=no")'>Voir aperçu</a><br>
        <a href='javascript:Popup("facture/apercuFactureEntete.jsp?idFactureMere=<%=fm.getIdFactureMere()%>","fenetre",800,600,"menubar=yes,scrollbars=yes,statusbar=no")'>Voir
            aperçu avec entete</a><br>
            <%} else {%>
        <h2><font color="#CC3300">Facture non viser</font></h2>
            <%}%>
              <!--  <a href="facture/apercuFacture.jsp?idFactureMere=<%=fm.getIdFactureMere()%>" target="_blank">Voir
              aperçu</a>--> </div>
</div>
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