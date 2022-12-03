<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<%!
        UserEJB u = null;
        String idType=null;
        String lien=null;
        String date= null;
	String dateDebut = null;
	String dateFin=null;
        String idClient = null;
        String idPenalite = null;
        String idScat = null;
        String acte = null;
%>
<%
idPenalite = request.getParameter("idPen");
idScat=request.getParameter("idScat");
acte = request.getParameter("acte");
if(idScat == null)idScat="temp";
if(acte == null)acte="none";
%>
<%
 	lien=(String)session.getValue("lien");
	try
	{
          u=(UserEJB)session.getAttribute("u");
		  if(idScat.compareTo("scat3")==0){
           %>
		  <script language="JavaScript">

                  document.location.replace("<%=lien%>?but=penalites/detailPenRetard.jsp&idPen=<%=idPenalite%>");
                  </script>

	  <%
		  }
	  if(idScat.compareTo("scat4")==0){
           %>
		  <script language="JavaScript">

                  document.location.replace("<%=lien%>?but=penalites/detailPenTauxQuai.jsp&idPen=<%=idPenalite%>");
                  </script>

	  <%
	  }
          if(idScat.compareTo("scat5")==0){
           %>
                  <script language="JavaScript">

                  document.location.replace("<%=lien%>?but=penalites/detailPenTrafic.jsp&idPen=<%=idPenalite%>");
                  </script>

          <%
	  }
          if(idScat.compareTo("scat6")==0){
           %>
                  <script language="JavaScript">

                  document.location.replace("<%=lien%>?but=penalites/detailPenVolConteneur.jsp&idPen=<%=idPenalite%>");
                  </script>

          <%
	  }
          if(idScat.compareTo("scat7")==0){
           %>
                  <script language="JavaScript">

                  document.location.replace("<%=lien%>?but=penalites/detailPenAccident.jsp&idPen=<%=idPenalite%>");
                  </script>

          <%
	  }
          if(idScat.compareTo("scat8")==0){
           %>
                  <script language="JavaScript">

                  document.location.replace("<%=lien%>?but=penalites/detailPenPenalite.jsp&idPen=<%=idPenalite%>");
                  </script>

          <%
	  }
          if(idScat.compareTo("scat9")==0){
           %>
                  <script language="JavaScript">

                  document.location.replace("<%=lien%>?but=penalites/detailPenDommageCont.jsp&idPen=<%=idPenalite%>");
                  </script>

          <%
	  }
	   if(acte.compareTo("ANNULE") == 0){
                  u.annulerPenalite(idPenalite);
           %>
                  <script language="JavaScript">

                  document.location.replace("<%=lien%>?but=penalites/listePenalites1.jsp");
                  </script>

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
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Document sans titre</title>


</head>
</html>
