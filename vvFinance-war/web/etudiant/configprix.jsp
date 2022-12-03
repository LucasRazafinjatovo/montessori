<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="recette.*" %>

<%
    String idetudiant = request.getParameter("idetudiant");
    ConfPrixEtudiant atcl = new ConfPrixEtudiant();
    
    ConfPrixEtudiant confs = (ConfPrixEtudiant) CGenUtil.rechercher(atcl, null, null, " AND etudiant = '" + idetudiant + "' and date_fin is null")[0];
    
    atcl.setEtudiant(idetudiant);
    PageInsert pi = new PageInsert(atcl, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));

    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("etudiant").setLibelle("Etudiant");
    pi.getFormu().getChamp("etudiant").setDefaut(idetudiant);
    pi.getFormu().getChamp("echeance").setLibelle("Echeance");
    pi.getFormu().getChamp("echeance").setDefaut(String.valueOf(confs.getEcheance()));
    pi.getFormu().getChamp("ecolage").setLibelle("Ecolage");
    pi.getFormu().getChamp("ecolage").setDefaut(String.valueOf(confs.getEcolage()));
    pi.getFormu().getChamp("food").setLibelle("Food");
    pi.getFormu().getChamp("food").setDefaut(String.valueOf(confs.getFood()));
    pi.getFormu().getChamp("transport").setLibelle("Transport");
    pi.getFormu().getChamp("transport").setDefaut(String.valueOf(confs.getTransport()));
    pi.getFormu().getChamp("inscription").setLibelle("Inscription");
    pi.getFormu().getChamp("inscription").setDefaut(String.valueOf(confs.getInscription()));
    pi.getFormu().getChamp("autres").setLibelle("Autres");
    pi.getFormu().getChamp("autres").setDefaut(String.valueOf(confs.getAutres()));
    pi.getFormu().getChamp("remarques").setLibelle("Remarques");
    pi.getFormu().getChamp("date_fin").setVisible(false);
    pi.getFormu().getChamp("date_debut").setLibelle("Date d&eacute;but");
    pi.getFormu().getChamp("date_debut").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("daty").setTypeData("date");
    pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());

    pi.getFormu().getChamp("remarques").setAutre("textarea");
    pi.getFormu().getChamp("etudiant").setPageAppel("etudiant/etudiant-valide-multiple.jsp");
    pi.getFormu().getChamp("etudiant").setAutre("readonly='readonly'");

    pi.preparerDataFormu();
%>

<h1>Configuration prix</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="article" id="article">
    <%
        pi.getFormu().makeHtmlInsertTabIndex();
        out.println(pi.getFormu().getHtmlInsert());
    %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="etudiant/listeEtudiant.jsp&id=<%=idetudiant%>">
    <input name="classe" type="hidden" id="classe" value="recette.ConfPrixEtudiant">
</form>
