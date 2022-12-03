<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="facture/apresAnnulerFacture.jsp";
        String lien= null;
        UserEJB u = null;
	String idBen = null;
        String acte = null;

%>
<%

%>
<%
  acte=request.getParameter("acte");
      try
        {
          u=(user.UserEJB)session.getValue("u");
          lien=(String)session.getValue("lien");
          idBen = request.getParameter("idBen");
           u=(UserEJB)session.getAttribute("u");
          if (acte.compareTo("UPDATE")==0)
          {
            u.updateTypeObjet("beneficiaire",idBen,request.getParameter("nom"),request.getParameter("description"));
           %>
  <script language="JavaScript"> document.location.replace("<%=lien%>?but=finance/listeBeneficiaire.jsp"); </script>
  <%
           }
          if (acte.compareTo("INSERT")==0)
          {
              u.createBeneficiaireCompta(request.getParameter("nom"),request.getParameter("description"),request.getParameter("comptable"));

           %>
          <script language="JavaScript"> document.location.replace("<%=lien%>?but=finance/listeBeneficiaire.jsp"); </script>
        <%
          }
          if (acte.compareTo("DELETE")==0)
          {

            //u.deleteTypeObjet("beneficiaire",request.getParameter("idBen"));
           %>
  <script language="JavaScript"> document.location.replace("<%=lien%>?but=finance/listeBeneficiaire.jsp"); </script>
  <%
          }
        }
        catch (Exception e)
        {%>
                <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
                <%return;
        }
%>
