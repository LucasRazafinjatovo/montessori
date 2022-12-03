<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="etudiant.*" %>
<%@ page import="promotion.*" %>
<%


    
    EtudiantAbondanonnee e = new EtudiantAbondanonnee();
    String listeCrt[] = {"id", "nom", "prenom","mois","annee"};
    String listeInt[] = {"mois"};
    String libEntete[] = {"id", "nom", "prenom", "motif","mois","annee"};

    PageRecherche pr = new PageRecherche(e, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("etudiant/listeEtudiantAbandonnes.jsp");

      affichage.Champ[] liste=new affichage.Champ[2];
     String mois1[]  = {"January","February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
    String moisvalue1[]  = {"1","2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"};
    liste[0] = new Liste("mois1", mois1, moisvalue1);

     String mois2[]  = {"January","February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
    String moisvalue2[]  = {"1","2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"};
    liste[1] = new Liste("mois2", mois2, moisvalue2);

    
    pr.getFormu().changerEnChamp(liste);
  
    pr.getFormu().getChamp("id").setLibelle("ID");
    pr.getFormu().getChamp("nom").setLibelle("Nom");
    
    pr.getFormu().getChamp("prenom").setLibelle("Pr&eacute;noms"); 
    pr.getFormu().getChamp("annee").setLibelle("Annee");
    pr.getFormu().getChamp("mois1").setLibelle("Mois (min)");
    pr.getFormu().getChamp("mois2").setLibelle("Mois (max)");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.listeetudiant.submit();
    }

</script>
<h1>Liste des &eacute;tudiants abandonn&eacute;s</h1>
<form action="<%=pr.getLien()%>?but=etudiant/listeEtudiantAbandonnes.jsp" method="post" name="listeetudiant" id="listeetudiant">
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
