<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<!--FICHIER TOJO And-->
<%!
    UserEJB u;
%>
<%
    String nomtable = request.getParameter("ciblename");
    TypeObjet p = new TypeObjet();
    p.setNomTable(nomtable);
    u = (user.UserEJB) session.getValue("u");
    PageUpdate pc = new PageUpdate(p, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin

    String titre = request.getParameter("ciblename");
    if(titre.compareToIgnoreCase("BUDGET_CATEGORIE_REJET_OP") == 0){
        titre = "Categorie rejet OP";
    }
    
    String val = "Valeur";
    String desce = "Description";

    if (request.getParameter("value") != null && request.getParameter("value").compareToIgnoreCase("") != 0) {
        val = request.getParameter("value");
    }
    if (request.getParameter("description") != null && request.getParameter("description").compareToIgnoreCase("") != 0) {
        desce = request.getParameter("description");
    }

    pc.getFormu().getChamp("val").setLibelle(val);
    pc.getFormu().getChamp("desce").setLibelle(desce);

    pc.preparerDataFormu();

%>
<div class="content-wrapper">
    <section class="content-header">
        <h1><a href="<%=(String) session.getValue("lien")%>?but=configuration/idvaldesce.jsp&ciblename=<%out.print(nomtable);%>&value=<%=val%>&description=<%=desce%>"><i class="fa fa-arrow-circle-left"></i></a> Modification <%out.print(titre);%></h1>
    </section>
    <section class="content">
        <form action="<%=(String) session.getValue("lien")%>?but=configuration/apresIdvaldesce.jsp" method="post" name="configuration" id="idvaldesce">
            <%
                out.println(pc.getFormu().getHtmlInsert());
            %>
            <input class="btn btn-warning" type="submit" name="Submit2" value="Modifier" class="submit">

            <input class="btn btn-danger" type="submit" name="Submit2" value="Supprimer" class="submit" onclick="acte.value = 'delete'">
            <input name="acte" type="hidden" id="acte" value="update">
            <input name="nomtable" type="hidden" id="nomtable" value="<%=nomtable%>">
            <input name="bute" type="hidden" id="bute" value="configuration/idvaldesce.jsp&ciblename=<%=nomtable%>&value=<%=val%>&description=<%=desce%>">
            <input name="classe" type="hidden" id="classe" value="bean.TypeObjet">
        </form>
    </section>
</div>
