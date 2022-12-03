<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="java.sql.Date" %>
<%
	UserEJB u = null;
	String date = null;
	String acte = null;
	String lien = null;
	String dateDebut = null;
	String dateFin = null;
	String idClient = null;
	String note = null;
	String idDeviseEn = null;
	String idFactureEn = null;
	String idTva = null;
	String reduction = null;
	String dateLimite = null;
	String idCategorie = null;
	String idFactMere = null;
	String montantAPayer = null;
	String idScatServ = null;
	String idCoursChange = null;
	String dateLimitePaiement = null;
	String idTypePaie=null;
	String entite=null;
	String parution=null;
	String agence=null;
	String actee = null;
	String idFact = null;
	String designation = null;
	String qte = null;
	String idUnite = null;
	String pu = null;

	facture.FactMere fm = null;
	facture.FactureFille ff[]= null;


	date = request.getParameter("date");
	idClient = request.getParameter("idClient");
	dateDebut = request.getParameter("dateDebut");
	dateFin = request.getParameter("dateFin");
	note = request.getParameter("note");
	idDeviseEn = "Ar";
	idFactureEn = "Ar";
	reduction = "0";
	idTva = "20";
	idCategorie = "scat12";
	idTypePaie = "typ02";
	agence = "agb24";
	entite = "BE011";
	parution = "";
	idUnite = "unt1";

	designation = request.getParameter("designation");
	qte = request.getParameter("quantite");
	pu = request.getParameter("prixunit");
	reduction = "0";


	try{
        u=(UserEJB)session.getValue("u");
        lien=(String)session.getValue("lien");
		idFactMere=u.createFactureMere(date, dateDebut,dateFin,idClient, note, idTva, idFactureEn,idDeviseEn,reduction,idCategorie,idTypePaie,agence,entite,parution);
		u.createFactureFille(idFactMere,idCategorie,designation,qte,idUnite,pu,reduction);

		fm = u.findFactureMere("","",idFactMere,"%","","%","%","%")[0];
		//ff=u.findFactureFille("%","%","%",idFactMere);
		idFact=u.finaliseFactureUpdate(idFactMere,date,dateDebut,dateFin, idClient, note,idTva,idFactureEn,idDeviseEn, reduction, fm.getIdSCatService(),idTypePaie);

		%>
		<script language="javascript">
			document.location.replace("<%=lien%>?but=facture/detailFacture.jsp&idFactureMere=<%=idFact%>");
		</script>
		<%

	}catch(Exception e){
		e.printStackTrace();
		%>
        <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
        <%
    }
%>