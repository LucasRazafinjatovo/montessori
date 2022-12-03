
<%@page import="finance.Caisse"%>
<%@page import="bean.CGenUtil"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="finance.Rib"%>
<%@page import="finance.MvtCaisseTous"%>
<%@page import="user.UserEJB"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%
    UserEJB u = (user.UserEJB) session.getValue("u");
    String numpageGl = request.getParameter("numPagGl");
    String numpageRl = request.getParameter("numPagRl");
    if (numpageGl == null) {
        numpageGl = "1";
    }
    if (numpageRl == null) {
        numpageRl = "1";
    }
    MvtCaisseTous gl = new MvtCaisseTous();
    gl.setNomTable("MVTNONRAPPROCHE");
    Rib rr = new Rib();
    rr.setNomTable("RIBNONRAPPROCHE");
    String lien = (String) session.getValue("lien");
    String listeCrtgl[] = {"daty"};
    String listeIntgl[] = {"daty"};
    String libEntetegl[] = {"id", "daty", "designation", "numcheque", "debit", "credit"};
    PageRecherche pr = new PageRecherche(gl, request, listeCrtgl, listeIntgl, 6);
    String listeCrtReleve[] = {"daty"};
    String listeIntReleve[] = {"daty"};
    String libEnteteReleve[] = {"id", "daty", "designation", "numcheque", "debit", "credit"};
    PageRecherche prrr = new PageRecherche(rr, request, listeCrtReleve, listeIntReleve, 6);
    pr.setUtilisateur(u);
    pr.setLien(lien);
    pr.setApres("finance/rapprochementMatching.jsp");
    prrr.setUtilisateur((user.UserEJB) session.getValue("u"));
    prrr.setLien((String) session.getValue("lien"));
    prrr.setApres("finance/rapprochementMatching.jsp");
    String[] colSommegl = null;
    String[] colsommeReleve = null;
    String id = (request.getParameter("idcaisse") == null || request.getParameter("idcaisse").compareToIgnoreCase("") == 0) ? "" : request.getParameter("idcaisse");
    if (id != null && id.compareToIgnoreCase("") != 0) {
        session.setAttribute("idcaisse", id);
    }
    //parametre de recherche grand livre
    Rib[] lrr = null;
    MvtCaisseTous[] lgrl = null;
    if (numpageGl != null && numpageGl.compareToIgnoreCase("") != 0 && numpageRl == null) {
        pr.setNumPage(Utilitaire.stringToInt(numpageGl));
    } else if (numpageGl == null && numpageRl != null && numpageRl.compareToIgnoreCase("") != 0) {
        prrr.setNumPage(Utilitaire.stringToInt(numpageRl));
    } else if (numpageGl != null && numpageGl.compareToIgnoreCase("") != 0 && numpageRl != null && numpageRl.compareToIgnoreCase("") != 0) {
        pr.setNumPage(Utilitaire.stringToInt(numpageGl));
        prrr.setNumPage(Utilitaire.stringToInt(numpageRl));
    }
    String whereRR = "";
    String whereGL = "";
    String designation = request.getParameter("designation");
    String numcheque = request.getParameter("numcheque");
    String date1 = request.getParameter("daty1");
    String date2 = request.getParameter("daty2");
    if(designation!=null && designation.compareToIgnoreCase("")!=0)
    {
       whereRR=whereRR + " AND designation LIKE '%" + designation + "%'";
       whereGL = whereGL + " AND designation LIKE '%" + designation + "%'";
    }

   if(numcheque != null && numcheque.compareToIgnoreCase("")!=0)
   {
     whereRR = whereRR + " AND numcheque LIKE '%" + numcheque + "%'" ;
     whereGL = whereGL + " AND numpiece LIKE '%" + numcheque + "%'";
   }
   if(date1 != null && date1.compareToIgnoreCase("")!=0)
   {
     whereRR = whereRR + " AND daty >=  '"+date1+"' " ;
     whereGL = whereGL + " AND daty >=  '"+date1+"' " ;
   }
   if(date2 != null && date2.compareToIgnoreCase("")!=0)
   {
     whereRR= whereRR + " AND daty <=  '"+date2+"' ";
     whereGL =  whereGL + " AND daty <=  '"+date2+"' ";
   }
    String idcaisse = (String) session.getAttribute("idcaisse");
    pr.setAWhere(whereGL + " and idcaisse='" + idcaisse + "'");
    prrr.setAWhere(whereRR + " and caisse='" + idcaisse + "'");
    prrr.setNpp(200);
    prrr.creerObjetPage(libEnteteReleve, colsommeReleve);
    lrr = (Rib[]) prrr.getTableau().getData();
    pr.setNpp(200);
    pr.creerObjetPage(libEntetegl, colSommegl);
    lgrl = (MvtCaisseTous[]) pr.getTableau().getData();
    Caisse[] liste = (Caisse[]) CGenUtil.rechercher(new Caisse(), null, null, "");

