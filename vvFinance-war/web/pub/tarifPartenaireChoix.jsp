<%-- 
    Document   : tarifPartenaireChoix
    Created on : 5 juil. 2017, 10:24:27
    Author     : Alain
--%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="pub.*" %>
<%
    TarifRadioPartenariat p = new TarifRadioPartenariat();
    String etat = "tarif_pack_radio";
    p.setNomTable(etat);
    String listeCrt[] = {"id", "libelle", "duree", "montant"};
    String listeInt[] = {"montant"};
    PageRecherche pr = new PageRecherche(p, request, listeCrt, listeInt, 3);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("tarifPartenaireChoix.jsp");
    String libEntete[] = {"id", "libelle", "duree", "montant", "nbspot", "nbemission", "tophoraire", "siconcert"}; 
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    TarifRadioPartenariat[] listeP = (TarifRadioPartenariat[]) pr.getRs().getResultat();
%>
<link href="../style/style.css" rel="stylesheet" type="text/css">
<h1>Liste parution</h1>
<script type="text/javascript">
    function getChoix() {
        setTimeout("document.frmchx.submit()", 800);
    }
</script>
<form action="tarifPartenaireChoix.jsp?champReturn=<%=request.getParameter("champReturn")%>" method="post" name="listeetudiantchoix" id="listeetudiantchoix">
    <%
        out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
    out.println(pr.getTableauRecap().getHtml());%>
<br>
<form action="../apresChoix.jsp" method="post" name="frmchx" id="frmchx">
    <input type="hidden" name="champReturn" value="<%=request.getParameter("champReturn")%>">

    <table width=100% border=0 align=center cellpadding=3 cellspacing=3 class=monographe>
        <tr class=head>
            <td align="center" valign="top"></td>
            <td align="center" valign="top">id</td>
            <td align="center" valign="top">Libelle</td>
            <td align="center" valign="top">Durée</td>
            <td align="center" valign="top">Plagr</td>
            <td align="center" valign="top">Montant</td>
            <td align="center" valign="top">Nb SPOT 30s</td>
            <td align="center" valign="top">Intervention Emission 10mn</td>
            <td align="center" valign="top">Top Horaire</td>
            <td align="center" valign="top">Si concert/Matraquage</td>
            <td align="center" valign="top">Couverture conférence de presse</td>
        </tr>

        <%
            for (int i = 0; i < listeP.length; i++) {
        %>
        <tr onmouseover="this.style.backgroundColor='#EAEAEA'" onmouseout="this.style.backgroundColor=''">
            <td><input type="radio" name="choix" onMouseDown="getChoix()" value="<%=listeP[i].getId()%>" class="radio" /></td>
            <td align="center"><%=listeP[i].getId()%></td>
            <td align="center"><%=listeP[i].getLibelle()%></td>
            <td align="center"><%=listeP[i].getDuree()%></td>
            <td align="center"><%=listeP[i].getPlage()%></td>
            <td align="center"><%=Utilitaire.formaterAr(listeP[i].getMontant())%></td>
            <td align="center"><%=listeP[i].getNbspot()%></td>
            <td align="center"><%=listeP[i].getNbemission()%></td>
            <td align="center"><%=listeP[i].getTophoraire()%></td>
            <td align="center"><%=listeP[i].getSiconcert()%></td>
            <td align="center"><%=listeP[i].getConfpresse()%></td>

        </tr>
        <%}%>
    </table>
</form>