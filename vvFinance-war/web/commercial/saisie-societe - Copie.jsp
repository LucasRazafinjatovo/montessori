
<%@page import="commercial.SocieteCommercialLibelle"%>
<%@page import="user.*"%>
<%@page import="bean.TypeObjet" %>
<%@page import="affichage.*" %>
<%@page import="utilitaire.*" %>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    SocieteCommercialLibelle  a = new SocieteCommercialLibelle();
    PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));    
    
	affichage.Champ[] liste = new affichage.Champ[3];
    
    TypeObjet op = new TypeObjet();
    op.setNomTable("CATEGORIESOCIETE");
    liste[0] = new Liste("categorie", op, "VAL", "id");
    
    TypeObjet op1 = new TypeObjet();
    op1.setNomTable("AGENCE");
    liste[1] = new Liste("commercial", op1, "VAL", "id");
    
	TypeObjet op2 = new TypeObjet();
    op2.setNomTable("ETATSOCIETECOMMERCIAL");
    liste[2] = new Liste("etat", op2, "VAL", "id");
	
    pi.getFormu().changerEnChamp(liste);
	
	pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("nom").setLibelle("Nom");
    pi.getFormu().getChamp("produits").setLibelle("Produits");
    pi.getFormu().getChamp("categorie").setLibelle("Categorie");
    pi.getFormu().getChamp("adresse").setLibelle("Adresse");
    pi.getFormu().getChamp("telephone").setLibelle("T�l�phone");
    pi.getFormu().getChamp("mail").setLibelle("Mail");
    pi.getFormu().getChamp("etat").setLibelle("Situation");
    pi.getFormu().getChamp("site").setLibelle("Site web");
    pi.getFormu().getChamp("reseausociaux").setLibelle("R�seau sociaux");
    pi.getFormu().getChamp("persresponsable").setLibelle("Personne responsable");
    pi.getFormu().getChamp("contactpers").setLibelle("Contact");
    pi.getFormu().getChamp("commercial").setLibelle("Commercial");
    pi.getFormu().getChamp("observation").setLibelle("Observation");
    pi.getFormu().getChamp("observation").setType("textarea");
    
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Saisie nouveau soci�t�</h1>
    <!--  -->
    <form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="societe" id="societe">
    <%
        pi.getFormu().makeHtmlInsertTabIndex();
        out.println(pi.getFormu().getHtmlInsert());
    %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="commercial/saisie-societe.jsp">
    <input name="classe" type="hidden" id="classe" value="commercial.SocieteCommercialLibelle">
    </form>
</div>