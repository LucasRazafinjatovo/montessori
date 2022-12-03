<%-- 
    Document   : pubradio-liste
    Created on : 9 mai 2017, 16:32:36
    Author     : Doudou Tiarilala
--%>

<%@page import="utilitaire.Utilitaire"%>
<%@page import="pub.PubTopRadio"%>
<%@page import="pub.PubType"%>
<%@page import="affichage.PageRecherche"%>
<script language="JavaScript">
    $(document).ready(function () {
        $('#cocheTout').click(function () {

            var cases = $("#divchck").find(':checkbox');
            if (this.checked) {
                cases.attr('checked', true);
                $('#cocheText').html('Tout decocher');
            } else {
                cases.attr('checked', false);
                $('#cocheText').html('Tout cocher');
            }

        });

    });
</script>
<%  PubTopRadio lv = new PubTopRadio();
    lv.setNomTable("pub_topradio_nonor");

    String listeCrt[] = {"id", "client", "reference", "responsable", "nature", "duree", "pubtype", "heure"};
    String listeInt[] = null;
    String libEntete[] = {"id", "client", "quantite", "datedebut", "datefin", "responsable", "nature", "duree", "pubtype", "heure"};
    PageRecherche pr = new PageRecherche(lv, request, listeCrt, listeInt, 3, libEntete, 10);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));

    pr.getFormu().getChamp("client").setLibelle("Client");
    pr.getFormu().getChamp("reference").setLibelle("Reference PUB");
    pr.getFormu().getChamp("pubtype").setLibelle("Plage horaire");

    pr.setApres("pub/pubradio-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);%>


<h1>Liste pub Radio</h1>


<form action="<%=pr.getLien()%>?but=pub/pubradio-liste.jsp" method="post" name="incident" id="incident">
    <%

        out.println(pr.getFormu().getHtmlEnsemble());
    %>
</form>
<%  String lienTableau[] = {pr.getLien() + "?but=pub/pubradio-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    out.println(pr.getTableauRecap().getHtml());
%>
<br>
<form method="post" name="e" action="<%=pr.getLien()%>?but=pub/facturePubRadioInit.jsp">
    <div id="divchck">
        <%
            String libEnteteAffiche[] = {"ID", "Client", "Qte/jrs", "Date debut", "Date fin", "Responsable", "Type", "Duree", "Plage", "Heure"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtmlWithCheckbox());
        %>
        <div>
            <input name="nombrechoix" id="nombrechoix" class="submit" type="hidden" value="0">
            <input name="nomjournal" id="nomjournal" class="submit" type="hidden" value="0">
        </div>
        <div align="center">
            <input type="submit" value="Valider">
            <input type="hidden" name="acte" value="facturer">
            <input type="hidden" name="bute" value="pub/pubradio-or-liste.jsp">
        </div>
    </div>
    <%
        out.println(pr.getBasPage());
    %>
</form>