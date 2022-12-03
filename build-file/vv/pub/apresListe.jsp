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
%>
<%

        try
        {
          lien=(String)session.getValue("lien");
          u=(UserEJB)session.getAttribute("u");
          String h=request.getParameter("nb");
          acte=request.getParameter("acte");
          if(acte.compareToIgnoreCase("svalide")==0)
          {
            String idFact=request.getParameter("numObjet");
            u.validerFacturerPub(idFact);
%>
          <script language="JavaScript"> document.location.replace("<%=lien%>?but=pub/listePubFacture.jsp&idFacture=<%=request.getParameter("numObjet")%>"); </script>
          <%
          }
          else if(acte.compareToIgnoreCase("svalideP")==0)
          {
            String idPubl=request.getParameter("numObjet");
            //u.validerAttacherMvtStockPublication(idPubl);
%>
          <script language="JavaScript"> document.location.replace("<%=lien%>?but=stockgazety/listeMvtStockPublication.jsp&id=<%=request.getParameter("numObjet")%>"); </script>
          <%
          }
          else if(acte.compareToIgnoreCase("delete")==0)
          {
            String idUnion=request.getParameter("idUnion");
            u.deleteUnionIntraTable("pubfacture",idUnion);
%>
          <script language="JavaScript"> document.location.replace("<%=lien%>?but=pub/listePubFacture.jsp&idFacture=<%=request.getParameter("numObjet")%>"); </script>
          <%

          }
          else if(acte.compareToIgnoreCase("deleteP")==0)
          {
            String idUnion=request.getParameter("idUnion");
            u.deleteUnionIntraTable("publicationmvtstock",idUnion);
%>
          <script language="JavaScript"> document.location.replace("<%=lien%>?but=stockgazety/listeMvtStockPublication.jsp&id=<%=request.getParameter("numObjet")%>"); </script>
          <%

          }
          else if(acte.compareToIgnoreCase("saveMap")==0)
          {
            String[] idPub=request.getParameterValues("id");
            String idFact=request.getParameter("numObjet");
            for(int i=0;i<idPub.length;i++)
              u.facturerPub(idFact,idPub[i]);
%>
          <script language="JavaScript"> document.location.replace("<%=lien%>?but=pub/listePubFacture.jsp&idFacture=<%=idFact%>"); </script>
          <%
          }
          else if(acte.compareToIgnoreCase("saveMapP")==0)
          {
            String[] idMvtS=request.getParameterValues("id");
            String idPubl=request.getParameter("numObjet");
            for(int i=0;i<idMvtS.length;i++){
              //u.attacherMvtStockPublication(idPubl,idMvtS[i]);
              //System.out.print("idP "+idPubl+" idMvtS"+i+" "+idMvtS[i]);
            }
%>
          <script language="JavaScript"> document.location.replace("<%=lien%>?but=stockgazety/listeMvtStockPublication.jsp&id=<%=idPubl%>"); </script>
          <%
          }
          else if(acte.compareToIgnoreCase("mep")==0)
          {
            if(h!=null && h.compareToIgnoreCase("")!=0)
              nb=Utilitaire.stringToInt(h);
            else
              throw new Exception("Pas de pub a mettre a jour");
            String []listId=new String[nb];
            String []listPage=new String[nb];
            String[] listePageAncien=new String[nb];
            for(int i=0;i<nb;i++)
            {
              listePageAncien[i]=request.getParameter("pageAncien"+i);
              listId[i]=request.getParameter("id"+i);
              listPage[i]=request.getParameter("page"+i);
            }
            u.mettrePage(listId,listPage,listePageAncien);
          %>
          <script language="JavaScript"> document.location.replace("<%=lien%>?but=pub/listePubMep.jsp<%=request.getParameter("crt")%>"); </script>
          <%
            }
            else if(acte.compareToIgnoreCase("remise")==0)
          {
            if(h!=null && h.compareToIgnoreCase("")!=0)
              nb=Utilitaire.stringToInt(h);
            else
              throw new Exception("Pas de pub a remiser");
            String []listId=new String[nb];
            String []listPage=new String[nb];
            for(int i=0;i<nb;i++)
            {
              listId[i]=request.getParameter("id"+i);
              listPage[i]=request.getParameter("page"+i);
            }
            u.remiserPub(listId,listPage);
          %>
          <script language="JavaScript"> document.location.replace("<%=lien%>?but=pub/listePubRemise.jsp<%=request.getParameter("crt")%>"); </script>
          <%
            }
            else if(acte.compareToIgnoreCase("corr")==0)
          {
            if(h!=null && h.compareToIgnoreCase("")!=0)
              nb=Utilitaire.stringToInt(h);
            else
              throw new Exception("Pas de pub a corriger");
            String []listId=new String[nb];
            String []listPage=new String[nb];
            for(int i=0;i<nb;i++)
            {
              listId[i]=request.getParameter("id"+i);
              listPage[i]=request.getParameter("page"+i);
            }
            u.corrigerPub(listId,listPage);
          %>
          <script language="JavaScript"> document.location.replace("<%=lien%>?but=pub/listePubCorr.jsp<%=request.getParameter("crt")%>"); </script>
          <%
            }
        }
        catch (Exception e){
          e.printStackTrace();
 %>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
                <%
                return;
                }
                %>

</html>




