<%-- 
    Document   : heureChoixMultiple
    Created on : 18 mai 2017, 11:00:07
    Author     : Safidimahefa
--%>

<%@ page import="user.UserEJB" %>
<%@ page import="comptabilite.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%

    String lien = null;
    UserEJB u = null;

    TypeObjet clt[] = null;

    TypeObjet cltCrt = null;
    String id = null, val = null, desce = null;
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
    cltCrt = new TypeObjet();
    cltCrt.setNomTable("pub_top_radio_heure");

    id = Utilitaire.remplacerNull(request.getParameter("id"));
    cltCrt.setId(id);
    val = Utilitaire.remplacerNull(request.getParameter("val"));
    cltCrt.setVal(val);
    desce = Utilitaire.remplacerNull(request.getParameter("desce"));
    cltCrt.setDesce(desce);
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

    ResultatEtSomme rs = CGenUtil.rechercherPage(cltCrt, null, null, pazy, "", null);
    clt = (TypeObjet[]) rs.getResultat();
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
                <td>Liste des Horaires</td>
            </tr>
        </table>

        <br>

        <TABLE align="center" class="tableContent">
            <TR>
                <TD>
                    <!-- mission-->
                    <fieldset class="fieldset1"><legend>Filtrer</legend>

                        <form action="heureChoixMultiple.jsp" method="post">
                            <table  align="center"  class="monographe" width="100%">
                                <tr>
                                    <td align="left">Id </td>
                                    <td  width="35%"  align="left"><input name="id" id="id"  type="text" value="<%=id%>" size="25" style="text-align:left;"></td>
                                    <td  align="left">Heure</td>
                                    <td width="35%" align="left"><input name="val" id="val" type="text" value="<%=val%>" size="25" style="text-align:left;" /></td>
                                </tr>
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
                                        <td>Heure </td>
                                    </tr>
                                    <%for (int i = 0; i < clt.length; i++) {%>
                                    <tr>
                                        <td><input type="checkbox" name="choix" value="<%=clt[i].getVal()%>" class="checkbox" /></td>

                                        <td><%=clt[i].getVal()%>  </td>
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
                                            <a href="heureChoixMultiple.jsp?id=<%=Utilitaire.remplacePourcentage(id)%>&val=<%=Utilitaire.remplacePourcentage(val)%>&desce=<%=Utilitaire.remplacePourcentage(desce)%>&pazy=<%=pazy - 1%>">&lt;&lt;Page
                                                pr&eacute;c&eacute;dente</a>
                                                <%

                                                    }
                                                    pazy = pazy + 1;
                                                %></td>
                                        <td width="305" align="right">
                                            <%
                                                if (pazy < nbPage) {
                                            %>
                                            <a href="heureChoixMultiple.jsp?id=<%=Utilitaire.remplacePourcentage(id)%>&val=<%=Utilitaire.remplacePourcentage(val)%>&desce=<%=Utilitaire.remplacePourcentage(desce)%>&pazy=<%=pazy - 1%>">&lt;&lt;Page
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
