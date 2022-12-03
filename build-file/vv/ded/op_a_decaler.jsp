<%@page import="utilitaire.Utilitaire"%>
<%@page import="ded.OpAAnnuler"%>
<%@page import="affichage.PageRecherche"%>
<% OpAAnnuler lv = new OpAAnnuler();
    String listeCrt[] = {"id", "montant", "montant_paye", "reste"};
    String listeInt[] = {"montant", "montant_paye", "reste"};
    String libEntete[] = {"id", "montant", "montant_paye", "reste"};
    PageRecherche pr = new PageRecherche(lv, request, listeCrt, listeInt, 3, libEntete, 4);
    pr.getFormu().getChamp("montant_paye1").setLibelleAffiche("Montant paye min");
    pr.getFormu().getChamp("montant_paye2").setLibelleAffiche("Montant paye max");
    pr.getFormu().getChamp("montant1").setLibelleAffiche("Montant  min");
    pr.getFormu().getChamp("montant2").setLibelleAffiche("Montant  max");
    pr.getFormu().getChamp("reste1").setLibelleAffiche("Reste  min");
    pr.getFormu().getChamp("reste2").setLibelleAffiche("Reste  max");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));

    pr.setApres("ded/op_a_decaler.jsp");
    String[] colSomme = {"montant", "montant_paye", "reste"};
    pr.setAWhere(" and reste >0");
    pr.creerObjetPage(libEntete, colSomme);
    OpAAnnuler[] listeOp = (OpAAnnuler[]) pr.getTableau().getData();
%>
<section class="content-header">
    <h1>Liste OP a decaler</h1>
</section>
<section class="content">
    <form action="<%=pr.getLien()%>?but=ded/op_a_decaler.jsp" method="post" name="incident" id="incident">
        <%

            out.println(pr.getFormu().getHtmlEnsemble());
        %>

    </form>
    <form action="<%=pr.getLien()%>?but=ded/apresOrdonnerPayement.jsp" method="post" name="incident" id="incident">

        <%
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <table width="100%" border="1" align="center" cellpadding="2" cellspacing="0" class="monographe">
            <thead>
            <th ><input onclick="CocheTout(this, 'idop');" type="checkbox"></th>
            <th >Id</th>
            <th >Montant</th>
            <th >Montant Paye</th>
            <th>Reste</th>
            <th>Date decalage</th>
            </thead>
            <tbody >
                <%for (int i = 0; i < listeOp.length; i++) {

                %>  

                <tr>   
                    <td><input type="checkbox" name="idop" class="check-input" id="check-<%out.print(i + 1);%>" value="<%out.print(listeOp[i].getId());%>"></td>
                    <td><% out.print(listeOp[i].getId());%></td>
                    <td><%out.print(Utilitaire.formaterAr(listeOp[i].getMontant()));%></td>
                    <td><%out.print(Utilitaire.formaterAr(listeOp[i].getMontant_paye()));%></td>
                    <td><%out.print(Utilitaire.formaterAr(listeOp[i].getReste()));%></td>
                    <td><input type="text" onmouseover="datepicker('date_decaler')" name="date_decaler" class="form-control datepicker" value="<%=Utilitaire.dateDuJour()%>"></td>
                </tr>

                <%/*System.out.println(lgrl[i].getId());*/

                                        }%>                      
            </tbody>
        </table>
        <input type="hidden" name="acte" value="decaler">
        <input type="hidden" name="bute" value="ded/op_a_decaler.jsp">
        <input type="submit" name="Submit" value="Decaler" class="submit" />
        <br>
        <%out.println(pr.getBasPage());%>
    </form>
</section>
    <script>
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


