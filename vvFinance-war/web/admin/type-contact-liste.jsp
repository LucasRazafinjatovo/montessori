<%@page import="affichage.PageRecherche"%>
<%@page import="bean.TypeObjet"%>
<%
    TypeObjet typecontact = new TypeObjet();
    typecontact.setNomTable("TYPECONTACT");
    String[] listeCrt =  {"val"};
    String[] listeInt = {};
    String[] libEntete = {"id", "val", "desce"};
    PageRecherche pr = new PageRecherche(typecontact, request, listeCrt, listeInt, 2, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.getFormu().getChamp("val").setLibelle("Type contact");
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("admin/type-contact-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<h1>Liste Types Contacts</h1>
<form action="<%=pr.getLien()%>?but=admin/type-contact-liste.jsp" method="post" name="liste" id="liste">
    <%out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
    String lienTableau[] = {pr.getLien() + "?but=admin/type-contact-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    out.println(pr.getTableauRecap().getHtml());
%>
<br>
<%
    String[] libelleAffichage = {"Id", "Type contact", "Description"};
    pr.getTableau().setLibelleAffiche(libelleAffichage);
    out.println(pr.getTableau().getHtml());
    out.println(pr.getBasPage());
%>