<%@ page import="user.UserEJB" %>
<%@ page import="facture.FactureClient" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%

    String apres = "admin/annulerFactureClient.jsp";
    String lien = null;
    UserEJB u = null;

//variable tableau d'objet retourné par la méthode find
    facture.FactureClient factClt[] = null;
    facture.FactureClient factCltCrt = null;
    String idfacturefournisseur = null;
    String idfournisseur = null;
    String numfact = null;
    //String datyinf = null;
    //String datysup = null;
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
    factCltCrt = new FactureClient();
    idfacturefournisseur = Utilitaire.remplacerNull(request.getParameter("idfacturefournisseur"));
    factCltCrt.setIdfacturefournisseur(idfacturefournisseur);
    idfournisseur = Utilitaire.remplacerNull(request.getParameter("idfournisseur"));
    factCltCrt.setIdfournisseur(idfournisseur);
    numfact = Utilitaire.remplacerNull(request.getParameter("numfact"));
    factCltCrt.setNumfact(numfact);
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
        champReturn = "idFactureClient";
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

    //Utiliser la méthode find :  findAgenceExecution(String id,String exercice,String libelle,String date1,String date2, String apresW, int page); ->retourne une classe retournant un objet gérant un objet Resultatetsomme
    //ResultatEtSomme rs=u.findClientPage(idClient, nomClient, "%","%","%", adr,numStat, nif,rc,"%","%",pazy);
    ResultatEtSomme rs = CGenUtil.rechercherPage(factCltCrt, null, null, pazy, "", null);
    factClt = (FactureClient[]) rs.getResultat();
    nbPage = Utilitaire.calculNbPage(rs.getSommeEtNombre()[0]);

    // if(maxpage>nbPage){maxpageT=nbPage;}else{maxpageT=maxpage;}
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
                <td><!-- Liste engagements liquidés-->
                    Liste Facture Client
                </td>
            </tr>
        </table>

        <br>

        <TABLE align="center" class="tableContent">
            <TR>
                <TD>
                    <!-- mission-->
                    <fieldset class="fieldset1"><legend>Filtrer</legend>

                        <form action="listeChoixFactureClient.jsp" method="post">
                            <table  align="center"  class="monographe" width="100%">
                                <tr>
                                    <td align="left">IdFactureFournisseur </td>
                                    <td  width="35%"  align="left"><input name="idfacturefournisseur" id="idClient"  type="text" value="<%=idfacturefournisseur%>" size="25" style="text-align:left;"></td>
                                    <td  align="left">IdFournisseur</td>
                                    <td width="35%" align="left"><input name="idfournisseur" id="nomClient" type="text" value="<%=idfournisseur%>" size="25" style="text-align:left;" /></td>
                                </tr>
                                <tr>
                                    <td align="left">Numéro facture </td>
                                    <td  width="35%"  align="left"><input name="numfact" id="adr" type="text" value="<%=numfact%>" size="25" style="text-align:left;"></td>
                                </tr>
                            </table>
                            <input type="hidden" name="champReturn" value="<%=champReturn%>">


                            <table align="center">
                                <tr><td><input type="submit" value="Afficher" class="bouton1"></td></tr>
                            </table>
                        </form>
                    </fieldset>

                    <fieldset class="fieldset1">
                        <form action="apresChoixFactureClient.jsp" method="post"  name="frmchx">
                            <div style="overflow:scroll;width:750px;" >
                                <input type="hidden" name="champReturn" value="<%=champReturn%>">
                                <table align="center" class="monographe" width="100%">
                                    <tr>
                                        <td>-</td>
                                        <td>IdFactureFournisseur</td>
                                        <td>IdFournisseur</td>
                                        <td>Numéro facture</td>

                                    </tr>
                                    <%
                                        for (int i = 0; i < factClt.length; i++) {
                                            // lcd = u.findLC(lcamenag[i].getIdLigne(),"%","%","%","%","%","%","%","%", "%","%","%","%","%","%")[0];


                                    %>
                                    <tr>
                                        <td><input type="radio" name="idFactureClient" onMouseDown="getChoix()" value="<%=factClt[i].getIdfacturefournisseur()%>" class="radio" /></td>
                                        <td><%=factClt[i].getIdfacturefournisseur()%> </td>
                                        <td><%=factClt[i].getIdfournisseur()%>  </td>
                                        <td><%=factClt[i].getNumfact()%></td>

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
                                            <a href="listeChoixFactureClient.jsp?idfacturefournisseur=<%=Utilitaire.remplacePourcentage(idfacturefournisseur)%>&idfournisseur=<%=Utilitaire.remplacePourcentage(idfournisseur)%>&numfact=<%=Utilitaire.remplacePourcentage(numfact)%>&pazy=<%=pazy - 1%>">&lt;&lt;Page
                                                pr&eacute;c&eacute;dente</a>
                                                <%

                                                    }
                                                    pazy = pazy + 1;
                                                %></td>
                                        <td width="305" align="right">
                                            <%
                                                if (pazy < nbPage) {
                                            %>
                                            <a href="listeChoixFactureClient.jsp?idfacturefournisseur=<%=Utilitaire.remplacePourcentage(idfacturefournisseur)%>&idfournisseur=<%=Utilitaire.remplacePourcentage(idfournisseur)%>&numfact=<%=Utilitaire.remplacePourcentage(numfact)%>&pazy=<%=pazy%>">Page
                                                suivante&gt;&gt;</a>
                                                <%
                                                    }
                                                %></td>
                                    </tr>
                                </table>

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