
<%
	String userName = (String) session.getAttribute("authenticatedUser");
%>

<table align="center">
	<tr>
		<td>
			<H1>
				<font face="cursive" color="#3399FF"><a href="index.jsp">Rotisserie Meatballs</a></font>
			</H1>
		</td>
		<td><%
	if (userName != null)
		out.print("<h3>Signed in as: "+userName+"</h3>");
%></td>
		<td><select onchange="location=this.value">
				<option value="" selected disabled hidden>Menu</option>
				<option value="login.jsp">Login</option>
				<option value="listprod.jsp">Begin Shopping</option>
				<option value="listorder.jsp">List All Orders</option>
				<option value="customer.jsp?id=<%=userName%>">Customer Info</option>
				<option value="admin.jsp">Administrators</option>
				<option value="logout.jsp">Log out</option>
		</select></td>
	</tr>
</table>

<hr>