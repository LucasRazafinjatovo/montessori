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
%>
<%
  acte     = request.getParameter("acte");
  numObjet =  request.getParameter("numObjet");
  montantObjet=  request.getParameter("montantObjet");
  System.out.println("acte="+acte);
    typeObjet =  request.getParameter("typeObjet");
%>
<%
  lien	= (String)session.getValue("lien");
  u		= (UserEJB)session.getAttribute("u");


 if(acte.compareToIgnoreCase("jLCDetail")==0){
		%>

	        <script language="JavaScript"> document.location.replace("<%=lien%>?but=lc/listeChoixLCDetail.jsp&numObjet=<%=numObjet%>&typeObjet=<%=typeObjet%>&montantObjet=<%=montantObjet%>&nature2=<%=Constante.getObjetLcDetail()%>"); </script>


<%}

 if(acte.compareToIgnoreCase("visa")==0){
%>

	       <script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/visaDED.jsp&numObjet=<%=numObjet%>&typeobjet=<%=Constante.getObjetDed()%>"); </script>


<%}
 if(acte.compareToIgnoreCase("ordonnancer")==0){
%>

	       <script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/ordonnerPayement.jsp&numObjet=<%=numObjet%>&typeObjet=<%=Constante.getObjetDed()%>&idLigne=<%=request.getParameter("idLigne")%>&montantObjet=<%=montantObjet%>"); </script>


<%}
 if(acte.compareToIgnoreCase("modifier")==0){
	 %>

	 	       <script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/modifierDed.jsp&numObjet=<%=numObjet%>&typeObjet=<%=Constante.getObjetDed()%>&idLigne=<%=request.getParameter("idLigne")%>&montantObjet=<%=montantObjet%>"); </script>


	 <%}
 
 if(acte.compareToIgnoreCase("UPDATE")==0){
	 %>

	 	       <script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/visualiserDed.jsp&numObjet=<%=numObjet%>&typeObjet=<%=Constante.getObjetDed()%>&idLigne=<%=request.getParameter("idLigne")%>&montantObjet=<%=montantObjet%>"); </script>


	 <%}

%>




</html>
