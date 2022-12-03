<%-- 
    Document   : pubTopRadioFille-saisie
    Created on : 17 mai 2017, 16:23:30
    Author     : Safidimahefa
--%>
<%@page import="pub.PubConstante"%>
<%@page import="pub.PubType"%>
<%@page import="pub.PubPlageHoraire"%>
<%@page import="pub.PubRadioFille"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.Direction" %>
<%@ page import="affichage.*" %>
<%@ page import="actualite.*" %>
<%
    String mere = request.getParameter("id");

    PubRadioFille pj = new PubRadioFille();
    PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    affichage.Champ[] liste = new affichage.Champ[3];
    TypeObjet r = new TypeObjet();
    r.setNomTable("PUB_TOP_RADIO_DUREE");
    PubPlageHoraire r1 = new PubPlageHoraire();
    PubType to1 = new PubType();

//PubPlageHoraire to2=new PubPlageHoraire();
//PubType to1 = new PubType();
    liste[0] = new Liste("nature", to1, "designation", "id");
    liste[1] = new Liste("duree", r, "val", "val");
    liste[2] = new Liste("pubtype", r1, "designation", "id");

    pi.getFormu().getChamp("nomcampagne").setLibelle("Nom Campagne");
    pi.getFormu().getChamp("mere").setLibelle("Mère");
    if (session.getAttribute("idpubmere") != null && !session.getAttribute("idpubmere").toString().isEmpty()) {
        pi.getFormu().getChamp("mere").setDefaut(session.getAttribute("idpubmere").toString());
        session.removeAttribute("idpubmere");
    } else if (mere != null && !mere.isEmpty()) {
        pi.getFormu().getChamp("mere").setDefaut(mere);
        session.setAttribute("idpubmere", mere);
    }

    pi.getFormu().getChamp("quantite").setLibelle("Quantité");
    pi.getFormu().getChamp("quantite").setDefaut("3");

    pi.getFormu().getChamp("datedebut").setLibelle("Date Début");
    pi.getFormu().getChamp("datefin").setLibelle("Date Fin");
    pi.getFormu().getChamp("heure").setLibelle("Heure");

    pi.getFormu().getChamp("etat").setVisible(false);

    pi.getFormu().getChamp("mere").setPageAppel("pub/pubRadioMereChoix.jsp");
    pi.getFormu().getChamp("heure").setPageAppel("pub/heureChoixMultiple.jsp");
    pi.getFormu().getChamp("heure").setDefaut("6h30;12h30;19h00");

    pi.getFormu().changerEnChamp(liste);
    pi.getFormu().getChamp("pubtype").setLibelle("Type");
    pi.getFormu().getChamp("duree").setLibelle("Durée");
    pi.getFormu().getChamp("nature").setLibelle("Nature");
    pi.getFormu().getChamp("pubtype").setAutre("onchange='changerQuantite(this)'");

    pi.preparerDataFormu();
%>

<h1>Saisir Pub Top Radio  Fille</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="actualite" id="actualite">
    <%
        pi.getFormu().makeHtmlInsertTabIndex();
        out.println(pi.getFormu().getHtmlInsert());
    %>
    <input name="acte" type="hidden" value="insert">
    <input name="valeurnature" id="valeurnature" type="hidden"  value="">

    <input name="bute" type="hidden" id="bute" value="pub/pubTopRadioFille-saisie.jsp">
    <input name="classe" type="hidden" id="classe" value="pub.PubRadioFille">
    <!--<input name="rajoutLien" type="hidden" id="classe" value="publicat-daty">-->
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
        } else if(obj.value === '<%= PubConstante.ID_6_DIFFUSION%>'){
            document.getElementById('quantite').value = '3';
            document.getElementById('heure').value = '6h30;12h30;19h00';
            document.getElementById('quantite').setAttribute('readonly', 'readonly');
        }else {
            document.getElementById('quantite').removeAttribute('readonly');
            document.getElementById('quantite').value = '';

        }
        document.getElementById('valeurnature').value = obj.value;
    }

</script>
