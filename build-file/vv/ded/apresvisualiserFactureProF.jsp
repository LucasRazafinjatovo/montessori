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


 if(acte.compareToIgnoreCase("jDed")==0){
		%>

	        <script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/listeChoixDed.jsp&numObjet=<%=numObjet%>&typeObjet=<%=typeObjet%>&montantObjet=<%=montantObjet%>&nature2=<%=Constante.getObjetDed()%>"); </script>


<%}

 if(acte.compareToIgnoreCase("vDed")==0){
%>

	       <script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/visualiserDedJointure.jsp&numObjet=<%=numObjet%>&typeObjet=<%=typeObjet%>&montantObjet=<%=montantObjet%>"); </script>


<%}
 if(acte.compareToIgnoreCase("detail")==0){
%>

	       <script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/detailGen.jsp&numObjet=<%=numObjet%>&nature=<%=Constante.getObjetBc()%>&tableDet=<%=Constante.getObjectDetailFPF()%>"); </script>


<%}


%>




</html>
