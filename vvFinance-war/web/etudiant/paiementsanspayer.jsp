<%@page import="finance.Caisse"%>
<%@page import="etudiant.PaiementDetail"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="recette.*" %>

<%
    String idetudiant = request.getParameter("idetudiant");
    PaiementDetail atcl = new PaiementDetail();
    PageInsert pi = new PageInsert(atcl, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));

    pi.getFormu().getChamp("echeance").setVisible(false);
    pi.getFormu().getChamp("date_fin").setVisible(false);
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("etudiant").setLibelle("Etudiant");
    if(request.getParameter("idetudiant") != null){
        pi.getFormu().getChamp("etudiant").setDefaut(idetudiant);
    }
    pi.getFormu().getChamp("montant_total").setLibelle("Montant Total");
    pi.getFormu().getChamp("ecolage").setLibelle("Montant &eacute;colage");
    pi.getFormu().getChamp("food").setLibelle("Montant Food");
    pi.getFormu().getChamp("transport").setLibelle("Montant Transport");
    pi.getFormu().getChamp("inscription").setLibelle("Montant Inscription");
    pi.getFormu().getChamp("autre").setLibelle("Montant Autres");
    pi.getFormu().getChamp("remarque").setLibelle("Remarques");
    pi.getFormu().getChamp("REMARQUE").setAutre("textarea");
    pi.getFormu().getChamp("etudiant").setPageAppel("etudiant/etudiant_tiers.jsp");
    pi.getFormu().getChamp("etudiant").setAutre("readonly='readonly'");
    pi.getFormu().getChamp("numero_cheque").setVisible(false);
    pi.getFormu().getChamp("etablissement").setVisible(false);
   
    affichage.Champ[] liste = new affichage.Champ[3];
    Caisse caisse = new Caisse();
    //caisse.setNomTable("caisse_sudaf");
    caisse.setNomTable("caisse");
    liste[0] = new Liste("caisse", caisse, "desccaisse", "idCaisse");
    
    TypeObjet modepaiement = new TypeObjet();
    modepaiement.setNomTable("modepaiementsanscheque");
    liste[1] = new Liste("modepaiement", modepaiement, "val", "id");
    
    TypeObjet devise = new TypeObjet();
    devise.setNomTable("devise");
    liste[2] = new Liste("devise", devise, "val", "id");
    
//    TypeObjet etablissement = new TypeObjet();
//    etablissement.setNomTable("etablissement");
//    liste[3] = new Liste("etablissement", etablissement, "val", "id");
    
    pi.getFormu().changerEnChamp(liste);

    pi.preparerDataFormu();
%>

<h1>Paiement</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="article" id="article">
    <%
        pi.getFormu().makeHtmlInsertTabIndex();
        out.println(pi.getFormu().getHtmlInsert());
    %>
    <input class="submit" onclick="pagePopUp('etudiant/edition_nonpayer.jsp')" type="button" value="Voir les impay&eacute;s">
    <input class="submit" onclick="pagePopUp('etudiant/edition_nonpayer.jsp?idetudiant=<%=idetudiant%>')" type="button" value="Voir ses impay&eacute;s">
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="etudiant/listeEtudiant.jsp">
    <input name="classe" type="hidden" id="classe" value="etudiant.PaiementDetailsanspayement">
</form>
