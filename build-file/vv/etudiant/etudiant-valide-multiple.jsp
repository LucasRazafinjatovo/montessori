<%--<%@page import="etudiant.Etudiant"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="indicateur.*" %>

<%
    //Etudiant e=new Etudiant();
    Etudiant a = new Etudiant();
    a.setNomTable("Etudiant");

    String listeCrt[] = {"id", "nom"};
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
%>--%>


<%@page import="etudiant.EntiteBeneficiaire"%>
<%@page import="etudiant.EtudiantIsOk"%>
<%@ page import="user.UserEJB" %>
<%@ page import="comptabilite.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%

    String lien = null;
    UserEJB u = null;

    EtudiantIsOk clt[] = null;

    EtudiantIsOk cltCrt = null;
    String id = null, nom = null, prenom = null;
    String champReturn = null;
    int nbPage = 0;
    String pazyS = null;
    int color = 0;
    String maxpageS = "";
    int maxpage = 0;
    int minpage = 0;
    int maxpageT = 0;
    int pazy = 0;
%>
<%
//Prendre les critères de filtre
    cltCrt = new EtudiantIsOk();
    cltCrt.setNomTable("etudiant_actif");

    id = Utilitaire.remplacerNull(request.getParameter("id"));
    cltCrt.setId(id);
    nom = Utilitaire.remplacerNull(request.getParameter("nom"));
    cltCrt.setNom(nom);
    prenom = Utilitaire.remplacerNull(request.getParameter("prenom"));
    cltCrt.setPrenom(prenom);
    champReturn = request.getParameter("champReturn");

    pazyS = request.getParameter("pazy");
    if ((pazyS == null) || (pazyS.compareTo("") == 0)) {
        pazy = 1;
    } else {
        pazy = Utilitaire.stringToInt(request.getParameter("pazy"));
    }
    maxpageS = request.getParameter("maxpageS");

    if ((maxpageS == null) || (maxpageS.compareTo("") == 0)) {
        maxpage = 15;
    } else {
        maxpage = Utilitaire.stringToInt(request.getParameter("maxpageS"));
    }
    minpage = maxpage - 14;
    if ((champReturn == null) || champReturn.compareTo("") == 0) {
        champReturn = "fournisseur";
    }
    if (request.getParameter("pazy") == null) {
        pazy = 1;
    } else {
        pazy = Utilitaire.stringToInt(request.getParameter("pazy"));
    }
%>
<%
    lien = (String) session.getValue("lien");
    u = (UserEJB) session.getAttribute("u");
    
    String stringentite = "%";
    if (request.getParameter("entite") != null && request.getParameter("entite").compareTo("%") != 0) {
        stringentite = request.getParameter("entite");
        cltCrt.setEntite(stringentite);
    }
    String stringprenom = "";
    if (request.getParameter("prenom") != null && request.getParameter("prenom").compareTo("") != 0) {
        stringprenom = request.getParameter("prenom");
        cltCrt.setPrenom(stringprenom);
    }
    String stringnom = "";
    if (request.getParameter("nom") != null && request.getParameter("nom").compareTo("") != 0) {
        stringnom = request.getParameter("nom");
        cltCrt.setNom(stringnom);
    }
    String stringid = "";
    if (request.getParameter("id") != null && request.getParameter("id").compareTo("") != 0) {
        stringid = request.getParameter("id");
        cltCrt.setId(stringid);
    }
    
    
    
    ResultatEtSomme rs = CGenUtil.rechercherPage(cltCrt, null, null, pazy, "", null);
    clt = (EtudiantIsOk[]) rs.getResultat();
    nbPage = Utilitaire.calculNbPage(rs.getSommeEtNombre()[0]);

    // if(maxpage>nbPage){maxpageT=nbPage;}else{maxpageT=maxpage;}
    affichage.Champ[] liste = new affichage.Champ[1];
    EntiteBeneficiaire entite = new EntiteBeneficiaire();
    String idSociete = "SOC00003";
    entite.setIdSociete(idSociete);
    liste[0] = new Liste("entite", entite, "val", "val");
    EntiteBeneficiaire[] tabentite = (EntiteBeneficiaire[]) CGenUtil.rechercher(entite, null, null, "");

%>


<script language="JavaScript">
    <!--
    function page(page_dest) {
        document.location = page_dest;
    }
    function getChoix() {
        setTimeout("document.frmchx.submit()", 800);
    }
    function Update() {
        window.opener.document.all.eng_titulaire.value = "G456546546";
        window.close();

    }
