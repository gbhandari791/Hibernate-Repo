package com.notetaker.servlets;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.notetaker.entity.Folder;
import com.notetaker.entity.Note;
import com.notetaker.helper.FactoryProvider;
import com.notetaker.helper.GeneralUtility;


@WebServlet("/AddNoteServlet")
public class AddNoteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public AddNoteServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String strFolderId = request.getParameter("folderId");
		Integer folderId = null;
		try {			
			if(strFolderId != null && !strFolderId.isEmpty()) {
				folderId = Integer.parseInt(strFolderId);
			} else {
				folderId = 1;
			}
			
			if(strFolderId != null) {
				
				String tital = request.getParameter("tital");
				String content = request.getParameter("content");				
								
				Session session = FactoryProvider.getFactory().openSession();	
				Folder folder = session.get(Folder.class, folderId);
				Note note = new Note(tital, content, new Date(), folder);
				Transaction tr = session.beginTransaction();
				
				session.save(note);
				
				tr.commit();			
				session.close();
			}			
			
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
