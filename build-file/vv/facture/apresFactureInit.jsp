<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<%!
        UserEJB u = null;
        String idTypeFacture=null;
        String lien=null;
        String date= null;
        String dateDebut = null;
        String idClient = null;
        String idFact = null;
        String idPen[] = new String[1];
        historique.MapUtilisateur ut=null;
        String acte = null;
        String reductionFactureProf = null;
%>
<%
  idTypeFacture = request.getParameter("idType");
  idPen[0] = request.getParameter("idPen");
  acte = request.getParameter("acte");
  reductionFactureProf = request.getParameter("reduction");
%>
<%

	try
	{
        lien=(String)session.getValue("lien");
			u=(UserEJB)session.getAttribute("u");
			ut=u.getUser();
			if(request.getParameter("typefact").compareToIgnoreCase("normale")==0){
				if (idTypeFacture.compareTo("scat1")== 0 || idTypeFacture.compareTo("scat2")==0)
				{

					idFact = u.createFactureRedevance(request.getParameter("idClient"),request.getParameter("date"),request.getParameter("dateDebut"),request.getParameter("dateFin"),request.getParameter("idType"));
					if(ut.getIdrole().compareTo("admin")==0 ||ut.getIdrole().compareTo("dg")==0 || ut.getIdrole().compareTo("adminFacture")==0){
						%>
						<script language="JavaScript">
							document.location.replace("<%=lien%>?but=facture/factureFilleAdmin.jsp&idTypeFacture=<%=idTypeFacture%>&idFactMere=<%=idFact%>&action=red");
						</script>
						<%
					}else{
						%>
						<script language="JavaScript">
							document.location.replace("<%=lien%>?but=facture/factureFilleRed.jsp&idFactMere=<%=idFact%>&action=red");
						</script>
						<%
					}
				}
				else if (idTypeFacture.compareTo("scat111") == 0)
				{     
					String idpub = request.getParameter("listepub");
					%>
					<script language="JavaScript"> document.location.replace("<%=lien%>?but=facture/facturePub.jsp&dateFin=<%=request.getParameter("dateFin")%>&dateDebut=<%=request.getParameter("dateDebut")%>&date=<%=request.getParameter("date")%>&idClient=<%=request.getParameter("idClient")%>&idTypeFacture=<%=request.getParameter("idType")%>&agence=<%=request.getParameter("agence")%>&entite=<%=request.getParameter("entite")%>&parution=<%=request.getParameter("parution")%>&acte=<%=acte%>&ttva=<%=request.getParameter("ttva")%>&datyparu=<%=request.getParameter("datyparu")%>&redFProf=<%=reductionFactureProf%>&idpub=<%=idpub%>"); </script>
					<%
				}
				else 
				{     
					String idpub = request.getParameter("idpub");
					System.out.println(" ===================== " + idpub);
					%>
					<script language="JavaScript"> document.location.replace("<%=lien%>?but=facture/factureMere.jsp&dateFin=<%=request.getParameter("dateFin")%>&dateDebut=<%=request.getParameter("dateDebut")%>&date=<%=request.getParameter("date")%>&idClient=<%=request.getParameter("idClient")%>&idTypeFacture=<%=request.getParameter("idType")%>&agence=<%=request.getParameter("agence")%>&entite=<%=request.getParameter("entite")%>&parution=<%=request.getParameter("parution")%>&acte=<%=acte%>&ttva=<%=request.getParameter("ttva")%>&datyparu=<%=request.getParameter("datyparu")%>&redFProf=<%=reductionFactureProf%>&listepub=<%=idpub%>"); </script>
					<%
				}
			}
			else{ %>
                <script language="JavaScript">
					document.location.replace("<%=lien%>?but=facture/factureMereProf.jsp&dateFin=<%=request.getParameter("dateFin")%>&dateDebut=<%=request.getParameter("dateDebut")%>&date=<%=request.getParameter("date")%>&idClient=<%=request.getParameter("idClient")%>&idTypeFacture=<%=request.getParameter("idType")%>&agence=<%=request.getParameter("agence")%>&entite=<%=request.getParameter("entite")%>&parution=<%=request.getParameter("parution")%>");
                </script>
			<%}
        }catch (Exception e){
            e.printStackTrace();
		%>
		<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
	<%
        return;
	}
	%>
<head>
<title>Document sans titre</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
</html>
