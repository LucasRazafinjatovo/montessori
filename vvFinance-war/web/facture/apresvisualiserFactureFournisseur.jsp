<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.*" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<%!
        UserEJB u 			= null;
		String lien  		= null;
		String acte 		= null;
	 	String numObjet = null;
		String typeObjet = null;
                String montantObjet=null;
%>
<%
  acte      = request.getParameter("acte");
  numObjet  =  request.getParameter("numObjet");
  typeObjet =  request.getParameter("typeObjet");
  montantObjet =  request.getParameter("montantObjet");
  System.out.println("acte="+acte);
%>
<%
  lien	= (String)session.getValue("lien");
  u		= (UserEJB)session.getAttribute("u");


 if(acte.compareToIgnoreCase("jOP")==0){
		%>

	        <script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/listeChoixOP.jsp&numObjet=<%=numObjet%>&typeObjet=<%=typeObjet%>&montantObjet=<%=montantObjet%>&nature2=<%=Constante.getObjetDed()%>"); </script>


<%}

 if(acte.compareToIgnoreCase("vOP")==0){
%>

	       <script language="JavaScript"> document.location.replace("<%=lien%>?but=lc/apresChoixListeLC.jsp&idLC=&numObjet=<%=numObjet%>&typeObjet=<%=typeObjet%>&montantObjet=<%=montantObjet%>"); </script>


<%}
 if(acte.compareToIgnoreCase("detail")==0){
%>

	       <script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/detailGen.jsp&numObjet=<%=numObjet%>&nature=<%=Constante.getObjectDetailFPF()%>&tableDet=<%=Constante.getObjectDetailFPF()%>"); </script>

<%}
 if(acte.compareToIgnoreCase("modifier")==0){
	 %>

	 	       <script language="JavaScript"> document.location.replace("<%=lien%>?but=facturefournisseur/modifierGen.jsp&numObjet=<%=numObjet%>&nature=<%=Constante.getObjetFactureFournisseur() %>&tableDet=<%=Constante.getObjectDetailFPF()%>"); </script>

	 <%}
           if(acte.compareToIgnoreCase("annuler")==0){
                                        %>

                                                       <script language="JavaScript">
                                                         if (confirm("Voulez-vous annuler cette facture ?")) { // Clic sur OK

                     <%
//annulerOp(String nomTable, String nomTableLiaison, String id)
                     u.annulerFact("FACTUREFOURNISSEUR","FACTUREFOURNISSEURLC",numObjet);
                     %>
                     }
                     document.location.replace("<%=lien%>?but=facture/visualiserFactureFournisseur.jsp&idBC=<%=numObjet%>&nature=FactureFournisseur");

                     </script>


	 <%}
%>




</html>
