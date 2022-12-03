<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="pub.*" %>

<%
    Publication p = new Publication();
    p.setNomTable("publicationlibelle");
    PageConsulte pc = new PageConsulte(p, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
    Publication[] pub = (Publication[]) CGenUtil.rechercher(p, null, null, " and id='" + request.getParameter("id") + "'");
    p = (Publication) pc.getBase();
%>
<html>
    <h1>Consultation d'une publication</h1>
    <form action="<%=(String) session.getValue("lien")%>?but=pub/apresPub.jsp&id=<%=request.getParameter("id")%>&libJournal=<%=request.getParameter("libJournal")%>" method="post" name="fichePub" id="listePub">
        <%
            out.println(pc.getHtml());
            String dat = Utilitaire.datetostring(pub[0].getDatyParution());
            System.out.print(pub[0].getDatyParution());
            String daty = Utilitaire.datetostring(pub[0].getDaty());
        %>
        <a href="<%=(String) session.getValue("lien")%>?but=pub/publication-modif.jsp&id=<%=request.getParameter("id")%>">Modifier</a>
    </form>
</html>
