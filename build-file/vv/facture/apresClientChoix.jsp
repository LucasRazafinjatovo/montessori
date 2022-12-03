<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
 
<html>
<%!
	UserEJB u = null;
	String acte = null;
	String lien = null;
	String apres = null;
	facture.Client clt = null;
	String idClient = null;

%>
<%
  acte=request.getParameter("Submit");
%>
<%
	try
	{
	  lien=(String)session.getValue("lien");
           u=(UserEJB)session.getAttribute("u");
	  if (acte.compareTo("Update")==0)
	  {
 String idClient=request.getParameter("idClient");
 String nomClient=request.getParameter("nomClient");
 String idRegime=request.getParameter("idRegime");
 String telephone=request.getParameter("telephone");
 String fax=request.getParameter("fax");
 String adresse =request.getParameter("adresse");
 String numStat =request.getParameter("numStat");
 String nif =request.getParameter("nif");
 String rc =request.getParameter("rc");
 String tp =request.getParameter("tp");
 String quittance=request.getParameter("quittance");
if(idClient==null || idClient.compareTo("")==0) throw new Exception("client invalide");
%>
 <script language="JavaScript"> document.location.replace("<%=lien%>?but=facture/apresClient.jsp&acte=UPDATE&idClient=<%=idClient%>&nomClient=<%=nomClient%>&idRegime=<%=idRegime%>&telephone=<%=telephone%>&fax=<%=fax%>&adresse=<%=adresse%>&numStat=<%=numStat%>&nif=<%=nif%>&rc=<%=rc%>&tp=<%=tp%>&quittance=<%=quittance%>"); </script>
 <%
	   }
           if (acte.compareTo("Insertion")==0)
         {
 String nomClient=request.getParameter("nomClient");
 String idRegime=request.getParameter("idRegime");
 String telephone=request.getParameter("telephone");
 String fax=request.getParameter("fax");
 String adresse =request.getParameter("adresse");
 String numStat =request.getParameter("numStat");
 String nif =request.getParameter("nif");
 String rc =request.getParameter("rc");
 String tp =request.getParameter("tp");
 String quittance=request.getParameter("quittance");
 String comptable=request.getParameter("comptable");
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=facture/apresClient.jsp&acte=INSERT&nomClient=<%=nomClient%>&idRegime=<%=idRegime%>&telephone=<%=telephone%>&fax=<%=fax%>&adresse=<%=adresse%>&numStat=<%=numStat%>&nif=<%=nif%>&rc=<%=rc%>&tp=<%=tp%>&quittance=<%=quittance%>&comptable=<%=comptable%>"); </script>
<%
    }
	}
catch (Exception e){
  %>
                <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
        <%
		return;
}%>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
</html>
