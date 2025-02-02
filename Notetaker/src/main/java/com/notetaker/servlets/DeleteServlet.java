package com.notetaker.servlets;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.notetaker.entity.Note;
import com.notetaker.helper.FactoryProvider;

@WebServlet("/DeleteServlet")
public class DeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public DeleteServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String strFolderId = request.getParameter("folderId");
		try {			
			String strNoteId = request.getParameter("noteId").trim();			
			int noteId = Integer.parseInt(strNoteId);
			Session session = FactoryProvider.getFactory().openSession();
			Transaction tr = session.beginTransaction();
			Note note = session.get(Note.class, noteId);
			session.delete(note);
			tr.commit();
			session.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (strFolderId != null && !strFolderId.isEmpty()) {
		    response.sendRedirect("ShowNotes?folderId=" + URLEncoder.encode(strFolderId, "UTF-8"));
		} else {
		    response.sendRedirect("ShowNotes");
		}
	}

}
