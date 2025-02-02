package com.notetaker.servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.jasper.tagplugins.jstl.core.If;
import org.hibernate.Session;
import org.hibernate.query.Query;

import com.notetaker.entity.Folder;
import com.notetaker.entity.Note;
import com.notetaker.helper.FactoryProvider;
import com.notetaker.helper.GeneralUtility;

/**
 * Servlet implementation class ShowNotes
 */
@WebServlet("/ShowNotes")
public class ShowNotes extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
    public ShowNotes() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String strFolderId = request.getParameter("folderId");
		Integer folderId = null;
		Folder folder = null;
		List<Note> allNotes = null;
		try {
					
			Session session = FactoryProvider.getFactory().openSession();
			if(strFolderId != null && !strFolderId.isEmpty()) {
				folderId = Integer.parseInt(strFolderId);
				folder = session.get(Folder.class, folderId);
			}	
			StringBuffer sbSql = new StringBuffer();
			sbSql.append("from Note");
			if(folderId != null) {
				sbSql.append(" where folder.id =: fId ");
			}
			sbSql.append(" ORDER BY id DESC");
			Query<Note> query = session.createQuery(sbSql.toString(), Note.class);
			if (folderId != null) {
			    query.setParameter("fId", folderId);
			}
			allNotes = query.list();
			for(Note note : allNotes) {
				if(note.getContent().length() > 100) {
					note.setContent(GeneralUtility.concat(note.getContent().substring(0, 100), "..."));
				}
			}			
			session.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("folderId", folderId);
		request.setAttribute("folder", folder);
		request.setAttribute("allNotes", allNotes);
		RequestDispatcher dispatcher = request.getRequestDispatcher("showNotes.jsp");
		dispatcher.forward(request, response);
	}

}
