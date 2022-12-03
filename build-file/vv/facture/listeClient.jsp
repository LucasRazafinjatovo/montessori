<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="facture.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
    Client c;
%>
<%
    c = new Client();
    c.setNomTable("CLIENT_CONTACT");
    String listeCrt[] = {"nom", "adresse", "telephone", "type_contact", "soustype_contact"};
    String listeInt[] = {};
    String libEntete[] = {"idClient", "nom", "adresse", "telephone", "type_contact", "soustype_contact"};
    PageRecherche pr = new PageRecherche(c, request, listeCrt, listeInt, 2, libEntete, 6);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    affichage.Champ[] liste = new affichage.Champ[2];
    TypeObjet to1 = new TypeObjet();
    to1.setNomTable("typecontact");
    liste[0] = new Liste("type_contact", to1, "val", "val");
    TypeObjet to2 = new TypeObjet();
    to2.setNomTable("soustypecontact");
    liste[1] = new Liste("soustype_contact", to2, "val", "val");
    pr.getFormu().changerEnChamp(liste);
    pr.getFormu().getChamp("nom").setLibelle("Nom");
    pr.getFormu().getChamp("adresse").setLibelle("Adresse");
    pr.getFormu().getChamp("telephone").setLibelle("Telephone");
    pr.getFormu().getChamp("type_contact").setLibelle("Type contact");
    pr.getFormu().getChamp("soustype_contact").setLibelle("Sous-Type contact");
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("facture/listeClient.jsp");
    String colSomme[] = null;
    pr.setNpp(100);
    pr.creerObjetPage(libEntete, colSomme);

%>
<h1>Liste des clients enregistr&eacute;s</h1>
<form action="<%=pr.getLien()%>?but=facture/listeClient.jsp" method="post" name="liste" id="liste">
    <%
            out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
    String lienTableau[] = {pr.getLien() + "?but=facture/detailClient.jsp"};
    String colonneLien[] = {"idClient"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
    String[] libelleAffichage = {"Id", "Nom", "Adresse", "Telephone", "Type contact", "Sous-type contact"};
    pr.getTableau().setLibelleAffiche(libelleAffichage);
    out.println(pr.getTableau().getHtml());
    out.println(pr.getBasPage());
%>