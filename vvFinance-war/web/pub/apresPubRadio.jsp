<%-- 
    Document   : apresPubRadio.jsp
    Created on : 12 juin 2017, 16:42:20
    Author     : Alain
--%>
<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="affichage.*" %>
<%@ page import="pub.*" %>
<%@ page import="ded.OrdonnerPayement" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <%!
        UserEJB u = null;
        String acte = null;
        String lien = null;
        finance.Entree entree = null;
    %>
    <%
        acte = request.getParameter("acte");
        try {
            lien = (String) session.getValue("lien");
            u = (UserEJB) session.getAttribute("u");
            if (acte.compareToIgnoreCase("pubor") == 0) {

                String[] lsitepub = request.getParameterValues("id");
                String temp = "";
                for (int k = 0; k < lsitepub.length; k++) {
                    temp += lsitepub[k] + ",";
                }
                session.removeAttribute("pubradio");
                session.setAttribute("pubradio", temp);
                %>
                <script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/ordonnerRecettePub.jsp");</script>
                <%
            }
        } catch (Exception e) {
            e.printStackTrace();
            %>
            <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>");</script>
            <%
            return;
        }
    %>
</html>




