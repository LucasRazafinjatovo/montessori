<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="affichage.*" %>
<%@ page import="pub.*" %>
<%@ page import="ded.*" %>
<%@ page import="prevision.*" %>
<%@ page import="finance.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <%
        UserEJB u = null;
        String acte = null;
        String lien = null;
        String bute;
        try {
            lien = (String) session.getValue("lien");
            u = (UserEJB) session.getAttribute("u");
            acte = request.getParameter("acte");
            bute = request.getParameter("bute");

            String classe = request.getParameter("classe");

            int nb = Utilitaire.stringToInt(request.getParameter("nombre"));

            for (int i = 0; i < nb; i++) {
                String zreport = request.getParameter("report" + i);
                if(zreport== null || zreport.compareTo("")==0){
                    break;
                }
                Report report = new Report();
                report.setDaty(Utilitaire.string_date("dd/MM/yyyy", request.getParameter("daty2")));
                report.setDevise("Ar");
                Caisse[] caisses = (Caisse[]) CGenUtil.rechercher(new Caisse(), "select * from caisse where desccaisse like '%"+request.getParameter("caisse" + i)+"%'");
                if (caisses!= null && caisses.length > 0){
                    report.setCaisse(caisses[0].getIdCaisse());
                }
                else{
                    throw new Exception("Caisse non valide");
                }
                report.setMontant(Utilitaire.stringToDouble(request.getParameter("report" + i)));
                u.createObject(report);
            }

    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute%>");</script>
    <%
    } catch (Exception e) {
        e.printStackTrace();
    %>
    <script language="JavaScript"> alert('<%=e.getMessage()%>');history.back();</script>
    <%
            return;
        }
    %>
</html>



