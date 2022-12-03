<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="affichage.*" %>
<%@ page import="pub.*" %>
<%@ page import="ded.OrdonnerPayement" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<%!
	UserEJB u = null;
	String acte=null;
	String lien=null;
	finance.Entree entree = null;
	%>
	<%
	acte = request.getParameter("acte");
	try
	{
        lien = (String)session.getValue("lien");
        u = (UserEJB)session.getAttribute("u");
        if(acte.compareToIgnoreCase("insert")==0)
        {
            Publicite[] ret = u.createPub(request.getParameter("parution1"),request.getParameter("parution2"),request.getParameter("client"),request.getParameter("designation"),request.getParameter("dimension"),request.getParameter("couleur"),request.getParameter("page"),request.getParameter("journal"),request.getParameter("numBc"),request.getParameter("rem"),request.getParameter("cat"),request.getParameter("agence"),request.getParameter("nPiec"),request.getParameter("formulaire"),request.getParameter("remis"));
			%>
			<script language="JavaScript"> document.location.replace("<%=lien%>?but=pub/Pub.jsp&parution1=<%=request.getParameter("parution1")%>&id=<%=ret[0].getId()%>"); </script>
			<%
        }
        else if(acte.compareToIgnoreCase("updateorp")==0){
			OrdonnerPayement op = new OrdonnerPayement();
			op.setNomTable("OrdonnerRecette");
			OrdonnerPayement[] lop = (OrdonnerPayement[])CGenUtil.rechercher(op, null, null, " and ID = '" + request.getParameter("id") + "'");
			if(lop.length > 0){
				lop[0].setDaty(Utilitaire.string_date("dd/MM/yyyy",request.getParameter("daty")));
				lop[0].upDateToTable();
			}
			%>
			<script language="JavaScript"> document.location.replace("<%=lien%>?but=finance/modifierORPrevision.jsp");</script>
			<%
		}else if(acte.compareToIgnoreCase("updateopp")==0){
			OrdonnerPayement op = new OrdonnerPayement();
			OrdonnerPayement[] lop = (OrdonnerPayement[])CGenUtil.rechercher(op, null, null, " and ID = '" + request.getParameter("id") + "'");
			if(lop.length > 0){
				lop[0].setDaty(Utilitaire.string_date("dd/MM/yyyy",request.getParameter("daty")));
				lop[0].upDateToTable();
			}
			%>
			<script language="JavaScript"> document.location.replace("<%=lien%>?but=finance/modifierOPPrevision.jsp");</script>
			<%
		}
        else if(acte.compareToIgnoreCase("update")==0)
        {
            Page p=new Page(new Publicite(),request);
            Publicite f=(Publicite)p.getObjectAvecValeur();
            u.updatePub(f);
            %>
			<script language="JavaScript"> document.location.replace("<%=lien%>?but=pub/fichePub.jsp&id=<%=f.getId()%>"); </script>
			<%
        }
        else if(acte.compareToIgnoreCase("corriger")==0)
        {
            u.corrigerPub(request.getParameter("id"));
            %>
			<script language="JavaScript"> document.location.replace("<%=lien%>?but=pub/listePubMep.jsp&libJournal=<%=request.getParameter("libJournal")%>&numParution1=<%=request.getParameter("numParution") %>&numParution2=<%=request.getParameter("numParution") %>"); </script>
			<%
        }
        else if(acte.compareToIgnoreCase("sparution")==0)
        {
            Parution parution = new Parution();
            Parution[] listeParution = (Parution[])CGenUtil.rechercher(parution,null,null," and '"+ request.getParameter("date") +"'= datyParution and journal ='"+request.getParameter("journal")+"'");
            if(listeParution.length > 0){
				String message = "Il existe déjà une parution de ce journal à cette date ";
				%>
				<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=message%>"); </script>
				<%
				return;
            }else{
				u.creerParution(request.getParameter("parution1"),request.getParameter("date"),request.getParameter("journal"),request.getParameter("nbpage"),request.getParameter("remarque"));
            }
            %>
			<script language="JavaScript"> document.location.replace("<%=lien%>?but=pub/Parution.jsp"); </script>
			<%
        }
        else if(acte.compareToIgnoreCase("insertPublication")==0)
        {
            Page p=new Page(new Publication(),request);
            Publication f=(Publication)p.getObjectAvecValeur();
            u.createObject(f);
            %>
			<script language="JavaScript"> document.location.replace("<%=lien%>?but=pub/savePublication.jsp"); </script>
			<%
        }
        else if(acte.compareToIgnoreCase("updatePublication")==0)
        {
            Page p = new Page(new Publication(),request);
            String daty = request.getParameter("datyparution");
            Publication f = (Publication)p.getObjectAvecValeur();
            u.updateObject(f);
            %>
			<script language="JavaScript"> document.location.replace("<%=lien%>?but=pub/listePublication.jsp"); </script>
			<%
        }
		else if(acte.compareToIgnoreCase("commissiongroupe") == 0){
			String[] listecomm = request.getParameterValues("idcomm");
			String[] detailCommission = u.getCommissionDetail(listecomm);
			
			session.setAttribute("matricule",detailCommission[0]);
			session.setAttribute("sommeCommission",detailCommission[1]);
			session.setAttribute("listeCommission",detailCommission[2]);
			%>
			<script language="JavaScript"> document.location.replace("<%=lien%>?but=ventegazety/ordonnerPayementCommission.jsp"); </script>
			<%
		}
          else if(acte.compareToIgnoreCase("pubor")==0){

			String[] lsitepub = request.getParameterValues("id");
			String temp = "";
			for(int k = 0; k < lsitepub.length; k++){
					temp += lsitepub[k] + ",";
			}
			session.removeAttribute("pub");
			session.setAttribute("pub",temp);
			%>
			<script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/ordonnerRecettePub.jsp");</script>
			<%
        }
        else
        {

        }
    }catch (Exception e){
		e.printStackTrace();
		%>
		<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
		<%
		return;
	}
%>
</html>




