package com.notetaker.servlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ShowFoldersServlet")
public class ShowFoldersServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ShowFoldersServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			
		} catch (Exception e) {
			
		}
		RequestDispatcher requestDispatcher = request.getRequestDispatcher("showFolders.jsp");
		requestDispatcher.forward(request, response);
	}

}
