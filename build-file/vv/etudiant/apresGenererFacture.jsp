<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="affichage.*" %>
<%@ page import="etudiant.*" %>
<html>
<%!
    UserEJB u = null;
    String acte=null;
    String lien=null;
    String bute;
    String classe;
    String rajoutLien="";
%>
<%
    try {
        lien=(String)session.getValue("lien");
        u=(UserEJB)session.getAttribute("u");
        acte=request.getParameter("acte");
        bute=request.getParameter("bute");
        classe=request.getParameter("classe");
        if(acte.compareToIgnoreCase("generer")==0)
        {
            String[] etudiants = request.getParameterValues("id");
            int moismin =Integer.parseInt(request.getParameter("moismin"));
            int moismax =Integer.parseInt(request.getParameter("moismax"));
            int annee=Integer.parseInt(request.getParameter("annee"));
            
            for(int i=0;i<etudiants.length;i++)
            {
                for(int j=moismin;j<=moismax;j++)
                {
                FactureMere factureMere=new FactureMere();
                factureMere.setIdetudiant(etudiants[i]);
                factureMere.setMois(j);
                factureMere.setAnnee(annee);
                factureMere.genererEcolage(u.getUser().getTuppleID());
                }
            }
           
        }
    
%>
        <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute+rajoutLien%>"); </script>
<%

    }catch (Exception e){
%>
        <script language="JavaScript"> alert('<%=e.getMessage()%>');history.back(); </script>
<%
        e.printStackTrace();
    }
%>

</html>
