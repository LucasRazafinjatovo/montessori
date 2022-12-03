<%@page import="etudiant.Etudiant"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="indicateur.*" %>

<%
    //Etudiant e=new Etudiant();
    Etudiant a = new Etudiant();
    a.setNomTable("Etudiant");

    String listeCrt[] = {"id", "nom", "prenom", "dateNaissance", "pere", "mere", "mail", "sexe"};
    String listeInt[] = {"dateNaissance"};
    String libEntete[] = {"id", "dateNaissance", "nom", "prenom", "sexe", "proffpere", "profMere", "pays"};
    PageRecherche pr = new PageRecherche(a, request, listeCrt, listeInt, 1);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("choixEtudiant.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    Etudiant[] listeP = (Etudiant[]) pr.getRs().getResultat();
%>
<link href="../style/style.css" rel="stylesheet" type="text/css">
<h1>Liste des Etudiants</h1>
<script type="text/javascript">
    function getChoix() {
        setTimeout("document.frmchx.submit()", 800);
    }
</script>
<form action="choixEtudiant.jsp?champReturn=<%=request.getParameter("champReturn")%>" method="post" name="listeetudiantchoix" id="listeetudiantchoix">
    <%
        out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
    out.println(pr.getTableauRecap().getHtml());%>
<br>
<form action="../<%=pr.getLien()%>?but=etudiant/apreschoix.jsp" method="post" name="frmchx" id="frmchx">
    <input type="hidden" name="champReturn" value="<%=request.getParameter("champReturn")%>">

    //id			prenom				

    <table width=100% border=0 align=center cellpadding=3 cellspacing=3 class=monographe>
        <tr class=head>
            <td width=5% align="center" valign="top"></td>
            <td width=9% align="center" valign="top">id</td>
            <td width=14% align="center" valign="top">dateNaissance</td>
            <td width=14% align="center" valign="top">prenom</td>
            <td width=14% align="center" valign="top">sexe</td>
            <td width=14% align="center" valign="top">proffpere</td>
            <td width=14% align="center" valign="top">profMere</td>
            <td width=14% align="center" valign="top">pays</td>
        </tr>

        <%
            for (int i = 0; i < listeP.length; i++) {
        %>
        <tr>
            <!--<tr onmouseover=this.style.backgroundColor='#EAEAEA' onmouseout="this.style.backgroundColor=''">-->
            <td><input type="radio" name="choix" onMouseDown="getChoix()" value="<%=listeP[i].getId()%>" class="radio" /></td>
            <td align=center><%=listeP[i].getId()%></td>
            <td align=center><%=listeP[i].getDateNaissance()%></td>
            <td align=center><%=listeP[i].getPrenom()%></td>
            <td align=center><%=listeP[i].getSexe()%></td>
            <td align=center><%=listeP[i].getProffPere()%></td>
            <td align=center><%=listeP[i].getProfMere()%></td>
            <td align=center><%=listeP[i].getPays()%></td>
        </tr>
        <%}%>
    </table>
</form>


<%
    out.println(pr.getBasPage());
%>
