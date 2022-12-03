<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="etudiant.*" %>
<%@ page import="promotion.*" %>
<%


    FactureMereFille facture = new FactureMereFille();
    String listeCrt[] = {"moisint", "annee","idetudiant","idecole"};
    String listeInt[] = {"moisint"};
    String libEntete[] = {"idfacturefille","designation", "montant", "mois","annee","idetudiant","ecole"};

    PageRecherche pr = new PageRecherche(facture, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("etudiant/liste-facture.jsp");
   
    affichage.Champ[] liste=new affichage.Champ[3];
   String mois1[]  = {"January","February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
    String moisvalue1[]  = {"1","2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"};
    liste[0] = new Liste("moisint1", mois1, moisvalue1);

     String mois2[]  = {"January","February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
    String moisvalue2[]  = {"1","2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"};
    liste[1] = new Liste("moisint2", mois2, moisvalue2);
    Ecole ecole=new Ecole();
    ecole.setNomTable("ecole");
    liste[2] = new Liste("idecole", ecole, "nom", "id");
    
    pr.getFormu().changerEnChamp(liste);
    pr.getFormu().getChamp("idetudiant").setLibelle("Etudiant"); 
    pr.getFormu().getChamp("idEcole").setLibelle("Ecole"); 
    pr.getFormu().getChamp("annee").setLibelle("Annee");
    pr.getFormu().getChamp("moisint1").setLibelle("Mois (min)");
    pr.getFormu().getChamp("moisint2").setLibelle("Mois (max)");

    pr.getFormu().changerEnChamp(liste);

    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.listefacture.submit();
    }

</script>
<h1>Liste Factures</h1>
<form action="<%=pr.getLien()%>?but=etudiant/liste-facture.jsp" method="post" name="listefacture" id="listefacture">
    <%
        out.println(pr.getFormu().getHtmlEnsemble());
    %>

</form>
<%
    String lienTableau[] = {pr.getLien() + "?but=etudiant/paiementFacture.jsp"};
    String colonneLien[] = {"idfacturefille"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    String libEnteteAffiche[] = {"Facture","Designation", "Montant", "Mois","Annee","Etudiant","Ecole"};;
    pr.getTableau().setLibelleAffiche(libEnteteAffiche);


%>
<br>
<%
  
    out.println(pr.getTableau().getHtml());
    out.println(pr.getBasPage());
%>
