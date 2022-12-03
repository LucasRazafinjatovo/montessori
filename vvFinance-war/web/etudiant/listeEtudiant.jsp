<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="etudiant.*" %>
<%@ page import="promotion.*" %>
<%

    //EtudiantPromo e = new EtudiantPromo();
    
    EtudiantAnneeScolaire e = new EtudiantAnneeScolaire();
    String listeCrt[] = {"id", "nom", "prenom", "ecole","idniveau","idanneescolaire"};
    String listeInt[] = {""};
    String libEntete[] = {"id", "nom", "prenom", "ecole","niveau","anneescolaire"};

    PageRecherche pr = new PageRecherche(e, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("etudiant/listeEtudiant.jsp");
//liste deroulante
    affichage.Champ[] liste = new affichage.Champ[3];

    Ecole ecole=new Ecole();
    ecole.setNomTable("ecole");
    liste[0] = new Liste("ecole", ecole, "nom", "nom");
    Niveau niveau = new Niveau();
    liste[1] = new Liste("idniveau", niveau, "nom", "id");
    AnneeScolaire anneeScolaire=new AnneeScolaire();
     liste[2] = new Liste("idanneescolaire", anneeScolaire, "nom", "id");
    pr.getFormu().changerEnChamp(liste);
    pr.getFormu().getChamp("idniveau").setLibelle("Niveau");
    pr.getFormu().getChamp("idanneescolaire").setLibelle("Anneescolaire");
    pr.getFormu().getChamp("ecole").setLibelle("Ecole");
    pr.getFormu().getChamp("id").setLibelle("ID");
    pr.getFormu().getChamp("nom").setLibelle("Nom");
    pr.getFormu().getChamp("prenom").setLibelle("Pr&eacute;noms");
    
    //pr.getFormu().getChamp("chemin").setVisible(false);
    //pr.getFormu().getChamp("promotion").setVisible(false);
    //pr.getFormu().getChamp("numero").setVisible(false);

    pr.getFormu().changerEnChamp(liste);

    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.listeetudiant.submit();
    }

</script>
<h1>Liste des &eacute;tudiants</h1>
<form action="<%=pr.getLien()%>?but=etudiant/listeEtudiant.jsp" method="post" name="listeetudiant" id="listeetudiant">
    <%
        out.println(pr.getFormu().getHtmlEnsemble());
    %>

</form>
<%
    String lienTableau[] = {pr.getLien() + "?but=etudiant/ficheEtudiant.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);

    out.println(pr.getTableauRecap().getHtml());
%>
<br>
<%
    out.println(pr.getTableau().getHtml());
    out.println(pr.getBasPage());
%>
