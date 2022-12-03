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
  System.out.println(" \n acte ============================== " + acte);
%>
<%
	try
	{
		lien=(String)session.getValue("lien");
        u=(UserEJB)session.getAttribute("u");
			if (acte.compareTo("Update")==0){
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
				u.updateClient(request.getParameter("idClient"),request.getParameter("nomClient"),request.getParameter("idRegime"),request.getParameter("telephone"),request.getParameter("fax"),request.getParameter("adresse"),request.getParameter("numStat"),request.getParameter("nif"),request.getParameter("rc"),request.getParameter("tp"),request.getParameter("quittance"));
%>
				<script language="JavaScript"> document.location.replace("<%=lien%>?but=facture/listeClient.jsp"); </script>
 <%
			}
           if (acte.compareTo("Insertion")==0){
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
				String typecontact=request.getParameter("typecontact");
				String soustypecontact=request.getParameter("soustypecontact");
				u.createClientComptable(request.getParameter("nomClient"),request.getParameter("idRegime"),request.getParameter("telephone"),request.getParameter("fax"),request.getParameter("adresse"),request.getParameter("numStat"),request.getParameter("nif"),request.getParameter("rc"),request.getParameter("tp"),request.getParameter("quittance"),request.getParameter("comptable"), typecontact, soustypecontact);
%>
				<script language="JavaScript"> document.location.replace("<%=lien%>?but=facture/listeClient.jsp"); </script>		
<%
			}
	}
	catch (Exception e){
%>
                <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
		return;
	}
%>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
</html>
