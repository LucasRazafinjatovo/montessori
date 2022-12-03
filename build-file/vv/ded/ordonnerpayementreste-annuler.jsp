<%@page import="bean.CGenUtil"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="ded.OrdonnerPayement"%>
<%@page import="ded.OrdonnerPayementReste"%>
<%@page import="user.UserEJB"%>
<%
    String apres = "ded/apresOrdonnerPayement.jsp";
    String lien = null;
    UserEJB u = null;
    OrdonnerPayementReste[] ordonnerPayementReste;

    u = (UserEJB) session.getValue("u");
    lien = (String) session.getValue("lien");
    String datyMin = request.getParameter("datyMin") == null ? Utilitaire.dateDuJour() : request.getParameter("datyMin");
    String datyMax = request.getParameter("datyMax") == null ? Utilitaire.dateDuJour() : request.getParameter("datyMax");
    System.out.println("exp = " + " AND DATY BETWEEN '" + datyMin + "' AND '" + datyMax + "'");
    ordonnerPayementReste = (OrdonnerPayementReste[]) CGenUtil.rechercher(new OrdonnerPayementReste(), null, null, " AND DATY BETWEEN '" + datyMin + "' AND '" + datyMax + "'");
%>
<h1>Liste Ordonner de Payement</h1>
<form action="<%=lien%>?but=ded/ordonnerpayementreste-annuler.jsp" method="post">
    <label for="datyMin">Date Min</label>
    <input type="text" name="datyMin" id="datyMin" value="<%=datyMin%>"/>
    <label for="datyMax">Date Max</label>
    <input type="text" name="datyMax" id="datyMax" value="<%=datyMax%>"/>
    <input type="submit" value="Rechercher" />
</form>
<form action="<%=lien%>?but=<%=apres%>" method="post">
    <table border="0" cellpadding="3" cellspacing="3" align="center" width="100%" class="monographe">
        <thead>
            <tr class="head">
                <th> <input type="checkbox" id="checkBoxAll" onclick="checkAll()" /> </th>
                <th>Id OP</th>
                <th>Date</th>
                <th>Montant</th>
                <th>Payé</th>
                <th>Reste</th>
                <th>Remarque</th>
            </tr>
        </thead>
        <tbody>
            <% for (OrdonnerPayementReste ordonnerPayementResteObjet : ordonnerPayementReste) {%>
            <tr>
                <td> <input type="checkbox" value="<%=ordonnerPayementResteObjet.getId()%>" name="checkIdOP" id="checkIdOP" /> </td>
                <td><a href="<%=lien%>?but=ded/visualiserOP.jsp&id=<%=ordonnerPayementResteObjet.getId()%>"><%=ordonnerPayementResteObjet.getId()%></a></td>
                <td><%=Utilitaire.formatterDaty(ordonnerPayementResteObjet.getDaty())%></td>
                <td align="right"><%=Utilitaire.formaterAr(ordonnerPayementResteObjet.getMontant())%></td>
                <td align="right"><%=Utilitaire.formaterAr(ordonnerPayementResteObjet.getPaye())%></td>
                <td align="right"><%=Utilitaire.formaterAr(ordonnerPayementResteObjet.getReste())%></td>
                <td><input type="text" name="remarque_<%=ordonnerPayementResteObjet.getId()%>" id="remarque_<%=ordonnerPayementResteObjet.getId()%>" /></td>
            </tr>
            <% }%>
        </tbody>
    </table>
    <div align="right">
        <input type="hidden" name="acte" id="acte" value="ANNULATIONOPRESTE" />

        <input type="submit" value="Annuler" />
    </div>
</form>

<script>
    function checkAll() {
        var checkBoxes = document.getElementsByName("checkIdOP");
        for (var i = 0; i < checkBoxes.length; i++) {
            checkBoxes[i].checked = document.getElementById("checkBoxAll").checked;
        }
    }
</script>