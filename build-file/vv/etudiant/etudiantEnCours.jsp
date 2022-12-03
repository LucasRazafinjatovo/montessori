<%@page import="etudiant.*"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="indicateur.*" %>

<%

    EtudiantEnCours etudiantEnCours = new EtudiantEnCours();
    etudiantEnCours.setNomTable("etudiantencours");
    String listeCrt[] = {"idetudiant", "nom", "prenom", "idecole","idniveau","idanneescolaire"};
    String listeInt[] = {""};
    String libEntete[] = {"idetudiant", "nom", "prenom", "ecole","niveau","anneescolaire"};

     PageRecherche pr = new PageRecherche(etudiantEnCours, request, listeCrt, listeInt, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("etudiant/etudiantEnCours.jsp");
     affichage.Champ[] liste = new affichage.Champ[3];

    Ecole ecole = new Ecole();
    ecole.setNomTable("ecole");
    liste[0] = new Liste("idecole", ecole, "nom", "id");
    Niveau niveau = new Niveau();
    liste[1] = new Liste("idniveau", niveau, "nom", "id");
    AnneeScolaire anneeScolaire=new AnneeScolaire();
     liste[2] = new Liste("idanneescolaire", anneeScolaire, "nom", "id");
    pr.getFormu().changerEnChamp(liste);
        pr.getFormu().getChamp("idniveau").setLibelle("Niveau");
    pr.getFormu().getChamp("idanneescolaire").setLibelle("Anneescolaire");
    pr.getFormu().getChamp("idecole").setLibelle("Ecole");
    pr.getFormu().getChamp("idetudiant").setLibelle("ID");
    pr.getFormu().getChamp("nom").setLibelle("Nom");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    EtudiantEnCours[] listeP = (EtudiantEnCours[]) pr.getRs().getResultat();
%>
<link href="../style/style.css" rel="stylesheet" type="text/css">
<h1>Liste des Etudiants en cours</h1>
<script type="text/javascript">
    function getChoix() {
        setTimeout("document.frmchx.submit()", 800);
    }
</script>
<form action="etudiantEnCours.jsp?champReturn=<%=request.getParameter("champReturn")%>" method="post" name="listeetudiantchoix" id="listeetudiantchoix">
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
            <td width=14% align="center" valign="top">ecole</td>
            <td width=14% align="center" valign="top">niveau</td>
            <td width=14% align="center" valign="top">anneescolaire</td>
           
        </tr>

        <%
            for (int i = 0; i < listeP.length; i++) {
        %>
        <tr>
            <!--<tr onmouseover=this.style.backgroundColor='#EAEAEA' onmouseout="this.style.backgroundColor=''">-->
            <td><input type="radio" name="choix" onMouseDown="getChoix()" value="<%=listeP[i].getIdEtudiant()%>" class="radio" /></td>
            <td align=center><%=listeP[i].getIdEtudiant()%></td>
            <td align=center><%=listeP[i].getNom()%></td>
            <td align=center><%=listeP[i].getPrenom()%></td>
            <td align=center><%=listeP[i].getEcole()%></td>
            <td align=center><%=listeP[i].getNiveau()%></td>
            <td align=center><%=listeP[i].getAnneeScolaire()%></td>
        </tr>
        <%}%>
    </table>
</form>

<%
    out.println(pr.getBasPagee());
%>
