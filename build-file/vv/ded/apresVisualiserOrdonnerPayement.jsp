<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.*" %>
<%@ page import="ded.*" %>
<%@ page import="bean.*" %>
<%@ page import="prevision.*" %>
<%@ page import="ded.OrdonnerPayement" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<%!
	UserEJB u 			= null;
	String lien  		= null;
	String acte 		= null;
	String numObjet = null;
	String montantObjet = null;
	String typeObjet = null;
	OrdonnerPayement op = null;
	%>
	<%
	acte      = request.getParameter("acte");
	numObjet  =  request.getParameter("numObjet");
	typeObjet =  request.getParameter("typeObjet");
	montantObjet = request.getParameter("montantObjet");
	%>
	<%
	lien = (String)session.getValue("lien");
	u = (UserEJB)session.getAttribute("u");
	op = u.findOp(numObjet,"%","%","","","","","%")[0];



	if(acte.compareToIgnoreCase("viser")==0){

		try{
			%>
			<script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/visaOrdrePayement.jsp&numObjet=<%=numObjet%>&typeObjet=<%=Constante.getObjetOp()%>"); </script>
			<%
		}catch(Exception ex){
			ex.printStackTrace();
			%>
			<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=ex.getMessage()%>"); </script>
			<%
		}
	}
	if(acte.compareToIgnoreCase("attachprev")==0){
		%>
		<script language="JavaScript"> document.location.replace("<%=lien%>?but=prevision/listeChoixPrevisionDepense.jsp&numObjet=<%=numObjet%>&typeObjet=<%=Constante.getObjetOp()%>"); </script>
		<%
	}
	if(acte.compareToIgnoreCase("attachcommission")==0){
		%>
		<script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/attacherCommAPayer.jsp&numObjet=<%=numObjet%>&typeObjet=<%=Constante.getObjetOp()%>"); </script>
		<%
	}
	if(acte.compareToIgnoreCase("attach")==0){
		if(op.getVisaFacture()==null)
		{
			%>
			<script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/ventilationOpFfLc.jsp&numObjet=<%=numObjet%>&idDED=<%=request.getParameter("idDED") %>"); </script>
		<%}
		else
		{
			%>
			<script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/ventilationOpFf.jsp&numObjet=<%=numObjet%>&idDED=<%=request.getParameter("idDED") %>"); </script>
		<%}
	}
	if(acte.compareToIgnoreCase("prevision")==0){
		String idprev = request.getParameter("numObjet");
		String remarque = request.getParameter("remarque");
		String montant = request.getParameter("montantObjet");
		Prevision prev = new Prevision(idprev, Utilitaire.dateDuJourSql(), Utilitaire.stringToDouble(montant), remarque);
		prev.setNomTable("OPPREVISION");
		prev.setEtat(1);

		Prevision crt = new Prevision();
		crt.setId(idprev);
		crt.setNomTable("OPPREVISION");
		if(u.controlerDoublon(crt) == false){
		  u.createObject(prev);
		}else{%>
		  <script language="JavaScript">alert("Prevision déjà existé");history.back();</script>
		<%}
	}
        if(acte.compareToIgnoreCase("modifierdatep")==0){
          String[] idop = request.getParameterValues("id");
          String datePaiement = request.getParameter("dateDePaiement");
          String ret = u.updateDateOp(idop, Utilitaire.stringToSqlDate("dd/MM/yyyy",datePaiement));
          %>
                <script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/listeOPgroupe_tdp.jsp");</script>
		<%
        }
	if(acte.compareToIgnoreCase("previsionmultiple")==0){
		String[] idprev = request.getParameterValues("id");
		String sqlid = Utilitaire.stringToTab(idprev, "'", ",");
		OrdonnerPayement opcrt = new OrdonnerPayement();
		opcrt.setNomTable("OrdonnerPayement");
		OrdonnerPayement[] listOP = (OrdonnerPayement[])CGenUtil.rechercher(opcrt, null, null, " and ID in (" + sqlid + ")");

		for(int i = 0; i < listOP.length; i++){
			Prevision prev = new Prevision(listOP[i].getId(), listOP[i].getDaty(), listOP[i].getMontant(), listOP[i].getRemarque());
			prev.setNomTable("OPPREVISION");
			prev.setEtat(1);
			System.out.println(" print debug " + i);
			Prevision crt = new Prevision();
			crt.setId(listOP[i].getId());
			crt.setNomTable("OPPREVISION");
			if(u.controlerDoublon(crt) == false){
				u.createObject(prev);
			}
		}
		%>
		<script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/listeOP.jsp");</script>
		<%
	}
	if(acte.compareToIgnoreCase("payer")==0){

		if(Utilitaire.stringToDouble(montantObjet)>0)
		{
			//u.createMvtCaisseDepense(Utilitaire.dateDuJour() ,"",request.getParameter("designation"), request.getParameter("debit"),request.getParameter("idDevise"), request.getParameter("idMode"),request.getParameter("idCaisse"),request.getParameter("remarque"),request.getParameter("agence"), request.getParameter("tiers"), request.getParameter("numPiece"),request.getParameter("typeMvt"), request.getParameter("numObjet"));
			%>

	       <script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/mvtCaisse.jsp&numObjet=<%=numObjet%>&typeObjet=<%=Constante.getObjetOp()%>&montantObjet=<%=montantObjet%>"); </script>
		<%}
		else
		{%>
			<script language="JavaScript"> document.location.replace("<%=lien%>?but=finance/mvtCaisseRetour.jsp&numObjet=<%=numObjet%>&typeObjet=<%=Constante.getObjetOp()%>&montantObjet=<%=montantObjet%>"); </script>
		<%}
	}
	if(acte.compareToIgnoreCase("vJointureLC")==0){
	%>
		<script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/visualiserDedJointure.jsp&numObjet=<%=numObjet%>&typeObjet=<%=Constante.getObjetOp()%>&nature2=<%=Constante.getObjetLcDetail()%>&montantObjet=<%=request.getParameter("montantObjet")%>"); </script>
	<%}
	if(acte.compareToIgnoreCase("jLC")==0){
		%>
		<script language="JavaScript"> document.location.replace("<%=lien%>?but=lc/listeChoixLCDetail.jsp&numObjet=<%=numObjet%>&typeObjet=<%=Constante.getObjetOp()%>&tableJointure=<%=Constante.getOpFactureFournisseur()%>&idLc=<%=request.getParameter("idLc")%>&montantObjet=<%=request.getParameter("montantObjet")%>"); </script>
	<%}
	if(acte.compareToIgnoreCase("modif")==0){
		%>
		<script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/modifierOP.jsp&numObjet=<%=numObjet%>&typeObjet=<%=Constante.getObjetOp()%>&tableJointure=<%=Constante.getOpFactureFournisseur()%>&idDED=<%=request.getParameter("idDED")%>"); </script>
	<%}
	if(acte.compareToIgnoreCase("dupliquer")==0){
		%>
		<script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/form_duplication.jsp&numObjet=<%=numObjet%>"); </script>
	<%}
        if(acte.compareToIgnoreCase("remplacerOp")==0){
		%>
		<script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/ordonnerPayementDupliquer.jsp&numObjet=<%=numObjet%>&typeObjet=<%=Constante.getObjetOp()%>&tableJointure=<%=Constante.getOpFactureFournisseur()%>&idDED=<%=request.getParameter("idDED")%>")</script>
	<%}
	if(acte.compareToIgnoreCase("reporter")==0){
        int nb = Utilitaire.stringToInt(request.getParameter("nb"));
        String []listId=new String[nb];
        String []listDaty=new String[nb];
        for(int i = 0; i < nb; i++)
        {
			listId[i] = request.getParameter("id"+i);
            listDaty[i] = request.getParameter("daty"+i);
        }
		u.reporterOp("ORDONNERPAYEMENT",listId,listDaty);
        %>
		<script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/reportOP.jsp"); </script>
		<%}
		if(acte.compareToIgnoreCase("UPDATE")==0){
			try{
				u.updateOR("ORDONNERPAYEMENT",numObjet,request.getParameter("idDed"),request.getParameter("remarque"),request.getParameter("daty"),request.getParameter("montantTTC"));
				UnionIntraTableUtil uit=new UnionIntraTableUtil();
				uit.setNomTable("OpFFlcLettre");
				UnionIntraTable[] lcc = (UnionIntraTable[])uit.rechercher(2,numObjet);
				u.devaliderUnionIntraTable(lcc,"opfflc");
				%>
					<script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/ventilationOpFfLc.jsp&numObjet=<%=numObjet%>&typeObjet=<%=Constante.getObjetOr()%>&tableJointure=<%=Constante.getOpFactureFournisseur()%>"); </script>
				<%
			}catch(Exception ex){
				ex.printStackTrace();
			}
			%>
			<script language="JavaScript"> document.location.replace("<%=lien%>?but=lc/visualiserOR.jsp&numObjet=<%=numObjet%>&typeObjet=<%=Constante.getObjetOp()%>&tableJointure=<%=Constante.getOpFactureFournisseur()%>"); </script>

			%>
			<script language="JavaScript"> document.location.replace("<%=lien%>?but=lc/visualiserOP.jsp&numObjet=<%=numObjet%>&typeObjet=<%=Constante.getObjetOp()%>&tableJointure=<%=Constante.getOpFactureFournisseur()%>"); </script>
		<%}
        if(acte.compareToIgnoreCase("annulerOp")==0){
			try{
				Visa vop = new Visa();
				vop.setNomTable("VISAORDREPAYEMENT");
				Visa[] laos = (Visa[])CGenUtil.rechercher(vop,null,null," and idobjet='"+numObjet+"'");
				if(laos.length > 0){
					%>
					<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=impossible d'annuler, OP déjà visé!"); </script>
					<%
				}else{
					%>
					<script language="JavaScript">
                        if (confirm("Voulez-vous annuler cet OP ?")) { // Clic sur OK
							<%
							u.annulerOp("ORDONNERPAYEMENT","OPFFLC",numObjet);
							%>
						}
						document.location.replace("<%=lien%>?but=ded/visualiserOP.jsp&idOP=<%=numObjet%>");
					</script>

				<%}
			}catch(Exception exc){
				exc.printStackTrace();
				%>
				<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=exc.getMessage()%>"); </script>
				<%
			}
		}


%>




</html>
