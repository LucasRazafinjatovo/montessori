<%-- 
    Document   : pubRadioPack-saisie
    Created on : 5 juil. 2017, 10:01:57
    Author     : Alain
--%>
<%@page import="pub.PubConstante"%>
<%@page import="pub.PubType"%>
<%@page import="pub.PubPlageHoraire"%>
<%@page import="pub.PubRadioPartenariat"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.Direction" %>
<%@ page import="affichage.*" %>
<%@ page import="actualite.*" %>
<%

    PubRadioPartenariat pj = new PubRadioPartenariat();
    PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));

    affichage.Champ[] liste = new affichage.Champ[4];
    TypeObjet r = new TypeObjet();
    r.setNomTable("PUB_TOP_RADIO_DUREE");
    PubPlageHoraire r1 = new PubPlageHoraire();
    PubType to1 = new PubType();
    TypeObjet rr = new TypeObjet();
    rr.setNomTable("agence");
    
    liste[3] = new Liste("responsable", rr, "val", "id");
    liste[0] = new Liste("nature", to1, "designation", "id");
    liste[1] = new Liste("duree", r, "val", "val");
    liste[2] = new Liste("pubtype", r1, "designation", "id");

    pi.getFormu().getChamp("nomcampagne").setLibelle("Nom Campagne");
    pi.getFormu().getChamp("datedebut").setLibelle("Date Début");
    pi.getFormu().getChamp("datefin").setLibelle("Date Fin");
    pi.getFormu().getChamp("heure").setLibelle("Heure");
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("heure").setPageAppel("pub/heureChoixMultiple.jsp");
    pi.getFormu().getChamp("heure").setDefaut("6h30;12h30;19h00");
    pi.getFormu().getChamp("daty").setLibelle("Date Saisie");
    pi.getFormu().getChamp("idtarif").setLibelle("Tarif");
    pi.getFormu().getChamp("idtarif").setAutre("readonly");
    pi.getFormu().getChamp("idtarif").setPageAppel("pub/tarifPartenaireChoix.jsp");
    pi.getFormu().getChamp("observation").setType("textarea");
    pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("datedebut").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("datefin").setDefaut(Utilitaire.dateDuJour());

    pi.getFormu().getChamp("client").setPageAppel("pub/clientChoix.jsp");

    pi.getFormu().changerEnChamp(liste);

    pi.getFormu().getChamp("pubtype").setLibelle("Type");
    pi.getFormu().getChamp("duree").setLibelle("Durée");
    pi.getFormu().getChamp("nature").setLibelle("Nature");
    pi.getFormu().getChamp("nombre_spot").setLibelle("Nb Spot");
	pi.getFormu().getChamp("nombre_spot").setDefaut("1");
    pi.getFormu().getChamp("pubtype").setAutre("onchange='changerQuantite(this)'");

    pi.preparerDataFormu();
%>

<h1>Saisir Pub Top Radio</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="actualite" id="actualite">
    <%
        pi.getFormu().makeHtmlInsertTabIndex();
        out.println(pi.getFormu().getHtmlInsert());
    %>
    <input name="acte" type="hidden" value="insert">
    <input name="valeurnature" id="valeurnature" type="hidden"  value="">

    <input name="bute" type="hidden" id="bute" value="pub/pubRadioPack-saisie.jsp">
    <input name="classe" type="hidden" id="classe" value="pub.PubRadioPartenariat">
</form>
<script>
    var e = document.getElementById('nature');
    var str = e.options[e.selectedIndex].value;
    document.getElementById('valeurnature').value = str;

    function changerQuantite(obj) {

        if (obj.value === '<%= PubConstante.ID_5_DIFFUSION%>') {
            document.getElementById('quantite').value = '14';
            document.getElementById('heure').value = '6h50;7h50;8h50;9h50;10h50;12h00;12h50;13h50;14h50;15h50;17h00;17h50;18h50;19h50';
            document.getElementById('quantite').setAttribute('readonly', 'readonly');
        } else if (obj.value === '<%= PubConstante.ID_6_DIFFUSION%>') {
            document.getElementById('quantite').value = '3';
            document.getElementById('heure').value = '6h30;12h30;19h00';
            document.getElementById('quantite').setAttribute('readonly', 'readonly');
        } else {
            document.getElementById('quantite').removeAttribute('readonly');
            document.getElementById('quantite').value = '';

        }
        document.getElementById('valeurnature').value = obj.value;
    }

</script>