<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="pub.*" %>
<link href="../style/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
    var $namesJournal = [];
    var nombrechoix = 0;
    function getChoixGazety(element) {

        $name = $(element).attr("name");
        if ($('input[name=' + $name + ']').is(':checked')) {
            //$nombrechoix = parseInt($('#nombrechoix').val())
            $nombrechoix = parseInt($('#nombrechoix').val()) + 1;
            $namesJournal.push(element.name);
        } else {
            $namesJournal = [];
            $('#mydiv input:checked').each(function () {
                $namesJournal.push(this.name);
            });
            $nombrechoix = $nombrechoix - 1;
            $('#nomjournal').val($namesJournal);
        }
        $('#nomjournal').val("");
        $('#nombrechoix').val($nombrechoix);
        $('#nomjournal').val($namesJournal);
    }
</script>
<%
    try {
        UserEJB u = (user.UserEJB) session.getValue("u");
        String lien = (String) session.getValue("lien");
        PubFactPaye p = new PubFactPaye();
        String etat = "pubfacttousf";
        if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("") != 0) {
            etat = request.getParameter("etat");
        }
        //System.out.print(etat);
        p.setNomTable(etat);
        //String listeCrt[] = {"idop","factclient","client","numcompte","annee"};
        String listeCrt[] = {"idop", "factclient", "client", "numcompte", "mois", "annee"};
        String listeInt[] = {"mois"};
        String libEntete[] = {"factclient", "numcompte", "client", "montant", "paye", "commission"};
        PageRecherche pr = new PageRecherche(p, request, listeCrt, listeInt, 2);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("pub/listeCommissionPub.jsp");

        pr.getFormu().getChamp("numcompte").setLibelle("Commercial");
        affichage.Champ[] liste = new affichage.Champ[1];
        TypeObjet to = new TypeObjet();
        to.setNomTable("commercialactif");
        liste[0] = new Liste("numcompte", to, "val", "val");
        pr.getFormu().changerEnChamp(liste);

        String colSomme[] = {"montant", "paye", "commission"};
        pr.creerObjetPage(libEntete, colSomme);
        PubFactPaye[] pf = (PubFactPaye[]) pr.getRs().getResultat();
        //pr.getTableau().setLibelleAffiche(libAffiche);
%>
<br/><br/>
<h2>
    <%
        if (u.getUser().getLoginuser().compareToIgnoreCase("tahina") == 0 || u.getUser().getLoginuser().compareToIgnoreCase("medicis") == 0 || u.getUser().getLoginuser().compareToIgnoreCase("tsilavina") == 0 || u.getUser().getLoginuser().compareToIgnoreCase("felana") == 0 || u.getUser().getLoginuser().compareToIgnoreCase("schall") == 0) {%>
    <a href="<%=lien%>?but=pub/listeCommissionPubDirection.jsp">Commission 1% (seulement direction)</a>
    <%}%></h2>
<h1>Liste commission commercial par pub</h1>
<form action="<%=lien%>?but=pub/listeCommissionPub.jsp"  method="post" name="listePub" id="listePub">
    <%
        out.println(pr.getFormu().getHtmlEnsemble());%>
    etat :


    <select name="etat" class="champ" id="etat" >
        <option value="pubfacttousf"  <%if (etat.compareTo("pubfacttousf") == 0) {
                out.println("selected");}%>>Comm pubF tous</option>
        <option value="pubfacttousfpaye"  <%if (etat.compareTo("pubfacttousfpaye") == 0) {
                out.println("selected");}%>>Comm pubF paye</option>
        <option value="pubfacttousfnonpaye"  <%if (etat.compareTo("pubfacttousfnonpaye") == 0) {
                out.println("selected");}%>>Comm pubF non paye</option>
        <option value="pubfacttousnf" <%if (etat.compareTo("pubfacttousnf") == 0) {
                out.println("selected");}%>>Comm pub OR</option>
    </select>

</form>
<%
    pr.setApresLienPage("&etat=" + etat);
    out.println(pr.getTableauRecap().getHtml());%>
