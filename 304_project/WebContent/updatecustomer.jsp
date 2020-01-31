<%@ include file="jdbc.jsp"%>
<%
	String userName = (String) session.getAttribute("authenticatedUser");
	String firstname = request.getParameter("firstname");
	String lastname = request.getParameter("lastname");
	String email = request.getParameter("email");
	String phone = request.getParameter("phone");
	String address = request.getParameter("address");
	String city = request.getParameter("city");
	String state = request.getParameter("state");
	String postcode = request.getParameter("postcode");
	String country = request.getParameter("country");
	String oldpass = request.getParameter("oldpass");
	String password = request.getParameter("password");

	try {
		getConnection();
		String sql = "SELECT password FROM customer WHERE userid = ?";
		PreparedStatement pst = con.prepareStatement(sql);
		pst.setString(1, userName);
		ResultSet rst = pst.executeQuery();
		rst.next();
		String checkpass = rst.getString(1);
		closeConnection();
		if (!oldpass.equals(checkpass) || oldpass == null) {
			response.sendRedirect("account.jsp");
		} else {
			getConnection();
			sql = "UPDATE customer SET firstName=?, lastName=?, email=?, phonenum=?, address=?, city=?, state=?, postalCode=?, country=?, password=? WHERE userid=?";
			pst = con.prepareStatement(sql);
			pst.setString(1, firstname);
			pst.setString(2, lastname);
			pst.setString(3, email);
			pst.setString(4, phone);
			pst.setString(5, address);
			pst.setString(6, city);
			pst.setString(7, state);
			pst.setString(8, postcode);
			pst.setString(9, country);
			if (password != null) {
				pst.setString(10, password);
			} else {
				pst.setString(10, oldpass);
			}
			pst.setString(11, userName);
			pst.executeUpdate();
			response.sendRedirect("account.jsp");
		}
	} catch (SQLException ex) {
		out.println(ex);
	} finally {
		closeConnection();
	}
	
%>