<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="etudiant.*" %>
<%@ page import="promotion.*" %>
<%

    EtudiantEnCours etudiantencours = new EtudiantEnCours();
    etudiantencours.setNomTable("etudiantencours");
    String listeCrt[] = {"idetudiant", "nom", "prenom", "idecole","idniveau","idanneescolaire"};
    String listeInt[] = {""};
    String libEntete[] = {"idetudiant", "nom", "prenom", "ecole","niveau","anneescolaire"};

     PageRecherche pr = new PageRecherche(etudiantencours, request, listeCrt, listeInt, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("etudiant/generer-facture.jsp");
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
     String mois[]  = {"January","February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
    String moisvalue[]  = {"1","2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"};
 %>
<script>
    function changerDesignation() {
        document.listeetudiant.submit();
    }

</script>
<h1>Generer facture</h1>
<form action="<%=pr.getLien()%>?but=etudiant/generer-facture.jsp" method="post" name="etudiantencours" id="etudiantencours">
    <%
        out.println(pr.getFormu().getHtmlEnsemble());
    %>
    <br>
</form>

<form method="POST" action="<%=pr.getLien()%>?but=etudiant/apresGenererFacture.jsp">
    <input name="acte" type="hidden" id="nature" value="generer">
    <input name="bute" type="hidden" id="bute" value="etudiant/generer-facture.jsp">
    <input name="classe" type="hidden" id="classe" value="etudiant.EtudiantEnCours">
    <table width="500" border="0" cellspacing="0" cellpadding="0" align="center">
    <td align="center"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="monographe">
        <tr>
			<td width="33%" class="left" height="23"> &nbsp;Mois min :</td>
            <td width="10%">&nbsp;</td>
            <td width="57%">
            <select name="moismin" class="champ">
            <%for(int m=0;m<mois.length;m++) {%>
            <option value="<%=moisvalue[m]%>"><%=mois[m]%></option>
            <% } %>
            </select>
            </td>
           
        </tr>
          <tr>
			<td width="33%" class="left" height="23"> &nbsp;Mois max:</td>
            <td width="10%">&nbsp;</td>
            <td width="57%">
            <select name="moismax" class="champ">
            <%for(int m=0;m<mois.length;m++) {%>
            <option value="<%=moisvalue[m]%>"><%=mois[m]%></option>
            <% } %>
            </select>
            </td>
         
        </tr>
        <tr>
			<td width="33%" class="left" height="23"> &nbsp;Ann&eacute;e :</td>
            <td width="10%">&nbsp;</td>
            <td width="57%"><input name="annee" type="text" class="champ" id="date" size="10" maxlength="10" required></td>
        </tr>
        </table>
      </td>
</table>
       <%      
            out.println(pr.getTableauRecap().getHtml());
            out.println(pr.getTableau().getHtmlWithCheckbox());
        %>
            <br>
            <div align="center"><input class="submit" type="submit" value="Generer"></div>
            
        </form>
 <%
    out.println(pr.getBasPage());
%>
