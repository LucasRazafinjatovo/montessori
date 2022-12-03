<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<%!
        UserEJB u = null;
        String acte=null;
        String lien=null;
        String type=null;
        //finance.Entree entree = null;

%>
<%
acte=request.getParameter("acte");
type=request.getParameter("type");
System.out.print(type);
        try
        {
          lien=(String)session.getValue("lien");
          u=(UserEJB)session.getAttribute("u");
          if(acte.compareToIgnoreCase("update")==0)
          {
            if(type.compareToIgnoreCase("prise")==0){
              u.updateTypeVente(type,request.getParameter("daty"),request.getParameter("nbre"),request.getParameter("id"),request.getParameter("publicat"),request.getParameter("vendeur"),request.getParameter("idPrix"));
            }
            else {
              u.updateTypeVente(type,request.getParameter("daty"),request.getParameter("nbre"),request.getParameter("id"),request.getParameter("publicat"),request.getParameter("vendeur"));
            }
          %>
          <script language="JavaScript"> document.location.replace("<%=lien%>?but=ventegazety/updateAdminGestionVente.jsp&type=<%=type%>"); </script>
          <%
          }
          else if(acte.compareToIgnoreCase("livraisonMultiple")==0){
            u.livraisonMultipleAbonne(request.getParameterValues("id"), request.getParameter("coursier"));
          %>
          <script language="JavaScript"> document.location.replace("<%=lien%>?but=ventegazety/livraison-liste.jsp&type=<%=type%>"); </script>
          <%
          }

          else
          {

          }
        }catch (Exception e){
e.printStackTrace();
 %>

<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
                <%
                return;
                }
                %>

</html>




