<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="finance.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<%!
        UserEJB u = null;
        String acte=null;
        String id=null;
        String lien=null;
        finance.Entree entree = null;
        String rep = null;
        int retour = 0;
        String idEntree=null;
        String numFact=null;
        String typa=null;
            String nomClient=null;
            String idLigne = null;
            SaisieVirement sVir=null;
            String numCheque = null;

%>
<%
acte=request.getParameter("acte");
idEntree=request.getParameter("idEntree");
numFact=request.getParameter("numFact");
typa=request.getParameter("typa");
nomClient=request.getParameter("nomClient");
idLigne=request.getParameter("numLCEntrer");
numCheque = request.getParameter("numCheque");
        try
        {
          lien=(String)session.getValue("lien");
           u=(UserEJB)session.getAttribute("u");
          if (acte.compareTo("UPDATE")==0)
          {
          rep = u.updateEntree(request.getParameter("id"),request.getParameter("date"),request.getParameter("designation"),request.getParameter("montant"),request.getParameter("client"),request.getParameter("idType"),request.getParameter("numPiece"),request.getParameter("idDevise"),request.getParameter("idMode"),request.getParameter("idCaisse"),"cree",request.getParameter("remarque"),"-","-",idLigne);
           %>
           <script language="JavaScript"> document.location.replace("<%=lien%>?but=finance/listeEntree.jsp&daty1=<%=request.getParameter("daty")%>&daty2=<%=request.getParameter("daty")%>"); </script>
           <%
          }
          if (acte.compareTo("INSERT")==0)
          {

            rep=u.createEntree(request.getParameter("daty"),request.getParameter("designation"),request.getParameter("montant"),request.getParameter("idClient"),request.getParameter("idType"),request.getParameter("numPiece"),request.getParameter("idDevise"),request.getParameter("idModeP"),request.getParameter("idCaisse"),request.getParameter("remarque"),request.getParameter("parution"),request.getParameter("agence"),request.getParameter("source"),"-","-",idLigne);// request.getParameter("projet"), request.getParameter("partenaire"));
                        out.println("autoinc  = "+rep);

%>
          <script language="JavaScript"> document.location.replace("<%=lien%>?but=finance/entree.jsp"); </script>
          <%
          }
        if (acte.compareTo("VIRER")==0)
        {
            
            sVir = u.virer(request.getParameter("montant"),request.getParameter("idDevise"),request.getParameter("caisse1"),request.getParameter("caisse2"),request.getParameter("idModeP"),request.getParameter("remarque"),request.getParameter("daty"),request.getParameter("numCheque"));

			%>
			<script language="JavaScript"> document.location.replace("<%=lien%>?but=finance/detailVirement.jsp&id=<%=sVir.getId()%>"); </script>
			<%
        }
		if (acte.compareTo("VIREMENTMULTIPLE")==0)
        {
			String[] listchq = Utilitaire.split(request.getParameter("listchq"),",");
			String devise = request.getParameter("idDevise");
			String modep  = request.getParameter("idModeP");
			String remarque = request.getParameter("remarque");
			String caisse2 = request.getParameter("caisse2");
			Cheque ch = new Cheque();
			Cheque cq = new Cheque();
			cq.setNomTable("CHEQUENONVIRE2");
						
			double somme = 0;
			String[] numcheque = new String[listchq.length];
			String[] montant = new String[listchq.length];
			for(int i = 0; i < listchq.length; i++){
				ch = ((Cheque[])CGenUtil.rechercher(cq,null,null," and numcheque = '"+listchq[i]+"'"))[0];
				System.out.println(" virement " + (i + 1));
				
				somme += ch.getMontant();
				numcheque[i] = ch.getNumCheque();
				montant[i] = String.valueOf(ch.getMontant());
			}
			u.virerVirementMiltiple(numcheque,montant,devise,ch.getCaisse(),caisse2,modep,remarque,request.getParameter("daty"));
			
			
            %>
			<script language="JavaScript"> document.location.replace("<%=lien%>?but=finance/listeCheque.jsp"); </script>
			<%
        }
          if (acte.compareTo("VISERVIR")==0)
          {
			u.viserVirement(request.getParameter("idVir"),request.getParameter("daty"),request.getParameter("rem"));
			%>
          <script language="JavaScript"> document.location.replace("<%=lien%>?but=finance/listeVirement.jsp"); </script>
          <%
          }
          if (acte.compareTo("REPORTER")==0)
          {

            u.reporter(request.getParameter("daty"),request.getParameter("montant"),request.getParameter("caisse"),request.getParameter("idDevise"));

%>
          <script language="JavaScript"> document.location.replace("<%=lien%>?but=finance/reporter.jsp"); </script>
          <%
          }
          if (acte.compareTo("REPORTERCAISSE")==0)
          {
            //String daty,                  String datyFin,                   String montant,             String caisse, String devise
            if(request.getParameter("montant").compareToIgnoreCase("0")==0) throw new Exception("montant invalide");
            u.reporter(request.getParameter("daty"),request.getParameter("montant"),request.getParameter("caisse"),request.getParameter("idDevise"));

%>
          <script language="JavaScript"> document.location.replace("<%=lien%>?but=finance/reporter.jsp"); </script>
          <%
          }
          if (acte.compareTo("ANNULER")==0)
          {
            retour=u.annulerEntree(idEntree);

           %>
                  <script language="JavaScript"> document.location.replace("<%=lien%>?but=finance/critereEntree.jsp"); </script>
        <%
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




