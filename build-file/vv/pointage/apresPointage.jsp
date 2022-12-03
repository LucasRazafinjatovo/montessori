<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="pointage.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
	UserEJB u=null;
        String daty,direction,entite,resp,designation,donneur,datyFin,urg;
        String lien=null;
%>

<%
	try
	{
  //ip=request.getRemoteAddr();
  //host=request.getRemoteHost();
  datyFin=request.getParameter("daty");
  direction=request.getParameter("direction");
  entite=request.getParameter("entite");
  resp=request.getParameter("resp");
  designation=request.getParameter("remarque");

  String temp=request.getParameter("estTache");
  urg=request.getParameter("urgence");
  u=(user.UserEJB)session.getValue("u");
  donneur=u.getUser().getTuppleID();
  lien=(String)session.getValue("lien");
  if(temp==null)
  {
                //String user, String daty, String heure, String type, String remarque, String ip
                //u.createPointage(u.getUser().getTuppleID(),"","",type,remarque,ip,agence,host);
  %>
    <script language="JavaScript">
   document.location.replace("<%=lien%>?but=pointage/listeTache.jsp");
    </script>
	  	<%
  }
  else if(temp.compareToIgnoreCase("estTacheInsert")==0)
  {
    //(String datyF,String donneu,String directio,String entit,String desi,String urg,String resp)
    try
    {
    System.out.println("niditra");
    Tache t=new Tache(datyFin,donneur,direction,entite,designation,urg,resp);
    u.creerTache(t);
    }
    catch(Exception ex)
    {
      ex.printStackTrace();
    }
    out.println("<script language='JavaScript'> document.location.replace('"+lien+"?but=pointage/Tache.jsp'); </script>");
  }
  else if(temp.compareToIgnoreCase("estTacheTransfert")==0)
  {
    //(String datyF,String donneu,String directio,String entit,String desi,String urg,String resp)
    Tache t=new Tache(datyFin,donneur,direction,entite,designation,urg,resp);
    u.transfererTache(request.getParameter("idTache"),resp);
    %>
  <script language="JavaScript">
 document.location.replace("<%=lien%>?but=pointage/listeTache.jsp");
  </script>
                <%
                  }
else if(temp.compareToIgnoreCase("effTache")==0)
  {
    //(public EffTache(String t,String ta,String comment)
    EffTache ef=new EffTache(request.getParameter("idTache"),datyFin,designation,u.getUser().getRefuser());
    u.effectuerTache(ef);
    %>
  <script language="JavaScript">
 document.location.replace("<%=lien%>?but=pointage/listeTache.jsp");
  </script>
                <%
                  }

	}
        catch (Exception e){

                  e.printStackTrace();
		%>
  		<script language="JavaScript">
		alert("<%=e.getMessage()%>");
		  </script>
	  	<%
		return;
	}
	%>



