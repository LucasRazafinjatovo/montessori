<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>
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
    InvenduLibelleType rv = new InvenduLibelleType();
    String etat = "INVENDULIBNONFACTURE";
    if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("") != 0) {
        etat = request.getParameter("etat");
    }
    System.out.println("etat = " + etat);
    rv.setNomTable(etat);
    String listeCrt[] = {"id", "nom", "matricule", "place", "province", "parution", "daty", "journal", "type"};
    String listeInt[] = {"daty", "parution"};
    String libEntete[] = {"id", "nom", "matricule", "journal", "parution", "daty", "province", "nombreinvendu", "type"};
    PageRecherche pr = new PageRecherche(rv, request, listeCrt, listeInt, 2);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("ventegazety/listeInvendu.jsp");
    affichage.Champ[] liste = new affichage.Champ[3];
    Vendeur ve = new Vendeur();
    liste[0] = new Liste("nom", ve, "surnom", "surnom");
    Journal jou = new Journal();
    liste[1] = new Liste("journal", jou, "desce", "val");

    Typevendeur tv = new Typevendeur();
    tv.setNomTable("typevendeur");
    liste[2] = new Liste("type", tv, "val", "val", true);

    pr.getFormu().changerEnChamp(liste);
    String colSomme[] = {"nombreinvendu"};
    pr.setNpp(300);
    pr.creerObjetPageMultiple(libEntete, colSomme);

%>
<h1>Liste des saisies invendus</h1>
<form action="<%=pr.getLien()%>?but=ventegazety/listeInvendu.jsp" method="post" name="rechercheVente" id="rechercheVente">
    <%
        out.println(pr.getFormu().getHtmlEnsemble());%>
    etat : <select name="etat" class="champ" id="etat" >
        <option value="INVENDULIBNONFACTURE"  <%if (etat.compareTo("INVENDULIBNONFACTURE") == 0) {
                out.println("selected");
            }%>>non facture</option>
        <option value="INVENDULIBFACTURE"  <%if (etat.compareTo("INVENDULIBFACTURE") == 0) {
                out.println("selected");
            }%>> facture</option>
        <option value="INVENDULIBTYPE">Tous</option>
    </select>
</form>
<br>
<br/>
<%
    out.println(pr.getTableauRecap().getHtml());
%>
<br/>
<br/>
<form method="post" name="e" action="<%=pr.getLien()%>?but=facture/factureInit.jsp">


    <div id="divchck">
        <%
            out.println(pr.getTableau().getHtmlWithCheckbox());
        %>
    </div>
    <div><input name="nombrechoix" id="nombrechoix" class="submit" type="hidden" value="0">
        <input name="nomjournal" id="nomjournal" class="submit" type="hidden" value="0"></div>
        <%if (etat.trim().compareTo("INVENDULIBNONFACTURE") == 0) {%>
    <div align="center">
        <input type="hidden" name="acte" value="invendu">
        <input type="submit" value="Valider">
        <input type="hidden" name="bute" value="ventegazety/listeInvendu.jsp">
    </div>
    <%}%>
</form>
<%
    out.println(pr.getBasPage());
%>