%>
<form action="<%=lien%>?but=finance/rapprochementMatching.jsp" method="post" id="caisse">
    <table class="monographe" align="center" border="0" cellpadding="2" cellspacing="2" width="100%">
        <tr>
            <td>
                <label for="designation" tableindex="1">Designation</label>
                <input id="designation" class="form-control" type="text" value="<%=Utilitaire.champNull(designation)%>" name="designation">
            </td>
            <td>
            <label for="numcheque" tableindex="1">Numero Cheque</label>
            <input id="numcheque" class="form-control" type="text" value="<%=Utilitaire.champNull(numcheque)%>" name="numcheque">
           </td>
        </tr>
        <tr>
            <td>
                <label for="daty1" tableindex="1">Date min</label>
                <input id="daty1" class="form-control" type="text" value="<%=Utilitaire.champNull(date1)%>" name="daty1">
            </td>
            <td>
            <label for="daty2" tableindex="1">Date max</label>
            <input id="daty2" class="form-control" type="text" value="<%=Utilitaire.champNull(date2)%>" name="daty2">
           </td>
        </tr>
        <tr>
            <td></td>
            <td>
                <input id="submt" type="submit" value="Afficher" />
            </td>
        </tr>
    </table>
    <select id="idcaisse" name="idcaisse" onchange="changerDesignation()">

        <% if (liste != null || liste.length > 0) {
                for (int i = 0; i < liste.length; i++) {
                    if (id != null && id != "" && id.compareToIgnoreCase(liste[i].getIdCaisse()) == 0) {%>
        <option value="<%=liste[i].getIdCaisse()%>" selected ><%= liste[i].getDescCaisse()%></option>
        <%
        } else {
        %>
        %>
        <option value="<%=liste[i].getIdCaisse()%>"><%= liste[i].getDescCaisse()%></option>
        <%}%>
        <%}
            }%>
    </select>
