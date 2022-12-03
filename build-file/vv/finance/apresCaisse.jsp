<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
       // String apres="facture/apresAnnulerFacture.jsp";
        String lien= null;
        UserEJB u = null;
		Caisse caiss = null;
        String acte = null;
		String idCaisse = null;

%>
<%
idCaisse =request.getParameter("idCaisse");

  acte=request.getParameter("acte");
        try
        {
           lien=(String)session.getValue("lien");
           u=(UserEJB)session.getAttribute("u");
          if (acte.compareTo("UPDATE")==0)
          {
            System.out.println(idCaisse+request.getParameter("caisse")+request.getParameter("responsable")+request.getParameter("idEtat"));
            u.updateCaisse(idCaisse,request.getParameter("caisse"),request.getParameter("responsable"),request.getParameter("idEtat"));
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=finance/listeCaisse.jsp"); </script>
	    <%
           }
          if (acte.compareTo("INSERT")==0)
          {//System.out.println("cccccccccccccccccccccccccccc"+idCaisse+request.getParameter("caisse")+request.getParameter("responsable")+request.getParameter("comptable"));
           			 u.createCaisseComptable(request.getParameter("caisse"),request.getParameter("responsable"),request.getParameter("comptable"));
     %>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=finance/listeCaisse.jsp"); </script>
	    <%
          }
          if (acte.compareTo("DELETE")==0)
          {
            //u.deleteBeneficiaire(request.getParameter("idBeneficiaire"));
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
