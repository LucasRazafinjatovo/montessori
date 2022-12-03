<%@page import="pub.PubConstante"%>
<%@page import="utilitaire.Utilitaire"%>
<html>
    <%
        String champRet = (String) request.getParameter("champReturn");
        String[] choix = request.getParameterValues("choix");
        String[] champs = Utilitaire.split(champRet, ";");
        String resp = "";
        int nombre = choix.length;
    %>
    <script language="JavaScript">
        <%
            for (int i = 0; i < choix.length; i++) {
                resp += choix[i] + ";";
            }
            if (champs[0] != null || champs[0].compareTo("") != 0) {
        %>
        window.opener.document.all.<%=champs[0]%>.value = "<%=resp%>";

        <%
            }
        %>
        window.close();
    </script>
</html>


</html>