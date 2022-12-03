<%--
    Document   : rubrique-prix-entite-saisie
    Created on : 22 mai 2018, 09:37:45
    Author     : pro
--%>

<%@page import="javax.validation.ValidationException"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="etudiant.*" %>
<%@ page import="finance.*" %>
<%
    String facture = request.getParameter("idfacturefille");

    Paiement paiement = new Paiement();
    PageInsert pi = new PageInsert(paiement, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    affichage.Champ[] liste=new affichage.Champ[2];
    TypeObjet modepaiement = new TypeObjet();
    modepaiement.setNomTable("modepaiement");
    liste[0] = new Liste("idmodepaiement", modepaiement, "val", "id");
    Caisse caisse = new Caisse();
    liste[1] = new Liste("idcaisse", caisse, "desccaisse", "idcaisse");
    pi.getFormu().changerEnChamp(liste);
    pi.getFormu().getChamp("datepaiement").setLibelle("Date de paiement");
    //pi.getFormu().getChamp("datepaiement").setType("date");
    pi.getFormu().getChamp("datepaiement").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("idmodepaiement").setLibelle("Mode de paiement");
    pi.getFormu().getChamp("idfacture").setLibelle("Facture");
    pi.getFormu().getChamp("montant").setLibelle("Montant");
     pi.getFormu().getChamp("idcaisse").setLibelle("Caisse");
    pi.getFormu().getChamp("idfacture").setDefaut(facture);
    pi.getFormu().getChamp("idfacture").setAutre(" readOnly=true ");
    pi.preparerDataFormu();
%>
<h1>Paiement facture</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="POST" name="paiement" id="paiement" >
    <%
        pi.getFormu().makeHtmlInsertTabIndex();
        out.println(pi.getFormu().getHtmlInsert());
    %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="etudiant/etat-analyse-paiement.jsp">
    <input name="classe" type="hidden" id="classe" value="etudiant.Paiement">
</form>

