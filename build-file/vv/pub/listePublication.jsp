s<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="pub.*" %>

<%
    Publication p = new Publication();
    p.setNomTable("PublicationLibelle");
    String listeCrt[] = {"id", "journal", "numParution", "remarque", "datyParution", "jour", "heure"};
    String listeInt[] = {"datyParution"};
    PageRecherche pr = new PageRecherche(p, request, listeCrt, listeInt, 2);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("pub/listePublication.jsp");
    affichage.Champ[] liste = new affichage.Champ[2];
    TypeObjet to = new TypeObjet();
    to.setNomTable("journal");
    liste[0] = new Liste("journal", to);
    ((Liste) (liste[0])).setColValeur("val");
    TypeObjet j = new TypeObjet();
    j.setNomTable("jour");
    liste[1] = new Liste("jour", j, "val", "val");
    pr.getFormu().changerEnChamp(liste);
    String libEntete[] = {"id", "journal", "numParution", "datyParution", "nbexth", "nbpage", "remarque", "jour", "heure", "nbexhuit"};
    String colSomme[] = {"nbexth", "nbexhuit"};
    pr.creerObjetPage(libEntete, colSomme);%>
<h1>Liste des pubications</h1>
<form action="<%=pr.getLien()%>?but=pub/listePublication.jsp" method="post" name="listePub" id="listePub">
    <%
    out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
    String lienTableau[] = {pr.getLien() + "?but=pub/fichePublication.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
    out.println(pr.getTableau().getHtml());
    out.println(pr.getBasPage());
%>
