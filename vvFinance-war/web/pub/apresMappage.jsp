<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<%!
        UserEJB u = null;
        String acte=null;
        String lien=null;
        int nb=0;
        String nomTable="";
%>
<%

	try
	{
          lien=(String)session.getValue("lien");
          u=(UserEJB)session.getAttribute("u");
          String h=request.getParameter("nb");
          acte=request.getParameter("acte");
          nomTable=request.getParameter("nomTable");
          String idUnion=request.getParameter("idUnion");

          String idFact=request.getParameter("numObjet");
          if(acte.compareToIgnoreCase("svalide")==0)
          {
            u.validerMappage(idFact,nomTable);
          }
          else if(acte.compareToIgnoreCase("delete")==0)
          {
            u.deleteUnionIntraTable(nomTable,idUnion);
          }
          else if(acte.compareToIgnoreCase("saveMap")==0)
          {
            String[] idPub=request.getParameterValues("id");
            for(int i=0;i<idPub.length;i++)
            {
              String montant=request.getParameter("montant"+i);
              String remarque="-";
              if(request.getParameter("remarque"+i)!=null)remarque=request.getParameter("remarque"+i);
              u.insertMereFille(nomTable, idPub[i], idFact, remarque, montant, "0");
              //u.facturerPub(idFact,idPub[i]);
            }
          }
%>
          <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=request.getParameter("bute")%>&idFacture=<%=idFact%>"); </script>
          <%


	}
        catch (Exception e){
          e.printStackTrace();
 %>
<script language="JavaScript"> alert('<%=e.getMessage()%>');history.back(); </script>
		<%
		return;
		}
		%>

</html>