<br>
<form method="post" name="e" action="modeleAdmin.jsp?but=pub/ordonnerPayementPub.jsp">
    <table class="monographe" width="100%" cellspacing="3" cellpadding="3" border="0" align="center" id="mydiv">
        <tr>
            <td bgcolor="#66ccff" align="center"><b>Fact client</b></td>
            <td bgcolor="#66ccff" align="center"><b>Commercial</b></td>
            <td bgcolor="#66ccff" align="center"><b>Client</b></td>
            <td bgcolor="#66ccff" align="center"><b>Montant</b></td>
            <td bgcolor="#66ccff" align="center"><b>Paye</b></td>
            <td bgcolor="#66ccff" align="center"><b>Commission</b></td>
            <td bgcolor="#66ccff" align="center"><b>Mois</b></td>
            <td bgcolor="#66ccff" align="center"><b>Annee</b></td>
            <%if (etat.compareTo("pubfactpaye") == 0 || etat.compareTo("pubfactnonpaye") == 0) {%>
            <td bgcolor="#66ccff" align="center"><b>idop</b></td>
            <%}%>
            <td bgcolor="#66ccff" align="center"></td>
        </tr>
        <%if (pf.length != 0) {%>
        <%for (int i = 0; i < pf.length; i++) {%>
        <tr>
            <td align="center"><a title="fact numero <%=pf[i].getFactclient()%>" href="<%=lien%>?but=facture/visualiserFactureClient.jsp&idFactureFournisseur=<%=pf[i].getFactclient()%>"><%=pf[i].getFactclient()%></a></td>
            <td align="center"><%=pf[i].getNumcompte()%></td>
            <td align="center"><%=pf[i].getClient()%></td>

            <td align="center"><%=Utilitaire.formaterAr(pf[i].getMontant())%></td>
            <td align="center"><%=Utilitaire.formaterAr(pf[i].getPaye())%></td>
            <td align="center"><%=Utilitaire.formaterAr(pf[i].getCommission())%></td>

            <td align="center"><%=Utilitaire.formaterAr(pf[i].getMois())%></td>
            <td align="center"><%=Utilitaire.formaterAr(pf[i].getAnnee())%></td>
            <%if (etat.compareTo("pubfactpaye") == 0 || etat.compareTo("pubfactnonpaye") == 0) {%>
            <td align="center"><a title="fact numero <%=pf[i].getIdop()%>" href="<%=lien%>?but=ded/visualiserOP.jsp&id=<%=pf[i].getIdop()%>"><%=pf[i].getIdop()%></a></td>
                <%}%>
                <%if (etat.compareTo("pubfacttousfnonpaye") == 0) {%>
            <td><input type="checkbox" onclick="getChoixGazety(this)" name="<%=pf[i].getFactclient()%>" value="<%=pf[i].getFactclient()%>"/></td>
                <%} else {%>
            <td></td>

            <% }
                }%>
        </tr>
    </table>
    <div>
        <input name="nombrechoix" id="nombrechoix" class="submit" type="hidden" value="0">
        <input name="nomjournal" id="nomjournal" class="submit" type="hidden" value="0"></div>
    <input name="numcompte" id="numcompte" class="submit" type="hidden" value="<%=pf[0].getNumcompte()%>"></div>
    <input name="lmoisd" id="lmoisd" class="submit" type="hidden" value="<%=request.getParameter("mois1")%>/<%=request.getParameter("annee")%>"></div>
    <input name="lmoisf" id="lmoisf" class="submit" type="hidden" value="<%=request.getParameter("mois2")%>/<%=request.getParameter("annee")%>"></div>
    <%if (etat.compareTo("pubfacttousfnonpaye") == 0) {%>
    <div align="center">
        <input type="submit" value="Valider">
        <input type="hidden" name="acte" value="insert">
        <input type="hidden" name="pourcentage" value="10">
        <input type="hidden" name="bute" value="pub/listeCommissionPub.jsp">
    </div><%}
        } %>
</form>
<%
        out.println(pr.getBasPage());
    }catch (Exception e) {
        e.printStackTrace();
    }
%>
