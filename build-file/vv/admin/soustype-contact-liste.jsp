<%@page import="affichage.Liste"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="bean.TypeObjet"%>
<%
    TypeObjet typecontact = new TypeObjet();
    typecontact.setNomTable("SOUSTYPECONTACTLIBELLE");
    String[] listeCrt =  {"val","desce"};
    String[] listeInt = {};
    String[] libEntete = {"id", "val", "desce"};
    PageRecherche pr = new PageRecherche(typecontact, request, listeCrt, listeInt, 2, libEntete, libEntete.length);
    affichage.Champ[] liste = new affichage.Champ[1];
    TypeObjet to1 = new TypeObjet();
    to1.setNomTable("TYPECONTACT");
    liste[0] = new Liste("desce", to1, "val", "val");
    pr.getFormu().changerEnChamp(liste);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.getFormu().getChamp("val").setLibelle("Sous-Type contact");
    pr.getFormu().getChamp("desce").setLibelle("Type contact");
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("admin/soustype-contact-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<h1>Liste Sous Types Contacts</h1>
<form action="<%=pr.getLien()%>?but=admin/soustype-contact-liste.jsp" method="post" name="liste" id="liste">
    <%out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
    String lienTableau[] = {pr.getLien() + "?but=admin/soustype-contact-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    out.println(pr.getTableauRecap().getHtml());
%>
<br>
<%
    String[] libelleAffichage = {"Id", "Sous-Type contact", "Type contact"};
    pr.getTableau().setLibelleAffiche(libelleAffichage);
    out.println(pr.getTableau().getHtml());
    out.println(pr.getBasPage());
%>