
	<%@ page import="user.*" %>
	<%@ page import="utilitaire.*" %>

	<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

	<html>
	<%!

		UserEJB u = null;
		String acte=null;
		String id=null;
		String lien="modeleAdmin.jsp";
                String idSoc = null;
                String nom = null;
                String regime = null;
                String adr = null;
                String phone = null;
                String fax  = null;
                String mail = null;
                String ger = null;
                String nif = null;
                String stat = null;
                String rc = null;
                String capital = null;
                String banque1 = null;
                String banque2 = null;
                String logo = null;
                String tp = null;
                String quittance = null;
                String entite = null;
                String daty = null;
        %>
        <%
          idSoc = request.getParameter("idSoc");
                  nom = request.getParameter("nom");
                  regime = request.getParameter("regime");
                  adr = request.getParameter("adr");
                  phone = request.getParameter("phone");
                  fax  = request.getParameter("fax");
                  mail = request.getParameter("mail");
                  ger =request.getParameter("ger");
                  nif =request.getParameter("nif");
                  stat =request.getParameter("stat");
                  rc =request.getParameter("rc");
                  capital = request.getParameter("capital");
                  banque1 = request.getParameter("banque1");
                  banque2 =request.getParameter("banque2");
                  logo =request.getParameter("logo");
                  tp =request.getParameter("tp");
                  quittance = request.getParameter("quittance");
                    entite =request.getParameter("entite");
                daty = request.getParameter("daty");
        %>
	<%
	acte=request.getParameter("acte");
	lien=(String)session.getValue("lien");
        u=(UserEJB)session.getAttribute("u");
			try
			{
				  lien=(String)session.getAttribute("lien");
				  if (acte.compareTo("UPDATE")==0)
				  {
//                                    String d, String no, String reg, String adr, String phone, String fa, String mai, String ger, String ni, String sta, String r, String cap, String b1, String b2, String log, String t, String q
                                      u.updateMaSociete(idSoc,nom,regime,adr,phone,fax,mail,ger,nif,stat,rc,capital,banque1,banque2,logo,tp,quittance,entite,daty);



				  %>
				  <script language="JavaScript"> document.location.replace("<%=lien%>?but=listeInfoSpat.jsp&id=<%=idSoc%>"); </script>
				  <%
				  }
                                  if (acte.compareTo("INSERT")==0)
                                  {

//                                    String d, String no, String reg, String adr, String phone, String fa, String mai, String ger, String ni, String sta, String r, String cap, String b1, String b2, String log, String t, String q
                                      String id=u.createMaSociete(idSoc,nom,regime,adr,phone,fax,mail,ger,nif,stat,rc,capital,banque1,banque2,logo,tp,quittance,entite,daty);



                                  %>
                                  <script language="JavaScript"> document.location.replace("<%=lien%>?but=listeInfoSpat.jsp&id=<%=id%>"); </script>
                                  <%
				  }
                        }
			catch (Exception e)
			{
                        %>
                                      <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
			<%
                          return;
			}

	                %>