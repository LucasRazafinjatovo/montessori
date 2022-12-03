<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="etudiant.*" %>
<%@ page import="promotion.*" %>
<%@ page import="finance.*" %>
<%


    EtatPaiement etatPaiement = new EtatPaiement();
    String listeCrt[] = {"id","idetudiant","moisint","annee","idecole"};
    String listeInt[] = {"moisint","annee"};
    String libEntete[] ={"id","idetudiant","designation", "mois","annee","montantapayer","montantdejapayer","resteapayer","ecole"};

    PageRecherche pr = new PageRecherche(etatPaiement, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("etudiant/etat-analyse-paiement.jsp");

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
    pr.getFormu().getChamp("annee1").setLibelle("Ann&eacute;e (min)");
    pr.getFormu().getChamp("annee2").setLibelle("Ann&eacute;e (max)");
    pr.getFormu().getChamp("moisint1").setLibelle("Mois (min)");
    pr.getFormu().getChamp("moisint2").setLibelle("Mois (max)");
    pr.getFormu().getChamp("id").setLibelle("Num facture");
    pr.getFormu().changerEnChamp(liste);

    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.etatpaiement.submit();
    }

</script>
<h1>Etat et analyse de paiement</h1>
<form action="<%=pr.getLien()%>?but=etudiant/etat-analyse-paiement.jsp" method="post" name="etatpaiement" id="etatpaiement">
    <%
        out.println(pr.getFormu().getHtmlEnsemble());
    %>

</form>
<%
    
    String lienTableau[] = {pr.getLien() + "?but=etudiant/etat-analyse-paiement-fiche.jsp"};
    String colonneLien[] = {"id"};
    String libEnteteAffiche[] = {"Num Facture","Etudiant","Designation", "Mois","Ann&eacute;e","Montant à payer","Montant d&eacute;ja payer","Reste à payer","Ecole"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    pr.getTableau().setLibelleAffiche(libEnteteAffiche);
     out.println(pr.getTableau().getHtml());
%>
<%
    out.println(pr.getBasPage());
%>
