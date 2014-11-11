<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="serverplus.*" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.concurrent.ConcurrentHashMap" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.URLEncoder" %>
<%@ include file="checksession2.jsp" %>

<%
	String username = (String)session.getAttribute("username");
	String exp = (String)request.getParameter(Constants.getExpID());
	if(exp==null) response.sendRedirect("index.jsp");
		int expid = Integer.parseInt(exp);
%>

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

	<%@ include file="header.jsp" %>  
    

	<div class="content">
		<div class="container">
      
			<div class="page-header">        
				<h1>Load Generator's Server Handler</h1>
			</div>
			<div>
				<a href="listExperiments.jsp">Back</a> 
			</div>
			
			<div>
				
<%
	DBManager db = new DBManager();
	ResultSet rs = db.getExperimentDetails(expid);
	
	
	if(rs==null){
		out.print("<h4>There are no experiment details yet...</h4>");
	}
	else{
%>		
				<table class="table">
					<thead>
						<tr>
							<th>Mac Address</th>
							<th>OS Build</th>
							<th>Wifi</th>
							<th>Cores</th>
							<th>Space </th>
							<th>Memory </th>
							<th>Processor Speed </th>
							<th>Signal Strength </th>
							<th>Log File</th>
						</tr>
					</thead>
					<tbody>
<%
		while(rs.next()){
%>				
					<tr>
						<td><%out.print(""+rs.getString(2));%></td>  
						<td><%out.print(""+rs.getInt(3));%></td>   
						<td><%out.print(""+rs.getString(4));%></td>
						<td><%out.print(""+rs.getInt(5));%></td>   
						<td><%out.print(""+rs.getInt(6));%></td>
						<td><%out.print(""+rs.getInt(7));%></td>
						<td><%out.print(""+rs.getInt(8));%></td>
						<td><%out.print(""+rs.getInt(9));%></td>
						<td>
						<%
							boolean received = (boolean)rs.getBoolean(10);
							if(!received) out.print("Not Received");
							else{
							String url = "download.jsp?" + URLEncoder.encode("random word £500 bank $", "UTF-8");
								out.print("<a href=\"download.jsp?" + Constants.getExpID() +"="+ rs.getInt(1) 
								+ "&download=log&" + Constants.getMacAddress() + "="
								+ URLEncoder.encode((String)rs.getString(2), "UTF-8")   
								+ "\" > Download </a>");
							}
						%>
						</td>	
						 
					</tr>
<%				
		}
		db.closeConnection();
	}
%>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	
	
	<%@ include file="footer.jsp" %>
    <script type="text/javascript" src="./js/jquery.min.js"></script>
    <script type="text/javascript" src="./js/bootstrap.min.js"></script>
   
  </body>
</html>
<%@ include file="closeBracket.msg" %>
