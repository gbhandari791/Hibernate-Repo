package com.notetaker.servlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import com.notetaker.entity.Note;
import com.notetaker.helper.FactoryProvider;

@WebServlet("/ViewNoteServlet")
public class ViewNoteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
    public ViewNoteServlet() {
        super();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String strNoteId = request.getParameter("noteId");
			if(strNoteId != null) {
			 	int noteId = Integer.parseInt(strNoteId.trim());
			 	Session session = FactoryProvider.getFactory().openSession();
			 	Note note = session.get(Note.class, noteId);
			 	request.setAttribute("viewNote", note);			 	
			 	session.close();
			 	
			 	RequestDispatcher requestDispatcher = request.getRequestDispatcher("viewNote.jsp");
			 	requestDispatcher.forward(request, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
