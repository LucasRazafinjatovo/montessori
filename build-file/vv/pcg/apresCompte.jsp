<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="finance.*" %>
<%@ page import="bean.*" %>
<%@ page import="pcg.*" %>

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
%>
<%
acte=request.getParameter("acte");
out.println(acte);
lien=(String)session.getValue("lien");
idSortie=request.getParameter("idSortie");
        try
        {
           u=(UserEJB)session.getAttribute("u");
          if (acte.compareTo("UPDATE")==0)
          {
		  System.out.println(request.getParameter("idCompte"));
		 rep=u.majCompte(request.getParameter("idCompte"),request.getParameter("compte"), request.getParameter("libelle"), request.getParameter("pcompte"));

        //  rep=u.updatesortie(request.getParameter("id"),request.getParameter("date"),request.getParameter("designation"),request.getParameter("montant"),request.getParameter("idBen"),request.getParameter("idType"),request.getParameter("idDevise"),request.getParameter("idMode"),request.getParameter("idCaisse"),"cree",request.getParameter("remarque"));
           %>
                          <script language="JavaScript"> document.location.replace("<%=lien%>?but=pcg/listeCompte.jsp"); </script>
                          <%
          }
          if (acte.compareTo("INSERT")==0)
          {
		  //System.out.println(request.getParameter("daty")+request.getParameter("designation")+request.getParameter("montant")+request.getParameter("beneficiaire")+request.getParameter("idType")+request.getParameter("idDevise")+request.getParameter("idMode")+request.getParameter("idCaisse")+request.getParameter("remarque"));
            rep=u.ajouterCompte(request.getParameter("compte"),request.getParameter("libelle"),request.getParameter("pcompte"));
			
			%>
                          <script language="JavaScript"> document.location.replace("<%=lien%>?but=pcg/entreeCompte.jsp"); </script>
                          <%
          }
		    if (acte.compareTo("NEW")==0)
          {
		  //System.out.println(request.getParameter("daty")+request.getParameter("designation")+request.getParameter("montant")+request.getParameter("beneficiaire")+request.getParameter("idType")+request.getParameter("idDevise")+request.getParameter("idMode")+request.getParameter("idCaisse")+request.getParameter("remarque"));
            rep=u.ajouterCompte(request.getParameter("compte"),request.getParameter("libelle"),request.getParameter("pcompte"));
			
			%>
                          <script language="JavaScript"> document.location.replace("<%=lien%>?but=pcg/entreeCompte.jsp"); </script>
                          <%
          }
          if (acte.compareTo("DELETE")==0)
          {
         //   retour=u.deleteSortie(request.getParameter("idsortie"));
           %>
                  <script language="JavaScript"> document.location.replace("<%=lien%>?but=pcg/listeSortie.jsp&daty1=<%=Utilitaire.dateDuJour()%>&daty2=<%=Utilitaire.dateDuJour()%>"); </script>
                          <%
          }
		   if (acte.compareTo("ADDSSC")==0)
          {
		  rep=u.ajouterCompte(request.getParameter("compte"),request.getParameter("libelle"),request.getParameter("pcompte"));
         //   retour=u.deleteSortie(request.getParameter("idsortie"));
           %>
                  <script language="JavaScript"> document.location.replace("<%=lien%>?but=pcg/listeCompte.jsp"); </script>
                          <%
          }
          if (acte.compareTo("ANNULER")==0)
          {
		  rep=u.ajouterCompte(request.getParameter("compte"),request.getParameter("libelle"),request.getParameter("pcompte"));
        //    retour=u.annulerSortie(idSortie);
 %>
        <script language="JavaScript"> document.location.replace("<%=lien%>?but=pcg/critereSortie.jsp"); </script>
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
</body>
</html>
