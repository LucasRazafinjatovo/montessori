<%@page import="pub.PubRadioPartenariat"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.Direction" %>
<%@ page import="affichage.*" %>
<%@ page import="actualite.*" %>
<%-- 
    Document   : pubRadioOr-liste
    Created on : 6 juil. 2017, 11:02:50
    Author     : Alain
--%>
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
<%
    try {
        PubRadioPartenariat p = new PubRadioPartenariat();
        p.setNomTable("pub_radio_partenariat_libor");
        String listeCrt[] = {"id", "client", "observation", "reference", "responsable", "nomcampagne", "nature", "duree", "pubtype", "heure"};
        String listeInt[] = null;
        PageRecherche pr = new PageRecherche(p, request, listeCrt, listeInt, 3);
        pr.setUtilisateur((user.UserEJB) request.getSession().getAttribute("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("pub/pubRadioOr-liste.jsp");

        String libEntete[] = {"id", "client", "observation", "datedebut", "datefin", "reference", "responsable", "nomcampagne", "nature", "duree", "pubtype", "heure"};
        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);
%>
<h1>Liste publicité</h1>
<form action="<%=pr.getLien()%>?but=pub/pubRadioOr-liste.jsp" method="post" name="listeplagehoraire" id="listeplagehoraire">
    <%
        out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
    String lienTableau[] = {pr.getLien() + "?but=pub/pubRadioPack-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    out.println(pr.getTableauRecap().getHtml());%>
<br>
<form method="post" name="e" action="<%=pr.getLien()%>?but=pub/facturePubRadioInit_1.jsp">
    <div id="divchck">
        <%
            out.println(pr.getTableau().getHtmlWithCheckbox());
        %>
        <div>
            <input name="nombrechoix" id="nombrechoix" class="submit" type="hidden" value="0">
            <input name="nomjournal" id="nomjournal" class="submit" type="hidden" value="0">
        </div>
        <div align="center">
            <input type="submit" value="Valider">
            <input type="hidden" name="acte" value="facturer">
            <input type="hidden" name="bute" value="pub/pubRadioOr-liste.jsp">
        </div>
    </div>
</form>
<%
    out.println(pr.getBasPage());
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript"> alert('<%=e.getMessage()%>');history.back();</script>
<%
        return;
    }
%>
