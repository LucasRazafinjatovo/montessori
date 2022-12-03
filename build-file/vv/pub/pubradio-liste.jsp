<%-- 
    Document   : pubradio-liste
    Created on : 9 mai 2017, 16:32:36
    Author     : Doudou Tiarilala
--%>

<%@page import="utilitaire.Utilitaire"%>
<%@page import="pub.PubTopRadio"%>
<%@page import="pub.PubType"%>
<%@page import="affichage.PageRecherche"%>
<%  PubTopRadio lv = new PubTopRadio();
    lv.setNomTable("pub_topradio_libelle");

    String listeCrt[] = {"id", "client", "nomcampagne", "reference", "responsable", "nature", "duree", "pubtype", "heure"};
    String listeInt[] = null;
    String libEntete[] = {"id", "client", "nomcampagne", "reference", "datedebut", "datefin", "responsable", "nature", "duree", "pubtype", "heure"};
    PageRecherche pr = new PageRecherche(lv, request, listeCrt, listeInt, 3, libEntete, 11);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));

    pr.getFormu().getChamp("client").setLibelle("Client");
    pr.getFormu().getChamp("nomcampagne").setLibelle("Campagne");
    /*pr.getFormu().getChamp("datedebut1").setLibelle("Date debut diffusion min");
    pr.getFormu().getChamp("datedebut2").setLibelle("Date debut diffusion max");
    pr.getFormu().getChamp("datefin1").setLibelle("Date fin diffusion min");
    pr.getFormu().getChamp("datefin2").setLibelle("Date fin diffusion max");*/
    pr.getFormu().getChamp("reference").setLibelle("Reference PUB");
    pr.getFormu().getChamp("pubtype").setLibelle("Plage horaire");

    String awhere = ""; 
    if (request.getParameter("daty") != null) {
        String a = request.getParameter("daty");
        awhere = " and datedebut<='" + Utilitaire.convertDatyFormtoRealDatyFormat(a) + "' and datefin>='" + Utilitaire.convertDatyFormtoRealDatyFormat(a) + "'";
        pr.setAWhere(awhere);
    }

    pr.setApres("pub/pubradio-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);%>


<h1>Liste pub Radio</h1>


<form action="<%=pr.getLien()%>?but=pub/pubradio-liste.jsp" method="post" name="incident" id="incident">
    <%

        out.println(pr.getFormu().getHtmlEnsemble());
    %>
    <input type="date" name="daty" id="daty">
</form>
<%  String lienTableau[] = {pr.getLien() + "?but=pub/pubradio-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
    String libEnteteAffiche[] = {"ID", "Client", "Campagne", "Reference", "Date debut", "Date fin", "Responsable", "Type", "Duree", "Plage", "Heure"};
    pr.getTableau().setLibelleAffiche(libEnteteAffiche);
    out.println(pr.getTableau().getHtml());
    out.println(pr.getBasPage());

%>
