<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="affichage.*" %>
<%@ page import="pub.*" %>
<%@ page import="ded.*" %>
<%@ page import="prevision.*" %>
<%@ page import="finance.*" %>
  <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<%!
  UserEJB u = null;
  String acte=null;
  String lien=null;
  String bute;
  int nb = 0;
  String h=null;
  String nomTable=null;
%>
<%
  try
{
  lien=(String)session.getValue("lien");
  u=(UserEJB)session.getAttribute("u");
  acte=request.getParameter("acte");
  bute=request.getParameter("bute");
  String[]rajoutLien=null;
  String tempRajout=request.getParameter("rajoutLien");
  String tableBdd=request.getParameter("tableBdd");
  h = request.getParameter("nb");
  nomTable = request.getParameter("classe");
  if(tempRajout!=null&&tempRajout.compareToIgnoreCase("")!=0)
  {
    rajoutLien=utilitaire.Utilitaire.split(tempRajout,"-");
  }
  if(bute==null||bute.compareToIgnoreCase("")==0) bute="pub/Pub.jsp";

  String classe=request.getParameter("classe");
  ClassMAPTable t=null;
                if(classe==null||classe.compareToIgnoreCase("")==0) classe="pub.Montant";
		if(acte.compareToIgnoreCase("insertprevisiondep")==0)
		{
                        t = (ClassMAPTable)(Class.forName(classe).newInstance());
                        PageInsert p = new PageInsert(t,request);
			ClassMAPTable f = p.getObjectAvecValeur();
                        PrevisionDepenseRecurrence[] prev = u.createPrevision(f);
			%>
			<script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute%>&numObjet=<%=prev[0].getId()+"&idligne="+prev[0].getIdligne()%>"); </script>
			<%

		}
		else if(acte.compareToIgnoreCase("insertprevisionrec")==0)
		{
			t = (ClassMAPTable)(Class.forName(classe).newInstance());
			PageInsert p = new PageInsert(t,request);
			ClassMAPTable f = p.getObjectAvecValeur();
			PrevisionRecette prev = (PrevisionRecette)u.createObject(f);
			String lc = request.getParameter("idligne");
			String[] idLcArecup = Utilitaire.split(request.getParameter("idligne"),"-");
			if((lc!=null))
			{
				String[] montantTab = {request.getParameter("montant")};
				u.mapperPrevLCRTableau(prev.getId(), idLcArecup, "prev recette lc unique", montantTab);
			}
			%>
			<script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute%>&numObjet=<%=prev.getId()%>&idligne=<%=lc%>"); </script>
			<%
		}
                else if(acte.compareToIgnoreCase("reporter")==0)
                {
                  if(h!=null && h.compareToIgnoreCase("")!=0)
                    nb=Utilitaire.stringToInt(h);
                  else
                    throw new Exception("Pas de prevision a reporter");
                  String []listId=new String[nb];
                  String []listPage=new String[nb];
                  for(int i=0;i<nb;i++)
                  {
                    listId[i]=request.getParameter("id"+i);
                    listPage[i]=request.getParameter("page"+i);
                  }
                  u.reporterPrevision(nomTable,listId,listPage);
         %>
         <script language="JavaScript"> document.location.replace("<%=lien+"?but="+bute+request.getParameter("crt")%>"); </script>
         <%
               }
               if(acte.compareToIgnoreCase("delete")==0){
                 u.deletePrevision(nomTable,request.getParameter("numObjet"));
           %>
         <script language="JavaScript"> document.location.replace("<%=lien+"?but=prevision/listePrevisionDepNonPaye.jsp"+request.getParameter("crt")%>"); </script>
         <%
               }

		String rajoutLie="";
		if(rajoutLien!=null)
		{
			for(int o=0;o<rajoutLien.length;o++)
			{
				String valeur = request.getParameter(rajoutLien[o]);
				rajoutLie=rajoutLie+"&"+rajoutLien[o]+"="+valeur;
			}
		}
		%>
		<script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute+rajoutLie%>"); </script>
		<%
	}catch (Exception e){
		e.printStackTrace();
           %>
			<script language="JavaScript"> alert('<%=e.getMessage()%>');history.back(); </script>
            <%
                return;
        }
        %>
</html>



