<%@page import="etudiant.Etudiant"%>
<%@page import="etudiant.EtudiantTiers"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="indicateur.*" %>

<%
    //Etudiant e=new Etudiant();
    Etudiant e=new Etudiant();
    e.setNomTable("ETUDIANTLIBELLE");

    String listeCrt[]={"nom","prenom","datenaissance","pere","proffpere","mere","profmere","adresse","contact","mail","sexe","niveau","pays"};
    String listeInt[]={"datenaissance"};
    String libEntete[]={"id","nom","prenom","datenaissance","adresse","contact","niveau"};
    PageRecherche pr = new PageRecherche(e, request, listeCrt, listeInt, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("etudiant_tiers.jsp");
    
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
<form action="listeEtudiantChoix.jsp?champReturn=<%=request.getParameter("champReturn")%>" method="post" name="listeetudiantchoix" id="listeetudiantchoix">
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
            <td width=9% align="center" valign="top">idEtudiant</td>
            <td width=14% align="center" valign="top">nom</td>
            <td width=14% align="center" valign="top">prenom</td>
            <td width=14% align="center" valign="top">dateNaissance</td>
            <td width=14% align="center" valign="top">niveau</td>
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
            <td align=center><%=listeP[i].getDateNaissance()%></td>
            <td align=center><%=listeP[i].getNiveau()%></td>
        </tr>
        <%}%>
    </table>
</form>

<%
    out.println(pr.getBasPage());
%>
