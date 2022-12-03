<%@page import="utilitaire.Utilitaire"%>
<%@page import="ded.OrdonnerPayement"%>
<%@page import="ded.OrdonnerPayementReste"%>
<%@page import="user.UserEJB"%>
<%!
  String apres="ded/apresOrdonnerRecette.jsp";
  String lien= null;
  UserEJB u = null;
  OrdonnerPayementReste[] ordonnerPayementReste;
 %>
<%
    u=(UserEJB)session.getValue("u");
    lien=(String)session.getValue("lien");
    String datyMin = request.getParameter("datyMin")==null?Utilitaire.dateDuJour():request.getParameter("datyMin");
    String datyMax = request.getParameter("datyMax")==null?Utilitaire.dateDuJour():request.getParameter("datyMax");
    OrdonnerPayementReste or=new OrdonnerPayementReste();
    or.setNomTable("ordonnerrecettereste");
    String awhere= "";
    if(datyMin!=null && datyMin.compareToIgnoreCase("")!=0)
    {
        awhere=awhere+" AND DATY BETWEEN '"+ datyMin +"' AND '" + datyMax + "'";
    }
    ordonnerPayementReste = (OrdonnerPayementReste[]) u.getData(or, null, null, null, awhere);
%>
<h1>Liste Recette</h1>
<form action="<%=lien%>" method="get">
    <label for="datyMin">Date Min</label>
    <input type="text" name="datyMin" id="datyMin" value="<%=datyMin%>"/>
    <label for="datyMax">Date Max</label>
    <input type="text" name="datyMax" id="datyMax" value="<%=datyMax%>"/>
    <input type="hidden" name="but" id="but" value="ded/ordonnerrecettereste-annuler.jsp" />
    <input type="submit" value="Rechercher" />
</form>
<form action="<%=lien%>?but=<%=apres%>" method="post">
    <table border="0" cellpadding="3" cellspacing="3" align="center" width="100%" class="monographe">
        <thead>
            <tr class="head">
                <th> <input type="checkbox" id="checkBoxAll" onclick="checkAll()" /> </th>
                <th>Id OR</th>
                <th>Date</th>
                <th>Montant</th>
                <th>Payé</th>
                <th>Reste</th>
                <th>Remarque</th>
            </tr>
        </thead>
        <tbody>
            <% for(OrdonnerPayementReste ordonnerPayementResteObjet : ordonnerPayementReste){ %>
            <tr>
                <td> <input type="checkbox" value="<%=ordonnerPayementResteObjet.getId()%>" name="checkIdOP" id="checkIdOP" /> </td>
                <td><a href="<%=lien%>?but=ded/visualiserOP.jsp&id=<%=ordonnerPayementResteObjet.getId()%>"><%=ordonnerPayementResteObjet.getId()%></a></td>
                <td><%=Utilitaire.formatterDaty(ordonnerPayementResteObjet.getDaty())%></td>
                <td align="right"><%=Utilitaire.formaterAr(ordonnerPayementResteObjet.getMontant())%></td>
                <td align="right"><%=Utilitaire.formaterAr(ordonnerPayementResteObjet.getPaye())%></td>
                <td align="right"><%=Utilitaire.formaterAr(ordonnerPayementResteObjet.getReste())%></td>
                <td><input type="text" name="remarque_<%=ordonnerPayementResteObjet.getId()%>" id="remarque_<%=ordonnerPayementResteObjet.getId()%>" /></td>
            </tr>
            <% } %>
        </tbody>
    </table>
    <div align="right">
        <input type="hidden" name="acte" id="acte" value="ANNULATIONORRESTE" />

        <input type="submit" value="Annuler" />
    </div>
</form>

<script>
    function checkAll(){
        var checkBoxes = document.getElementsByName("checkIdOP");
        for(var i=0;i<checkBoxes.length;i++){
            checkBoxes[i].checked = document.getElementById("checkBoxAll").checked;
        }
    }
</script>