//-->
</script>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<body bgcolor="#ffffff">


    <div id="header">

    </div>
    <!--fin table entete-->
    <div id ="titre">

    </div>
    <!--table pour la page-->
    <div id ="content">

        <table  border="0" align="center"class="tableTitre">
            <tr>
                <td>Liste des Comptes G&eacute;n&eacute;raux</td>
            </tr>
        </table>

        <br>

        <TABLE align="center" class="tableContent">
            <TR>
                <TD>
                    <!-- mission-->
                    <fieldset class="fieldset1"><legend>Filtrer</legend>

                        <form action="etudiant-valide-multiple.jsp" method="post">
                            <table  align="center"  class="monographe" width="100%">
                                <tr>
                                    <td align="left">Id </td>
                                    <td  width="35%"  align="left"><input name="id" id="id"  type="text" value="<%=id%>" size="25" style="text-align:left;"></td>
                                    <td align="left">Nom </td>
                                    <td  width="35%"  align="left"><input name="nom" id="nom"  type="text" value="<%=nom%>" size="25" style="text-align:left;"></td>
                                </tr>
                                <tr>
                                    <td align="left">Prénom </td>
                                    <td  width="35%"  align="left"><input name="prenom" id="prenom"  type="text" value="<%=prenom%>" size="25" style="text-align:left;"></td>
                                    <td  align="left">Ecole</td>
                                    <td width="35%" align="left">
                                        <select name="entite" id="entite" type="text"  style="text-align:left;" >
                                            <option value="%">-</option>
                                            <%for (int i = 0; i < tabentite.length; i++) {%>
                                            <option value="<%=tabentite[i].getId()%>"><%=tabentite[i].getVal()%></option>
                                            <%}%>
                                        </select>

                                    </td>
                                </tr>
                                <!--<tr>
                                    <td align="left">Libelle </td>
                                    <td  width="35%"  align="left"><input name="desce" id="desce" type="text" value="<%=prenom%>" size="25" style="text-align:left;"></td>
                                    <td></td>
                                </tr>-->
                            </table>
                            <input type="hidden" name="champReturn" value="<%=champReturn%>">


                            <table align="center">
                                <tr><td><input type="submit" value="Afficher" class="bouton1"></td></tr>
                            </table>
                        </form>
                    </fieldset>

                    <fieldset class="fieldset1">
                        <form action="apreschoixMultiple.jsp" method="post"  name="frmchx">
                            <div style="overflow:scroll;width:750px;" >
                                <input type="hidden" name="champReturn" value="<%=champReturn%>">
                                <table align="center" class="monographe" width="100%">
                                    <tr>
                                        <td>-</td>
                                        <td>ID.</td>
                                        <td>Nom </td>
                                        <td>Prenom</td>
                                        <td>Date de naissance</td>
                                    </tr>
                                    <%for (int i = 0; i < clt.length; i++) {%>
                                    <tr>
                                        <td><input type="checkbox" name="choix" value="<%=clt[i].getId()%>" class="checkbox" /></td>
                                        <td><%=clt[i].getId()%> </td>
                                        <td><%=clt[i].getNom()%>  </td>
                                        <td><%=clt[i].getPrenom()%></td>
                                        <td><%=clt[i].getDateNaissance()%></td>
                                    </tr>
                                    <%

                                        }
                                    %>
                                </table>

                                <table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
                                    <tr><td height="25"><b>Nombre de r&eacute;sultat :</b> <%=rs.getSommeEtNombre()[0]%></td><td align="right"><strong>page</strong> <%=pazy%> <b>sur</b><%=nbPage%></td>
                                    </tr>
                                    <tr>
                                        <td width="295" valign="top" height="25">
                                            <%if (pazy != 1) {%>
                                            <a href="choixCompteMultiple.jsp?id=<%=Utilitaire.remplacePourcentage(id)%>&val=<%=Utilitaire.remplacePourcentage(nom)%>&desce=<%=Utilitaire.remplacePourcentage(prenom)%>&pazy=<%=pazy - 1%>">&lt;&lt;Page
                                                pr&eacute;c&eacute;dente</a>
                                                <%

                                                    }
                                                    pazy = pazy + 1;
                                                %></td>
                                        <td width="305" align="right">
                                            <%
                                                if (pazy < nbPage) {
                                            %>
                                            <a href="choixCompteMultiple.jsp?id=<%=Utilitaire.remplacePourcentage(id)%>&val=<%=Utilitaire.remplacePourcentage(nom)%>&desce=<%=Utilitaire.remplacePourcentage(prenom)%>&pazy=<%=pazy - 1%>">&lt;&lt;Page
                                                suivante&gt;&gt;</a>
                                                <%
                                                    }
                                                %></td>
                                    </tr>
                                </table>
                                <p><input type="button" value="Valider" onClick="getChoix()"/></p>

                                <!-- Table permettant d'afficher la liste des pages -->

                            </div>


                            <!-- FIN TABLE page-->





                            <input type="hidden" name="acte" value ="choix">
                            <input type="hidden" name="champReturn" value =<%=champReturn%>>
                        </form>
                    </fieldset>



                </TD></TR>
        </TABLE>
    </div>