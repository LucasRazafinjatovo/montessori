<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="finance.*" %>
<%@ page import="bean.*" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<%!
        UserEJB u = null;
        String acte=null;
        String id=null;
        String lien=null;
        Sortie sortie = null;
        String rep = null;
        int retour = 0;
        String idSortie=null;
        String idLigne = null;
%>
<%
acte=request.getParameter("acte");
lien=(String)session.getValue("lien");
idSortie=request.getParameter("idSortie");
idLigne = request.getParameter("numLigneSortie");
        try
        {
           u=(UserEJB)session.getAttribute("u");
          if (acte.compareTo("UPDATE")==0)
          {

        //  rep=u.updatesortie(request.getParameter("id"),request.getParameter("date"),request.getParameter("designation"),request.getParameter("montant"),request.getParameter("idBen"),request.getParameter("idType"),request.getParameter("idDevise"),request.getParameter("idMode"),request.getParameter("idCaisse"),"cree",request.getParameter("remarque"));
           %>
                          <script language="JavaScript"> document.location.replace("<%=lien%>?but=finance/listeSortie.jsp&daty1=<%=request.getParameter("daty")%>&daty2=<%=request.getParameter("daty")%>"); </script>
                          <%
          }
          if (acte.compareTo("INSERT")==0)
          {
		  System.out.println(request.getParameter("daty")+request.getParameter("designation")+request.getParameter("montant")+request.getParameter("beneficiaire")+request.getParameter("idType")+request.getParameter("idDevise")+request.getParameter("idMode")+request.getParameter("idCaisse")+request.getParameter("remarque")+request.getParameter("parution")+request.getParameter("agence")+request.getParameter("projet")+request.getParameter("numpiece")+request.getParameter("idFacture"));
          //  System.out.println(request.getParameter("daty")+request.getParameter("designation")+request.getParameter("montant")+"beneficiaire","idType",request.getParameter("idDevise"),request.getParameter("idMode"),request.getParameter("idCaisse"),request.getParameter("remarque"),"parution","agence",request.getParameter("projet"), request.getParameter("numP"),request.getParameter("idFacture"));

            rep=u.createSortie(request.getParameter("daty"),request.getParameter("designation"),request.getParameter("montant"),request.getParameter("beneficiaire"),request.getParameter("idType"),request.getParameter("idDevise"),request.getParameter("idMode"),request.getParameter("idCaisse"),request.getParameter("remarque"),request.getParameter("parution"),request.getParameter("agence"),"projet", request.getParameter("numpiece"),request.getParameter("idFacture"),idLigne);
%>
                          <script language="JavaScript"> document.location.replace("<%=lien%>?but=finance/sortie.jsp"); </script>
                          <%
          }
          if (acte.compareTo("DELETE")==0)
          {
            retour=u.deleteSortie(request.getParameter("idsortie"));
           %>
                  <script language="JavaScript"> document.location.replace("<%=lien%>?but=finance/listeSortie.jsp&daty1=<%=Utilitaire.dateDuJour()%>&daty2=<%=Utilitaire.dateDuJour()%>"); </script>
                          <%
          }
          if (acte.compareTo("ANNULER")==0)
          {
            retour=u.annulerSortie(idSortie);
 %>
        <script language="JavaScript"> document.location.replace("<%=lien%>?but=finance/critereSortie.jsp"); </script>
<%
          }
        }catch (Exception e){
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
