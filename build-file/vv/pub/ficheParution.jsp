<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="pub.*" %>

<%
    Parution p = new Parution();
    p.setNomTable("parutionlibelle");
    PageConsulte pc = new PageConsulte(p, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
    p = (Parution) pc.getBase();
%>
<html>
    <h1>Consultation d'une parution</h1>
    <form action="<%=(String) session.getValue("lien")%>?but=pub/apresPub.jsp&id=<%=request.getParameter("id")%>" method="post" name="fichePub" id="listePub">
        <%
            out.println(pc.getHtml());
        %>
        <a href="<%=(String) session.getValue("lien")%>?but=pub/parution-modif.jsp&id=<%=request.getParameter("id")%>">Modifier</a>

    </form>
</html>
