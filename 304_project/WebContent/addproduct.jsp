<%@ include file="jdbc.jsp" %>
<%
	if (request.getParameter("name") != null && request.getParameter("price") != null
			&& request.getParameter("desc") != null && request.getParameter("catid") != null) {
		try {
			getConnection();
			String sql = "INSERT INTO product (productName, productPrice, productDesc, categoryId) VALUES (?, ?, ?, ?)";
			PreparedStatement pst = con.prepareStatement(sql);
			pst.setString(1, request.getParameter("name"));
			pst.setDouble(2, Double.parseDouble(request.getParameter("price")));
			pst.setString(3, request.getParameter("desc"));
			pst.setInt(4, Integer.parseInt(request.getParameter("catid")));
			pst.executeUpdate();
		} catch (SQLException ex) {
			out.println(ex);
		} finally {
			closeConnection();
		}
	}
	response.sendRedirect("index.jsp");
%>