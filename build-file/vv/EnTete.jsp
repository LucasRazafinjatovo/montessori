<%@ page import="user.*" %>
<%
  try
  {
          if((UserEJB)session.getValue("u")==null)
          {
                  out.println("<script language='JavaScript'> document.location.replace('modeleControle.jsp?but=index.jsp'); </script>");
                  return;
          }

  }
  catch (Exception e)
  {
          out.println("<script language='JavaScript'> document.location.replace('modeleControle.jsp?but=index.jsp'); </script>");
          return;
	}
%>