</form>
<form id="formLettrage" action="<%=lien%>?but=finance/apresTarifRappro.jsp" method="post">
    <div>
        <div style="float:left">
            <table id="table-compte" border="1" style="overflow-x:scroll">
                <thead>
                    <tr>
                        <th style='background-color:#FFFFFF' colspan="7"><h3 class="box-title" style="text-align: center;">Mouvement de caisse</h3>
                </th>
                </tr>
                <tr>
                    <th style='background-color:#0099FF'>ID</th>
                    <th style='background-color:#0099FF'>Date</th>
                    <th style='background-color:#0099FF'>Designation</th>
                    <th style='background-color:#0099FF'>Numéro cheque</th>
                    <th style='background-color:#0099FF'>Débit</th>
                    <th style='background-color:#0099FF'>Crédit</th>
                    <th style='background-color:#0099FF'><input onclick="CocheTout(this, 'manuelgl');" type="checkbox"></th>
                </tr>

                </thead>
                <tbody id="container-tab-compte">
                    <%for (int i = 0; i < lgrl.length; i++) {

                    %>

                    <tr>
                        <td> <a href="?but=finance/rapprochrMvtCaisse.jsp&id=<%= lgrl[i].getId()%>"> <%out.print(lgrl[i].getId());%> </a></td>
                        <td><% out.print(Utilitaire.formatterDaty(lgrl[i].getDaty()));%></td>
                        <td><%out.print(lgrl[i].getDesignation());%></td>
                        <td><%out.print(Utilitaire.champNull(lgrl[i].getNumpiece()));%></td>
                        <td id="debit-<%out.print(i + 1);%>"><%out.print(Utilitaire.formaterAr(lgrl[i].getDebit())); %></td>
                        <td id="credit-<%out.print(i + 1);%>"><%out.print(Utilitaire.formaterAr(lgrl[i].getCredit()));%></td>
                        <td><input type="checkbox" name="manuelgl" id="manuelgl" value="<%out.print(lgrl[i].getId());%>"></td>
                    </tr>

                    <%/*System.out.println(lgrl[i].getId());*/

                        }%>
                </tbody>
            </table>
            <table border=0 cellpadding=0 cellspacing=0 align=center width='100%'>
                <tr>
                    <td height=25><b>Nombre de r&eacute;sultat :</b><% out.print(Utilitaire.formaterSansVirgule(pr.getRs().getSommeEtNombre()[pr.getNombreColonneSomme()]));%></td><td align='right'><strong>page</strong> <%=pr.getNumPage()%><b>sur</b> <%=pr.getNombrePage()%></td>
                    </td>
                </tr>
                <tr>
                    <td width=50% valign='top' height=25>
                        <%  if (pr.getNumPage() > 1) {%>
                        <a href="<%=pr.getLien()%>?but=<%=pr.getApres()%>&numPagRl=<%=numpageRl%>&numPagGl=<%out.print(String.valueOf(pr.getNumPage() - 1));%>&designation=<%=Utilitaire.champNull(designation)%>&numcheque=<%=Utilitaire.champNull(numcheque)%>">&lt;&lt;Page pr&eacute;c&eacute;dente</a>
                        <%;
                            }%>
                    </td>
                    <td width=50% align=right>
                        <% if (pr.getNumPage() < pr.getNombrePage()) {%>
                        <a href="<%=pr.getLien()%>?but=<%=pr.getApres()%>&numPagRl=<%=numpageRl%>&numPagGl=<%out.print(String.valueOf(pr.getNumPage() + 1));%>&designation=<%=Utilitaire.champNull(designation)%>&numcheque=<%=Utilitaire.champNull(numcheque)%>">Page suivante&gt;&gt;</a>
                        <% ;
                            }%>
                    </td>
                </tr>
            </table>
        </div>
        <div style="float: left;">
            <table id="table-banque" border="1" style="overflow-x:scroll">
                <thead>
                    <tr>
                        <th style='background-color:#FFFFFF' colspan="7">
                <h3 class="box-title" style="text-align: center;">RIB</h3>
                </th>

                </tr>
                <th style='background-color:#0099FF'>ID</th>
                <th style='background-color:#0099FF'>Date</th>
                <th style='background-color:#0099FF'>Designation</th>
                <th style='background-color:#0099FF'>Numéro cheque</th>
                <th style='background-color:#0099FF'>Débit</th>
                <th style='background-color:#0099FF'>Crédit</th>
                <th style='background-color:#0099FF'><input onclick="CocheTout(this, 'manuelr');" type="checkbox"></th>
                </thead>
                <tbody id="container-tab-releve">

                    <%
                        for (int i = 0; i < lrr.length; i++) {
                    %>

                    <tr>
                        <td> <a href="?but=finance/ficheRibnonr.jsp&id=<%= lrr[i].getId()%>"> <%out.print(lrr[i].getId());%> </a></td>
                        <td> <%out.print(Utilitaire.formatterDaty(lrr[i].getDaty()));%></td>
                        <td> <%out.print(lrr[i].getDesignation());%></td>
                        <td> <%out.print(Utilitaire.champNull(lrr[i].getNumcheque()));%></td>
                        <td id="debit2-<%out.print(i + 1);%>"> <%out.print(Utilitaire.formaterAr(lrr[i].getDebit()));%></td>
                        <td id="credit2-<%out.print(i + 1);%>"> <%out.print(Utilitaire.formaterAr(lrr[i].getCredit()));%></td>
                        <td><input type="checkbox" id="manuelr" name="manuelr" value="<%out.print(lrr[i].getId());%>"> </td>
                    </tr>
                    <%
                        ;
                        }

                    %>

                </tbody>
            </table>
            <table border=0 cellpadding=0 cellspacing=0 align=center width='100%'>
                <tr>
                    <td height=25><b>Nombre de r&eacute;sultat :</b><% out.print(Utilitaire.formaterSansVirgule(prrr.getRs().getSommeEtNombre()[prrr.getNombreColonneSomme()]));%></td><td align='right'><strong>page</strong> <%=prrr.getNumPage()%> <b>sur</b> <%=prrr.getNombrePage()%></td>
                    </td>
                </tr>
                <tr>
                    <td width=50% valign='top' height=25>
                        <%  if (prrr.getNumPage() > 1) {%>
                        <a href="<%=prrr.getLien()%>?but=<%=prrr.getApres()%>&numPagGl=<%=numpageGl%>&numPagRl=<%out.print(String.valueOf(prrr.getNumPage() - 1));%>&designation=<%=Utilitaire.champNull(designation)%>&numcheque=<%=Utilitaire.champNull(numcheque)%>">&lt;&lt;Page pr&eacute;c&eacute;dente</a>
                        <%;
                            }%>
                    </td>
                    <td width=50% align=right>
                        <% if (prrr.getNumPage() < prrr.getNombrePage()) {%>
                        <a href="<%=prrr.getLien()%>?but=<%=prrr.getApres()%>&numPagGl=<%=numpageGl%>&numPagRl=<%out.print(String.valueOf(prrr.getNumPage() + 1));%>&designation=<%=Utilitaire.champNull(designation)%>&numcheque=<%=Utilitaire.champNull(numcheque)%>">Page suivante&gt;&gt;</a>
                        <% ;
                            }%>
                    </td>
                </tr>
            </table>
        </div>
                    <div style="clear:both">
        <table style="float:left;">
            <input name="acte" type="hidden" id="acte" value="">
            <input name="bute" type="hidden" id="bute" value="finance/rapprochementMatching.jsp">
            <input name="classe" type="hidden" id="classe" value="">
            <tr>
                <td><a onclick="rapprocher()" href="#" style="margin-center:10px; background-color: #0099FF">rapprocher</a></td>

                <td><a onclick="lettrerAuto()" href="#" style="margin-center:10px; background-color: #0099FF">rapprocher Auto</a></td>
            </tr>
        </table>
                    </div>
    </div>




</form>

<script>
    function rapprocher() {
        $("#acte").val("rapprocher");
        document.forms["formLettrage"].submit();

    }
    function lettrerAuto()
    {
        $("#acte").val("rapprocherAuto");
        document.forms["formLettrage"].submit();
        //document.location.reload();
    }
    function changerDesignation() {
        document.getElementById('caisse').submit();
        //document.caisse.submit();
    }
    function CocheTout(ref, name)
    {
        var form = ref;
        while (form.parentNode && form.nodeName.toLowerCase() != 'form') {
            form = form.parentNode;
        }

        var elements = form.getElementsByTagName('input');

        for (var i = 0; i < elements.length; i++) {
            if (elements[i].type == 'checkbox' && elements[i].name == name) {
                elements[i].checked = ref.checked;
            }
        }
    }
</script>


</body>
</html>
