<%@page import="user.*"%>
<%@page import="bean.*"%>
<%@page import="utilitaire.*"%>
<%@page import="affichage.*"%>
<%@page import="commercial.SocieteCommercialLibelle"%>
<link href="style/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
    function getChoix() {
        setTimeout("document.frmchx.submit()", 800);
    }
</script>
<%
    String champReturn = request.getParameter("champReturn");
    SocieteCommercialLibelle e = new SocieteCommercialLibelle();
    //e.setNomTable("ARTICLE_VUE");

    String listeCrt[] = {"nom", "daterdv", "etat", "commercial"};
    String listeInt[] = {"daterdv"};
    String libEntete[] = {"id", "daty", "nom", "persresponsable", "contactpers", "categorie", "adresse", "telephone", "mail", "etat", "daterdv", "commercial"};
    PageRecherche pr = new PageRecherche(e, request, listeCrt, listeInt, 3, libEntete, 12);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("commercial/historique-societe.jsp");

    affichage.Champ[] liste = new affichage.Champ[2];

    if (pr.getUtilisateur().getUser().getTeluser().compareToIgnoreCase("-") != 0 && pr.getUtilisateur().getUser().getTeluser() != null) {
        pr.setAWhere(" and idcomm like '%" + pr.getUtilisateur().getUser().getTeluser() + "%'");
    }

    TypeObjet op2 = new TypeObjet();
    op2.setNomTable("ETATSOCIETECOMMERCIAL");
    liste[0] = new Liste("etat", op2, "VAL", "VAL", true);

    TypeObjet ag = new TypeObjet();
    ag.setNomTable("AGENCE");
    liste[1] = new Liste("commercial", ag, "VAL", "VAL");

    pr.getFormu().changerEnChamp(liste);

    //pr.getFormu().getChamp("id").setLibelleAffiche("ID");
    pr.getFormu().getChamp("nom").setLibelleAffiche("Nom");
    pr.getFormu().getChamp("commercial").setLibelleAffiche("Commercial");
    pr.getFormu().getChamp("etat").setLibelleAffiche("Etat");
    pr.getFormu().getChamp("daterdv1").setLibelleAffiche("Date rdv 1");
    pr.getFormu().getChamp("daterdv2").setLibelleAffiche("Date rdv 2");

    String[] colSomme = null;
    pr.creerObjetPageMultiple(libEntete, colSomme);
%>
<h1>Liste societe</h1>
<form action="<%=pr.getLien()%>?but=commercial/historique-societe.jsp" method="post" name="personneliste" id="personneliste">
    <% out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
    String lienTableau[] = {pr.getLien() + "?but=commercial/fiche-societe.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    String libelles[] = {"ID", "Date", "Nom soci&eacute;t&eacute;", "Responsable", "Contact", "Categorie", "Adresse", "Telephone", "Mail", "Situation", "Rendez-vous", "Commercial"};
    pr.getTableau().setLibelleAffiche(libelles);
    out.println(pr.getTableauRecap().getHtml());
%>

<% out.println(pr.getTableau().getHtml()); %>
<% out.println(pr.getBasPage());%>
