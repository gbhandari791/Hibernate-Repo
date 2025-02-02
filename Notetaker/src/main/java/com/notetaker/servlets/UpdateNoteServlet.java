package com.notetaker.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.notetaker.entity.Note;
import com.notetaker.helper.FactoryProvider;

@WebServlet("/UpdateNoteServlet")
public class UpdateNoteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			
			String strNoteId = request.getParameter("noteId");
			if(strNoteId != null) {
				int noteId = Integer.parseInt(strNoteId.trim());
				String title = request.getParameter("title");
				String content = request.getParameter("content");
				Session sesssion = FactoryProvider.getFactory().openSession();
				Transaction tr = sesssion.beginTransaction();
				Note note = sesssion.get(Note.class, noteId);
				note.setTitle(title);
				note.setContent(content);
				sesssion.update(note);
				tr.commit();
				sesssion.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
