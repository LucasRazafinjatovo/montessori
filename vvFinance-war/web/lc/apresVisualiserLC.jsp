<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.*" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<%!
        UserEJB u 			= null;
		String lien  		=null;
		String acte 		= null;
	 	String numObjet   = null;
%>
<%
  acte=request.getParameter("acte");
  
  numObjet=request.getParameter("numobjet");
%>
<%
  lien	= (String)session.getValue("lien");
  u		= (UserEJB)session.getAttribute("u");
 

 if(acte.compareToIgnoreCase("LC")==0){ 
	%>
   <script language="JavaScript">
        window.opener.document.all.idLigneACopier.value = "<%=request.getParameter("choix")%>";
        window.opener.document.all.idLigneACopier.readonly=true;
        window.close();
 </script>

	<%
 }
 if(acte.compareToIgnoreCase("detail")==0){
	 System.out.println("acte="+acte);
		%>
	   
	        <script language="JavaScript"> document.location.replace("<%=lien%>?but=lc/saisieDetailLC.jsp&numObjet=<%=numObjet%>"); </script>


<%} 
 if(acte.compareToIgnoreCase("modif")==0){ 
%>

	       <script language="JavaScript"> document.location.replace("<%=lien%>?but=lc/modifierLC.jsp&numObjet=<%=numObjet%>"); </script>


<%}  
if(acte.compareToIgnoreCase("dupliquer")==0){ 
%>
	<script language="JavaScript"> document.location.replace("<%=lien%>?but=lc/dupliquerLC.jsp&numObjet=<%=numObjet%>&classeLC=LigneCredit&apresDupl=listeLC2"); </script>
<%}  
%>
</html>
