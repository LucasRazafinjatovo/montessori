package etudiant;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import javax.servlet.annotation.WebServlet;
/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */
@WebServlet(name = "imageetudiant", urlPatterns = {"/imageetudiant"})
public class ImageServlet extends HttpServlet {
  static final private String CONTENT_TYPE = "text/html";
  //Initialize global variables
  public void init() throws ServletException {
  }
  //Process the HTTP Get request
  public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    response.setContentType(CONTENT_TYPE);

                try
                {
				System.out.print("MIDITRA ATO");
						DataOutput output = new DataOutputStream( response.getOutputStream() );
                        response.setContentType("image/jpeg");

                        String nomImage = request.getParameter("imageName");

                        File file = null;

                        FileInputStream in = null;
						System.out.print("sary============="+nomImage);
                        

                        String filePath = "D:\\image_etudiant_itu\\"+nomImage+".jpg";


                        file = new File(filePath);

                        /*
                         * Dans le cas ou l'image n'est pas présente dans le répertoire
                         * On affiche une image par defaut 'Image Introuuvable'
                         */
                        if(file!=null){
                        in = new FileInputStream(file);

                        response.setContentLength((int)file.length());

                        byte buffer[]=new byte[4096];
                        int nbLecture;

                        while( (nbLecture = in.read(buffer)) != -1 )
                        {
                                output.write(buffer,0,nbLecture);
                        }

                        in.close();
                        }
                        //this.getServletContext().getRequestDispatcher("/upload/testupload1.jsp").forward(request,response);
                }
                catch (IOException e)
                {
                    e.printStackTrace();
                }



  }
  //Clean up resources
  public void destroy() {
  }
}