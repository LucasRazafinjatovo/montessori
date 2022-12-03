<%-- 
    Document   : ListeeEtudiantPopupPrix
    Created on : 22 mai 2018, 09:47:34
    Author     : Lai Christophe
--%>

<%@page import="recette.ConfPrixEtudiantLibelleTotal"%>
<%@page import="etudiant.Etudiant"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="indicateur.*" %>

<%
    //c e=new Etudiant();
    ConfPrixEtudiantLibelleTotal a = new ConfPrixEtudiantLibelleTotal();
    a.setNomTable("ConfPrixEtudiantLibelleTotal");

    String listeCrt[] = {"id"};
//    String listeCrt[] = {"ID", "dateNaissance", "ETUDIANT", "ECHEANCE", "ECOLAGE", "FOOD", "TRANSPORT", "INSCRIPTION", "AUTRES", "TOTAL", "REMARQUES"};
    String listeInt[] = {};
    PageRecherche pr = new PageRecherche(a, request, listeCrt, listeInt, 2);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("ListeeEtudiantPopupPrix.jsp");
    String libEntete[] = {"ID", "NOM", "PRENOM", "TOTAL", "ECOLAGE", "FOOD"};
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    ConfPrixEtudiantLibelleTotal[] listeP = (ConfPrixEtudiantLibelleTotal[]) pr.getRs().getResultat();
%>
<link href="../style/style.css" rel="stylesheet" type="text/css">
<h1>Listee Etudiant PopupPrix </h1>
<script type="text/javascript">
    function getChoix() {
        setTimeout("document.frmchx.submit()", 800);
    }
</script>
<form action="ListeeEtudiantPopupPrix.jsp?champReturn=<%=request.getParameter("champReturn")%>" method="post" name="listeetudiantchoix" id="listeetudiantchoix">
    <%
        out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
    out.println(pr.getTableauRecap().getHtml());%>
<br>
<form action="../<%=pr.getLien()%>?but=etudiant/apreschoix.jsp" method="post" name="frmchx" id="frmchx">
    <input type="hidden" name="champReturn" value="<%=request.getParameter("champReturn")%>">
    <table width=100% border=0 align=center cellpadding=3 cellspacing=3 class=monographe>
        <tr class=head>
            <td width=5% align="center" valign="top"></td>
            <td width=9% align="center" valign="top">id</td>
            <td width=14% align="center" valign="top">nom</td>
            <td width=14% align="center" valign="top">prenom</td>
            <td width=14% align="center" valign="top">total</td>
            <td width=14% align="center" valign="top">ecolage</td>
            <td width=14% align="center" valign="top">food</td>
            <td width=14% align="center" valign="top">transport</td>
            <td width=14% align="center" valign="top">inscription</td>
            <td width=14% align="center" valign="top">autres</td>
        </tr>

        <%
            for (int i = 0; i < listeP.length; i++) {
        %>
        <tr>
            <!--<tr onmouseover=this.style.backgroundColor='#EAEAEA' onmouseout="this.style.backgroundColor=''">-->
            <td><input type="radio" name="choix" onMouseDown="getChoix()" value="<%=listeP[i].getId()%>" class="radio" /></td>
            <td align=center><%=listeP[i].getId()%></td>
            <td align=center><%=listeP[i].getNom()%></td>
            <td align=center><%=listeP[i].getPrenom()%></td>
            <td align=center><%=listeP[i].getTotal()%></td>
            <td align=center><%=listeP[i].getEcolage()%></td>
            <td align=center><%=listeP[i].getFood()%></td>
            <td align=center><%=listeP[i].getTransport()%></td>
            <td align=center><%=listeP[i].getInscription()%></td>
            <td align=center><%=listeP[i].getAutres()%></td>
         </tr>
        <%}%>
    </table>
</form>


<%
    out.println(pr.getBasPage());
%>
