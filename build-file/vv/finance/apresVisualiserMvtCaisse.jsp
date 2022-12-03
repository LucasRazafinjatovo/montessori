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
	 	String montantObjet = null;
		String typeObjet = null;
                String idMvt=null;
%>
<%
  acte      = request.getParameter("acte");
  numObjet  =  request.getParameter("numObjet");
  typeObjet =  request.getParameter("typeObjet");
  montantObjet = request.getParameter("montantObjet");
  idMvt=request.getParameter("idMvt");
%>
<%
  lien	= (String)session.getValue("lien");
  u		= (UserEJB)session.getAttribute("u");

 if(acte.compareToIgnoreCase("detail")==0){

		%>

	        <script language="JavaScript"> document.location.replace("<%=lien%>?but=finance/detailMvtCaisseDepense.jsp&idMvt=<%=idMvt%>"); </script>


<%}

 if(acte.compareToIgnoreCase("viser")==0){

		%>

	        <script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/visaOrdrePayement.jsp&numObjet=<%=numObjet%>&typeObjet=<%=Constante.getObjetOp()%>"); </script>


<%}

 if(acte.compareToIgnoreCase("payer")==0){
%>

	       <script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/mvtCaisse.jsp&numObjet=<%=numObjet%>&typeObjet=<%=Constante.getObjetOp()%>&montantObjet=<%=montantObjet%>"); </script>


<%}
 if(acte.compareToIgnoreCase("vJointureLC")==0){
%>

	       <script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/visualiserDedJointure.jsp&numObjet=<%=numObjet%>&typeObjet=<%=Constante.getObjetMvtCaisse()%>&nature2=<%=Constante.getObjetLcDetail()%>&montantObjet=<%=request.getParameter("montantObjet")%>"); </script>


<%}
 if(acte.compareToIgnoreCase("saisieCheque")==0){
	 %>

	 	       <script language="JavaScript"> document.location.replace("<%=lien%>?but=finance/cheque.jsp&idMvt=<%=numObjet%>"); </script>


	 <%}
 if(acte.compareToIgnoreCase("modif")==0){
	 %>

	 	       <script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/modifierOP.jsp&numObjet=<%=numObjet%>&typeObjet=<%=Constante.getObjetOp()%>&tableJointure=<%=Constante.getOpFactureFournisseur()%>&idDED=<%=request.getParameter("idDED")%>"); </script>


	 <%}
 if(acte.compareToIgnoreCase("UPDATE")==0){
	 %>

	 	       <script language="JavaScript"> document.location.replace("<%=lien%>?but=lc/visualiserOP.jsp&numObjet=<%=numObjet%>&typeObjet=<%=Constante.getObjetOp()%>&tableJointure=<%=Constante.getOpFactureFournisseur()%>"); </script>


	 <%}

 if(acte.compareToIgnoreCase("annuler")==0){
	 u.annulerMvtDepense(numObjet);
	 %>

	 	       <script language="JavaScript"> document.location.replace("<%=lien%>?but=finance/listeMvtCaisse.jsp&numObjet=<%=numObjet%>&typeObjet=<%=Constante.getObjetOp()%>&tableJointure=<%=Constante.getOpFactureFournisseur()%>"); </script>


	 <%}

%>




</html>
