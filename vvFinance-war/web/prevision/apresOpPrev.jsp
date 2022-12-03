<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="ventegazety.*" %>
<%@ page import="bean.*" %>
<%@ page import="ded.*" %>
<%@ page import="facturefournisseur.FactureFournisseur" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<%!
        UserEJB u = null;
        String acte = null;
        String id = null;
        String lien = null;
        finance.Entree entree = null;
        String rep = null;
        int retour = 0;
        String idEntree = null;
        String numFact = null;
        String typa = null;
		String nomClient = null;
		String nature = null;
		String typeOp = null;
		FactureFournisseur ff = null;
        String lc = "";
        String prevision = "";
        String[] temps = null;
%>
<%
acte=request.getParameter("acte");
	try
	{
        lien=(String)session.getValue("lien");
        u=(UserEJB)session.getAttribute("u");
        nature=request.getParameter("nature");
        typeOp = request.getParameter("typeOp"); if(typeOp==null)typeOp="facture";
        lc=request.getParameter("lc");
		if (acte.compareTo("INSERT")==0)
		{
			if(typeOp.compareToIgnoreCase(Constante.typeOpFacture)==0)
			{
				FactureFournisseur crt = new FactureFournisseur("facturefournisseurviseAop");//
				crt.setIdFactureFournisseur(request.getParameter("idDed"));
				FactureFournisseur[] reponse=(FactureFournisseur[])CGenUtil.rechercher(crt,null,null,"");
				if(reponse.length == 0){
					throw new Exception("Le facture n existe pas");
				}
				rep = u.createOp(request.getParameter("idDed"), request.getParameter("daty"),request.getParameter("montantTTC"),request.getParameter("remarque"), request.getParameter("prevision"));
			}else {

				ff = u.createOpSimple(request.getParameter("daty"),request.getParameter("montantTTC"),request.getParameter("tva"),request.getParameter("fournisseur"),request.getParameter("idDevise"),request.getParameter("remarque"),request.getParameter("prevision"));
				OrdonnerPayement op = new OrdonnerPayement();
				op.setNomTable("OrdonnerPayement");
				op.setDed_Id(ff.getIdFactureFournisseur());
				OrdonnerPayement[] lop = (OrdonnerPayement[])CGenUtil.rechercher(op,null,null,"");
				u.createOpPrevisionLC("prevdepenselc","opfflc","facturefournisseurlc",temps,lop,ff);
			}

			%>
			<script language="JavaScript"> document.location.replace("<%=lien%>?but=prevision/listePrevision.jsp");
			  </script>
			<%
		}
		if (acte.compareTo("attacheropprev")==0){

			String orr = request.getParameter("idop");
			String[] listor = Utilitaire.split(orr,",");
			String res = u.attcherOpRCPrev(request.getParameter("idprev"),listor);
			if(res.compareToIgnoreCase("yes") == 0){
				%>
				<script language="JavaScript"> document.location.replace("<%=lien%>?but=prevision/listePrevisionDepesne.jsp");</script>
				<%
			}else{
				%>
				<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=res%>"); </script>
				<%
			}
        }
		if (acte.compareTo("attacheropprev2")==0){

			String orp = request.getParameter("numop");
			String c = request.getParameter("prevision");
			String res = u.attcherOpDepPrev2(c,orp);
			if(res.compareToIgnoreCase("yes") == 0){
				%>
				<script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/visualiserOP.jsp&idOP=<%=orp%>");</script>
				<%
			}else{
				%>
				<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=res%>"); </script>
				<%
			}
        }
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

<body>
<table width="425" border="0" cellspacing="0">
  <tr>
    <td><div align="justify"></div>
    </td>
  </tr>
</table>
</body>
</html>




