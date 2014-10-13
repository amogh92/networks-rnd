<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>

<%@ page import="serverplus.*" %>


<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="ServerHandler">
    <meta name="IITB" content="IITB Wi-Fi Load Generator">
    <title>ServerHandler</title>
	
	<link type="text/css" rel="stylesheet" href="./css/bootstrap.min.css" />
	<link type="text/css" rel="stylesheet" href="./css/bootstrap-responsive.min.css" />
	<link type="text/css" rel="stylesheet" href="./css/font-awesome.css" />
	<link type="text/css" rel="stylesheet" href="./css/font-awesome-ie7.css" />
	<link type="text/css" rel="stylesheet" href="./css/boot-business.css" />
	
	
  </head>
  <body>

<%

	String expID=null,macAddress=null;

	File file ;
	int maxFileSize = 10 * 1024 * 1024;	
	int maxMemSize = 10 * 1024 * 1024;
	String filePath = Constants.getMainExpLogsDir();
	String tempFiles = Constants.getTempFiles();
	
	// Verify the content type
	String contentType = request.getContentType();
	if ((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0)) {

	  DiskFileItemFactory factory = new DiskFileItemFactory();
	  factory.setSizeThreshold(maxMemSize);
	  factory.setRepository(new File(tempFiles));

	  ServletFileUpload upload = new ServletFileUpload(factory);
	  upload.setSizeMax( maxFileSize );
	  try{ 
		 List fileItems = upload.parseRequest(request);

			Iterator i = fileItems.iterator();
			while(i.hasNext()){
				FileItem fi = (FileItem)i.next();
				if(fi.isFormField()){
					String fieldName = fi.getFieldName();
					String fieldValue = fi.getString();
					System.out.println("field name: " + fieldName + ", filed value: " + fieldValue);
					out.print("</p><br>field name: " + fieldName + ", filed value: " + fieldValue + "</p><br>");
					if(fieldName.equals(Constants.getExpID())){
						expID= fieldValue;
					}
					else if(fieldName.equals(Constants.getMacAddress())){
						macAddress = fieldValue;
					}
				}
			}

			if(expID==null || macAddress==null){
				System.out.println("Error while getting parameters");
				out.print("<p>Error while getting parameters</p>");
			}
			
			
			filePath=filePath + expID + "/";
			File theDir = new File(filePath);
			if (!theDir.exists()) {
				theDir.mkdir();
			}
			out.println("<p>Directory : " +  filePath + "</p>");

		 i = fileItems.iterator();
			
		 while ( i.hasNext () ){
			FileItem fi = (FileItem)i.next();
			if ( !fi.isFormField () ){
				String fileName = macAddress;
				boolean isInMemory = fi.isInMemory();
				long sizeInBytes = fi.getSize();
				if( fileName.lastIndexOf("\\") >= 0 ){
					file = new File( filePath + 
					fileName.substring( fileName.lastIndexOf("\\"))) ;
				}else{
					file = new File( filePath + 
					fileName.substring(fileName.lastIndexOf("\\")+1)) ;
				}
				fi.write( file ) ;
			}
		 }
		 
		 int result = Utils.updateFileReceivedField(Integer.parseInt(expID), macAddress, true);
			System.out.println("update FIle received result: " + result);
			out.print("update FIle received result: " + result);
			if(result<0)
				response.setStatus(response.SC_REQUEST_URI_TOO_LONG);
			
			
		}catch(Exception ex) {
			response.setStatus(response.SC_REQUEST_URI_TOO_LONG);
			System.out.println(ex);
		} 
	  
	}

	
%>


</body>
</html>
