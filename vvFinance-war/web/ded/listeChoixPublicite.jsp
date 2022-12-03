<%@ page import="user.UserEJB" %>
<%@ page import="pub.Publicite" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%

    String apres = "admin/annulerPublicite.jsp";
    String lien = null;
    UserEJB u = null;

//variable tableau d'objet retourné par la méthode find
    Publicite pub[] = null;
    Publicite pubCrt = null;
    
    String id = null;
    String idClient = null;
    String idMont = null;
    String idCat = null;
    String idAgence = null;
    String idParution = null;
    String designation = null;
    String remarque = null;
    String numPiece = null;
  
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
    pubCrt = new Publicite();
    pubCrt.setNomTable("publibelle");
    id = Utilitaire.remplacerNull(request.getParameter("id"));
    pubCrt.setId(id);
    idClient = Utilitaire.remplacerNull(request.getParameter("idClient"));
    pubCrt.setIdClient(idClient);
    idMont = Utilitaire.remplacerNull(request.getParameter("idMont"));
    pubCrt.setIdMont(idMont);
    idCat = Utilitaire.remplacerNull(request.getParameter("idCat"));
    pubCrt.setIdCat(idCat);
    idAgence = Utilitaire.remplacerNull(request.getParameter("idAgence"));
    pubCrt.setIdAgence(idAgence);
    idParution = Utilitaire.remplacerNull(request.getParameter("idParution"));
    pubCrt.setIdParution(idParution);
    designation = Utilitaire.remplacerNull(request.getParameter("designation"));
    pubCrt.setDesignation(designation);
    remarque = Utilitaire.remplacerNull(request.getParameter("remarque"));
    pubCrt.setRemarque(remarque);
    numPiece = Utilitaire.remplacerNull(request.getParameter("numPiece"));
    pubCrt.setNumPiece(numPiece);
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
        champReturn = "idPublicite";
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
    ResultatEtSomme rs = CGenUtil.rechercherPage(pubCrt, null, null, pazy, "", null);
    pub = (Publicite[]) rs.getResultat();
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
                    Liste Publicité
                </td>
            </tr>
        </table>

        <br>

        <TABLE align="center" class="tableContent">
            <TR>
                <TD>
                    <!-- mission-->
                    <fieldset class="fieldset1"><legend>Filtrer</legend>

                        <form action="listeChoixPublicite.jsp" method="post">
                            <table  align="center"  class="monographe" width="100%">
                                <tr>
                                    <td align="left">Id </td>
                                    <td  width="35%"  align="left"><input name="id" id="id"  type="text" value="<%=id%>" size="25" style="text-align:left;"></td>
                                    <td  align="left">Client</td>
                                    <td width="35%" align="left"><input name="idClient" id="idClient" type="text" value="<%=idClient%>" size="25" style="text-align:left;" /></td>
                                </tr>
                                <tr>
                                    <td align="left">Mont</td>
                                    <td  width="35%"  align="left"><input name="idMont" id="idMont" type="text" value="<%=idMont%>" size="25" style="text-align:left;"></td>
                                    <td  align="left">Catégorie</td>
                                    <td width="35%" align="left"><input name="idCat" id="idCat" type="text" value="<%=idCat%>" size="25" style="text-align:left;" /></td>
                                </tr>
                                <tr>
                                    <td align="left">Agence</td>
                                    <td  width="35%"  align="left"><input name="idAgence" id="idAgence" type="text" value="<%=idAgence%>" size="25" style="text-align:left;"></td>
                                    <td  align="left">Parution</td>
                                    <td width="35%" align="left"><input name="idParution" id="idParution" type="text" value="<%=idParution%>" size="25" style="text-align:left;" /></td>
                                </tr>
                                <tr>
                                    <td align="left">Désignation</td>
                                    <td  width="35%"  align="left"><input name="designation" id="designation" type="text" value="<%=designation%>" size="25" style="text-align:left;"></td>
                                    <td  align="left">Remarque</td>
                                    <td width="35%" align="left"><input name="remarque" id="remarque" type="text" value="<%=remarque%>" size="25" style="text-align:left;" /></td>
                                </tr>
                                <tr>
                                    <td align="left">Numéro pièce</td>
                                    <td  width="35%"  align="left"><input name="numPiece" id="numPiece" type="text" value="<%=numPiece%>" size="25" style="text-align:left;"></td>
                                </tr>
                            </table>
                            <input type="hidden" name="champReturn" value="<%=champReturn%>">


                            <table align="center">
                                <tr><td><input type="submit" value="Afficher" class="bouton1"></td></tr>
                            </table>
                        </form>
                    </fieldset>

                    <fieldset class="fieldset1">
                        <form action="apresChoixPublicite.jsp" method="post"  name="frmchx">
                            <div style="overflow:scroll;width:750px;" >
                                <input type="hidden" name="champReturn" value="<%=champReturn%>">
                                <table align="center" class="monographe" width="100%">
                                    <tr>
                                        <td>-</td>
                                        <td>Id</td>
                                        <td>Client</td>
                                        <td>Mont</td>
                                        <td>Catégorie</td>
                                        <td>Agence</td>
                                        <td>Parution</td>
                                        <td>Numéro Page</td>
                                        <td>Désignation</td>
                                        <td>NumBc</td>
                                        <td>Remarque</td>
                                        <td>Numéro pièce</td>
                                        <td>Formulaire</td>
                                        <td>Page</td>
                                        <td>Montant</td>
                                        <td>Remis</td>

                                    </tr>
                                    <%
                                        for (int i = 0; i < pub.length; i++) {
                                            // lcd = u.findLC(lcamenag[i].getIdLigne(),"%","%","%","%","%","%","%","%", "%","%","%","%","%","%")[0];


                                    %>
                                    <tr>
                                        <td><input type="radio" name="idPublicite" onMouseDown="getChoix()" value="<%=pub[i].getId()%>" class="radio" /></td>
                                        <td><%=pub[i].getId()%> </td>
                                        <td><%=pub[i].getIdClient()%>  </td>
                                        <td><%=pub[i].getIdMont()%></td>
                                        <td><%=pub[i].getIdCat()%></td>
                                        <td><%=pub[i].getIdAgence()%></td>
                                        <td><%=pub[i].getIdParution()%></td>
                                        <td><%=pub[i].getNumPage()%></td>
                                        <td><%=pub[i].getDesignation()%></td>
                                        <td><%=pub[i].getNumBc()%></td>
                                        <td><%=pub[i].getRemarque()%></td>
                                        <td><%=pub[i].getNumPiece()%></td>
                                        <td><%=pub[i].getFormulaire()%></td>
                                        <td><%=pub[i].getPagemisyazy()%></td>
                                        <td><%=pub[i].getMontant()%></td>
                                        <td><%=pub[i].getRemis()%></td>

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
                                            <a href="listeChoixPublicite.jsp?id=<%=Utilitaire.remplacePourcentage(id)%>&idClient=<%=Utilitaire.remplacePourcentage(idClient)%>&idMont=<%=Utilitaire.remplacePourcentage(idMont)%>&idCat=<%=Utilitaire.remplacePourcentage(idMont)%>&idAgence=<%=Utilitaire.remplacePourcentage(idMont)%>&idParution=<%=Utilitaire.remplacePourcentage(idMont)%>&designation=<%=Utilitaire.remplacePourcentage(idMont)%>&remarque=<%=Utilitaire.remplacePourcentage(idMont)%>&numPiece=<%=Utilitaire.remplacePourcentage(idMont)%>&pazy=<%=pazy - 1%>">&lt;&lt;Page
                                                pr&eacute;c&eacute;dente</a>
                                                <%

                                                    }
                                                    pazy = pazy + 1;
                                                %></td>
                                        <td width="305" align="right">
                                            <%
                                                if (pazy < nbPage) {
                                            %>
                                            <a href="listeChoixPublicite.jsp?id=<%=Utilitaire.remplacePourcentage(id)%>&idClient=<%=Utilitaire.remplacePourcentage(idClient)%>&idMont=<%=Utilitaire.remplacePourcentage(idMont)%>&idCat=<%=Utilitaire.remplacePourcentage(idMont)%>&idAgence=<%=Utilitaire.remplacePourcentage(idMont)%>&idParution=<%=Utilitaire.remplacePourcentage(idMont)%>&designation=<%=Utilitaire.remplacePourcentage(idMont)%>&remarque=<%=Utilitaire.remplacePourcentage(idMont)%>&numPiece=<%=Utilitaire.remplacePourcentage(idMont)%>&pazy=<%=pazy%>">Page
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