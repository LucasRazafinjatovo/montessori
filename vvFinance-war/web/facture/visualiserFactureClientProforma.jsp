<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="ded.*" %>
<%@ page import="facturefournisseur.FactureFournisseur" %>
<%@ page import="facturefournisseur.Detail" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%!
    String apres = "facture/apresvisualiserFactureClient.jsp";
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
    String idDed = null;
    Detail detail[] = null;
    Visa[] v = null;
    FactureFournisseur bc[] = null;
%>
<%
    idFact = request.getParameter("idFactureFournisseur");
    if (idFact == null || idFact.compareToIgnoreCase("") == 0) {
        idFact = request.getParameter("idFactureFournisseur");
    }
    nature = request.getParameter("nature");
    if ((nature == null) || nature.compareTo("") == 0) {
        nature = "factureClientProforma";
    }
    idDed = request.getParameter("idDed");
    if (idFact == null) {
        idFact = "";
    }
    try {
        u = (user.UserEJB) session.getValue("u");
        lien = (String) session.getValue("lien");
//dev = u.findTva("%", "%","","");
        clt = u.findClient("%", "%", "%", "%", "%", "%", "%", "%", "%", "%", "%");
        tva = u.loadTva(Utilitaire.dateDuJour());
        FactureFournisseur crt = new FactureFournisseur();
        crt.setIdFactureFournisseur(idFact);
        crt.setNomTable("FACTURECLIENTPROF");
        bc = (FactureFournisseur[]) CGenUtil.rechercher(crt, null, null, "");
        Visa vu = new Visa();
        vu.setNomTable("VISAFACTURECLIENTPROFORMA");
        v = (Visa[]) CGenUtil.rechercher(vu, null, null, " and idobjet='" + idFact + "'");
        if (bc.length == 0) {
            out.print("Le bon de comande n extiste pas");
            return;
        }//(String nomTable, String id, String idMere, String designation, String qte1, String qte2, String puHT1, String puHT2, String rem)

    } catch (Exception e) {
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>");</script>
<%
    }
//out.println(datyinf + datySup + client + idEtat + idCatServ + idSsCatServ + numFact);
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">


<h1>Visualiser <%=nature%> num <%=bc[0].getIdFactureFournisseur()%></h1>
<h2>&nbsp;</h2>

<h2>&nbsp;</h2>

<form action="<%=lien%>?but=<%=apres%>" method="post" name="recette" id="recette" target="_parent" onsubmit="return (verifie(daty.value) && verifie(designation.value) && verifie(montant.value))">

    <table width="600" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td> <table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
                    <tr>
                        <td width="35%" class="left">Num Facture Client Proforma: </td>
                        <td width="65%" align="center"><%=bc[0].getIdFactureFournisseur()%>    </td>
                    </tr>

                    <tr>
                        <td class="left">Date : <span class="remarque">*</span></td>
                        <td align="center"> <%=bc[0].getDaty()%>   </td>
                    </tr>
                    <tr>
                        <td class="left">Date emission : <span class="remarque">*</span></td>
                        <td align="center"><%=bc[0].getDateEmission()%></td>
                    </tr>
                    <tr>
                        <td class="left">Designation : <span class="remarque">*</span></td>
                        <td align="center"> <%=bc[0].getDesignation()%> </td>
                    </tr>
                    <tr>
                        <td class="left">Fournisseur: <span class="remarque">*</span></td>
                        <td align="center">            <%=bc[0].getIdFournisseur()%> </td>
                    </tr>
                    <tr>
                        <td class="left">Montant TTC : </td>
                        <td align="center"><%=Utilitaire.formaterAr(bc[0].getMontantTTC())%></td>
                    </tr>
                    <tr>
                        <td class="left">Montant tva : <span class="remarque">*</span></td>
                        <td align="center">
                            <%=Utilitaire.formaterAr(bc[0].calculMontantTva())%></td>
                    </tr>
                    <tr>
                        <td class="left">Devise : <span class="remarque">*</span></td>
                        <td align="center"><%=bc[0].getIdDevise()%></td>
                    </tr>
                    <tr>
                        <td class="left">Remarque : </td>
                        <td align="center"><%=bc[0].getRemarque()%></td>
                    </tr>




                </table></td>
        </tr>
        <tr>
            <td height="30" align="center">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td align="center"><input name="typeObjet" type="hidden" id="nature" value="<%=nature%>">
                            <input name="numObjet" type="hidden" id="numObjet" value="<%=bc[0].getIdFactureFournisseur()%>">
                            <input name="montantObjet" type="hidden" id="montantObjet" value="<%=bc[0].getMontantTTC()%>">
                            <input type="hidden" name="acte" value="viser" />
                            &nbsp;
                            <!--<input type="submit" name="Submit" value="Modifier" class="submit"
                            onClick="acte.value='modifier'">
                           &nbsp;--><%if (v.length == 0) {
                                   if (u.getUser().getLoginuser().compareToIgnoreCase("tahina") == 0 || u.getUser().getLoginuser().compareToIgnoreCase("lalanirina") == 0 || u.getUser().getLoginuser().compareToIgnoreCase("schall") == 0 || u.getUser().getLoginuser().compareToIgnoreCase("liliane") == 0 || u.getUser().getLoginuser().compareToIgnoreCase("fano") == 0 || u.getUser().getLoginuser().compareToIgnoreCase("jaona") == 0) {
                            %><input type="button" name="Submit" value="Viser" class="submit"
                                   onClick="parent.location = '<%=lien%>?but=facturefournisseur/viserFactureClientProforma.jsp&numObjet=<%=idFact%>'">
                            <% } %>
                            <%}
    if ((bc[0].estAnnulableClient() == true) && (u.getUser().getIdrole().compareTo("dg") == 0)) {%>
                            <input type="submit" name="Submit" value="annuler" class="submit" onClick="acte.value = 'annuler'">&nbsp;<%}%>
                        </td>

                    </tr>
                </table>
                <% if (bc[0].getRemarque().compareTo("orAuto") != 0) {%>
                <h2><a href="<%=lien%>?but=facture/detailFactureProforma.jsp&idFactureMere=<%=bc[0].getNumFact()%>">Details de la Facture PROFORMA</a> </h2>
                <%}%>
            </td>
        </tr>
    </table>

</form>


<div align="center">

    <span class="remarque">(*) Champs obligatoires</span></div>