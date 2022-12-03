<%-- 
    Document   : listeChoixParution
    Created on : 29 juin 2017, 14:29:32
    Author     : Alain
--%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="pub.*" %>
<%
    Parution p = new Parution();
    String etat = "parutionlibelle";
    p.setNomTable(etat);
    String listeCrt[] = {"id", "journal", "numParution"};
    String listeInt[] = null;
    PageRecherche pr = new PageRecherche(p, request, listeCrt, listeInt, 3);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("listeChoixParution.jsp");
    String libEntete[] = {"id", "journal", "numParution","datyparution"};
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    Parution[] listeP = (Parution[]) pr.getRs().getResultat();
%>
<link href="style/style.css" rel="stylesheet" type="text/css">
<h1>Liste parution</h1>
<script type="text/javascript">
    function getChoix() {
        setTimeout("document.frmchx.submit()", 800);
    }
</script>
<form action="listeChoixParution.jsp?champReturn=<%=request.getParameter("champReturn")%>" method="post" name="listeetudiantchoix" id="listeetudiantchoix">
    <%
        out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
    out.println(pr.getTableauRecap().getHtml());%>
<br>
<form action="<%=pr.getLien()%>?but=listeChoixParution.jsp" method="post" name="frmchx" id="frmchx">
    <input type="hidden" name="champReturn" value="<%=request.getParameter("champReturn")%>">

    <table width=100% border=0 align=center cellpadding=3 cellspacing=3 class=monographe>
        <tr class=head>
            <td align="center" valign="top"></td>
            <td align="center" valign="top">id</td>
            <td align="center" valign="top">Journal</td>
            <td align="center" valign="top">Num parution</td>
            <td align="center" valign="top">Date parution</td>
        </tr>

        <%
            for (int i = 0; i < listeP.length; i++) {
        %>
        <tr onmouseover="this.style.backgroundColor='#EAEAEA'" onmouseout="this.style.backgroundColor=''">
            <td><input type="radio" name="choix" onMouseDown="getChoix()" value="<%=listeP[i].getId()%>" class="radio" /></td>
            <td align="center"><%=listeP[i].getId()%></td>
            <td align="center"><%=listeP[i].getJournal()%></td>
            <td align="center"><%=listeP[i].getNumParution()%></td>
            <td align="center"><%=listeP[i].getDatyParution()%></td>

        </tr>
        <%}%>
    </table>
</form>


<%
//out.println(pr.getBasPage());
%>
