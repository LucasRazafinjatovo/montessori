/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utilitaire;

import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author Matiasy
 */
public class UtilitaireExcelMa {
    public static String[] getAllStringBetween(String s , String start , String end){
        ArrayList<String> ret = new ArrayList<String>();
        String []ret1 =  null;
        String pattern1 = start;
        String pattern2 = end;
        String text = s;
      // System.out.println("avant____"+text);
        text = text.replace("\t", "").replace("\n", "");
       // System.out.println("apres____"+text);
       // System.out.println("FINN___________");
        Pattern p = Pattern.compile(Pattern.quote(pattern1) + "(.*?)" + Pattern.quote(pattern2));
        Matcher m = p.matcher(text);
        while (m.find()) {
          ret.add(m.group(1));          
        }
        ret1 = new String[ret.size()];
        for(int i=0;i<ret.size();i++){
            ret1[i]  = ret.get(i);
        }
        return ret1 ; 
    }
    public static String convertirEnTete(String html , String aChercher){
       html = html.substring(html.indexOf("<"+aChercher)+1);
       
        //Eto tokony misy vérification Rowspan sy Colspan
        //*************************************************
       
        String ret = html.substring(html.indexOf(">")+1);
        //System.out.println("ret______"+ret.length()+" index _____"+ret.indexOf("</"+aChercher+">")+"___istrue____"+(ret.indexOf("</"+aChercher+">")<ret.length()));
        //System.out.println("mipoaka______"+ret.substring(0,ret.indexOf("</"+aChercher+">")));
        ret = "<"+aChercher+">"+ret.substring(0,ret.indexOf("</"+aChercher+">")) +"</"+aChercher+">";         
        return ret ;
    }
    public static ArrayList<String> getAllStringBetweenToArray(String s , String start , String end){
        ArrayList<String> ret = new ArrayList<String>();
        String []ret1 =  null;
        String pattern1 = start;
        String pattern2 = end;
        String text = s.replace("\t", "").replace("\n", "");
        Pattern p = Pattern.compile(Pattern.quote(pattern1) + "(.*?)" + Pattern.quote(pattern2));
        Matcher m = p.matcher(text);
        while (m.find()) {
          ret.add(m.group(1));  
         // System.out.println("ret____"+m.group(1));
        }
        return ret ; 
    }
    public static ArrayList<ArrayList> convertHTMLTableIntoArrayList(String html){
        if(html==null || html.compareTo("")==0)            
            return null;
        html = convertirEnTete(html, "table");
        ArrayList<String> ret = new ArrayList<>();
        ArrayList<ArrayList> retFinal = new ArrayList<>();
        String headerStr = ""; 
        if(html.contains("thead")){
            //String []tmp = getAllStringBetween(html, "<thead>", "</thead>");
          //  if(tmp.length>0)headerStr = tmp[0];
            headerStr = convertirEnTete(html, "thead");
            if(headerStr.contains("tr")){
                headerStr = convertirEnTete(headerStr, "tr");
            }else return retFinal ;            
        }else{
            headerStr = "<tr>"+html.substring(html.indexOf("<tr"), html.indexOf("</tr>"))+"</tr>";
        }
        if(headerStr.length()>0){
          //  System.out.println("titre___"+headerStr);
            ret.add(headerStr);
        }
        if(html.contains("tbody") || (html.indexOf("tr")!=html.lastIndexOf("tr"))){
            if(html.contains("tbody")){
                if(html.contains("thead")){
                    html= html.substring(html.indexOf("</thead>")+8);
                }
                String tbody  = convertirEnTete(html, "tbody");
                //System.out.println("tbody voalohany "+tbody);
               // ArrayList<String> allTR = new ArrayList<String>();
                while(tbody.indexOf("tr")!=-1){
                  //  System.out.println("tbody "+tbody);
                    String tmp = convertirEnTete(tbody, "tr") ; 
                  //  System.out.println("tmp "+tmp);
                    ret.add(tmp);
                    String tmpNouveau = tbody.substring(tbody.indexOf("</tr>")+4);
                  //  System.out.println("tmpNouveau = " + tmpNouveau);
                    tbody = tmpNouveau;
                }                
            }else{
                String tbody  = convertirEnTete(html, "tbody");
                tbody = html.substring(html.indexOf("</tr>")+3);
                while(tbody.indexOf("tr")!=-1){
                    ret.add(convertirEnTete(tbody, "tr"));
                    tbody = tbody.substring(0,tbody.indexOf("</tr>"));
                } 
            }
        }
         retFinal = convertTRToArray(ret);
       // System.out.println("taille="+retFinal.size());
        return retFinal;
    }
    public static ArrayList<ArrayList> convertTRToArray(ArrayList<String> tr){
     //   System.out.println("converting tr to array");
        ArrayList<ArrayList> retFinal = new ArrayList<ArrayList>();
        for(int i=0;i<tr.size();i++){
         //   System.out.println("tr.get(i)___"+tr.get(i));
            String[] between = getAllStringBetween(tr.get(i), "<tr>", "</tr>");
          //  System.out.println("between"+between.length);
            String tmp = UtilitaireExcelMa.convertirEnTete(tr.get(i), "tr");
            //getAllStringBetween(tr.get(i), "<tr>", "</tr>")[0];
          //  System.out.println("tr___"+tmp);
            ArrayList<String> ret = new ArrayList<String>();
            if(tmp.contains("<th")){
               // System.out.println("is HEADERRRRRR");
                while(tmp.indexOf("th")!=-1){
                    String tmp2 = convertirEnTete(tmp, "th") ; 
                    //System.out.println("tmp2 "+tmp2);
                    String valeur =getAllStringBetween(tmp2, "<th>", "</th>")[0] ; 
                    //System.out.println("val____"+valeur);
                    if(valeur.length()>0){                        
                        String[] temp = getAllStringBetween(valeur,">","</");
                            if(temp!=null && temp.length>0) 
                                valeur = temp[0];
                    }
                    ret.add(valeur.replace("&nbsp;"," "));
                    String tmpNouveau = tmp.substring(tmp.indexOf("</th>")+5);
                  //  System.out.println("tmpNouveau = " + tmpNouveau);
                    tmp = tmpNouveau;
                  //  System.out.println("ret size "+ret.size());
                }
            }else{
                  while(tmp.indexOf("<td")!=-1){
                    String tmp2 = convertirEnTete(tmp, "td") ; 
                //    System.out.println("tmp2 "+tmp2);
                    String valeur = getAllStringBetween(tmp2, "<td>", "</td>")[0];
                   // System.out.println("val____"+valeur);
                    if(valeur.length()>0){                        
                        String[] temp = getAllStringBetween(valeur,">","</");
                            if(temp!=null && temp.length>0) 
                                valeur = temp[0];
                    }

                    ret.add(valeur.replace("&nbsp;"," "));
                    String tmpNouveau = tmp.substring(tmp.indexOf("</td>")+5);
                  //  System.out.println("tmpNouveau = " + tmpNouveau);
                    tmp = tmpNouveau;                    
                }
                
            }
            retFinal.add(ret);
            //System.out.println("size "+ret.size());
        }
        return retFinal;
    }


}
